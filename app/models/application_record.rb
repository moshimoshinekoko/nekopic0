class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end


class Tweet
  attr_accessor :contents

  def initialize(contents)
    @contents = contents
  end
end
