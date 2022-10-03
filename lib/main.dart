import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

int counter = 0;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyMapWidget(),
    );
  }
}

class MyMapWidget extends StatelessWidget {
  MyMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CustomPoint xyPoint =
        CrsSimple().latLngToPoint(LatLng(52.20008, 13.404954), 18.0);
    print(xyPoint.x);

    return Scaffold(
      body: map_widget,
    );
  }
}

FlutterMap map_widget = FlutterMap(
  options: MapOptions(
    center: LatLng(52.502556472061276, 13.390568014803453),
    zoom: 18,
  ),
  nonRotatedChildren: [
    AttributionWidget.defaultWidget(
      source: 'OpenStreetMap contributors',
      onSourceTapped: null,
    ),
  ],
  children: wms_tilelayer,
);

dynamic wms_tilelayer = [
  TileLayer(
    wmsOptions: WMSTileLayerOptions(
      baseUrl: 'https://a.s2maps-tiles.eu/wms/?',
      layers: ['s2cloudless-2018_3857'],
      //transparent: false, //Egal wenn nicht format: 'image/png'
    ),
    userAgentPackageName: 'noreply.amazon.com',
  ),
  // TileLayer(
  //   wmsOptions: WMSTileLayerOptions(
  //     baseUrl: 'http://nowcoast.noaa.gov/wms/com.esri.wms.Esrimap/obs',
  //     layers: ['RAS_RIDGE_NEXRAD'],
  //     format: 'image/png',
  //     transparent: true,
  //   ),
  // )
];

dynamic wmts_tilelayer = [
  TileLayer(
      urlTemplate:
          'https://a.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.app',
      tileBuilder: (context, widget, tile) => Stack(
          fit: StackFit.passthrough, children: getTile(context, widget, tile))),
  TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.app',
      tileBuilder: (context, widget, tile) => Stack(
          fit: StackFit.passthrough, children: getTile(context, widget, tile))),
];

List<Widget> getTile(c, w, t) {
  counter++;
  if (counter.isOdd) {
    return [
      w,
      const Center(child: Text('ODD')),
    ];
  }
  return [
    w,
    Center(
        child: Text(
            '${t.coords.x.floor()} : ${t.coords.y.floor()} : ${t.coords.z.floor()}')),
  ];
}
