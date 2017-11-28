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
    private var currentSection = -1
    private var sectionHeaders: [SectionHeaderView] = []
    private var dataSource: [Any] = []
    
    // MARK: - View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareSectionHeaders()
    }
    
    /**
     Preparing the section headers
     */
    private func prepareSectionHeaders() {
        let sectionTitles: [Any] = ["Earth", "Jupiter", "Pluto", "Neptune", "Mercury"]
        for i in 0..<sectionTitles.count {
            if let sectionHeader = SectionHeaderView.fromNib() {
                let title = sectionTitles[i] as! String
                sectionHeader.configure(title, index: i, delegate: self)
                sectionHeaders.append(sectionHeader)
            }
        }
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
        return sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSection == section ? dataSource.count: 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaders[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource[indexPath.row] as? String
        return cell
    }
    
    /**
     Deleting the rows in the given section number
     - parameter section: Section index to remove the rows
     */
    fileprivate func deleteSectionRows(_ section: Int) {
        guard currentSection != -1 else { return }
        
        var indexPaths: [IndexPath] = []
        for i in 0..<self.dataSource.count {
            indexPaths.append(IndexPath(row: i, section: currentSection))
        }
        sectionHeaders[currentSection].updateArrowImage()
        
        currentSection = -1

        guard indexPaths.count > 0 else { return }
        
        self.tableView.deleteRows(at: indexPaths, with: .top)
    }
    
    /**
     Preparing data source for the given section and reloading the section to reflect the data.
     The delay is added to make the animation smoother as the deleting rows takes some time to
     play delete animation. Feel free to play with it.
     - parameter section: Section index to add the rows
     */
    fileprivate func reloadSection(_ section: Int) {
        let time = DispatchTime.now() + 0.15
        DispatchQueue.main.asyncAfter(deadline: time) {[weak self] in
            print("Touched Section: \(section)")
            self?.sectionHeaders[section].updateArrowImage()
            let indexes = IndexSet(integer: section)
            self?.currentSection = section
            self?.dataSource = ["Row 1", "Row 2", "Row 3", "Row 4", "Row 5"]
            self?.tableView.reloadSections(indexes, with: .automatic)
        }
    }
}

// MARK: - Section header Tap handling
extension ViewController: SectionTapDelegate {
    
    /**
     Deleting the previously added section rows first. If the user taps the same section again then
     simply returning after deleting the rows. If the tapped section is different then reloading that
     section to reflect show its rows.
     */
    func onSectionTouched(_ section: Int) {
        let oldSection = currentSection
        self.deleteSectionRows(section)
        
        guard oldSection != section else { return }

        self.reloadSection(section)
    }
}
