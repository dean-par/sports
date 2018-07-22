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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Force unwrap url since we have certainty it exists.
        NetworkManager.shared.fetchStats(for: Configuration.matchURL(for: "NRL20172101")!, completionHandler: { data in
            do {
                let matchStats = try JSONDecoder().decode([Match].self, from: data)
                self.matchStats = matchStats
                self.matchStatsSectionViewModel = MatchStatsSectionViewModel(matchStats: matchStats)
            } catch {
                
            }
        }) { error in
            // TODO: implement error case.
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "player", for: indexPath)
        return cell
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

