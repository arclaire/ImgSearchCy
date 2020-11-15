//
//  CellTableRoles.swift
//  ImgSearchCy
//
//  Created by Lucy on 22/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

protocol CellTableMenuDelegate: NSObjectProtocol {
    func cellTableMenuDidSelectIndex(index: Int)
}


class CellTableMenu: UITableViewCell {

    @IBOutlet weak var viewCover: UIView!
    @IBOutlet weak var vwContainer: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var flowLayoutMenu: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionMenu: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionBanner: UICollectionView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    weak var delegate: CellTableMenuDelegate?
    var indexActive: Int = 0
    var model: [ModelFood]? {
        didSet {
            
        }
    }
    var data: [String]? {
        didSet {
           
        }
    }
   
    var timer: Timer?
    let SLIDE_TIME = 2.0
    var pageIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCollectionView()
        //self.vwContainer.backgroundColor = UIColor.systemPink
        timer = Timer.scheduledTimer(timeInterval: SLIDE_TIME, target: self, selector: #selector(onTimeSlideTriggered), userInfo: nil, repeats: true)
        // Initialization code
    }

    @objc func onTimeSlideTriggered() {
        if let data = self.model {
            if self.pageIndex < data.count {
                self.pageIndex += 1
            } else {
                self.pageIndex = 0
            }
            
            var rect = CGRect.zero
            rect.origin.x = CGFloat(self.pageIndex) * self.collectionBanner.bounds.width
            rect.size.width = self.collectionBanner.bounds.width
            rect.size.height = self.collectionBanner.bounds.height
            self.collectionBanner.scrollRectToVisible(rect, animated: true)//scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            self.pageControl.currentPage = self.pageIndex
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setUpCollectionView() {
        self.viewCover.layer.cornerRadius = 30
        self.collectionBanner.delegate = self
        self.collectionBanner.dataSource = self
        self.collectionBanner.showsHorizontalScrollIndicator = false
        self.collectionBanner.showsVerticalScrollIndicator = false
        self.collectionBanner.backgroundColor = UIColor.white
        self.collectionBanner.contentInset = UIEdgeInsets.zero
        self.collectionBanner.isPagingEnabled = true
        
        self.collectionMenu.delegate = self
        self.collectionMenu.dataSource = self
        self.collectionMenu.showsHorizontalScrollIndicator = false
        self.collectionMenu.showsVerticalScrollIndicator = false
        self.collectionMenu.backgroundColor = UIColor.white
        self.collectionMenu.contentInset = UIEdgeInsets.zero
        self.flowLayout.minimumInteritemSpacing = 0
        self.flowLayout.minimumLineSpacing = 0
        self.flowLayoutMenu.minimumInteritemSpacing = 0
        self.flowLayoutMenu.minimumLineSpacing = 0
        
        let nib = UINib(nibName: String(describing: CellCollectionHeroes.self), bundle: nil)
        self.collectionBanner.register(nib, forCellWithReuseIdentifier: String(describing: CellCollectionHeroes.self))
        
        let nib2 = UINib(nibName: String(describing: CellCollectionHeroes.self), bundle: nil)
        self.collectionMenu.register(nib2, forCellWithReuseIdentifier: String(describing: CellCollectionHeroes.self))
    }
    
    func refreshUI() {
        self.collectionMenu.reloadData()
        self.collectionBanner.reloadData()
        self.pageControl.numberOfPages = self.model?.count ?? 1
        
    }
    
}

extension CellTableMenu: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionBanner {
            return self.model?.count ?? 0
        } else {
            return self.data?.count ?? 0
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionBanner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CellCollectionHeroes.self), for: indexPath) as! CellCollectionHeroes
            if let data = self.model {
                if let str = data[indexPath.row].featured_image {
                    cell.setDataToUI(model: str, hideTitle: true)
                }
                
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CellCollectionHeroes.self), for: indexPath) as! CellCollectionHeroes
            if let data = self.data {
                cell.setDataToUI(model: data[indexPath.row], hideTitle: false)
            }
            if indexPath.row == indexActive {
                cell.labelTitle.textColor = UIColor.blue
            } else {
                cell.labelTitle.textColor = UIColor.black
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionMenu {
            self.indexActive = indexPath.row
            self.collectionMenu.reloadData()
            self.delegate?.cellTableMenuDidSelectIndex(index: indexPath.row)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = self.collectionBanner.bounds.size.width / 2
        var height: CGFloat = self.collectionMenu.bounds.size.height
        if collectionView == self.collectionBanner {
            width = self.collectionBanner.bounds.size.width
            height = 600 - self.collectionMenu.bounds.size.height
        }
       
        let size = CGSize(width: width, height: height)
        
        return size
    }
}
