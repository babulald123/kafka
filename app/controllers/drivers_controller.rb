# app/controllers/drivers_controller.rb
class DriversController < ApplicationController
  def update_location
    driver = Driver.find(params[:id])
    if driver.update(location: params[:location])
      # Publish location update to Kafka
      DriverLocationPublisher.new(driver).publish_location
      render json: { success: true, message: 'Location updated successfully' }, status: :ok
    else
      render json: { success: false, message: driver.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
