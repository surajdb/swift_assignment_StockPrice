//
//  ForeignStockHolding.swift
//  Optional
//
//  Created by CryTech on 2016-05-20.
//  Copyright © 2016 CryTech. All rights reserved.
//

import Foundation

 public class ForeignStockHolding: StockHolding
{
    var conversionRate: Float = 0.0
    
    init(frgnSharePrice: Float, frgnCurrSharePrice: Float, frgnNumOfShare: Int, fgrnCompName: String, conversionRate: Float)
    {
        self.conversionRate = conversionRate
        super.init(sharePrice: frgnSharePrice , currSharePrice: frgnCurrSharePrice, numOfShare: frgnNumOfShare, compName: fgrnCompName)
    }
    
    override public func costInDollars ()-> Float
    {
        return purchaseSharePrice * Float(numberOfShares) * conversionRate
    }
    
    override public func valueInDollars ()-> Float
    {
        return currentSharePrice * Float(numberOfShares) * conversionRate
    }
}