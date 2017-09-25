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
import UIKit

fileprivate extension String {
    fileprivate func queryArgumentEncodedString() -> String? {
        var charSet = NSCharacterSet.urlQueryAllowed
        charSet.remove(charactersIn: "&")
        return addingPercentEncoding(withAllowedCharacters: charSet)
    }
}

public final class CollectorURLScheme {
    
    public static let scheme = "arcgis-collector:"
    
    public static var canOpen: Bool {
        return UIApplication.shared.canOpenURL(URL(string: scheme)!)
    }
    
    public var itemID: String
    public var center: String?

    public var featureSourceURL: URL?
    public var featureAttributes: [String:Any]?
    public var featureID: String?
    
    public init(itemID: String, center: String? = nil) {
        self.itemID = itemID
        self.center = center
    }
    
    public func generateURL() throws -> NSURL? {
        
        var stringBuilder = "\(CollectorURLScheme.scheme)//?itemid=\(itemID)"
        
        if let center = center {
            stringBuilder += "&center=\(center)"
        }

        if let url = featureSourceURL?.absoluteString {
            stringBuilder += "&featureSourceURL=\(url)"

            if let attrs = featureAttributes {
                do {
                    let data = try JSONSerialization.data(withJSONObject: attrs, options: [])
                    if let encodedAttributesString = String(data: data, encoding: String.Encoding.utf8)?.queryArgumentEncodedString() {
                        stringBuilder += "&featureAttributes=\(encodedAttributesString)"
                    }
                } catch {}
            }

            if let fid = featureID {
                stringBuilder += "&featureID=\(fid)"
            }
        }

        return NSURL(string: stringBuilder)
    }
}
