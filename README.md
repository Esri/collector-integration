# Collector custom URL scheme

This is a multi-language repository that contains documentation and sample code for creating custom URL schemes in [Collector for ArcGIS](http://doc.arcgis.com/en/collector/).

##Versions Supported

* Collector for ArcGIS iOS 10.4.0 and greater
* Collector for ArcGIS Windows 10.4.0 (beta) and greater

## What's included

* [Documentation](#documentation) on the URL scheme structure
* [Sample code](#sample) for iOS (Swift), and Web (JavaScript)

## Getting started

Read the following documentation, and clone down the appropriate language into your development environment.
<a name="documentation"></a>

## Documentation

####What is the Collector for ArcGIS URL scheme?

A URL scheme allows you to open a native app from another app, website, or email. You can set options in the URL that will be passed to the app you want to open, causing it to perform specific functions, such as opening a web map and centering the map on a given location.  This capability is available on the iOS platform.

####Basic URL scheme structure

All Collector URL schemes start with the identifier `arcgis-collector` and can contain additional parameters that follow the form:

`
arcgis-collector://?parameter=value&parameter=value
`

The rest of this topic describes the various parameters Collector supports.

####Open a web map 

This is one of the simplest schemes that can be used. The following example url scheme demonstrates how to open a specific map within collector.

`itemID`: The web map to open within Collector.  (*optional*)

The following example URL defines opening a web map:

```
arcgis-collector://?itemID=35b1ccecf226485ea7d593f100996b49 
```

####Center at a given location

The location on which to center the map.  

`center`: Specified as a set of latitude, longitude (y,x) coordinates.  Coordinates must be in WGS84 coordinates. (*optional*)

The following example URL defines a map to open and a location to center the map:

```
arcgis-collector://?itemID=35b1ccecf226485ea7d593f100996b49&center=34.0547155,-117.1961714
```

####Scale for provided location

The scale for the given location.  

`scale`: If coordinates are being sent, an optional scale can be specified for the initial zoom to the center point instead of max scale (*optional*)

The following example URL defines a map to open and a location to center and scale the map:

```
arcgis-collector://?itemID=35b1ccecf226485ea7d593f100996b49&center=34.0547155,-117.1961714&scale=2500
```

####Errors
If an error is encountered when processing a URL scheme, the user will receive an alert.
<a name="sample"></a>

## Sample code

* [Swift (iOS)](https://github.com/Esri/collector-integration/tree/master/src/Swift)
* [Python](https://github.com/Esri/collector-integration/tree/master/src/Python)

## Resources and related repositories

* [Collector for ArcGIS documentation](http://doc.arcgis.com/en/collector/)
* [Navigator for ArcGIS integration repository](https://github.com/Esri/navigator-integration)

Not Esri's doc but still pretty dang useful :-)

* [Apple's guide to custom URL schemes](https://developer.apple.com/library/ios/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html#//apple_ref/doc/uid/TP40007899)

## Issues

Find a bug or want to request a new feature? Please let us know by [submitting an issue](https://github.com/Esri/collector-integration/issues/new). Thank you!

## Contributing

Anyone and everyone is welcome to contribute. See our [guidelines for contributing](https://github.com/esri/contributing).

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

[](Esri Tags: iOS, Windows, Collector, URL Scheme)
[](Esri Language: Java, C#, Javascript)
