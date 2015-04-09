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
    show_comment?(post)
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
      url: @@link,
      user: Scraper.user(article),
      item_id: Scraper.item_id(article),
      comments: Scraper.comments(article)
    }
  end

  def self.format_post(post)
    puts 'Title: '.colorize(:light_cyan) + "#{post.title}".colorize(:green)
    puts 'Url: '.colorize(:light_cyan) + "#{post.url}".colorize(:green)
    puts 'Points: '.colorize(:light_cyan) + "#{post.points}".colorize(:green)
    puts 'Posted by: '.colorize(:light_cyan) + "#{post.user}".colorize(:green)
    puts 'ID: '.colorize(:light_cyan) + "#{post.item_id}".colorize(:green)
  end

  def self.show_comment?(post)
    if prompt_user('Show 5 comments? (y/n): ') == "y"
      format_comments(post)
      show_comment?(post)
    end
  end

  def self.format_comments(post)
    if post.comments.size > 0
      post.comments[1..5].each do |comment|
        puts ''
        puts "Posted #{comment.age} days ago by #{comment.user}: "
        puts "#{comment.content}".colorize(:white)
      end
    else
      puts 'No comment yet'
    end
  end

  ## private_class_methods

  def self.prompt_user(question)
    print question
    $stdin.gets.chomp
  end

  def self.create_comment(post)
    post.add_comment(content)
  end
end

Application.execute