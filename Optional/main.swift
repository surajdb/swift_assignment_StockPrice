


import Foundation

formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle

var stocklist = [StockHolding]()

var option : Int = 1

func objectOf(stocklist1 : StockHolding)->String // to check to which type the object belongs
{
    if ((stocklist1 as? ForeignStockHolding) != nil)
    {
        return "Foreign"
    }
    else
    {
        return "Local"
    }
}

func addStocks( val1 :Int, type : String) // to add stoks to the stocklist array
{
    print("Please enter buy price of stock")
    let val2 = validOptionFloat(0.0)
    print("Please enter Current price of stock")
    let val3 = validOptionFloat(0.0)
    print("Please enter number of stock")
    let val4 = validOptionString( 1,end: 1000)
    if (type == "local"  )
    {
         stocklist.append(StockHolding(sharePrice: val2, currSharePrice: val3,
                    numOfShare: val4, compName: localStocks[val1]!))
    }
    else
    {
        print("Please enter conversion rate")
        let val5 = validOptionFloat(0.0)
        stocklist.append(ForeignStockHolding(frgnSharePrice: val2, frgnCurrSharePrice: val3,
            frgnNumOfShare: val4, fgrnCompName: forgnStocks[val1]!,conversionRate: val5))
    }
}

func validateStock()->Bool   // to check whether the stocklist array is empty
{
   if stocklist.isEmpty
    {
        print("Please add some stocks and try again !!\n" )
        return false
    }
   else
   {
        return true
   }
}
func checkStock(val: Int, stocktype: Int)-> Bool // to check whether the passed Stock type exist in the Stocklist array
{
    var counter : Int = 0
    for i in 0...stocklist.count-1
    {
       if (stocktype == 1)
        {
            if (stocklist[i].companyName == localStocks[val]!)
            {
                counter = counter + 1
            }
        }
        else
       {
            if (stocklist[i].companyName == forgnStocks[val]!)
            {
                counter = counter + 1
            }
        }
    }
    if (counter > 0)
    {
        return true
    }
    else
    {
        return false
    }
}
func removeStock(val:Int) // to remove a part or complete stock type
{
    print("Stock Number",
          addSpaces(18, str: "Stock Name",var1: 0),
          addSpaces(18, str: "Number of Stocks",var1: 0))
    print(String (count :50, repeatedValue: Character("=")))
    for i in 0...stocklist.count-1
    {
       if (val == 1)
       {
            if ( stocklist[i] as? ForeignStockHolding == nil)
            {
               for (key , values) in localStocks
                {
                 if (values == stocklist[i].companyName)
                    {
                       print(String (format: "%5d%@%10d", key ,
                             addSpaces(26,str: values,var1: 0),
                             stocklist[i].numberOfShares))
                    }
                }
            }
        }
        else
       {
            if ( stocklist[i] as? ForeignStockHolding != nil)
            {
            
                for (key , values) in forgnStocks
                {
                 if (values == stocklist[i].companyName)
                    {
                      print(String (format: "%5d%@%10d", key ,
                            addSpaces(26,str: values,var1: 0),
                            stocklist[i].numberOfShares))
                    }
                }
            }
        }
    }
    var val1: Int = -1
    print("Chose stock number provided above" )
    if (val == 1)
    {
        while (val1 == -1)
        {
            val1 = validOptionString(1,end: localStocks.count)
            if (checkStock(val1,stocktype: 1) != true)
            {
               print("Please enter above provided Stock Number only!")
               val1 = -1
            }
            else
            {
                for i in 0...stocklist.count-1
                {
                    if (stocklist[i].companyName == localStocks[val1]!)
                    {
                        val1 = i
                        break
                    }
                }
            }
        }
    }
    else
    {
        while (val1 == -1)
        {
            val1 = validOptionString(1,end: forgnStocks.count)
            if (checkStock(val1,stocktype: 2) != true)
            {
                print("Please enter above provided Stock Number only!")
                val1 = -1
            }
            else
            {
                for i in 0...stocklist.count-1
                {
                    if (stocklist[i].companyName == forgnStocks[val1]!)
                    {
                        val1 = i
                        break
                    }
                }
            }
        }
    }
    print("Chose number of stocks you want to remove for this stock holding" )
    var val2 = validOptionString(1,end: 10000)
    
    while(stocklist[val1].numberOfShares - val2 < 0 )
    {
        print("Insufficient Stocks!! Please enter number within range\n")
        val2 = validOptionString(1,end: 10000)
    }
    if (stocklist[val1].numberOfShares - val2 == 0)
    {
        stocklist.removeAtIndex((stocklist.indexOf(stocklist[val1]))!)
    }
    else
    {
        stocklist[val1].numberOfShares = stocklist[val1].numberOfShares - val2
    }
    diplaystocks()
}

