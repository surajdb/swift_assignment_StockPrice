//
//  StockHolding.swift
//  Optional
//
//  Created by CryTech on 2016-05-20.
//  Copyright © 2016 CryTech. All rights reserved.
//

import Foundation

public class StockHolding :NSObject
{
    var purchaseSharePrice : Float = 0.0
    var currentSharePrice : Float  = 0.0
    var numberOfShares : Int       = 0
    var companyName : String       = ""    
    
    public init(sharePrice: Float, currSharePrice: Float, numOfShare: Int, compName: String)
    {
        self.purchaseSharePrice = sharePrice
        self.currentSharePrice  = currSharePrice
        self.numberOfShares     = numOfShare
        self.companyName        = compName
    }
    
    public func costInDollars ()-> Float
    {
        return purchaseSharePrice * Float(numberOfShares)
    }
    
    public func valueInDollars ()-> Float
    {
        return currentSharePrice * Float(numberOfShares)
    }
}