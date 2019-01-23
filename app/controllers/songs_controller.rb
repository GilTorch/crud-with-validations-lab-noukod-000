class SongsController < ApplicationController
  before_action :set_song ,only:[:show,:edit,:update,:destroy]

  def index
    @songs=Song.all
  end

  def new
    @song=Song.new
  end

  def show
  end

  def create
    @song=Song.new(songs_params(:title,:release_year,:artist_name,:released,:genre))
    #binding.pry

    if @song.save
      redirect_to song_path(@song)
    else
      render :new
    end
  end

  def update

    if   @song.update(songs_params(:title,:released,:release_year,:artist_name,:genre))
      redirect_to song_path(@song)
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @song.delete
    redirect_to songs_path
  end

  def set_song
    @song=Song.find(params[:id])
  end

  def songs_params(*args)
    params.require(:song).permit(*args)
  end

end
