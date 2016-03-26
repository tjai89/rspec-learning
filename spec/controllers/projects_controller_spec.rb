require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  it "fails create gracefully" do
    action_stub = double(create: false, project: Project.new)
    expect(CreatesProject).to receive(:new).and_return(action_stub)
    post :create, :project => {name: 'Project Runway'}
    expect(response).to render_template(:new)
  end

  it "fails update gracefully" do
    sample = Project.create!(name: "Test Project")
    expect(sample).to receive(:update_attributes).and_return(false)
    allow(Project).to receive(:find).and_return(sample)
    patch :update, id: sample.id, project: {name: "Fred"}
    expect(response).to render_template(:edit)
  end

  describe "POST create" do 
    it "creates a project" do
      post :create, project: {name: "Runway", tasks: "Start something:2"}
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action).project.name).to eq("Runway")
    end

    it "goes back to the form on failure" do
      post :create, project: {name: "", tasks: ""}
      expect(response).to render_template(:new)
      expect(assigns(:project)).to be_present
    end
  end

end
