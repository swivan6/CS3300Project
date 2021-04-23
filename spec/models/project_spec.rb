require "rails_helper"

RSpec.describe Project, type: :model do
  context "validations tests" do
    it "ensures the name is present" do
      project = Project.new(description: "Content of the description")
      expect(project.valid?).to eq(false)
    end

    it "ensures the description is present" do
      project = Project.new(name: "Name")
      expect(project.valid?).to eq(false)
    end
    
    it "should be able to save project" do
      project = Project.new(name: "Name", description: "Some description content goes here")
      expect(project.save).to eq(true)
    end
  end

  context "scopes tests" do

  end
end