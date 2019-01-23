class SongsController < ApplicationController
  before_action :set_song ,only:[:show,:edit,:update]

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
    @song.save
    if @song.valid?
      redirect_to song_path(@song)
    else
      render :new
    end
  end

  def update
    @song.update(songs_params(:title,:released,:release_year,:artist_name,:genre))

    if @song.valid?
      redirect_to song_path(@song)
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
  end

  def set_song
    @song=Song.find(params[:id])
  end

  def songs_params(*args)
    params.require(:song).permit(*args)
  end

end
