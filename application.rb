require './config'

class Application

  # Application.prompt_user_for_comment is responsible for prompting the user for an input
  # it accepts the following parameters: nothing
  # it returns the following value: string
  # it raises the following exceptions in the following circumstances: exception types and reasons
  @@link = ARGV.first
  @@file = File.open('post.html')
  @@article = nil

  def self.execute
    @@article = scrape_article
    extract_article_data
    format_article(Post.create)
  end

  private

  def self.scrape_article
    Nokogiri::HTML(@@file)
  end

  def self.format_article(article)

  end

  def self.display_article #displays the 
    format_article(parsed_article)
  end

  # def self.parsed_link #takes the user input link and returns the nokogiri parsed file
  #   Nokogiri::HTML(open(@@link))
  # end

  def self.extract_article_data #takes the scraped article and returns an array of the scraped article's selected data
    article_data = []
    artice_data << @@article.css('title').css
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