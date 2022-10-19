//
//  VisitorsViewController.swift
//  SMB
//
//  Created by Vinoth on 24/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import UIKit

class VisitorsViewController: UIViewController {

    private var viewModel = VisitorViewModel()
    @IBOutlet weak var listview: UITableView!
    var visiting  = false {
        didSet {
            self.listview.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        visiting = true
        viewModel.visitorsLoaded = { [weak self] str in
            self?.visiting = false
            if let str = str {
                self?.showAlert(message: str, title: "Alert")
            }
        }
        viewModel.fetchVisitors(phone: "8553038211")
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

extension VisitorsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visiting == true ? 10 : viewModel.dSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_id", for: indexPath) as? VisitorsTableViewCell
        if visiting {
            ShimmerLoader().startSmartShining(cell?.contentView ?? UIView())
            return cell!
        }
        else {
            ShimmerLoader().stopSmartShining(cell?.contentView ?? UIView())
        }
        let model = viewModel.dSource[indexPath.row]
        cell?.config(name: model.name ?? "Unknown", model.mobile_number ?? "")
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SMBFactory.getDetail()
        self.present(vc, animated: true, completion: nil)
    }
}
