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
from src.Python.CollectorURLScheme_GeneratorLibrary.CollectorURLScheme import CollectorURLScheme, CollectorURLHyperlinks

'''1) Specify if you want to generate or use explicit url'''
GENERATEURL = True


'''2a) Example variables for building url -- USE THIS INFO IF YOU WANT TO GENERATE A HTML PAGE USING LIBRARY GENERATED URL'''
itemID = '2adf08a4a1a84834a773805a6e86f69e'
center = '43.656789,-70.278083'
# dictionary of variables -- parameters are optional by deleting key/value
parameterDictionary = {'itemID': itemID, 'center': center}

'''2b) Example string for explicit url -- USE THIS INFO IF YOU WANT TO GENERATE A HTML PAGE USING EXPLICIT URL'''
explicitURL = 'arcgis-collector://?itemID=2adf08a4a1a84834a773805a6e86f69e'
title = "simple_openMap"

'''3) Call to libraries -- Generate single link pages from data above'''
if GENERATEURL:
    collectorURLObject = CollectorURLScheme(parameterDictionary)  # create CollectorURLScheme object and generateURL
    outputURL = collectorURLObject.generateURL()  # based on above setting, build or use explicit url
else: outputURL = explicitURL

CollectorURLHyperlinks().generateHTMLlink(outputURL, title)  # create HTML file with single link


