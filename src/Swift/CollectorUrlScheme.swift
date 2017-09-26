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


    /// The URL scheme that triggers Collector for ArcGIS.
    ///
    public static let scheme = "arcgis-collector:"

    /// A convenience property that indicates whether or not Collector for ArcGIS is
    /// installed on the iOS device.
    ///
    /// NOTE: You must declare the `arcgis-collector` URL scheme in the Info.plist of your application
    ///       under the `LSApplicationQueriesSchemes` key.
    ///
    public static var canOpen: Bool {
        return UIApplication.shared.canOpenURL(URL(string: scheme)!)
    }


    /// The specific web map to open when the application is launched.
    ///
    public let itemID: String

    /// The location in which to center the map. Should be in the following format (decimal degrees):
    /// <latitude, longitude>
    ///
    public var center: String?

    /// The URL of the feature layer to start collecting from.
    /// NOTE: This should be the URL to the layer, not the service.
    ///
    public var featureSourceURL: URL?

    /// Attributes to set on the newly created feature. Only keys that
    /// match the feature layer's field names (case-insensitive) should
    /// be used.
    ///
    public var featureAttributes: [String:Any]?


    /// Initializer for the scheme object. Requires at least an `itemID` of the web map to open
    /// on launch.
    ///
    /// - Parameters:
    ///   - itemID: The specific web map to open on launch.
    ///   - center: An optional center point to pan to when the map has finished loading.
    public init(itemID: String, center: String? = nil) {
        self.itemID = itemID
        self.center = center
    }


    /// A method to generate a URL that can be used to create a hyperlink (or from within another iOS application)
    /// to launch Collector with the specified parameters.
    ///
    /// - Returns: A valid URL that can be used to launch Collector for ArcGIS.
    /// - Throws: An Error that occurs while trying to serialize JSON to Data or generate the URL from the given parameters.
    public func generateURL() throws -> URL? {
        
        var stringBuilder = "\(CollectorURLScheme.scheme)//?itemid=\(itemID)"
        
        if let center = center {
            stringBuilder += "&center=\(center)"
        }

        if let url = featureSourceURL?.absoluteString {
            stringBuilder += "&featureSourceURL=\(url)"

            if let attrs = featureAttributes {
                let data = try JSONSerialization.data(withJSONObject: attrs, options: [])
                if let encodedAttributesString = String(data: data, encoding: String.Encoding.utf8)?.queryArgumentEncodedString() {
                    stringBuilder += "&featureAttributes=\(encodedAttributesString)"
                }
            }
        }

        return URL(string: stringBuilder)
    }
}
