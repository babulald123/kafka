# app/services/delivery_time_calculator.rb
require 'net/http'
require 'json'
require 'uri'

class DeliveryTimeCalculator
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
    @api_key = ENV['GOOGLE_API_KEY']
  end

  def calculate
    uri = URI("https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{@origin}&destinations=#{@destination}&key=#{@api_key}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    if data['status'] == 'OK'
      data['rows'][0]['elements'][0]['duration']['text']
    else
      'Unable to calculate'
    end
  end
end
