class IndicatorsController < ApplicationController
  def index
    @indicators = Indicator.all

    render("indicators/index.html.erb")
  end

  def show
    @indicator = Indicator.find(params[:id])

    render("indicators/show.html.erb")
  end

  def new
    @indicator = Indicator.new

    render("indicators/new.html.erb")
  end

  def create
    @indicator = Indicator.new

    @indicator.name = params[:name]
    @indicator.description = params[:description]
    @indicator.expected_sign = params[:expected_sign]
    @indicator.database_key = params[:database_key]

    save_status = @indicator.save

    if save_status == true
      redirect_to("/indicators/#{@indicator.id}", :notice => "Indicator created successfully.")
    else
      render("indicators/new.html.erb")
    end
  end

  def edit
    @indicator = Indicator.find(params[:id])

    render("indicators/edit.html.erb")
  end

  def update
    @indicator = Indicator.find(params[:id])

    @indicator.name = params[:name]
    @indicator.description = params[:description]
    @indicator.expected_sign = params[:expected_sign]
    @indicator.database_key = params[:database_key]

    save_status = @indicator.save

    if save_status == true
      redirect_to("/indicators/#{@indicator.id}", :notice => "Indicator updated successfully.")
    else
      render("indicators/edit.html.erb")
    end
  end

  def destroy
    @indicator = Indicator.find(params[:id])

    @indicator.destroy

    if URI(request.referer).path == "/indicators/#{@indicator.id}"
      redirect_to("/", :notice => "Indicator deleted.")
    else
      redirect_to(:back, :notice => "Indicator deleted.")
    end
  end
end
