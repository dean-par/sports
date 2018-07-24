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
    @IBOutlet weak var positionLabel: UILabel!
    
    struct CellIdentifier {
        static let stat = "stat"
    }
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    var playerViewModel: PlayerViewModel?
    var teamID = ""
    var individualStatsViewModel: IndividualStatsViewModel?
    
    var playerID: String {
        return String(playerViewModel?.id ?? "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = playerViewModel?.fullName
        positionLabel.text = playerViewModel?.position
        // Download image of player - this is failing.
        headshotImage.downloadedFrom(url: Configuration.image(for: playerID)!)
        loadFromServer()
    }
    
    func loadFromServer() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        NetworkManager.shared.fetch(for: Configuration.playerStatsURL(for: teamID, playerID: playerID)!, completionHandler: { data in
            do {
                let individualStats = try JSONDecoder().decode(IndividualStats.self, from: data)
                self.individualStatsViewModel = IndividualStatsViewModel(individualStats: individualStats)
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.activityIndicator.stopAnimating()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Last Game Stats"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return individualStatsViewModel?.statsCount ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.stat) else { return UITableViewCell() }
        if let statKeys = individualStatsViewModel?.statKeys,
            let statValues = individualStatsViewModel?.statValues
        {
            cell.textLabel?.text = statKeys[indexPath.row]
            cell.detailTextLabel?.text = statValues[indexPath.row]
        }
        return cell
    }

}
