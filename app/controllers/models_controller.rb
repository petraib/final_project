class ModelsController < ApplicationController
  
  # you can place this into individual controller if want to make it more specific
  before_action :authenticate_user!
  
  def index
    @models = Model.all

    render("models/index.html.erb")
  end

  def show
    @model = Model.find(params[:id])

    render("models/show.html.erb")
  end

  def new
    @model = Model.new

    render("models/new.html.erb")
  end

  def create
    @model = Model.new

    @model.user_id = params[:user_id]
    @model.mname = params[:mname]

    save_status = @model.save

    if save_status == true
      redirect_to("/models/#{@model.id}", :notice => "Model created successfully.")
    else
      render("models/new.html.erb")
    end
  end

  def edit
    @model = Model.find(params[:id])

    render("models/edit.html.erb")
  end

  def update
    @model = Model.find(params[:id])

    @model.user_id = params[:user_id]
    @model.mname = params[:mname]

    save_status = @model.save

    if save_status == true
      redirect_to("/models/#{@model.id}", :notice => "Model updated successfully.")
    else
      render("models/edit.html.erb")
    end
  end

  def destroy
    @model = Model.find(params[:id])

    @model.destroy

    if URI(request.referer).path == "/models/#{@model.id}"
      redirect_to("/", :notice => "Model deleted.")
    else
      redirect_to(:back, :notice => "Model deleted.")
    end
  end
end
