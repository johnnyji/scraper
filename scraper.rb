class Scraper

  def self.title(link)
    link.css('title').text
  end

  def self.user(link)
    sub_info(link)[0]
  end

  def self.item_id(link)
    sub_info(link)[1]
  end

  def self.points(link)
    link.search('.score').text
  end

  def self.comments(link)
    comments = []
    link.search('.default').each do |comment|
      user, age = comment.search('.comhead a').map {|i| i.text }
      content = comment.search('.comment').text
      comments << Comment.create(user, age, content)
    end
    comments
  end

  def self.sub_info(link) #scrapes the sub info of the article and returns an array of the article poster's name and the article's id
    link.search('.subtext a').map {|object| object['href']}.uniq.map do |item|
      item[8..-1]
    end
  end

end