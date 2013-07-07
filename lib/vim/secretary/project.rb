module Vim
  module Secretary
    class Project < ActiveRecord::Base
      has_many :punches
    end
  end
end
