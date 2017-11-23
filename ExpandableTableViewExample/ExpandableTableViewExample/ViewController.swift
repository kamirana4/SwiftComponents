//
//  ViewController.swift
//  ExpandableTableViewExample
//
//  Created by M.Kamran on 11/23/17.
//  Copyright © 2017 M.Kamran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let sectionTitles = ["Earth", "Jupiter", "Pluto", "Neptune", "Mercury"]
    
    
    // MARK: - View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

// MARK: - UITableView delegate handling here
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
}

// MARK: - UITableView data source handling here
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = SectionHeaderView.fromNib()
        sectionHeader?.configure(sectionTitles[section], index: section, delegate: self)
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - Section header Tap handling
extension ViewController: SectionTapDelegate {
    
    func onSectionTouched(_ index: Int) {
        print("Touched Section: \(index)")
    }
}
