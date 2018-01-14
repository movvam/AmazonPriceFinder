//
//  ViewController.swift
//  gs2
//
//  Created by Manikanth Movva on 1/13/18.
//  Copyright © 2018 Manikanth Movva. All rights reserved.
//

import UIKit

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonPressed(_ sender: Any) {
    
        //let urlString: String = searchEntry.text!
        //var urlVar = URL(string: urlString)
    
//        if (urlVar != nil) {
//            urlVar = URL(string: "http://www.google.com/search?q=\(urlString)")
//            //var request = URLRequest.init(url: urlVar!)
        //
        //let urlString = "couch"
        //let urlVar = URL(string: "https://www.google.com/search?output=search&tbm=shop&q=\(urlString)")
        //UIApplication.shared.open(urlVar!, options: [:], completionHandler: nil)
        
        let object = "table"
        //let str = "https://www.google.com/search?output=search&tbm=shop&q=\(object)"
        let str = "https://www.amazon.com/s/ref=nb_sb_noss_2?url=search-alias%3Daps&field-keywords=\(object)"
        
        let urlval = NSURL(string: str)
            do {
                let contents = try String(contentsOf:urlval! as URL, encoding: String.Encoding.utf8)
                //print(contents)
                let price = findAmazonPrice(contents: contents)
                print(price)
            }catch{
                print("rip")
            }
        
        
    }
    
    func findAmazonPrice(contents: String) -> String {
        
        var returnVal = ""

        // Search for one string in another.
        var result = contents.range(of: "Retail ",
                                options: NSString.CompareOptions.literal,
                                range: contents.startIndex..<contents.endIndex,
                                locale: nil)
        if let range = result {
            
            // Start of range of found string.
            var start = range.lowerBound
            
            
            // Display string starting at first index.
            //print(contents[start..<contents.endIndex])
            
            while(contents[start] != "$"){
                start = contents.index(after: start)
            }
            //print(contents[start..<contents.endIndex])
            
            var end = start
            while(contents[end] != " "){
                end = contents.index(after: end)
            }
            end = contents.index(before: end)
            //print(contents[start..<end])
            
            returnVal = String(contents[start..<end])


            // Display string before first index.
            //print(contents[contents.startIndex..<start])
        }
        return returnVal
    }
    
    func findPrice(contents: String){
        let firstDollarSign = contents.index(of: "$") ?? contents.endIndex
        let priceStart = contents.dropFirst(firstDollarSign.encodedOffset)
        let end = priceStart.index(of: "<")
        let trueEnd = priceStart.endIndex
        let num = trueEnd.encodedOffset - end!.encodedOffset
        let finalString = priceStart.dropLast(num)
        print(finalString)
    }
    

}

