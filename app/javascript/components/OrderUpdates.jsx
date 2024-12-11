import React, { useEffect, useState } from "react";
import { Card, CardContent, Typography } from "@mui/material";

const OrderUpdates = () => {
  const [orders, setOrders] = useState([]);

  useEffect(() => {
    const eventSource = new EventSource("/api/order_stream");
    eventSource.onmessage = (event) => {
      const newOrder = JSON.parse(event.data);
      setOrders((prev) => [...prev, newOrder]);
    };

    return () => eventSource.close();
  }, []);

  return (
    <div>
      <Typography variant="h4">Live Order Updates</Typography>
      {orders.map((order, index) => (
        <Card key={index} style={{ margin: "10px 0" }}>
          <CardContent>
            <Typography>Order #{order.id}</Typography>
            <Typography>Status: {order.status}</Typography>
            <Typography>Total: ${order.total}</Typography>
          </CardContent>
        </Card>
      ))}
    </div>
  );
};

export default OrderUpdates;
