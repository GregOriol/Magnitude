//
//  Magnitude.swift
//  Magnitude
//
//  Created by Idris Khenchil on 11/1/15.
//  Copyright © 2015 Idris Khenchil. All rights reserved.
//

import ScreenSaver

public class Magnitude: ScreenSaverView {
    public override func drawRect(rect: NSRect) {
        let quote = "Great companies are built on great products." as NSString
        let author = "Elon Musk"
        
        let attributes = [
            NSForegroundColorAttributeName: NSColor.blackColor()
        ]
        
        let quoteSize = quote.sizeWithAttributes(attributes)
        let authorSize = author.sizeWithAttributes(attributes)
        
        let authorRect = CGRect(
            x: round((bounds.width - authorSize.width) / 2),
            y: round(((bounds.height - authorSize.height) / 2) - 20),
            width: authorSize.width,
            height: authorSize.height
        )
        
        let quoteRect = CGRect(
            x: round((bounds.width - quoteSize.width) / 2),
            y: round((bounds.height - quoteSize.height) / 2),
            width: quoteSize.width,
            height: quoteSize.height
        )
        
        //Draw text on canvas
        quote.drawInRect(quoteRect, withAttributes: attributes)
        author.drawInRect(authorRect, withAttributes: attributes)
    }
}
