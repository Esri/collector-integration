/*
 
 COPYRIGHT 2016 ESRI
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>
 
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
    
    public struct URLSchemeError: ErrorType {
        let unencodableString: String
    }
    
    
    public var itemid: String
    public var center: String?
    
    public init(itemid: String, center: String? = nil) {
        self.itemid = itemid
        self.center = center
    }
    
    public func generateURL() throws -> NSURL? {
        
        var stringBuilder = "\(CollectorURLScheme.scheme)//?itemid=\(itemid)"
        
        if let center = center {
            stringBuilder += "&center=\(center)"
        }

        return NSURL(string: stringBuilder)
    }
}
