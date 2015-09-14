//
//  LFAssetHelper.swift
//  LFPhotoPicker
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 xyb100. All rights reserved.
//  练习单例的写法


import UIKit
import AssetsLibrary

class LFAssetManger: NSObject {
   
    static func shareInstance()->ALAssetsLibrary{
        struct LFAssetManger{
            static var predicate:dispatch_once_t = 0
            static var instance:ALAssetsLibrary? = nil
        }
        dispatch_once(&LFAssetManger.predicate,{
            LFAssetManger.instance=ALAssetsLibrary()
            }
        )
        return LFAssetManger.instance!
    }
}
