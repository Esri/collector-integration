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
from src.Python.CollectorURLScheme import CollectorURLHyperlinks

'''1) Call to libraries -- Generate multiple link pages from explicit list of links'''
# define list of link lists and generate html page
hyperlinkObject = CollectorURLHyperlinks()
explicitURLs = (('arcgis-collector://', 'link1'),
                ('arcgis-collector://?itemID=90472a60554e4093b09311f327b06670', 'link2'),
                ('arcgis-collector://?itemID=90472a60554e4093b09311f327b06670&center=41.772023,-88.152667', 'link3'))
htmlPageTitle = "ExplicitListOfURLs"
hyperlinkObject.generateHTMLpage(explicitURLs, htmlPageTitle)
