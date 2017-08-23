class OurmodelsController < ApplicationController
  def index
    @ourmodels = Ourmodel.all
    @exposure = 90
    #Indicator.group(:name).count
    #Indicator.pluck(:name, 1)
    
    @dt = Array.new(Ourmodel.count) { Hash.new }
    Ourmodel.all.each do |omodel|
      @dt[omodel.id] = {:name=>omodel.ourmodel_name, :data=>[["signal", 10], ["weight",  omodel.model_weight]]}
    end
    render("ourmodels/index.html.erb")
  end

  def show
    @ourmodel = Ourmodel.find(params[:id])

    render("ourmodels/show.html.erb")
  end

  def new
    @ourmodel = Ourmodel.new

    render("ourmodels/new.html.erb")
  end

  def create
    @ourmodel = Ourmodel.new

    @ourmodel.model_weight = params[:model_weight]
    @ourmodel.ourmodel_name = params[:ourmodel_name]

    save_status = @ourmodel.save

    if save_status == true
      redirect_to("/ourmodels/#{@ourmodel.id}", :notice => "Ourmodel created successfully.")
    else
      render("ourmodels/new.html.erb")
    end
  end

  def edit
    @ourmodel = Ourmodel.find(params[:id])

    render("ourmodels/edit.html.erb")
  end

  def update
    @ourmodel = Ourmodel.find(params[:id])

    @ourmodel.model_weight = params[:model_weight]
    @ourmodel.ourmodel_name = params[:ourmodel_name]

    save_status = @ourmodel.save

    if save_status == true
      redirect_to("/ourmodels/#{@ourmodel.id}", :notice => "Ourmodel updated successfully.")
    else
      render("ourmodels/edit.html.erb")
    end
  end

  def destroy
    @ourmodel = Ourmodel.find(params[:id])

    @ourmodel.destroy

    if URI(request.referer).path == "/ourmodels/#{@ourmodel.id}"
      redirect_to("/", :notice => "Ourmodel deleted.")
    else
      redirect_to(:back, :notice => "Ourmodel deleted.")
    end
  end
end
