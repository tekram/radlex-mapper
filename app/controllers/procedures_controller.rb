class ProceduresController < ApplicationController
  # GET /procedures
  # GET /procedures.json
  def index
    @procedures = Procedure.order(:rpid).page params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @procedures }
    end
  end

  # GET /procedures/1
  # GET /procedures/1.json
  def show
    @procedure = Procedure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @procedure }
    end
  end

	def map
		terms = params[:name].split(" ") if params[:name]
		@terms = Term.findRadlex(terms) if params[:name]
	end

  # GET /procedures/new
  # GET /procedures/new.json
  def new
    @procedure = Procedure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @procedure }
    end
  end

  # GET /procedures/1/edit
  def edit
    @procedure = Procedure.find(params[:id])
  end

  # POST /procedures
  # POST /procedures.json
  def create
    @procedure = Procedure.new(params[:procedure])

    respond_to do |format|
      if @procedure.save
        format.html { redirect_to @procedure, :notice => 'Procedure was successfully created.' }
        format.json { render :json => @procedure, :status => :created, :location => @procedure }
      else
        format.html { render :action => "new" }
        format.json { render :json => @procedure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /procedures/1
  # PUT /procedures/1.json
  def update
    @procedure = Procedure.find(params[:id])

    respond_to do |format|
      if @procedure.update_attributes(params[:procedure])
        format.html { redirect_to @procedure, :notice => 'Procedure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @procedure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /procedures/1
  # DELETE /procedures/1.json
  def destroy
    @procedure = Procedure.find(params[:id])
    @procedure.destroy

    respond_to do |format|
      format.html { redirect_to procedures_url }
      format.json { head :no_content }
    end
  end
end
