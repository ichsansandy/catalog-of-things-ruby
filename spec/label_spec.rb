require_relative '../lib/label/label'
require_relative '../lib/label/labels_manager'
require_relative '../lib/book/book'
require 'date'

RSpec.describe Label do
  include LabelsManager

  before :each do
    title = 'Gift'
    color = 'Red'
    @label = Label.new(title, color)
  end

  it 'Should create an instance of the Label class' do
    label = @label
    expect(label).to be_instance_of Label
  end

  it 'should store labels' do
    labels = [Label.new('label1', 'red'), Label.new('label2', 'blue')]
    store_labels(labels)
    expect(File.exist?('./Data/labels.json') && !File.empty?('./Data/labels.json')).to eq true
  end
end
