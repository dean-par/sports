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
        // Force unwrap url since we have certainty it exists.
        NetworkManager.shared.fetch(for: Configuration.matchURL(for: MatchIdentifier.penrithVsCanterbury)!, completionHandler: { data in
            do {
                let matchStats = try JSONDecoder().decode([Match].self, from: data)
                self.matchStatsViewModel = MatchStatsViewModel(matchStats: matchStats)
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.updateHeaderView()
                    strongSelf.tableView.reloadData()
                }
            } catch {
                // TODO: implement error case.
            }
        }) { error in
            // TODO: implement error case.
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
        // Switch on stat type enum here.
        let player = matchStatsViewModel.topAPlayers[indexPath.row]
        cell.teamAPlayer.textLabel.text = player.fullName
        cell.teamAPlayer.detailTextLabel.text = String(player.jumperNumber)
        cell.teamAPlayer.subtitleTextLabel.text = player.position
        cell.teamAPlayer.subDetailTextLabel.text = String(player.statValue)
        let playerID = String(player.id)
        // Downloading image is failing.
        if let headshotImage =  cell.teamAPlayer.headshotImage as? PlayerImageView {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            headshotImage.player = player
            headshotImage.teamID = matchStatsViewModel.teamAID
            headshotImage.downloadedFrom(url: Configuration.image(for: playerID)!)
            headshotImage.addGestureRecognizer(tapGesture)
            headshotImage.isUserInteractionEnabled = true
        }
        let bplayer = matchStatsViewModel.topAPlayers[indexPath.row]
        cell.teamBPlayer.textLabel.text = bplayer.fullName
        cell.teamBPlayer.detailTextLabel.text = String(bplayer.jumperNumber)
        cell.teamBPlayer.subtitleTextLabel.text = bplayer.position
        cell.teamBPlayer.subDetailTextLabel.text = String(bplayer.statValue)
        let bplayerID = String(player.id)
        // Downloading image is failing.
        if let headshotImage =  cell.teamBPlayer.headshotImage as? PlayerImageView {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            headshotImage.player = player
            headshotImage.teamID = matchStatsViewModel.teamBID
            headshotImage.downloadedFrom(url: Configuration.image(for: bplayerID)!)
            headshotImage.addGestureRecognizer(tapGesture)
            headshotImage.isUserInteractionEnabled = true
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
        performSegue(withIdentifier: "playerDetail", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let imageView = (sender as? UITapGestureRecognizer)?.view as? PlayerImageView else { return }
        switch segue.identifier {
        case "playerDetail":
            guard let detailViewController = segue.destination as? PlayerDetailViewController else { return }
            detailViewController.player = imageView.player
            detailViewController.teamID = imageView.teamID ?? ""
        default: break
        }
    }

}

