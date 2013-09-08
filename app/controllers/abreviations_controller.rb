class AbreviationsController < ApplicationController
  # GET /abreviations
  # GET /abreviations.json
  def index
    @abreviations = Abreviation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @abreviations }
    end
  end

  # GET /abreviations/1
  # GET /abreviations/1.json
  def show
    @abreviation = Abreviation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @abreviation }
    end
  end

  # GET /abreviations/new
  # GET /abreviations/new.json
  def new
    @abreviation = Abreviation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @abreviation }
    end
  end

  # GET /abreviations/1/edit
  def edit
    @abreviation = Abreviation.find(params[:id])
  end

  # POST /abreviations
  # POST /abreviations.json
  def create
    @abreviation = Abreviation.new(params[:abreviation])

    respond_to do |format|
      if @abreviation.save
        format.html { redirect_to @abreviation, :notice => 'Abreviation was successfully created.' }
        format.json { render :json => @abreviation, :status => :created, :location => @abreviation }
      else
        format.html { render :action => "new" }
        format.json { render :json => @abreviation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /abreviations/1
  # PUT /abreviations/1.json
  def update
    @abreviation = Abreviation.find(params[:id])

    respond_to do |format|
      if @abreviation.update_attributes(params[:abreviation])
        format.html { redirect_to @abreviation, :notice => 'Abreviation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @abreviation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /abreviations/1
  # DELETE /abreviations/1.json
  def destroy
    @abreviation = Abreviation.find(params[:id])
    @abreviation.destroy

    respond_to do |format|
      format.html { redirect_to abreviations_url }
      format.json { head :no_content }
    end
  end
end
