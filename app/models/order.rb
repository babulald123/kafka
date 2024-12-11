class Order < ApplicationRecord
  after_save :publish_update
  after_save :calculate_delivery_time

  private

  def publish_update
    kafka_producer = KafkaProducer.new
    kafka_producer.produce("order_updates", "Order #{id} status changed to #{status}")
  end

  def calculate_delivery_time
    origin = 'restaurant_address'
    destination = 'user_address' # Replace with user's actual address
    estimated_time = DeliveryTimeCalculator.new(origin, destination).calculate
    OrderEstimatePublisher.new(self, estimated_time).publish_estimate
  end
end
