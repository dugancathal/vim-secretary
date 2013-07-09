module Vim
  module Secretary
    class Project < ActiveRecord::Base
      has_many :punches
      has_many :timesheets, through: :punches
    end
  end
end
