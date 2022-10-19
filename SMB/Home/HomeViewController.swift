//
//  HomeViewController.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var barbutton: UIBarButtonItem!
    private var viewModel       = HomeViewModel()
    private var productsLoading = false {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    class func controller() -> HomeViewController {
        SMBFactory.getHomeController()
    }
      
    @IBAction func visitorsDidTap(_ sender: UIBarButtonItem) {
        
    }
    private func initialise() {
        navigationController?.navigationBar.isHidden         = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if !admins.contains(SMBDefaults.phoneNumber) {
            self.navigationItem.rightBarButtonItem = nil
        }
        productsLoading =  true
        viewModel.products { (products, er) in
            self.productsLoading = false
            if let er = er {
                print(er)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialise()
        self.title                = "Home"
        collectionView.delegate   = self
        collectionView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
    }
    deinit {
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
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsLoading ? 10 : viewModel.numberOfItems
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemID", for: indexPath) as? ProductCollectionViewCell {
            if productsLoading {
                ShimmerLoader().startSmartShining(cell.contentView)
            }
            else {
                ShimmerLoader().stopSmartShining(cell.contentView)
                cell.config(vm: viewModel.cellModel(at: indexPath.item))
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        productsLoading ? print("loading") : _ = viewModel.itemAtIndex(at: indexPath.item)
        self.present(SMBFactory.getDetail(), animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            return CGSize.init(width: (collectionView.frame.size.height) / 1.8 , height: 220)
        }
        return CGSize.init(width: (collectionView.frame.size.width) / 2 , height: 220)
    }
}
