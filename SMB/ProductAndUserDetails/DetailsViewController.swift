//
//  DetailsViewController.swift
//  SMB
//
//  Created by Vinoth on 25/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var close: UIButton!
    
    @IBAction func closeButton(_ sender: UIButton ) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
