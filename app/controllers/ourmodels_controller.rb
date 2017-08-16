class OurmodelsController < ApplicationController
  def index
    @ourmodels = Ourmodel.all

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
