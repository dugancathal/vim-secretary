require 'spec_helper'

describe Vim::Secretary::Parser do
  before(:all) do
    @secretary_file = PROJECT_ROOT.join('spec/fixtures/secretary-sample-full')
    @unaltered_file = File.read(@secretary_file)
    @parser = Vim::Secretary::Parser.new(@secretary_file.to_s)
    @parser.parse
    @first_project = @parser.projects.first
    @last_project = @parser.projects.last
  end

  it 'removes comment lines that start with #' do
    @unaltered_file.split("\n").count.must_equal 19
    @parser.lines.count.must_equal 5
  end

  it 'allows notes to spill onto a new line' do
    @parser.projects.count.must_equal 4
  end

  it 'sets the date by the first field' do
    @first_project[:date].must_be_kind_of DateTime
  end

  it 'sets the project name by the first field inside the []s' do
    @first_project[:name].must_be_kind_of String
    @first_project[:name].must_equal 'My Project'
  end

  it 'uses the dirname as the project name if the project name is blank' do
    @last_project[:name].must_equal 'fixtures'
  end

  it 'sets the tags by the remaining fields inside the []s' do
    @first_project[:tags].must_be_kind_of Array
  end

  it 'sets the notes as anything after the dash (-)' do
    @first_project[:notes].must_be_kind_of String
  end

  describe "#config" do
    it 'is generated from the top lines of comments' do
      @parser.config.must_be_kind_of Vim::Secretary::Config
    end

    it 'provides all the config niceties' do
      @parser.config['location'].must_equal '.'
    end
  end
end

if ENV['bench']
  describe "Parser Benchmark" do
    before do
      @secretary_file = PROJECT_ROOT.join('spec/fixtures/secretary-sample-bench')
      @parser = Vim::Secretary::Parser.new(@secretary_file.to_s)
    end

    bench_performance_constant 'parsing', 0.95 do
      @parser.parse
    end
  end
end
