//
//  Massege.swift
//  Breaker
//
//  Created by Amr Ali on 5/1/18.
//  Copyright © 2018 AAA. All rights reserved.
//

import Foundation

class Massege {
    
    private var _Content :String
    private var _SenderId :String
    
    var Content :String
    {
        return _Content
    }
    
    var SenderId :String
    {
        return _SenderId
    }
    
    init(Content : String , SenderId : String) {
        self._SenderId = SenderId
        self._Content = Content
    }

}
