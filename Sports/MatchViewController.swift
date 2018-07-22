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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Force unwrap url since we have certainty it exists.
        NetworkManager.shared.fetchStats(for: Configuration.matchURL(for: "NRL20172101")!, completionHandler: { data in
            do {
                let matchStats = try JSONDecoder().decode([Match].self, from: data)
                print(matchStats)
            } catch {
                
            }
        }) { error in
            // TODO: implement error case.
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

