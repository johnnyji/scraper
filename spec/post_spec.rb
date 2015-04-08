require 'spec_helper'

describe Post do
  before :each do
    @fake_url = 'http://johnnyji.com/'
    @post = Post.new('Post title', @fake_url)
  end

  describe '#initialize' do
    it 'should have 0 points' do
      expect(@post.points).to eq 0
    end
    it 'should be an instance of the Post class' do
      expect(@post).to be_an_instance_of Post
    end
    it 'should have a title and url upon inception' do
      expect(@post.title).to eq 'Post title'
      expect(@post.url).to eq @fake_url
    end
  end

  describe '#add_comment' do
    it 'should add a comment to the comment list' do
      expect($stdin).to receive_message_chain('gets.chomp').and_return('This is a comment.')
      comment_list_size = @post.comments.size
      @post.add_comment
      expect(@post.comments.size).to eq comment_list_size + 1
    end
  end
end