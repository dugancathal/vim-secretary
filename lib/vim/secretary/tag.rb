module Vim
  module Secretary
    class Tag < ::ActiveRecord::Base
      has_many :taggings
      has_many :punches, through: :taggings
    end
  end
end
