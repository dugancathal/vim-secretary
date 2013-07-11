module Vim
  module Secretary
    class Tagging < ActiveRecord::Base
      belongs_to :tag
      belongs_to :project
    end
  end
end
