require './config'

class Application
  @@link = ARGV.first
  @@comment_starting_point = 0

  def self.execute
    extracted_data = extract_data(scraped_article)
    post = Post.create(extracted_data)
    format_post(post)
    show_comment?(post)
  end

  private

  def self.scraped_article
    Nokogiri::HTML(open(@@link))
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
    raise(ArgumentError, 'Input must be an instance of Post') unless post.is_a? Post
    puts 'Title: '.colorize(:light_cyan) + "#{post.title}".colorize(:green)
    puts 'Url: '.colorize(:light_cyan) + "#{post.url}".colorize(:green)
    puts 'Points: '.colorize(:light_cyan) + "#{post.points}".colorize(:green)
    puts 'Posted by: '.colorize(:light_cyan) + "#{post.user}".colorize(:green)
    puts 'ID: '.colorize(:light_cyan) + "#{post.item_id}".colorize(:green)
  end

  def self.show_comment?(post)
    raise(ArgumentError, 'Input must be an instance of Post') unless post.is_a? Post
    if post.comments.size > 0
      until no_more_comments(post) || prompt_user('Show 5 comments? (y/n): ') == "n"
        show_group_of_comments(post, 5)
        show_comment?(post)
      end
      exit!
    else 
      puts "No comments yet"
    end
  end

  ## private_class_methods

  def self.show_group_of_comments(post, number)
    post.comments[@@comment_starting_point, number].each do |comment| 
      format_comment(comment)
      @@comment_starting_point += 1
    end
  end

  def self.format_comment(comment)
    puts ''
    puts "Posted #{comment.age} days ago by #{comment.user}: "
    puts "#{comment.content}".colorize(:white)
  end


  def self.no_more_comments(post)
    @@comment_starting_point >= post.comments.size
  end

  def self.increment_comment_starting_point(post)
    case @@comment_starting_point 
    when post.comments.size then puts "No more commen"
    end

  end

  def self.prompt_user(question)
    print question
    $stdin.gets.chomp
  end

  def self.create_comment(post)
    post.add_comment(content)
  end
end

Application.execute