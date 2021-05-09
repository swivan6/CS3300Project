require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        fill_in "Name", with: "Test name"
      end
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Project was successfully created")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    let(:project) { Project.create(name: "Test name", description: "Test content") }
    before(:each) do
      visit edit_project_path(project)
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Project was successfully updated")
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    let!(:project) { Project.create(name: "Test name", description: "Test content") }
    scenario "remove project" do
      visit projects_path
      user = User.create(email: 'testemail@test.com', password: "password", password_confirmation: "password")
      sign_in user
      click_on(class: 'btn btn-secondary', text: 'Delete')
      #find('btn btn-secondary', text: 'Delete').click
      #find("Delete").click
      #click_on "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end