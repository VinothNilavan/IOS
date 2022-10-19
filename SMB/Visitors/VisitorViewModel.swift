//
//  VisitorViewModel.swift
//  SMB
//
//  Created by Vinoth on 24/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

class VisitorViewModel {
    
    private var client  = NetworkWrapper.init()
    var dSource         = [VisitedUser]()
    
    var visitorsLoaded:(_ str:String?)->() = { _  in }
    
    func fetchVisitors(phone:String) {
        let req = ApiService.visitedList(phone)
        client.request(req) { (visitors:[VisitedUser]) in
            self.dSource = visitors
            self.visitorsLoaded(nil)
        } onError: { (er) in
            print(er)
            self.visitorsLoaded(er.localizedDescription)
        }
    }
}
