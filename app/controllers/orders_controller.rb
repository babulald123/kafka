class OrdersController < ApplicationController
  include ActionController::Live

  def stream
    response.headers["Content-Type"] = "text/event-stream"

    byebug
    kafka = Rails.application.config.kafka
    consumer = kafka.consumer(group_id: "order_stream")
    consumer.subscribe("order_updates")
    consumer.each_message do |message|
      response.stream.write("data: #{message.value}\n\n")
    end
  ensure
    response.stream.close
  end

  def create
    order = Order.new(order_params)
    if order.save
      KafkaProducer.new.produce("order_updates", order)
      render json: order, status: :created
    else
      render json: { error: "Unable to create order" }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status, :total)
  end
end
