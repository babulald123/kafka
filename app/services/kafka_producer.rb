require 'kafka'

class KafkaProducer
  def initialize
    @kafka = Kafka.new(["localhost:9092"])
  end

  def produce(topic, message)
    producer = @kafka.producer
    producer.produce(message, topic: topic)
    producer.deliver_messages
  end
end
