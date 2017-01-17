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
'''Needed for csv section'''
import csv
'''Needed for xlsx section'''
import xlrd

'''EXAMPLE OF HOW TO BUILD URL FROM CSV OF STOPS USING 'CollectorURLScheme' LIBRARY'''
'''import library'''
# if library is inside folder as your script you can use:
# import CollectorURLScheme
# otherwise below references from the root folder
from src.Python.CollectorURLScheme import CollectorURLScheme, CollectorURLHyperlinks


csvfile_or_xlsxfile = "csv"
csvLocation = ''  # <-- full path to file
xlsxLocation =''  # <-- full path to file

'''User information'''
# example variables -- all optional
start = []  # <-- append the string coord/address and optional string name here i.e. ['43.633332,-70.259971', 'My house']
stops = []  # <-- append a list that includes ^ for each stop (name item is optional) i.e. [['43.681959,-70.092359', 'Jewell Island']]
optimize = "false"  # <-- use string
travelmode = "driving time"  # <-- use string
navigate = "false"  # <-- use string
callback = ["my-cool-app://", "My Cool App"]  # <-- use list (optional callback name)

if csvfile_or_xlsxfile == 'csv':
    '''Iterate over CSV example  --  this assumes addresses in 5th col and address names in 6th col'''
    with open(str(csvLocation)) as csvFile:
        readCSV = csv.reader(csvFile)
        # use this to skip 1 line (i.e. header)
        next(readCSV, None)
        # iterate over each row in csv and assume 1st row is header
        row_count = 1
        for row in readCSV:
            if row_count == 1:
                start.append(str(row[4]))
                start.append(str(row[5]))
            else:
                # build new list
                stop = []  # i.e. ['43.633332,-70.259971', 'My house']
                stop.append(str(row[4]))
                stop.append(str(row[5]))
                stops.append(stop)  # add the list to the stops list
            row_count += 1  # add 1 each row
else:
    '''Iterate over XLXS example  --  this assumes addresses in 5th col and address names in 6th col'''
    # open the workbook
    xl_workbook = xlrd.open_workbook(xlsxLocation)
    # grab the first sheet by index
    xl_sheet = xl_workbook.sheet_by_index(0)
    # iterate over each row in xlsx and assume 1st row is header (note the range start below)
    row_count = 1
    num_cols = xl_sheet.ncols   # number of columns
    for row_idx in range(1, xl_sheet.nrows):
        if row_count == 1:
            start.append(str(xl_sheet.cell(row_idx, 4)))
            start.append(str(xl_sheet.cell(row_idx, 5)))
        else:
            # build new list
            stop = []  # i.e. ['43.633332,-70.259971', 'My house']
            stop.append(str(xl_sheet.cell(row_idx, 4)))
            stop.append(str(xl_sheet.cell(row_idx, 5)))
            stops.append(stop)  # add the list to the stops list
        row_count += 1  # add 1 each row

'''Call to libraries -- Generate single link from data above and generate html page with clickable link'''
# dictionary of variables -- this gets passed to build the url
parameterDictionary = {'start': start, 'stops': stops}  # <-- can add any of these to dictionary: "start", "stops", "optimize", "travelmode", "navigate", "callback"
# assign title if you want to build html link
title = "callbackPrompt_startThenStop"  # <-- some string title
# create CollectorURLScheme object and generateURL
collectorURLObject = CollectorURLScheme(parameterDictionary)
collectorURL = collectorURLObject.generateURL()
# create HTML file with single link
CollectorURLHyperlinks().generateHTMLlink(collectorURL, title)
