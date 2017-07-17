# Test data for ReadWaterML2 command #

These files are test data for the `ReadWaterML2()` command.
Test command files typically have a commented-out command to download the data used for the test.
Multiple commands use the same data so updating any data will likely impact multiple commands.

The WaterML 2.0 specification a root element of `Collection`, with other WaterML 2 elements that follow.
See [OGC WaterML standard](http://www.opengeospatial.org/standards/waterml) and
[WaterML 2.0 - Getting Started](http://external.opengeospatial.org/twiki_public/WaterML/WaterML2GettingStarted).

The USGS web services additionally wrap the standard WaterML 2.0 content with a `FeatureCollection` as shown below:

```xml
<gml:FeatureCollection gml:id="USGS.waterservices" xsi:schemaLocation="http://www.opengis.net/waterml/2.0 http://schemas.opengis.net/waterml/2.0/waterml2.xsd" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:wml2="http://www.opengis.net/waterml/2.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:om="http://www.opengis.net/om/2.0" xmlns:sa="http://www.opengis.net/sampling/2.0" xmlns:sams="http://www.opengis.net/samplingSpatial/2.0" xmlns:swe="http://www.opengis.net/swe/2.0">
  <gml:featureMember>
    <wml2:Collection gml:id="C.USGS.09070500">

```
This requires that software be able to handle either variant.
