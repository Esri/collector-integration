# Collector custom URL scheme

This is a multi-language repository that contains documentation and sample code for creating custom URL schemes in [Collector for ArcGIS](http://doc.arcgis.com/en/collector/).

## Supported versions

* Collector for ArcGIS 10.4.0 or later on iOS and Windows 10, and Collector for ArcGIS 10.4.1 or later on Android

## What's included

* [Documentation](#documentation) on the URL scheme structure
* [Sample code](#sample) for iOS (Swift), Windows (.NET), Android (Java), and Python

## Get started

Read the following documentation and clone down the appropriate language into your development environment.
<a name="documentation"></a>

## Documentation

#### Collector URL scheme overview

A URL scheme allows you to launch a native app from another app, website, or email. You can set options in the URL that will be passed to the app you want to open, causing it to perform specific functions, such as opening a web map and centering the map on a given location.  This capability is available on all platforms.

Support for featureSourceURL and featureAttributes parameters is available in Collector 17.0.3 or later (iOS and Android only).

#### Basic Collector URL scheme structure

All Collector URL schemes start with the identifier `arcgis-collector` and can contain additional parameters that follow the form:

`
arcgis-collector://?parameter=value&parameter=value
`

The remainder of this topic describes the various parameters Collector currently supports.

#### Open a web map 

This is one of the simplest schemes that can be used. The following example URL scheme demonstrates how to open a specific map within Collector.

`itemID`: The web map to open in Collector.  

The following example URL defines opening a web map:

```
arcgis-collector://?itemID=35b1ccecf226485ea7d593f100996b49 
```

#### Center at a given location

The location on which to center the map.  

`center`: (*optional*) Specified as a set of latitude, longitude (y,x) coordinates. Coordinates must be in WGS84. 

The following example URL defines a map to open and a location to center the map:

```
arcgis-collector://?itemID=35b1ccecf226485ea7d593f100996b49&center=34.0547155,-117.1961714
```

#### Initiate a new feature collection 

Starts a feature collection for a specific layer in the map.

`featureSourceURL`: (*optional*) The URL to the layer or table in which to collect a feature.


This will start the collect activity and filter the list of available feature templates to those associated with the `featureSourceURL`. 
If `center` is passed this will be used as the geometry for a point feature, or the first vertex in a line or polygon feature.  Collection of new related tables is not supported.

The following example URL initiates a feature collection for a layer, and the center is used to define the new feature's geometry:

```
arcgis-collector://?itemID=5d417865c4c947d19a26a13c7d320323&center=43.524080, 5.445545&featureSourceURL=http://sampleserver5a.arcgisonline.com/arcgis/rest/services/LocalGovernment/Recreation/FeatureServer/0
```

#### Initiate a new feature collection and specify attributes

Include a set of attribute field values to populate to the new feature collection.  

`featureAttributes`: (*optional*) A JSON dictionary of attributes to apply to the new feature collection.

A`featureSourceURL` must be passed.

All attribute values specified will overwrite any existing values present.  If a field is not present, or the type is incorrect, the attribute value will be ignored.

Date fields should be represented as a numeric value (epoch time). Fields with an associated coded domain value should use the domain code.  Do not use the domain description.

Feature attributes should be URL encoded prior to being passed to Collector. 

The following example URL specifies a layer to start a collection activity, uses the `center` parameter for the geometry, and includes values to populate two fields:

```
arcgis-collector://?itemID=5d417865c4c947d19a26a13c7d320323&center=43.524080, 5.445545&featureSourceURL=http://sampleserver5a.arcgisonline.com/arcgis/rest/services/LocalGovernment/Recreation/FeatureServer/0&featureAttributes={”quality”:2,“observed”:1502917218285}
```

Feature attributes should be URL encoded prior to being passed to Collector. 

The following URL is identical to the previous example, only this has been URL encoded:

```
arcgis-collector://?itemID=5d417865c4c947d19a26a13c7d320323&center=43.524080, 5.445545&featureSourceURL=http://sampleserver5a.arcgisonline.com/arcgis/rest/services/LocalGovernment/Recreation/FeatureServer/0&featureAttributes=%7B%22quality%22:2,%22observed%22:1502917218285%7D
```

#### Errors
If an error is encountered when processing a URL scheme with an `itemID` and `center`, the user will receive an alert.  Errors encountered in processing `featureSourceURL` and `featureAttributes` parameters will not be presented to the user.
<a name="sample"></a>

## Sample code

* [Swift (iOS)](https://github.com/Esri/collector-integration/tree/master/src/Swift)
* [.NET (Windows)](https://github.com/Esri/collector-integration/tree/master/src/dotnet)
* [Java (Android)](https://github.com/Esri/collector-integration/tree/master/src/java)
* [Python](https://github.com/Esri/collector-integration/tree/master/src/Python)

## Resources

* [Collector for ArcGIS documentation](http://doc.arcgis.com/en/collector/)
* [Navigator for ArcGIS integration repository](https://github.com/Esri/navigator-integration)
* [Apple's guide to custom URL schemes](https://developer.apple.com/library/ios/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899)

## Issues

Find a bug or want to request a new feature? Please let us know by [submitting an issue](https://github.com/Esri/collector-integration/issues/new). Thank you!

## Contributing

Esri welcomes contributions from anyone and everyone. Please see our [guidelines for contributing](https://github.com/esri/contributing).

## Licensing
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

A copy of the license is available in the repository's [license.txt]( https://raw.github.com/Esri/collector-integration/master/license.txt) file.

[](Esri Tags: iOS Windows Collector URL-Scheme C-Sharp)
[](Esri Language: Swift)
