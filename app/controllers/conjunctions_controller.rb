class ConjunctionsController < ApplicationController
  # GET /conjunctions
  # GET /conjunctions.json
  def index
    @conjunctions = Conjunction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @conjunctions }
    end
  end

  # GET /conjunctions/1
  # GET /conjunctions/1.json
  def show
    @conjunction = Conjunction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @conjunction }
    end
  end

  # GET /conjunctions/new
  # GET /conjunctions/new.json
  def new
    @conjunction = Conjunction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @conjunction }
    end
  end

  # GET /conjunctions/1/edit
  def edit
    @conjunction = Conjunction.find(params[:id])
  end

  # POST /conjunctions
  # POST /conjunctions.json
  def create
    @conjunction = Conjunction.new(params[:conjunction])

    respond_to do |format|
      if @conjunction.save
        format.html { redirect_to @conjunction, :notice => 'Conjunction was successfully created.' }
        format.json { render :json => @conjunction, :status => :created, :location => @conjunction }
      else
        format.html { render :action => "new" }
        format.json { render :json => @conjunction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /conjunctions/1
  # PUT /conjunctions/1.json
  def update
    @conjunction = Conjunction.find(params[:id])

    respond_to do |format|
      if @conjunction.update_attributes(params[:conjunction])
        format.html { redirect_to @conjunction, :notice => 'Conjunction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @conjunction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /conjunctions/1
  # DELETE /conjunctions/1.json
  def destroy
    @conjunction = Conjunction.find(params[:id])
    @conjunction.destroy

    respond_to do |format|
      format.html { redirect_to conjunctions_url }
      format.json { head :no_content }
    end
  end
end
