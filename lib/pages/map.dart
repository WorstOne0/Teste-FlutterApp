import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key});

  static const _initialCameraPosition =
      CameraPosition(target: LatLng(-24.95480, -53.46551), zoom: 11.5);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _googleMapController;

  Set<Marker> _markers = {
    Marker(
        markerId: MarkerId("0"),
        infoWindow: InfoWindow(title: "Marker 0"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.97140, -53.39399)),
    Marker(
        markerId: MarkerId("1"),
        infoWindow: InfoWindow(title: "Marker 1"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.94932, -53.43281)),
    Marker(
        markerId: MarkerId("2"),
        infoWindow: InfoWindow(title: "Marker 2"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.96516, -53.43650)),
    Marker(
        markerId: MarkerId("3"),
        infoWindow: InfoWindow(title: "Marker 3"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.96868, -53.45526)),
    Marker(
        markerId: MarkerId("4"),
        infoWindow: InfoWindow(title: "Marker 4"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.94356, -53.46428)),
    Marker(
        markerId: MarkerId("5"),
        infoWindow: InfoWindow(title: "Marker 5"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.95063, -53.44927)),
    Marker(
        markerId: MarkerId("6"),
        infoWindow: InfoWindow(title: "Marker 6"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.94769, -53.42848)),
    Marker(
        markerId: MarkerId("7"),
        infoWindow: InfoWindow(title: "Marker 7"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.97798, -53.49503)),
    Marker(
        markerId: MarkerId("8"),
        infoWindow: InfoWindow(title: "Marker 8"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.92228, -53.12451)),
    Marker(
        markerId: MarkerId("9"),
        infoWindow: InfoWindow(title: "Marker 9"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.48524, -53.78541)),
    Marker(
        markerId: MarkerId("10"),
        infoWindow: InfoWindow(title: "Marker 10"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.45214, -53.45214)),
    Marker(
        markerId: MarkerId("11"),
        infoWindow: InfoWindow(title: "Marker 11"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.45785, -53.98451)),
    Marker(
        markerId: MarkerId("12"),
        infoWindow: InfoWindow(title: "Marker 12"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.97452, -53.42184)),
    Marker(
        markerId: MarkerId("13"),
        infoWindow: InfoWindow(title: "Marker 13"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.56874, -53.45314)),
    Marker(
        markerId: MarkerId("14"),
        infoWindow: InfoWindow(title: "Marker 14"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.12347, -53.54687)),
    Marker(
        markerId: MarkerId("15"),
        infoWindow: InfoWindow(title: "Marker 15"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(-24.42347, -53.12314)),
  };

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  void addMarker(LatLng position) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_markers.length.toString()),
          infoWindow: InfoWindow(title: "Marker ${_markers.length}"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: position));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: MapPage._initialCameraPosition,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: _markers,
        onLongPress: addMarker,
      ),
    );
  }
}
