require 'nokogiri'
require 'open-uri'
require 'pry'

class Post
  attr_accessor :title, :points, :comment_list
  attr_reader :item_id, :comment_count

  def initialize(title, url, user, comment_count)
    @title = title
    @points = 0
    @item_id = item_id
    @comments = []
    @comment_count = comment_count
  end

  def add_comment(content)
    @comments << Comment.create(content)
  end

  def comments #returns a parsed array of comments or an error string from the comments object array
    @comments.size > 0 ? @comments.map { |comment| "#{comment.content}" } : "No comments yet"
  end

  def self.create(nokogiri_article) #takes in a nokogiri parsed doc and creates an object with attributes of certain information from that nokogiri doc
    title = nokogiri_article.css('title').text
    points = nokogiri_article.css('span[class="score"]').text
    post_data = nokogiri_article.search('.subtext a').map
    user = post_data.
    Post.new(title, points, comment_count)
  end
end

Post.create(Nokogiri::HTML(File.open('post.html')))