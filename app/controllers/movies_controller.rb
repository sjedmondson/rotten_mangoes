class MoviesController < ApplicationController

  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  def index
    @movies = Movie.all
    if params[:title].present?
      @movies = @movies.where('title LIKE ?', "%#{params[:title]}%")
    end
    if params[:director].present?
      @movies = @movies.where('director LIKE ?', "%#{params[:director]}%")
    end
    case params[:runtime_in_minutes]
    when "1"
      @movies = @movies.where('runtime_in_minutes < 90')
    when "2"
      @movies = @movies.where('runtime_in_minutes >= 90 AND runtime_in_minutes <= 120')
    when "3"
      @movies = @movies.where('runtime_in_minutes > 120')
    end
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end

end

