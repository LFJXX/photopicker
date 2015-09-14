//
//  LFCollectionViewCell.swift
//  LFPhotoPicker
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xyb100. All rights reserved.

//  自定义UICollectViewCell

//

import UIKit

class LFCollectionViewCell: UICollectionViewCell {
   
    var imageView:UIImageView!
    var selectBtn:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var imageView = UIImageView(frame: self.contentView.bounds)
        self.imageView = imageView
        self.contentView.addSubview(imageView)
        
        let W = self.contentView.bounds.size.width;
        let H = self.contentView.bounds.size.height;
        let btnW:CGFloat = 20;
        let btnH = btnW;
        var btn = UIButton(frame: CGRectMake(W-btnW, H-btnH, btnW, btnH))
        btn.setBackgroundImage(UIImage(named: "pic_unchecked_icon"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "pic_checked_icon"), forState: UIControlState.Selected)
        self.selectBtn = btn;
        self.contentView.addSubview(btn)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   
}
