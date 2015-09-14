//
//  LFPhotoPickerController.swift
//  LFPhotoPicker
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xyb100. All rights reserved.

//  获取系统相册的图片,并实现多张选择  以及代理的用法

import UIKit
import AssetsLibrary

protocol LFPhotoPickerControllerDelegate:NSObjectProtocol{


    func selectImage(photos:NSArray)
    
}

class LFPhotoPickerController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

var delegate:LFPhotoPickerControllerDelegate?
    var collectView:UICollectionView?
    var selePhotos = NSMutableArray()
    var seleImageNameArray = NSMutableArray()
    var photos = NSMutableArray()
    var currentGroup:ALAssetsGroup?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "图片选择";
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: self, action: "cancel")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.Done, target: self, action: "confirm")
       self.makeUI()
        self.reloadImage()
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
        self.collectView?.registerClass(LFCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func reloadImage(){

         LFAssetManger.shareInstance().enumerateGroupsWithTypes(ALAssetsGroupType(ALAssetsGroupSavedPhotos),
            usingBlock: {
                group, stop in
                if group != nil {
                    self.showPhoto(group)
                
                }
            },
            failureBlock: {
                error in
                println("error occurred: \(error.localizedDescription)")
        })
        
    }
    
    func showPhoto(group:ALAssetsGroup!){
    
        if group != nil{
        
            if self.currentGroup == nil || !((self.currentGroup?.valueForProperty(ALAssetsGroupPropertyName) as! NSString).isEqualToString(group.valueForProperty(ALAssetsGroupPropertyName) as! NSString as! String)){
            
                self.currentGroup = group;
                if self.photos.count == 0 {
                
                    self.photos = NSMutableArray()
                }else{
                
                    self.photos.removeAllObjects()
                }
                
                self.currentGroup?.setAssetsFilter(ALAssetsFilter.allPhotos())
                
                self.currentGroup?.enumerateAssetsUsingBlock({
                    asset, index, stop in
                    
                    if (asset != nil) {
                        
                        self.photos.addObject(asset)
                    }else{}
                })
                
                self.title = self.currentGroup?.valueForProperty(ALAssetsGroupPropertyName) as? String
                self.collectView?.reloadData()
                
            }
            
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: LFCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! LFCollectionViewCell
    
        let asset = self.photos.objectAtIndex(indexPath.item) as! ALAsset
        cell.imageView.image = UIImage(CGImage: asset.thumbnail().takeUnretainedValue())
    
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell:LFCollectionViewCell = collectView?.cellForItemAtIndexPath(indexPath) as! LFCollectionViewCell
        if cell.selectBtn.selected == false {
           cell.selectBtn.selected = true
            let asset:ALAsset = self.photos.objectAtIndex(indexPath.row) as! ALAsset
            self.selePhotos.addObject(asset)
            self.seleImageNameArray.addObject(asset.valueForProperty(ALAssetPropertyAssetURL))
        }else{
        
            cell.selectBtn.selected = false
            let asset:ALAsset = self.photos.objectAtIndex(indexPath.row) as! ALAsset
            for ass in self.selePhotos{
            
                let str1:NSURL = asset.valueForProperty(ALAssetPropertyAssetURL) as! NSURL
                let str2:NSURL = ass.valueForProperty(ALAssetPropertyAssetURL) as! NSURL
                if str1.isEqual(str2){
                
                    self.selePhotos.removeObject(ass)
                    break
                }
            }
            self.seleImageNameArray.removeObject(asset.valueForProperty(ALAssetPropertyAssetURL))
        }
    }


    func confirm(){
        
        if (self.delegate?.respondsToSelector("selectImage:") != nil){
        
            self.delegate?.selectImage(self.selePhotos)
        }

    
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func cancel(){
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
