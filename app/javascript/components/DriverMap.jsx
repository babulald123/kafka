import React, { useEffect, useState } from 'react';
import { GoogleMap, LoadScript, Marker } from '@react-google-maps/api';
import { io } from 'socket.io-client';

const DriverMap = () => {
  const [driverLocation, setDriverLocation] = useState(null);

  useEffect(() => {
    const socket = io('http://localhost:4000'); // WebSocket endpoint
    socket.on('driver_updates', (data) => {
      setDriverLocation(data.location);
    });

    return () => {
      socket.disconnect();
    };
  }, []);

  return (
    <LoadScript googleMapsApiKey="YOUR_GOOGLE_MAPS_API_KEY">
      <GoogleMap
        mapContainerStyle={{ width: '100%', height: '400px' }}
        center={driverLocation || { lat: 0, lng: 0 }}
        zoom={12}
      >
        {driverLocation && <Marker position={driverLocation} />}
      </GoogleMap>
    </LoadScript>
  );
};

export default DriverMap;
