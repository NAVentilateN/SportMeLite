import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    const fitMapToMarkers = (map, markers) => {
      const bounds = new mapboxgl.LngLatBounds();
      markers.forEach( marker => {
        bounds.extend([ marker.lng, marker.lat ]);
        });
      map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    };

    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10',
    });

    // Add markers to the map.
    let markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window);
    new mapboxgl.Marker({})
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
    });
    fitMapToMarkers(map, markers);

    // Add geolocate control to the map.

    if (document.querySelectorAll('.mapboxgl-marker').length > 1) {
      map.addControl(
        new mapboxgl.GeolocateControl({
          positionOptions: {
              enableHighAccuracy: true
          },
          // When active the map will receive updates to the device's location as it changes.
          trackUserLocation: true
          // Draw an arrow next to the location dot to indicate which direction the device is heading.
        })
      );
    }
  }
};
export { initMapbox };
