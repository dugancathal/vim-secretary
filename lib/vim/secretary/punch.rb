module Vim
  module Secretary
    class Punch < ActiveRecord::Base
      belongs_to :project
      belongs_to :timesheet
    end 
  end
end
