//
//  VCListHeroes.swift
//  ImgSearchCy
//
//  Created by Lucy on 17/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class VCListMenu: UIViewController {

   
    @IBOutlet weak var table: UITableView!
  
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var eventHandler : PsListMenu?
    
    var dataCuisine:[String] = [String]() {
        didSet {
           
        }
    }
    var indexCuisineActive: Int = 0
    var model: [ModelFood] = [ModelFood]() {
        didSet {
            
            self.table.reloadData()
            
        }
    }
    
    var modelFiltered: [ModelFood] = [ModelFood]() {
        didSet {
            
        }
    }
    var indexRowSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setUI()
        self.setUpLocalData()
        self.setUpTableHeader()
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestData()
    }
    
    func requestData() {
        self.eventHandler?.fetchFoodData()
    }
    
    private func setUpLocalData() {
        if let model = self.eventHandler?.getCuisineData() {
            self.dataCuisine = model
        }
    }
    
    private func setupTableView() {
        let nibToRegister = UINib(nibName: String(describing: CellTableMenu.self), bundle: nil)
        self.table.register(nibToRegister, forCellReuseIdentifier: String(describing: CellTableMenu.self))
        let nibToRegister2 = UINib(nibName: String(describing: CellTableItem.self), bundle: nil)
        self.table.register(nibToRegister2, forCellReuseIdentifier: String(describing: CellTableItem.self))
       
        self.table.delegate = self
        self.table.dataSource = self
        self.table.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.table.separatorInset = .zero
        self.table.insetsContentViewsToSafeArea = false
        if #available(iOS 13.0, *) {
            self.table.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        self.table.contentInsetAdjustmentBehavior = .never
        self.table.contentOffset = CGPoint.zero
        
    }
    
    private func setUpTableHeader() {
        
    }
    
    private func setUI() {
        //self.navigationItem.title = "All"
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    

}


//MARK: - TableView
extension VCListMenu: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.modelFiltered.count
        }
         //self.modelAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableMenu.self)) as! CellTableMenu
            cell.model = self.model
            cell.data = self.dataCuisine
            cell.refreshUI()
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableItem.self)) as! CellTableItem
            if let str = self.modelFiltered[indexPath.row].name {
                cell.labelName.text = str
            }
            
            if let str = self.modelFiltered[indexPath.row].featured_image {
                if str.count > 1 {
                    cell.imgThumb.setImage(str)
                } else {
                    cell.imgThumb.setImage("https://reviewit.pk/wp-content/uploads/2019/10/img_4307.jpg")
                }
                
            } 
            
            if let str = self.modelFiltered[indexPath.row].average_cost_for_two {
                cell.buttonPrice.setTitle(String(str), for: .normal)
            }
            
            return cell
        }
                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.eventHandler?.goToDetail(index: indexPath.row)
     
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 600
        } else {
            return  250
        }
    }
    
    
}

extension VCListMenu: CellTableMenuDelegate {
    func cellTableMenuDidSelectIndex(index: Int) {
        let cuisine = self.dataCuisine[index]
        self.modelFiltered = self.eventHandler?.interactor?.filterModelWith(str: cuisine) ?? self.model
        self.table.reloadSections(IndexSet(integer: 1), with: .fade)
    }
}
