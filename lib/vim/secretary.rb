require "vim/secretary/version"

require 'enrar'
require 'pathname'

module Vim
  module Secretary
    def self.initialize!
      Enrar.initialize!
    end
  end
end

require 'vim/secretary/config'
require 'vim/secretary/parser'
require 'vim/secretary/project'
require 'vim/secretary/punch'
require 'vim/secretary/timesheet'
