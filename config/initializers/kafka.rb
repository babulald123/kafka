require 'kafka'

kafka = Kafka.new(
  seed_brokers: ['localhost:9092'],
  client_id: 'live_order_system'
)

Rails.application.config.kafka = kafka
