class OurmodelsController < ApplicationController
  def index
    @ourmodels = Ourmodel.all
    #Indicator.group(:name).count
    #Indicator.pluck(:name, 1)
    
     ### calculate all model signals
    @result = Array.new(@ourmodels.count,0) 
    @scaled_result = Array.new(@ourmodels.count,0) 
    @max = Array.new(@ourmodels.count,0) 
    @min = Array.new(@ourmodels.count,0) 
    @wts = Array.new(@ourmodels.count,0) 
    
    i = 0
    Ourmodel.all.each do |ourmodel|
      
            @history_length = 15000

            if(ourmodel.variables != [])
              ourmodel.variables.each do |variable|
                ind = Indicator.find(variable.indicator_id)
                @result[i] += ind.values.last.value.to_f * ind.expected_sign.to_f * variable.weight.to_f
                @history_length = [@history_length, ind.values.count].min
              end
              
              #set boundaries:
              @dt = Array.new(@history_length,0) ;
              
              ourmodel.variables.each do |variable|
                indicator = Indicator.find(variable.indicator_id)
                for j in 0..(@dt.count-1)
                    
                      @dt[j] += indicator.values[j].value.to_f * indicator.expected_sign.to_f * variable.weight.to_f
            
                end
              end
              @max[i] = @dt.compact.max
              @min[i] = @dt.compact.min
              
              @scaled_result[i] = (@result[i] - @min[i] ) / (@max[i] - @min[i]) *100
              @wts[i] = ourmodel.model_weight.to_f
              
            else
              @result[i] = 0
              @max[i] = 100
              @min[i] = -100
              
              @scaled_result[i] = (@result[i] - @min[i] ) / (@max[i] - @min[i]) *100
              @wts[i] = 0
            end
            i+=1
    end
    
    
    ### plots
    @signals = Array.new(Ourmodel.count) { Hash.new }
    @weights = Array.new(Ourmodel.count) { Hash.new }

    counter = 0
    @exposure = 0
    Ourmodel.all.each do |omodel|
      @signals[counter] = {:name=>omodel.ourmodel_name, :data=>[["signal", @scaled_result[counter].round(2)]]}
      @weights[counter] = {:name=>omodel.ourmodel_name, :data=>[ ["weight",  omodel.model_weight]]}
      @exposure += @scaled_result[counter] * @wts[counter]

      counter +=1

    end
    

    
    
   
    render("ourmodels/index.html.erb")
  end

  def show
    @ourmodel = Ourmodel.find(params[:id])
    
    @result = 0
    
    @history_length = 15000
    @dt = Array.new(Ourmodel.count) { Hash.new }
     
    if(@ourmodel.variables != [])
      
      @ourmodel.variables.each do |variable|
      i = Indicator.find(variable.indicator_id)
      @result += i.values.last.value.to_f * i.expected_sign.to_f * variable.weight.to_f
      
      @history_length = [@history_length, i.values.count].min
      end
      
  
       #set boundaries:
        @dt = Array.new(@history_length,0) ;
        
        @ourmodel.variables.each do |variable|
          indicator = Indicator.find(variable.indicator_id)
          for j in 0..(@dt.count-1)
              
                @dt[j] += indicator.values[j].value.to_f * indicator.expected_sign.to_f * variable.weight.to_f
      
          end
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
    @ourmodel.description = params[:description]

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
    @ourmodel.description = params[:description]

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
