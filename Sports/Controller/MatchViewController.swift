//
//  ViewController.swift
//  Sports
//
//  Created by Dean Parreno on 22/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import UIKit

class MatchViewController: UITableViewController {
    
    var matchStats: [Match]?
    var matchStatsSectionViewModel: MatchStatsSectionViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "player")
        // Force unwrap url since we have certainty it exists.
        NetworkManager.shared.fetch(for: Configuration.matchURL(for: "NRL20172101")!, completionHandler: { data in
            do {
                let matchStats = try JSONDecoder().decode([Match].self, from: data)
                self.matchStats = matchStats
                self.matchStatsSectionViewModel = MatchStatsSectionViewModel(matchStats: matchStats)
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.tableView.reloadData()
                }
            } catch {
                // TODO: implement error case.
            }
        }) { error in
            // TODO: implement error case.
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "player") as? PlayerTableViewCell else { return UITableViewCell() }
        // Switch on stat type enum here.
        if let topPlayers = matchStats?.first?.teamA.topPlayers {
            let player = topPlayers[indexPath.row]
            cell.teamAPlayer.textLabel.text = player.fullName
            cell.teamAPlayer.detailTextLabel.text = String(player.jumperNumber)
            cell.teamAPlayer.subtitleTextLabel.text = player.position
            cell.teamAPlayer.subDetailTextLabel.text = String(player.statValue)
            let playerID = String(player.id)
            // Downloading image is failing.
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            cell.teamAPlayer.headshotImage.downloadedFrom(url: Configuration.image(for: playerID)!)
            cell.teamAPlayer.headshotImage?.addGestureRecognizer(tapGesture)
            cell.teamAPlayer.headshotImage?.isUserInteractionEnabled = true
        }
        if let topPlayers = matchStats?.first?.teamB.topPlayers {
            let player = topPlayers[indexPath.row]
            cell.teamBPlayer.textLabel.text = player.fullName
            cell.teamBPlayer.detailTextLabel.text = String(player.jumperNumber)
            cell.teamBPlayer.subtitleTextLabel.text = player.position
            cell.teamBPlayer.subDetailTextLabel.text = String(player.statValue)
            let playerID = String(player.id)
            // Downloading image is failing.
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            cell.teamBPlayer.headshotImage.downloadedFrom(url: Configuration.image(for: playerID)!)
            cell.teamBPlayer.headshotImage?.addGestureRecognizer(tapGesture)
            cell.teamBPlayer.headshotImage?.isUserInteractionEnabled = true
        }
        cell.layoutIfNeeded()
        
        return cell
    }
    
    @objc func handleTap(sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        performSegue(withIdentifier: "playerDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        switch segue.identifier {
        case "playerDetail":
            guard let detailViewController = segue.destination as? PlayerDetailViewController else { return }
            detailViewController.playerID = String(matchStats?.first?.teamA.topPlayers![indexPath.row].id ?? 0)
            detailViewController.teamID = String(matchStats?.first?.teamA.id ?? 0)
        default: break
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return matchStatsSectionViewModel?.titleFor(section: section)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchStatsSectionViewModel?.numberOfRows(section: section) ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return matchStatsSectionViewModel?.numberOfSections ?? 0
    }

}

