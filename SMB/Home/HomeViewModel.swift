//
//  HomeViewModel.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    private var client  = NetworkWrapper()
    private var dSource = [Product]()
    
    var numberOfItems: Int { dSource.count }
    
    func itemAtIndex(at row: Int) -> Product { dSource[row] }
    
    func cellModel(at row: Int) -> ProductViewModel {
        let model      = itemAtIndex(at: row)
        let vm         = ProductViewModel.init()
        vm.desc        = model.desc
        vm.displayName = model.name
        vm.imageUrl    = model.imageUrl
        return vm
    }
    
    func products(handler:@escaping ([Product?], Error?) -> Void ) {
        
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue       = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async {
            sleep(3) // 3: Do your networking task or background work here.
            DispatchQueue.main.async {
                let prod = Product(name: "Product 1", imageUrl: "https://storage.googleapis.com/webdesignledger.pub.network/WDL/6afbb7c0-logo.jpg", desc: "desc 121313 ")
                let prod2 = Product(name: "Product 2", imageUrl: "https://playtech.ro/wp-content/uploads/2017/07/Apple-logo-3.jpg", desc: "Prod desc ")
                
                let prod3 = Product(name: "3 Product", imageUrl: "https://storage.googleapis.com/webdesignledger.pub.network/WDL/6e4f2a8d-screenshot-2020-06-24-at-14.55.19.png", desc: "third one")
                self.dSource = [prod, prod2, prod3]
                handler([],nil)
            }
        }
    /*
        
        let api = ApiService.getProducts("")
        client.request(api) {[weak self] (products: [Product]) in
            self?.dSource  = products
            self?.dSource += products
            handler([],nil)
        } onError: { (er) in
            handler([],er)
        }
     */
    }
}
