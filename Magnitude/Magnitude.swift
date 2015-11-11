//
//  Magnitude.swift
//  Magnitude
//
//  Created by Idris Khenchil on 11/1/15.
//  Copyright © 2015 Idris Khenchil. All rights reserved.
//

import ScreenSaver
import Cocoa
import SystemConfiguration


public class Magnitude: ScreenSaverView {
    
    //Connectivity test - http://stackoverflow.com/questions/30743408/check-for-internet-conncetion-in-swift-2-ios-9
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    //Set default quote
    struct Core {
        static var quote:NSString! = "\"Failure is an option here. If things are not failing, you are not innovating enough.\""
        static var author:NSString! = "-Elon Musk"
    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary? {
        do {
            if let feed = try NSJSONSerialization.JSONObjectWithData(inputData, options: .MutableContainers) as? NSDictionary {
                // Success block...
                return feed
            }
        }
        catch {
            //return(error)
        }
        return nil
    }
    
    private var fontA: NSFont!
    private var fontB: NSFont!
    private var fontC: NSFont!
    
    func isNight(time: Int) -> Bool{
        if(time >= 6 && time < 22){
            //Is day
            return false
        }
        else{
            //Is night
            return true
        }
    }
    
    
    public override func drawRect(rect: NSRect) {
        
        var background:NSColor
        var quoteAttributes: NSDictionary!
        var authorAttributes: NSDictionary!
        var timeAttributes: NSDictionary!
        
        var todaysAuthor:AnyObject
        var todaysQuote:AnyObject
        
        let date = NSDate()
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("getTime"), userInfo: nil, repeats: true)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = components.hour
        
