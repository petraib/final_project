class AuthorsController < ApplicationController
  def index
    @authors = Author.all

    render("authors/index.html.erb")
  end

  def show
    @author = Author.find(params[:id])

    render("authors/show.html.erb")
  end

  def new
    @author = Author.new

    render("authors/new.html.erb")
  end

  def create
    @author = Author.new


    save_status = @author.save

    if save_status == true
      redirect_to("/authors/#{@author.id}", :notice => "Author created successfully.")
    else
      render("authors/new.html.erb")
    end
  end

  def edit
    @author = Author.find(params[:id])

    render("authors/edit.html.erb")
  end

  def update
    @author = Author.find(params[:id])


    save_status = @author.save

    if save_status == true
      redirect_to("/authors/#{@author.id}", :notice => "Author updated successfully.")
    else
      render("authors/edit.html.erb")
    end
  end

  def destroy
    @author = Author.find(params[:id])

    @author.destroy

    if URI(request.referer).path == "/authors/#{@author.id}"
      redirect_to("/", :notice => "Author deleted.")
    else
      redirect_to(:back, :notice => "Author deleted.")
    end
  end
end
