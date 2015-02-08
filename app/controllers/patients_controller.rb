class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    
     @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.savae
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def up_patient
  #@patient = Patient.all
    unless params[:archive].nil?
        
       logger.info("########################table for id is ======== #{params[:archive].keys}")
    for index in params[:archive].keys do 
       logger.info("########################table for id is ======== #{@patient.to_json}")
      #@patient.select{|b| b.id == params[:archived].keys[index.to_i-1]}.map{|p| p.archived}[0]= true
      @patient = Patient.where(:id => params[:archive].keys[index.to_i - 1].to_i).first
     @patient.archived = true
       @patient.save!
    end
       # @patient.save!
  end
    #@patients = Patient.all
    #respond_to do |format|
     # format.html
      #format.js
    #end
    redirect_to :action => 'index'
  end
  
  
  def add_patient
    
     @patient = Patient.new(patient_params)
     @patient.save
    #respond_to do |format|
     # if @patient.save
      #  format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
       # format.json { render :show, status: :created, location: @patient }
      #else
       # format.html { render :new }
        #format.json { render json: @patient.errors, status: :unprocessable_entity }
      #end
    #end
    redirect_to :action => 'index', notice: 'Patient was successfully created.'
  end
  
  def edit_patient
    @patient = Patient.where(:id => params[:patient][:id]).first
    @patient.name = params[:patient][:name]
    @patient.first_name = params[:patient][:first_name]
    @patient.archived= params[:patient][:archived]
    @patient.save
    #respond_to do |format|
      
       #if @patient.save!
        #format.html { redirect_to @patient, notice: 'Patient was successfully update.' }
        #format.json { render :show, status: :created, location: @patient }
      #else
       # format.html { render :new }
        #format.json { render json: @patient.errors, status: :unprocessable_entity }
      #end
      # end
      redirect_to :action => 'index', notice: 'Patient was successfully update.'
  end
 

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :first_name, :archived)
    end
end
