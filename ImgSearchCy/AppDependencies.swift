//
//  AppDependencies.swift
//  ImgSearchCy
//
//  Created by Lucy on 23/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class AppDependencies {
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        let wf = AppDependencies.configureDependecy()
        wf.presentVCToWindow(window)
    }
    
    class func configureDependecy() -> WfListMenu {
        let wf = WfListMenu()
     
        let rootWireframe = WFRoot()
        
        let presenter = PsListMenu()
        let datamanager = ManagerMenu()
        let interactor = IListMenu(manager: datamanager)
        
        presenter.interactor = interactor
        presenter.wfVc = wf
        
        wf.presenter = presenter
        wf.wfRoot = rootWireframe
    
        
        return wf
    }
    
    deinit {
        print("deinit")
    }
}
