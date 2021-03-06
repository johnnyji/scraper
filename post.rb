require 'nokogiri'
require 'open-uri'
require 'pry'

class Post
  attr_reader :title, :url, :user, :item_id, :points, :comments

  def initialize(title, url, user, item_id, points, comments=[])
    @title = title
    @points = points
    @url = url
    @user = user
    @item_id = item_id
    @comments = comments
  end

  def self.create(article) #takes in a nokogiri parsed doc and creates an object with attributes of certain information from that nokogiri doc
    Post.new(article[:title], article[:url], article[:user], article[:item_id], article[:points], article[:comments])
  end
end