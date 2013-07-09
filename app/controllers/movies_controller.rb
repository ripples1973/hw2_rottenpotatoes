class MoviesController < ApplicationController

  
  ## my code
  @sortOrder = ":asc"
  @sortField = ":none"
  
  def sort
    @movies  = Movie.all.reverse   
  end
  ## end of my code
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
#    @all_ratings = [{'G' => 1,'PG' => 1,'PG-13' => 1,'R' => 1, 'NC-17' => 1}]
    @all_ratings = ['G', 'PG', 'PG-13', 'R', 'NC-17']
    if params[:sort] == nil
      sort = session[:sort]
    else
      sort = params[:sort]
      session[:sort] = sort
    end
    
    if params[:ratings] == nil
      if session[:ratings] == nil then
        @ratings = @all_ratings
      else
        @ratings = session[:ratings]
        # now do redirect
        params[:ratings] = @ratings
        flash.keep
        redirect_to :sort => sort, :ratings => @ratings
      end
    else
      @ratings = params[:ratings]
      session[:ratings] = @ratings
    end
      
    if sort == nil then
      @movies = Movie.where("rating in (?)", @ratings.keys())
      @hilite_title = nil
      @hilite_release_date = nil
    else
        @movies = Movie.where("rating in (?)", @ratings.keys()).order(sort)
        if sort == 'title' then
          @hilite_title = 'hilite'
          @hilite_release_date = nil
        else
          @hilite_title = nil
          @hilite_release_date = 'hilite'
        end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
