require 'spec_helper'

describe Comment do
  before :each do 
    @comment = Comment.new('content')
    @post = Post.new('awesome post', 'http://johnnyji.com/')
  end

  describe '#initialize' do
    it 'should be an instance of the Comment class' do
      expect(@comment).to be_an_instance_of Comment
    end
    it 'should return the content based on user input' do
      expect(@comment.content).to eq 'content'
    end
  end

  describe ".create" do
    it 'should accept content' do
      expect{ Comment.create('content') }.not_to raise_error
    end
    it 'create an instance of the Comment class' do
      comment1 = Comment.create('content')
      expect(comment1.content).to be_an_instance_of Comment
    end
  end
end