func calProfit(index : Int)-> Float // to calculate profit percentage for a given stock
{
    return ((stocklist[index].currentSharePrice - stocklist[index].purchaseSharePrice ) * 100
        / stocklist[index].purchaseSharePrice)
}

repeat
{
    while ((option >= 1 && option <= 8) )
    {
        showMenu()
        option = validOptionString(1,end: 9)
        switch option
        {
              case  1:// for adding a stock
                    if (stocklist.count == 8)
                    {
                        print("Maximum stock added! Please remove some existing and try again")
                    }
                    print("Please select type of stock you want to choose :\n1 for Local Stocks\n2 for Foreign Stocks")
                    var a = validOptionString(1,end: 2)
                    if (a == 1)
                    {
                        displayLocalStocks()
                        print("Chose stock number from 1 - \(localStocks.count)" )
                        let val1 = validOptionString(1,end: localStocks.count)
                        addStocks (val1 , type : "local")
                        diplaystocks()
                    }
                    if (a == 2)
                    {
                       displayForgnStocks()
                        print("Chose stock number from 1 - \(forgnStocks.count)" )
                        let val1 = validOptionString(1,end: forgnStocks.count)
                        addStocks (val1 , type : "foriegn")
                        diplaystocks()
                    }
              case  2:// for removing an existing stock
                    if (validateStock()  == true)
                    {
                        diplaystocks()
                        print("Which stock do you want to remove ?\nType 1 for Local and 2 for Foreign")
                        var a = validOptionString(1,end: 2)
                        if (a == 1)
                        {
                            var counter : Int = 0
                            for i in 1...localStocks.count
                            {
                                if (checkStock (i, stocktype: 1) == true)
                                {
                                     counter = counter + 1
                                }
                            }
                            if (counter > 0)
                            {
                                removeStock(a)
                            }
                            else
                            {
                                print("There are no Local stocks in your account! Please add some and try again")
                            }
                        }
                        if (a == 2)
                        {
                            var counter : Int = 0
                            for i in 1...forgnStocks.count
                            {
                                if (checkStock (i, stocktype: 2) == true)
                                {
                                    counter = counter + 1
                                }
                            }
                            if (counter > 0)
                            {
                                removeStock(a)
                            }
                            else
                            {
                                print("There are no foriegn stocks in your account! Please add some and try again")
                            }
                        }
                     }
                    else
                    {
                        break
                    }
              case  3://Diplay stock with least purchase price
                    stocklist.sortInPlace({ $0.purchaseSharePrice < $1.purchaseSharePrice })
                    print("Stock with lowest value is ==>")
                    displayIndividualStock(0)
              case  4://diplay stock with highest purchase price
                    stocklist.sortInPlace({ $0.purchaseSharePrice > $1.purchaseSharePrice })
                    print("Stock with highest value is ==>")
                    displayIndividualStock(0)
              case  5://display Most profitable stock
                    if (stocklist.isEmpty)
                    {
                        print("No Stocks available !")
                        break
                    }
                    var temp :Int = 0
                    var max : Float = calProfit(0)
                    for i in 0...stocklist.count-1
                    {
                        if (max < calProfit(i))
                        {
                            max = calProfit(i)
                            temp = i
                        }
                    }
                    print("Most profitable Stock with profit percentage of \(max) % is ==>")
                    displayIndividualStock(temp)
              case  6://display least profitable stock
                    if (stocklist.isEmpty)
                    {
                        print("No Stocks available !")
                        break
                    }
                    var temp :Int = 0
                    var min : Float = calProfit(0)
                    for i in 0...stocklist.count-1
                    {
                        if (min > calProfit(i))
                        {
                            min = calProfit(i)
                            temp = i
                        }
                    }
                    print("Least profitable Stock with profit percentage of \(min) % is ==>")
                    displayIndividualStock(temp)
              case  7://Diplay stock from A-Z in ascending order of company name
                      stocklist.sortInPlace({ $0.companyName < $1.companyName })
                      diplaystocks()
              case  8://Diplay stocks from lowest to highest purchase price
                      stocklist.sortInPlace({ $0.purchaseSharePrice < $1.purchaseSharePrice })
                      diplaystocks()
              case  9: break
              default: break
            }
    }
}
while (option != 9)
print("Exiting Application...\nHave a good Day 😊😊😊" )
 


