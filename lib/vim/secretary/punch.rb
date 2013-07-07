module Vim
  module Secretary
    class Punch < ActiveRecord::Base
      belongs_to :project
    end 
  end
end
