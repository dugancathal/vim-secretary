require 'spec_helper'

describe Vim::Secretary::Parser do
  before(:all) do
    @secretary_file = PROJECT_ROOT.join('spec/fixtures/secretary-sample-full')
    @unaltered_file = File.read(@secretary_file)
    @parser = Vim::Secretary::Parser.new(@secretary_file.to_s)
    @parser.parse
    @first_project = @parser.projects.first
  end

  it 'removes comment lines that start with #' do
    @unaltered_file.split("\n").count.must_equal 6
    @parser.lines.count.must_equal 4
  end

  it 'allows notes to spill onto a new line' do
    @parser.projects.count.must_equal 3
  end

  it 'sets the date by the first field' do
    @first_project[0].must_be_kind_of DateTime
  end

  it 'sets the project name by the first field inside the []s' do
    @first_project[1].must_be_kind_of String
    @first_project[1].must_equal 'My Project'
  end

  it 'sets the tags by the remaining fields inside the []s' do
    @first_project[2].must_be_kind_of Array
  end

  it 'sets the notes as anything after the dash (-)' do
    @first_project[3].must_be_kind_of String
  end
end

describe "Parser Benchmark" do
  before do
    @secretary_file = PROJECT_ROOT.join('spec/fixtures/secretary-sample-bench')
    @parser = Vim::Secretary::Parser.new(@secretary_file.to_s)
  end

  bench_performance_constant 'parsing', 0.95 do
    @parser.parse
  end
end
