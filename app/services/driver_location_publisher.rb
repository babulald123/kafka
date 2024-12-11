# app/services/driver_location_publisher.rb
class DriverLocationPublisher
  def initialize(driver)
    @driver = driver
    @kafka = Kafka.new(["localhost:9092"], client_id: "driver_location_service")
  end

  def publish_location
    producer = @kafka.producer
    message = {
      driver_id: @driver.id,
      location: @driver.location,
      timestamp: Time.now.to_s
    }
    producer.produce(message.to_json, topic: "driver_updates")
    producer.deliver_messages
  ensure
    producer&.shutdown
  end
end
