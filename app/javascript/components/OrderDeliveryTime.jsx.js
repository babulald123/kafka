import React, { useEffect, useState } from 'react';
import { io } from 'socket.io-client';

const OrderDeliveryTime = ({ orderId }) => {
  const [estimatedTime, setEstimatedTime] = useState(null);

  useEffect(() => {
    const socket = io('http://localhost:4000'); // WebSocket endpoint
    socket.on('order_estimates', (data) => {
      if (data.order_id === orderId) {
        setEstimatedTime(data.estimated_time);
      }
    });

    return () => {
      socket.disconnect();
    };
  }, [orderId]);

  return (
    <div>
      <h3>Estimated Delivery Time</h3>
      {estimatedTime ? (
        <p>{estimatedTime}</p>
      ) : (
        <p>Calculating...</p>
      )}
    </div>
  );
};

export default OrderDeliveryTime;
