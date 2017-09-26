"""
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
"""

'''EXAMPLE OF HOW TO CALL -- THIS WOULD ALL BE OUTSIDE LIBRARY'''
'''import library'''
# if library is inside folder as your script you can use:
# import CollectorURLScheme
# or explicitly point to folders with dot notation
from src.Python.CollectorURLScheme import CollectorURLScheme, CollectorURLQRCode

'''1) Specify if you want to generate or use explicit url'''
GENERATEURL = True

'''2a) Example variables for building url -- USE THIS INFO IF YOU WANT TO GENERATE A HTML PAGE USING LIBRARY GENERATED URL'''
itemID = '90472a60554e4093b09311f327b06670'
center = '41.772023,-88.152667'
featureSourceURL = 'https://sampleserver6.arcgisonline.com/arcgis/rest/services/DamageAssessment/FeatureServer/0'
featureAttributes = {"numoccup":5, "descdamage":"Needs Attention"} 
parameterDictionary = {'itemID': itemID, 'center': center,'featureSourceURL': featureSourceURL, 'featureAttributes': featureAttributes}

'''2b) Example string for explicit url -- USE THIS INFO IF YOU WANT TO GENERATE A HTML PAGE USING EXPLICIT URL'''
explicitURL = 'arcgis-collector://?itemID=90472a60554e4093b09311f327b06670'
title = "simple_openMap"

'''3) Call to libraries -- Generate single link pages from data above'''
if GENERATEURL:
    collectorURLObject = CollectorURLScheme(parameterDictionary)  # create CollectorURLScheme object and generateURL
    outputURL = collectorURLObject.generateURL()  # based on above setting, build or use explicit url
else: outputURL = explicitURL

CollectorURLQRCode().returnQRCodeText(outputURL)
CollectorURLQRCode().saveQRCodeSVG(outputURL, title)
CollectorURLQRCode().saveQRCodePNG(outputURL, title)


