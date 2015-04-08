require 'nokogiri'
require 'open-uri'
require 'pry'

class Post
  attr_reader :title, :url, :user, :item_id, :points, :comments

  def initialize(title, url, user, item_id, points, comments=[])
    @title = title
    @points = points
    @user = user
    @item_id = item_id
    @comments = comments
  end

  def add_comment(user, age, content)
    @comments << Comment.create(content)
  end

  def comments #returns a parsed array of comments or an error string from the comments object array
    @comments.size > 0 ? @comments.map { |comment| "#{comment.content}" } : "No comments yet"
  end

  def self.create(article) #takes in a nokogiri parsed doc and creates an object with attributes of certain information from that nokogiri doc
    Post.new(article[:title], article[:url], article[:user], article[:item_id], article[:points], article[:comments])
  end
end