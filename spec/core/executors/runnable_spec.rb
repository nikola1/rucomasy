require 'fileutils'
require './core/rucomasy_core'

describe 'Runnable' do
  def random_subdir(dir = File.dirname(__FILE__))
    File.join dir, random_dirname
  end

  def random_dirname
    "#{Time.now.to_i}_#{Process.pid}_#{Random.rand(6661313)}"
  end

  def exists?(dirname)
    File.exists? dirname
  end

  def fullpath(dirname)
    File.absolute_path dirname
  end

  before(:each) do
    @first_dirname  = random_subdir
    @second_dirname = random_subdir
    @source_folder  = random_dirname

    source_folder_path = File.join(@first_dirname, @source_folder)
    FileUtils.mkdir_p source_folder_path
    Dir.chdir(source_folder_path) { FileUtils.touch (1..3).map(&:to_s) }
  end

  after(:each) do
    FileUtils.rm_r @first_dirname  if File.exists? @first_dirname
    FileUtils.rm_r @second_dirname if File.exists? @second_dirname
  end

  let(:first_dir_source) { File.join @first_dirname, @source_folder }
  let(:second_dir_source) { File.join @second_dirname, @source_folder }

  it 'moves runnable\'s directory' do
    runnable = Runnable.new "", first_dir_source
    runnable.fullpath.should eq first_dir_source
    exists?(first_dir_source).should be true

    (1..3).each do |file|
      exists?(File.join first_dir_source, file.to_s).should be true
    end

    runnable.move_to @second_dirname
    runnable.fullpath.should eq second_dir_source

    exists?(first_dir_source).should be false
    exists?(second_dir_source).should be true

    (1..3).each do |file|
      exists?(File.join first_dir_source, file.to_s).should be false
      exists?(File.join second_dir_source, file.to_s).should be true
    end
  end

  it 'copies runnable\'s directory' do
    first_runnable = Runnable.new "", first_dir_source
    first_runnable.fullpath.should eq first_dir_source
    exists?(@first_dirname).should be true

    (1..3).each do |file|
      exists?(File.join first_dir_source, file.to_s).should be true
    end

    second_runnable = first_runnable.copy_to @second_dirname
    second_runnable.fullpath.should eq second_dir_source

    exists?(first_dir_source).should be true
    exists?(second_dir_source).should be true

    (1..3).each do |file|
      exists?(File.join first_dir_source, file.to_s).should be true
      exists?(File.join second_dir_source, file.to_s).should be true
    end
  end
end
