//
//  Vendoer.h
//  Estay
//
//  Created by jerry on 14-11-1.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#ifndef Estay_CommonVendor
#define Estay_CommonVendor
#pragma mark --------------------------- 百度地图
//百度地图 比例尺 对应的地图缩放级别
typedef enum BMapScaleBarToMap_Level{
    BMapScaleBar20M=19,
    BMapScaleBar50M=18,
    BMapScaleBar100M=17,
    BMapScaleBar200M=16,
    BMapScaleBar500M=15,
    BMapScaleBar1KM=14,
    BMapScaleBar2KM=13,
    BMapScaleBar5KM=12,
    BMapScaleBar10KM=11,
    BMapScaleBar20KM=10,
    BMapScaleBar25KM=9,
    BMapScaleBar50KM=8,
    BMapScaleBar100KM=7,
    BMapScaleBar200KM=6,
    BMapScaleBar500KM=5,
    BMapScaleBar1000KM=4,
    BMapScaleBar2000KM=3,
    BMapScaleBar5000KM=2,//该级别手机不可用
    BMapScaleBar10000KM=1//该级别手机不可用
}BMapScaleBarToMapLevel;
#endif
