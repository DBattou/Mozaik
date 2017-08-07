require "spec_helper.rb"
require 'json'
require_relative "../main"
require_relative "../mozaik"

describe Mozaik do
	it "is named SuperPicture.jpg" do
		infos = JSON.parse(File.read('input_info.json'))
		mozaik = Mozaik.new(infos)
		mozaik.name.should == 'SuperPicture.jpg'
	end
end


describe Mozaik do
	it "'s name is wrong'" do
		testjson = {"name":"test","width":10,"height":10,"backgroundColor":"blue","inputImg":{"URL": "https://assets-cdn.github.com/images/modules/open_graph/github-octocat.png","x_pos":0,"y_pos":0,"percentSize":50},"outputSize": 40}.to_json
		expect { testmain(testjson) }.to raise_error ("The output format is wrong. Must be \".jpg\" ")
	end
end