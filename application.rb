require './config'

class Application

  # Application.prompt_user_for_comment is responsible for prompting the user for an input
  # it accepts the following parameters: nothing
  # it returns the following value: string
  # it raises the following exceptions in the following circumstances: exception types and reasons
  @@link = ARGV.first
  @@file = File.open('./post.html')

  def self.execute
    extracted_data = extract_data(scraped_article)
    post = Post.create(extracted_data)
    format_post(post)
  end

  private

  def self.scraped_article
    Nokogiri::HTML(@@file)
  end

  def self.display_article #displays the 
    format_article(parsed_article)
  end

  def self.extract_data(article) #takes the scraped article and returns an array of the scraped article's selected data
    sub_info = article.search('.subtext a').map {|object| object['href']}.uniq
    article_data = {
      title: Scraper.title(article),
      points: Scraper.points(article),
      url: @@link.to_s,
      user: Scraper.user(article),
      item_id: Scraper.item_id(article),
      comments: Scraper.comments(article)
    }
  end

  def self.format_post(post)
    puts "Title: #{post.title}"
    puts "Url: #{post.url}"
    puts "Points: #{post.points}"
    puts "Posted by: #{post.user}"
    puts "ID: #{post.item_id}"
  end


  ## private_class_methods

  def self.prompt_user_for_comment
    print "What would you live to comment: "
    $stdin.gets.chomp
  end

  def self.create_comment(post)
    post.add_comment(content)
  end
end

Application.execute