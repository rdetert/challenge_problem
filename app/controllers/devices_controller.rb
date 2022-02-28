class DevicesController < ApplicationController
  before_action :set_device, only: [:edit, :update, :show, :destroy]

  def index
    @devices = Device.joins(:player).order(os_version: :asc)

    if params[:min_os].present?
      @devices = @devices.os_versions_gte(params[:min_os])
    end

    if params[:max_os].present?
      @devices = @devices.os_versions_lte(params[:max_os])
    end
  end

  def new
    @device = Device.new
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      redirect_to devices_path, notice: 'Device Created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @device.update(device_params)
      redirect_to devices_path, notice: 'Device Updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @device.destroy
    redirect_to devices_path, notice: 'Device Destroyed.'
  end


  private

    def set_device
      @device = Device.find(params[:id])
    end

    def device_params
      params.require(:device).permit(
        :player_id,
        :device_model,
        :os,
        :os_version,
        :locale,
      )
    end

end
