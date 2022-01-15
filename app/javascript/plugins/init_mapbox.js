import mapboxgl from 'mapbox-gl';
// import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  let lightMode = localStorage.getItem("lightMode");
  const mapElement = document.getElementById('map');

  if (mapElement) {
    const fitMapToMarkers = (map, markers) => {
      const bounds = new mapboxgl.LngLatBounds();
      markers.forEach( marker => {
        bounds.extend([ marker.lng, marker.lat ]);
        });
      map.fitBounds(bounds, { padding: 50, maxZoom: 15, duration: 0 });
    };

    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    let map = new mapboxgl.Map({
        container: 'map'
      });
    if (lightMode == 'true') {
      map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/light-v10'
      });
    } else {
      map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/dark-v10',
      });
    }

    // Add markers to the map.
    let markers = JSON.parse(mapElement.dataset.markers);

    markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window);
    new mapboxgl.Marker({
      color: "#ff5d03",
      scale: 0.5
    })
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
    });
    fitMapToMarkers(map, markers);

    // Add geolocate control to the map.
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

    // map.addControl(new mapboxgl.FullscreenControl({container: document.querySelector('body')}));

  }
};
export { initMapbox };
