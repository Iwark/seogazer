class KeywordsController < ApplicationController

  before_action :set_keyword, only: [:show, :edit, :update, :destroy]

  permits :name, :url, :memo

  def index
    @keywords = Keyword.all
  end

  def show
  end

  def new
    @keyword = Keyword.new
  end

  def create(keyword)
    Keyword.create(keyword)
    redirect_to :root
  end

  def edit
  end

  def update(keyword)
    @keyword.update(keyword)
    redirect_to :root
  end

  def destroy
    @keyword.destroy
    redirect_to :root
  end

  private
  def set_keyword(id)
    @keyword = Keyword.find(id)
  end

end