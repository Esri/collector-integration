/*
 Copyright 2016 Esri
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */


import Foundation

private extension String {
    private func queryArgumentEncodedString() -> String? {
        let charSet = NSCharacterSet.URLQueryAllowedCharacterSet().mutableCopy() as! NSMutableCharacterSet
        charSet.removeCharactersInString("&")
        
        return stringByAddingPercentEncodingWithAllowedCharacters(charSet)
    }
}

public final class CollectorURLScheme {
    
    public static let scheme = "arcgis-collector:"
    
    public static var canOpen: Bool {
        return UIApplication.sharedApplication().canOpenURL(NSURL(string: scheme)!)
    }
    
    public var itemID: String?
    public var center: String?
    
    public init(itemID: String? = nil, center: String? = nil) {
        self.itemID = itemID
        self.center = center
    }
    
    public func generateURL() throws -> NSURL? {
        
        var stringBuilder = "\(CollectorURLScheme.scheme)//"
        
        if let itemID = itemID {
            stringBuilder = addParameter(stringBuilder, parameterName: "itemid", parameterValue: itemID)
        }
        if let center = center {
            stringBuilder = addParameter(stringBuilder, parameterName: "center", parameterValue: center)
        }
        
        return NSURL(string: stringBuilder)
    }
    
    private func addParameter(stringBuilder: String, parameterName: String, parameterValue: String) -> String {
        return  stringBuilder + (stringBuilder.containsString("?") ? "&" : "?") + parameterName + "=" + parameterValue
    }
}
