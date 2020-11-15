//
//  WfListHeroes.swift
//  ImgSearchCy
//
//  Created by Lucy on 17/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class WfListMenu: NSObject {
 
    var vc: VCListMenu?
    var wfRoot: WFRoot?
   
    var presenter : PsListMenu?

    func presentVC(fromVC: UIViewController) {
        self.vc = self.initiateVC()
    }
    
    func initiateVC() -> VCListMenu {
        let storyboard = UIStoryboard.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ID_VC_ListHeroes) as! VCListMenu
        viewController.eventHandler = self.presenter
        self.presenter?.vc = viewController
        return viewController
    }
    
    func presentVCToWindow(_ window: UIWindow) {
        let viewController = initiateVC()
        wfRoot?.showRootViewController(viewController, inWindow: window)
    }
    
    func navigateToDetail(model: ModelFood) {
        let wfDetail = WfListHeroesDetail()

        var manager = ManagerMenu()
        if let dataManager = self.presenter?.interactor?.dataManager {
            manager = dataManager
        }
        let interactor = IListHeroesDetail(manager: manager)
        let presenter = PsListHeroesDetail()
        
        presenter.interactor = interactor
        presenter.interactor?.modelSelected = model
        presenter.interactor?.model = self.presenter?.interactor?.model
        presenter.vc = wfDetail.vc
        presenter.wfVc = wfDetail
        wfDetail.presenter = presenter
        
        wfDetail.push(vc: (self.presenter?.vc)!, data: model)
    }
    
    
    func displayAlert(title: String? = nil, message: String? = nil) {
        var titleString = "Error"
        var messageString = message
        if title != nil {
            titleString = title!
        }
        if message != nil {
            messageString = message!
        }
        
        let alertController = UIAlertController(title: titleString, message: messageString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            // refetch data
            self.vc?.requestData()
        }))
        self.vc?.present(alertController, animated: true, completion: nil)
    }
}
