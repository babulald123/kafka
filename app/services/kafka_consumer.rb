require 'kafka'

class KafkaConsumer
  def initialize
    @kafka = Kafka.new(["localhost:9092"])
  end

  def consume(topic)
    consumer = @kafka.consumer(group_id: "rails-consumer-group")
    consumer.subscribe(topic)

    consumer.each_message do |message|
      # Handle the message
      puts "Received message: #{message.value}"
    end
  end
end
