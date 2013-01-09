class TripsController < ApplicationController
  include TripsHelper

  respond_to :html
  before_filter :authenticate_user!
  before_filter :check_owner, only: [:edit, :update, :destroy]

  def index
    @trips = Trip.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @trips }
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @trip = Trip.find(params[:id])
    @places = @trip.places
  end

  # GET /trips/new
  # GET /trips/new.json
  def new
    @trip = current_user.trips.new
    @places = []
  end

  # GET /trips/1/edit
  def edit
    @trip = Trip.find(params[:id])
    @places = @trip.places
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = current_user.trips.new(params[:trip].except(:places))
    params[:trip][:places] ||= []
    @trip.add_trip_places(params[:trip][:places])
    if @trip.save
      flash[:notice] = "Trip succesfully created"
      redirect_to @trip
    else
      flash.now[:error] = @trip.errors.full_messages
      @places = params[:trip][:places]
      render "new"
    end
  end

  # PUT /trips/1
  # PUT /trips/1.json
  def update
    @trip = Trip.find(params[:id])
    params[:trip][:places] ||= []
    @trip.add_trip_places(params[:trip][:places])
    if @trip.update_attributes(params[:trip].except(:places))
      flash[:notice] = "Trip succesfully updated"
      redirect_to @trip
    else
      flash.now[:error] = @trip.errors.full_messages
      @places = params[:trip][:places]
      render "edit"
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end

  private

  def check_owner
    trip = Trip.find(params[:id])
    unless my_trip?(trip)
      flash[:error] = "Cannot modify/delete this trip since it does not belong to you"
      redirect_to trips_path
    end
  end
end
