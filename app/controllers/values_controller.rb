class ValuesController < ApplicationController
  def index
    @values = Value.all

    render("values/index.html.erb")
  end

  def show
    @value = Value.find(params[:id])

    render("values/show.html.erb")
  end

  def new
    @value = Value.new

    render("values/new.html.erb")
  end

  def create
    @value = Value.new

    @value.indicator_id = params[:indicator_id]
    @value.date = params[:date]
    @value.value = params[:value]

    save_status = @value.save

    if save_status == true
      redirect_to("/values/#{@value.id}", :notice => "Value created successfully.")
    else
      render("values/new.html.erb")
    end
  end

  def edit
    @value = Value.find(params[:id])

    render("values/edit.html.erb")
  end

  def update
    @value = Value.find(params[:id])

    @value.indicator_id = params[:indicator_id]
    @value.date = params[:date]
    @value.value = params[:value]

    save_status = @value.save

    if save_status == true
      redirect_to("/values/#{@value.id}", :notice => "Value updated successfully.")
    else
      render("values/edit.html.erb")
    end
  end

  def destroy
    @value = Value.find(params[:id])

    @value.destroy

    if URI(request.referer).path == "/values/#{@value.id}"
      redirect_to("/", :notice => "Value deleted.")
    else
      redirect_to(:back, :notice => "Value deleted.")
    end
  end
end
