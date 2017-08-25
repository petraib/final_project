class ModelsController < ApplicationController
  
  # you can place this into individual controller if want to make it more specific
  before_action :authenticate_user!
  
  def index
    @models = Model.all

    render("models/index.html.erb")
  end

  def show
    @model = Model.find(params[:id])
    
    @result = 0
    
    @history_length = 15000
    @dt = Array.new(Ourmodel.count) { Hash.new }
     
    @model.variables.each do |variable|
    i = Indicator.find(variable.indicator_id)
    @result += i.values.last.value.to_f * i.expected_sign.to_f * variable.weight.to_f
    
    @history_length = [@history_length, i.values.count].min
    end
    

    @dt = Array.new(@history_length) 
    if(@model.variables != [])

      variable = @model.variables.first
      
      indicator = Indicator.find(variable.indicator_id)
        for i in 0..(@dt.count-1)
            @dt[i] = indicator.values[i].value * indicator.expected_sign * variable.weight.to_f
  
        end
      @max = @dt.compact.max
      @min = @dt.compact.min
      
      @scaled_result = (@result - @min ) / (@max - @min) *100
      #i.values.order("value DESC").last
      else
      @result = 0
      @max = 100
      @min = -100
      
      @scaled_result = (@result - @min ) / (@max - @min) *100
    end
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
