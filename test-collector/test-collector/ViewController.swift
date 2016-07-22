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

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    
    let tests = [
        ("Launch", "arcgis-collector://"),
        ("Just Center", "arcgis-collector://?center=34.0547155,-117.1961714"),
        ("Open Item With ID", "arcgis-collector://?itemid=ab914ba3a7914e8f810efcace999906e"),
        ("Open Item and Center", "arcgis-collector://?itemid=ab914ba3a7914e8f810efcace999906e&center=34.0547155,-117.1961714"),
        ("Bad Item", "arcgis-collector://?itemid=636363636363"),
        ("Bad coordinates", "arcgis-collector://?center=33434344.0547155,-11343437.1961714"),
        ("Bad number params", "arcgis-collector://?center=33434344.0547155,-11343437.1961714&itemid"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.dataSource = self
        picker.delegate = self
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tests.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tests[row].0
    }
    
    @IBAction func executeTest(sender: AnyObject) {
        let url = NSURL(string: tests[picker.selectedRowInComponent(0)].1)!
        UIApplication.sharedApplication().openURL(url)
    }
}

