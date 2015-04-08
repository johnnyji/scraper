class Comment
  attr_reader :content

  def initialize(content)
    @content = content
    # @id = id
  end


  # Comment.create is responsible for creating an instance of Comment class
  # it accepts the following parameters: content
  # it returns the following value: object
  # it raises the following exceptions in the following circumstances: exception types and reasons

  def self.create(content)
    Comment.new(content)
  end

end