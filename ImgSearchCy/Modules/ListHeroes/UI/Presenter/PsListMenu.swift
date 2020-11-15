//
//  PsListHeroes.swift
//  ImgSearchCy
//
//  Created by Lucy on 17/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class PsListMenu: BaseViewModel {
    var wfVc: WfListMenu?
    var interactor: IListMenu?
    var vc : VCListMenu?
    
    var dataSourceObservable = BehaviorRelay<[ModelResto]?>(value:nil)
    var dataSource: [ModelResto]? {
        get {
            return dataSourceObservable.value
        }
        set {
            dataSourceObservable.accept(newValue)
        }
    }
    
    func fetchFoodData() {
        if let interactor = self.interactor {
            if let data = interactor.dataManager?.retrieveFood() {
                if data.count > 0 {
                    self.vc?.model = data
                    //self.dataSource = data
                    self.vc?.model = data
                    self.interactor?.model = data
                    self.vc?.modelFiltered = self.interactor?.filterModelWith(str: "singapore") ?? data
                    
                } else {
                    if Connectivity.isConnectedToInternet {
                        interactor.fetchResto()
                            .catchError({ [unowned self] error -> Observable<[ModelResto]?> in
                                self.handleNetworkError(error)
                                self.wfVc?.displayAlert(message: error.localizedDescription)
                                return Observable.just(nil)
                            })
                            .subscribe(onNext: { [unowned self] modelResponse in
                                if let validModel = modelResponse {
                                    var arrModelFood: [ModelFood] = [ModelFood]()
                                    for model in validModel {
                                        if let modelRest = model.restaurant {
                                            arrModelFood.append(modelRest)
                                        }
                                    }
                                    self.interactor?.dataManager?.saveFoodies(arrModelFood)
                                    self.dataSource = validModel
                                    self.state.accept(.finished)
                                    self.interactor?.model = arrModelFood
                                    self.vc?.model = arrModelFood
                                    
                                    self.vc?.modelFiltered = self.interactor?.filterModelWith(str: "singapore") ?? arrModelFood
                                    //
                                } else {
                                    self.state.accept(.failed)
                                }
                            }).disposed(by: disposeBag)
                    } else {
                        self.wfVc?.displayAlert(message:"No Internet Connection")
                    }
                }
            }
        }
    }
    
   
    func getCuisineData() -> [String]? {
        
        if let arr = self.interactor?.dataManager?.arrCuisine {
            return arr
        }
        return nil
    }
    
    func goToDetail(model: ModelFood) {
        self.wfVc?.navigateToDetail(model: model)
    }
}
