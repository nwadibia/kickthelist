class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page =>150)
  end

  def mylist
    @pins = current_user.pins.all.order("created_at DESC").paginate(:page => params[:page], :per_page =>150)
  end

  def myprofile
    @pins = current_user.pins
  end

  def discover
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page =>150)
  end

  def discoverkicked
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page =>150)
  end
  
  # GET /pins/1
  # GET /pins/1.json
  def show
    @pins = Pin.all.order("created_at DESC").where("description LIKE ?", "#{@pin.description}%")
  end

  # GET /pins/new
  def new
    @pin = current_user.pins.build
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins
  # POST /pins.json
  def create
    @pin = current_user.pins.build(pin_params)

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Successfully created!' }
        format.json { render :show, status: :created, location: @pin }
      else
        format.html { render :new }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to @pin, notice: 'Successfully updated.' }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
        @pin = current_user.pins.find_by(id: params[:id])
        redirect_to pins_path, notice: "Not authorized to edit this post" if @pin.nil?
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
