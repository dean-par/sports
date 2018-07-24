//
//  ViewController.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import UIKit

class MatchViewController: UITableViewController {
    
    @IBOutlet weak var teamALabel: UILabel!
    @IBOutlet weak var teamBLabel: UILabel!
    
    var matchStatsViewModel: MatchStatsViewModel?
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    struct MatchIdentifier {
        static let penrithVsCanterbury = "NRL20172101"
    }
    
    struct SegueIdentifier {
        static let playerDetail = "playerDetail"
    }
    
    struct CellIdentifier {
        static let player = "player"
    }
    
    struct CellNibName {
        static let player = "PlayerTableViewCell"
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: CellNibName.player, bundle: nil), forCellReuseIdentifier: CellIdentifier.player)
        loadFromServer()
    }
    
    private func loadFromServer() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        // Force unwrap url since we have certainty it exists.
        NetworkManager.shared.fetch(for: Configuration.matchURL(for: MatchIdentifier.penrithVsCanterbury)!, completionHandler: { data in
            do {
                let matchStats = try JSONDecoder().decode([Match].self, from: data)
                self.matchStatsViewModel = MatchStatsViewModel(matchStats: matchStats)
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.activityIndicator.stopAnimating()
                    strongSelf.updateHeaderView()
                    strongSelf.tableView.reloadData()
                }
            } catch {
                // TODO: implement error case.
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                   strongSelf.activityIndicator.stopAnimating()
                }
            }
        }) { error in
            // TODO: implement error case.
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.activityIndicator.stopAnimating()
            }
        }
    }

    
    private func updateHeaderView() {
        guard let matchStatsViewModel = matchStatsViewModel else { return }
        teamALabel.text = matchStatsViewModel.teamAName
        teamBLabel.text = matchStatsViewModel.teamBName
    }
    
    // MARK: Table View Controller Delegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.player) as? PlayerTableViewCell,
            let matchStatsViewModel = matchStatsViewModel
            else { return UITableViewCell() }
        let match = matchStatsViewModel.matchFor(section: indexPath.section)
        if let player = match.teamA.topPlayers?[indexPath.row] {
            let playerViewModel = PlayerViewModel(player: player)
            cell.teamAPlayer.textLabel.text = playerViewModel.shortName
            cell.teamAPlayer.detailTextLabel.text = playerViewModel.jumperNumber
            cell.teamAPlayer.subtitleTextLabel.text = playerViewModel.position
            cell.teamAPlayer.subDetailTextLabel.text = playerViewModel.statValue
            // Downloading image is failing.
            if let headshotImage =  cell.teamAPlayer.headshotImage as? PlayerImageView {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
                headshotImage.playerViewModel = playerViewModel
                headshotImage.teamID = matchStatsViewModel.teamAID
                headshotImage.downloadedFrom(url: Configuration.image(for: playerViewModel.id)!)
                headshotImage.addGestureRecognizer(tapGesture)
                headshotImage.isUserInteractionEnabled = true
            }
        }
        if let bPlayer = match.teamB.topPlayers?[indexPath.row] {
            let playerViewModel = PlayerViewModel(player: bPlayer)
            cell.teamBPlayer.textLabel.text = playerViewModel.shortName
            cell.teamBPlayer.detailTextLabel.text = playerViewModel.jumperNumber
            cell.teamBPlayer.subtitleTextLabel.text = playerViewModel.position
            cell.teamBPlayer.subDetailTextLabel.text = playerViewModel.statValue
            // Downloading image is failing.
            if let headshotImage =  cell.teamBPlayer.headshotImage as? PlayerImageView {
                let tapBGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
                headshotImage.playerViewModel = playerViewModel
                headshotImage.teamID = matchStatsViewModel.teamBID
                headshotImage.downloadedFrom(url: Configuration.image(for: playerViewModel.id)!)
                headshotImage.addGestureRecognizer(tapBGesture)
                headshotImage.isUserInteractionEnabled = true
            }
        }
        cell.layoutIfNeeded()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return matchStatsViewModel?.titleFor(section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchStatsViewModel?.numberOfRows(section: section) ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return matchStatsViewModel?.numberOfSections ?? 0
    }
    
    // MARK: Navigation

    @objc func handleTap(sender: Any?) {
        performSegue(withIdentifier: SegueIdentifier.playerDetail, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let imageView = (sender as? UITapGestureRecognizer)?.view as? PlayerImageView else { return }
        switch segue.identifier {
        case SegueIdentifier.playerDetail:
            guard let detailViewController = segue.destination as? PlayerDetailViewController else { return }
            detailViewController.playerViewModel = imageView.playerViewModel
            detailViewController.teamID = imageView.teamID ?? ""
        default: break
        }
    }

}

