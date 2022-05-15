module LogInModule
  def log_in_as(user)
    allow_any_instance_of(UserSession).to receive(:current_user).and_return(user)
  end
end
