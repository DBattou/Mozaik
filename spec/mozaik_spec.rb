require "spec_helper.rb"
require 'json'
require_relative "../mozaik"

describe Mozaik do
	it "is named SuperPicture.jpg" do
		infos = JSON.parse(File.read('input_info.json'))
		mozaik = Mozaik.new(infos)
		mozaik.get_name().should == 'SuperPicture.jpg'
	end
end
