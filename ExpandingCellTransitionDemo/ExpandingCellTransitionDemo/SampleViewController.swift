//
//  SampleViewController.swift
//  ExpandingCellTransition
//
//  Created by MuronakaHiroaki on 2017/05/05.
//  Copyright © 2017年 MuronakaHiroaki. All rights reserved.
//

import UIKit
import ExpandingCellTransition

class SampleViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var transition:ExpandingCellTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: SampleTableViewCell.self)
        let nib = UINib(nibName: "SampleTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: "SampleTableViewCell")
        
        self.transition = ExpandingCellTransition(tableView: self.tableView, duration: 0.5)
    }
}

extension SampleViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleTableViewCell") as! SampleTableViewCell
        cell.numberLabel.text = "\(indexPath.row + 1)"
        return cell
    }
    
}

extension SampleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.number = indexPath.row + 1
        vc.transitioningDelegate = self.transition
        self.transition.tappedCellIndex = indexPath
        
        self.present(vc, animated: true, completion: nil)
    }
}
