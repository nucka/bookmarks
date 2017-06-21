class BookmarksController < ApplicationController

  def index
    if params[:search]
      condition = [:title, :url, :shortening].map { |e| e.to_s + ' ilike :search' }.join(' or ')
      @bookmarks = Bookmark.where(condition, {search: '%'+params[:search]+'%'})
    else
      @bookmarks = Bookmark.all
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = Bookmark.new
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    if @bookmark.save
      redirect_to @bookmark
    else
      render 'new'
    end
  end

  def update
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.update(bookmark_params)
      redirect_to @bookmark
    else
      render 'edit'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy

    redirect_to bookmarks_path
  end

  private

    def bookmark_params
      params.require(:bookmark).permit(:title, :url, :shortening)
    end
end
