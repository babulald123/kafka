# app/services/order_estimate_publisher.rb
class OrderEstimatePublisher
  def initialize(order, estimated_time)
    @order = order
    @estimated_time = estimated_time
    @kafka = Kafka.new(["localhost:9092"], client_id: "order_estimate_service")
  end

  def publish_estimate
    producer = @kafka.producer
    message = {
      order_id: @order.id,
      estimated_time: @estimated_time,
      timestamp: Time.now.to_s
    }
    producer.produce(message.to_json, topic: "order_estimates")
    producer.deliver_messages
  ensure
    producer&.shutdown
  end
end
