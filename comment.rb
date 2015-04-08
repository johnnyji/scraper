class Comment
  attr_reader :content

  def initialize(user, age, content)
    @user = user
    @age = age
    @content = content
  end


  # Comment.create is responsible for creating an instance of Comment class
  # it accepts the following parameters: content
  # it returns the following value: object
  # it raises the following exceptions in the following circumstances: exception types and reasons

  def self.create(user, age, content)
    Comment.new(user, age, content)
  end

end