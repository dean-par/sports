//
//  PlayerDetailViewController.swift
//  Sports
//
//  Created by Dean Parreno on 23/7/18.
//  Copyright © 2018 DeanParreno. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UITableViewController {
    
    @IBOutlet weak var headshotImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var isTeamA = true
    var playerID: String = "115370"
    var teamID: String = "55011"
    var individualStats: IndividualStats?
    
    var statKeys: [String]? {
        return individualStats?.lastMatchStats.map { $0.key }
    }
    
    var statValues: [String]? {
        return individualStats?.lastMatchStats.map { String($0.value ?? 0) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Force unwrap url since we have certainty it exists.
        NetworkManager.shared.fetch(for: Configuration.playerStatsURL(for: teamID, playerID: playerID)!, completionHandler: { data in
            do {
                let individualStats = try JSONDecoder().decode(IndividualStats.self, from: data)
                self.individualStats = individualStats
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return individualStats?.lastMatchStats.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stat") else { return UITableViewCell() }
        if let statKeys = statKeys,
            let statValues = statValues
        {
            cell.textLabel?.text = statKeys[indexPath.row]
            cell.detailTextLabel?.text = String(statValues[indexPath.row])
        }
        return cell

    }

}
