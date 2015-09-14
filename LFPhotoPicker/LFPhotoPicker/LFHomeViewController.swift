//
//  LFHomeViewController.swift
//  LFPhotoPicker
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xyb100. All rights reserved.
//

import UIKit
<<<<<<< Updated upstream
import AssetsLibrary
class LFHomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,LFPhotoPickerControllerDelegate {
   var collectView:UICollectionView?
    var imageArray = NSMutableArray()
=======

class LFHomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
   var collectView:UICollectionView?
    var imageArray = NSArray()
>>>>>>> Stashed changes
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "图片展示";
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "清除", style: UIBarButtonItemStyle.Done, target: self, action: "clearImage")
<<<<<<< Updated upstream
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "选择", style: UIBarButtonItemStyle.Done, target: self, action: "openPhotoLibrary")
=======
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "选择", style: UIBarButtonItemStyle.Done, target: self, action: "selectImage")
>>>>>>> Stashed changes
        
        self.makeUI()
    }
    
    func makeUI(){
    let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let margin:CGFloat = 5
        let itemW = (UIScreen.mainScreen().bounds.size.width - 4 * margin)/3
        let itemH = itemW
        layout.itemSize = CGSizeMake(itemW, itemH)
        
        let X:CGFloat = 5
        let W = UIScreen.mainScreen().bounds.size.width - 2 * X
        let H = UIScreen.mainScreen().bounds.size.height
       self.collectView = UICollectionView(frame: CGRectMake(X, 0, W, H), collectionViewLayout: layout)
        self.view.addSubview(self.collectView!)
        self.collectView?.delegate = self
        self.collectView?.dataSource = self
        self.collectView?.backgroundColor = UIColor.whiteColor()
     self.collectView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        var imageview = UIImageView(frame: cell.bounds)
        cell.contentView.addSubview(imageview)
        imageview.image = self.imageArray.objectAtIndex(indexPath.item) as? UIImage
        return cell
    }
<<<<<<< Updated upstream
    // 代理的方法
    func selectImage(photos: NSArray) {
        
        for var i = 0;i < photos.count; i++ {
        
            let asset:ALAsset = photos.objectAtIndex(i) as! ALAsset
            var image = UIImage(CGImage: asset.defaultRepresentation().fullScreenImage().takeUnretainedValue())
            self.imageArray.addObject(image!)
        }
        
        self.collectView?.reloadData()
    
    }
    func openPhotoLibrary(){
    
        let photoPickeVc = LFPhotoPickerController()
        photoPickeVc.delegate = self
=======
    func selectImage(){
    
        let photoPickeVc = LFPhotoPickerController()
>>>>>>> Stashed changes
        let nav = UINavigationController(rootViewController: photoPickeVc)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    func clearImage(){
    
<<<<<<< Updated upstream
        self.imageArray.removeAllObjects()
        self.collectView?.reloadData()
=======
>>>>>>> Stashed changes
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
