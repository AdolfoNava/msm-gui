class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    @movie = Movie.new
    @movie.title  = params["title"]
    @movie.year = params["year"]
    @movie.duration = params["duration"]
    @movie.description = params["description"]
    @movie.image = params["image_url"]
    @movie.director_id = params["director_id"]

    if @movie.valid?
      @movie.save 
      redirect_to("/movies", {:notice => "movie created successfully."})
    else
      redirect_to("/movies", {:notice => "movie failed to create successfully."})
    end
  end
  def update
    id = params["path_id"]
    @movie = Movie.where({:id => id}).at(0)
    
    @movie.title  = params["title"]
    @movie.year = params["year"]
    @movie.duration = params["duration"]
    @movie.description = params["description"]
    @movie.image = params["image_url"]
    @movie.director_id = params["director_id"]

    if @movie.valid?
      @movie.save
      redirect_to("/movies/#{@movie.id}", { :notice => "movie updated successfully."} )
    else
      redirect_to("/movies/#{@movie.id}", { :alert => "movie failed to update successfully." })
    end
  end
  def destroy 
    @id = params["path_id"]
    movie = Movie.where({:id => @id}).at(0)
    movie.destroy
    redirect_to("/movies", {:notice => "movie deleted successfully."} )
  end
end