        if(isNight(hour)){
            //Set background as dark
            background = NSColor(red:0.01, green:0.01, blue:0, alpha:1)
            
            //Set text for dark mode
            quoteAttributes = [
                NSForegroundColorAttributeName: NSColor.whiteColor(),
                NSFontAttributeName: fontA,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            authorAttributes = [
                NSForegroundColorAttributeName: NSColor.whiteColor(),
                NSFontAttributeName: fontB,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            timeAttributes = [
                NSForegroundColorAttributeName: NSColor(red:1, green:0.24, blue:0.22, alpha:1),
                NSFontAttributeName: fontC,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
        }
        else{
            //Set background as light
            background = NSColor(red:1, green:1, blue:1, alpha:1)
            
            //Set text for light mode
            quoteAttributes = [
                NSForegroundColorAttributeName: NSColor.blackColor(),
                NSFontAttributeName: fontA,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            authorAttributes = [
                NSForegroundColorAttributeName: NSColor.blackColor(),
                NSFontAttributeName: fontB,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            
            timeAttributes = [
                NSForegroundColorAttributeName: NSColor(red:0.13, green:0.75, blue:0.99, alpha:1),
                NSFontAttributeName: fontC,
                NSParagraphStyleAttributeName: paragraphStyle
            ]
        }
        
        background.setFill()
        NSBezierPath.fillRect(rect)
        
        
        let attributes = [
            NSForegroundColorAttributeName: NSColor.blackColor()
        ]
        
        let quoteSize = Core.quote!.sizeWithAttributes(quoteAttributes as? [String: AnyObject])
        let authorSize = Core.author!.sizeWithAttributes(authorAttributes as? [String: AnyObject])
        
        var quoteRect: CGRect!
        var authorRect: CGRect!
        
        
        let quoteCount = Core.quote as String
        
        //More lines
        if(quoteCount.characters.count > 100){
            //Get ready for another line
            quoteRect = CGRect(
                x: round((bounds.width - quoteSize.width / 2.20) / 2),
                y: round((bounds.height - quoteSize.height) / 2) - (quoteSize.height / 2),
                width: quoteSize.width / 2.20,
                height: quoteSize.height * 3
            )
            
            //Adjust author to fit
            authorRect = CGRect(
                x: round((bounds.width - authorSize.width) / 2),
                y: round(((bounds.height - quoteSize.height) / 2) - (quoteSize.height + (authorSize.height / 2))),
                width: authorSize.width,
                height: authorSize.height
            )
            
        }
            
        else if(quoteCount.characters.count > 50){
            //Get ready for another line
            quoteRect = CGRect(
                x: round((bounds.width - quoteSize.width / 1.20) / 2),
                y: round((bounds.height - quoteSize.height) / 2) - (quoteSize.height / 2),
                width: quoteSize.width / 1.20,
                height: quoteSize.height * 2
            )
            
            //Adjust author to fit
            authorRect = CGRect(
                x: round((bounds.width - authorSize.width) / 2),
                y: round(((bounds.height - quoteSize.height) / 2) - (quoteSize.height + (authorSize.height / 2))),
                width: authorSize.width,
                height: authorSize.height
            )
        }
        else{
            //All good as is
            quoteRect = CGRect(
                x: round((bounds.width - quoteSize.width) / 2),
                y: round((bounds.height - quoteSize.height) / 1.75) - (quoteSize.height / 2),
                width: quoteSize.width,
                height: quoteSize.height
            )
            
            //Adjust author to fit
            authorRect = CGRect(
                x: round((bounds.width - authorSize.width) / 2),
                y: round(((bounds.height - quoteSize.height) / 1.75) - (quoteSize.height + (authorSize.height / 2))),
                width: authorSize.width,
                height: authorSize.height
            )
        }
        
        //Draw text on canvas
        Core.quote!.drawInRect(quoteRect, withAttributes: quoteAttributes as? [String: AnyObject])
        Core.author!.drawInRect(authorRect, withAttributes: authorAttributes as? [String: AnyObject])
        
        
        //Add time label
        var time = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .NoStyle, timeStyle: .ShortStyle) as NSString
        
        let timeSize = time.sizeWithAttributes(timeAttributes as? [String: AnyObject])
        
        let timeRect = CGRect(
            x: round((bounds.width - timeSize.width) / 2),
            y: 15,
            width: timeSize.width,
            height: timeSize.height
        )
        
        func getTime() {
            let date = NSDate()
            let outputFormat = NSDateFormatter()
            outputFormat.locale = NSLocale(localeIdentifier:"en_US")
            outputFormat.dateFormat = "HH:mm:ss"
            time = String(outputFormat.stringFromDate(date))
        }
        
        time.drawInRect(timeRect, withAttributes: timeAttributes as? [String: AnyObject])
    }
    
    //Called once
    public override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        initialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    /// The screen saver engine calls this whnever it wants to display a new frame.
    public override func animateOneFrame() {
        setNeedsDisplayInRect(bounds)
    }
    
    private func initialize() {
        // Set to 15fps
        animationTimeInterval = 0.15
        updateFont()
        
        let returnedJSON:AnyObject
        let number:Int
        
        if isConnectedToNetwork(){
            number = Int(arc4random_uniform(5-0) + 0)
            
            //Network present, get some quotes
            returnedJSON = parseJSON(getJSON("https://idriskhenchil.me/quote"))!
        }
        else{
            //Fall back to some generic quotes
            number = Int(arc4random_uniform(18-0) + 0)
            
            returnedJSON = [
                [
                    "quote": "Wrinkles should merely indicate where smiles have been.",
                    "author": "Mark Twain"
                ],
                [
                    "quote": "All diseases run into one, old age.",
                    "author": "Ralph Waldo Emerson"
                ],
                [
                    "quote": "Every man over forty is a scoundrel.",
                    "author": "George Bernard Shaw"
                ],
                [
                    "quote": "Age is a very high price to pay for maturity.",
                    "author": "Tom Stoppard"
                ],
                [
                    "quote": "Old age is no place for sissies.",
                    "author": "Bette Davis"
                ],
                [
                    "quote": "It takes a long time to become young.",
                    "author": "Pablo Picasso"
                ],
                [
                    "quote": "After thirty, a body has a mind of its own.",
                    "author": "Bette Midler"
                ],
                [
                    "quote": "Forty is the old age of youth, fifty is the youth of old age.",
                    "author": "Hosea Ballou"
                ],
                [
                    "quote": "Old age is fifteen years older than I am.",
                    "author": "Oliver Wendell Holmes"
                ],
                [
                    "quote": "It is sad to grow old but nice to ripen.",
                    "author": "Brigitte Bardot"
                ],
                [
                    "quote": "Age is how we determine how valuable you are.",
                    "author": "Jane Elliot"
                ],
                [
                    "quote": "Aging seems to be the only available way to live a long life.",
                    "author": "Kitty O'Neill Collins"
                ],
                [
                    "quote": "Old age is a shipwreck.",
                    "author": "Charles de Gaulle"
                ],
                [
                    "quote": "Peace is the one condition of survival in this nuclear age.",
                    "author": "Adlai E. Stevenson"
                ],
                [
                    "quote": "I wish I'd gotten sober at a younger age.",
                    "author": "Janice Dickinson"
                ],
                [
                    "quote": "Nothing amazes me anymore.",
                    "author": "David Beckham"
                ],
                [
                    "quote": "Amazement awaits us at every corner.",
                    "author": "James Broughton"
                ],
                [
                    "quote": "Your best teacher is your last mistake.",
                    "author": "Ralph Nader"
                ],
                [
                    "quote": "Imagination creates reality.",
                    "author": "Richard Wagner"
                ]
            ]
        }
        
        func update(){
            if isConnectedToNetwork(){
                let rawQuote = returnedJSON["data"]!![number]!["quote"]!
                let rawAuthor = returnedJSON["data"]!![number]!["author"]!
                Core.quote =  "\"" + (rawQuote! as! String) + "\""
                Core.author = "-" + String(rawAuthor!)
            }
            else{
                let rawQuote = returnedJSON[number]["quote"]!
                let rawAuthor = returnedJSON[number]["author"]!
                Core.quote = "\"" + (rawQuote! as! String) + "\""
                Core.author = "-" + (rawAuthor! as! String)
            }
        }
        
        update()
    }
    
    private func updateFont() {
        fontA = fontWithSize(bounds.size.width / 32)
        fontB = fontWithSize(bounds.size.width / 55)
        fontC = fontWithSize(bounds.size.width / 52)
    }
    
    //Get a font - https://github.com/soffes/WhatColorIsIt/blob/master/What%20Color%20Is%20It/View.swift#L110
    private func fontWithSize(fontSize: CGFloat) -> NSFont {
        let fontA: NSFont
        if #available(OSX 10.11, *) {
            fontA = NSFont.systemFontOfSize(fontSize, weight: NSFontWeightThin)
        } else {
            fontA = NSFont(name: "HelveticaNeue-Thin", size: fontSize)!
        }
        
        let fontDescriptor = fontA.fontDescriptor.fontDescriptorByAddingAttributes([
            NSFontFeatureSettingsAttribute: [
                [
                    NSFontFeatureTypeIdentifierKey: kNumberSpacingType,
                    NSFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
                ]
            ]
            ])
        return NSFont(descriptor: fontDescriptor, size: fontSize)!
    }
}