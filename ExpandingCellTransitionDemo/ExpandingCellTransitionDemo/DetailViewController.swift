//
//  DetailViewController.swift
//  ExpandingCellTransition
//
//  Created by MuronakaHiroaki on 2017/05/05.
//  Copyright © 2017年 MuronakaHiroaki. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var number: Int = 0
    @IBOutlet var numberLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberLabel.text = "\(number)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleTapped(gesture: UIGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
