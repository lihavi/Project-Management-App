class ApplicationController < Sinatra::Base
    set :default_content_type, 'application/json'
    
    # Add your routes here
    get "/" do
      { message: "Good luck with your project!" }.to_json
    end

    # User registration
post '/api/register' do
    user = User.new(username: params[:username], password: BCrypt::Password.create(params[:password]))
  
    if user.save
      { message: 'User registered successfully' }.to_json
    else
      status 400
      { error: 'Error registering user' }.to_json
    end
  end
  
  # User login
  post '/api/login' do
    user = User.find_by(username: params[:username])
  
    if user && BCrypt::Password.new(user.password_digest) == params[:password]
      session[:user_id] = user.id
      { message: 'User logged in successfully' }.to_json
    else
      status 401
      { error: 'Invalid login credentials' }.to_json
    end
  end
  
  # User logout
  post '/api/logout' do
    session.clear
    { message: 'User logged out successfully' }.to_json
  end
  # Get all projects for the current user
get '/api/projects' do
    authenticate_user!
  
    projects = current_user.projects
    projects.to_json
  end
  
  # Create a new project
  post '/api/projects' do
    authenticate_user!
  
    project = current_user.projects.new(name: params[:name], description: params[:description])
  
    if project.save
      { message: 'Project created successfully' }.to_json
    else
      status 400
      { error: 'Error creating project' }.to_json
    end
  end
  
  # Update a project
  put '/api/projects/:id' do
    authenticate_user!
  
    project = current_user.projects.find(params[:id])
  
    if project.update(name: params[:name], description: params[:description])
      { message: 'Project updated successfully' }.to_json
    else
      status 400
      { error: 'Error updating project' }.to_json
    end
  end
  
  # Delete a project
  delete '/api/projects/:id' do
    authenticate_user!
  
    project = current_user.projects.find(params[:id])
    project.destroy
  
    { message: 'Project deleted successfully' }.to_json
  end
  # Get all members for a project
get '/api/projects/:id/members' do
    authenticate_user!
  
    project = current_user.projects.find(params[:id])
    members = project.users
    members.to_json
  end
  
  # Add a member to a project
post '/api/projects/:id/members' do
   
  
    project = Project.find(params[:id])
    user = User.find_by(username: params[:username])
  
    if project && user
      membership = Membership.new(project_id: project.id, user_id: user.id)
      if membership.save
        { message: "Member added to project" }.to_json
      else
        status 422
        { errors: membership.errors.full_messages }.to_json
      end
    else
      status 404
      { message: "Project or user not found" }.to_json
    end
  end
  
  # Remove a member from a project
  delete '/api/projects/:id/members/:user_id' do
    content_type :json
  
    project = Project.find(params[:id])
    user = User.find_by(id: params[:user_id])
  
    if project && user
      membership = Membership.find_by(project_id: project.id, user_id: user.id)
      if membership
        membership.destroy
        { message: "Member removed from project" }.to_json
      else
        status 404
        { message: "Membership not found" }.to_json
      end
    else
      status 404
      { message: "Project or user not found" }.to_json
    end
  end
end
  