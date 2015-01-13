class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :signup, :login]

  def index
    user_signed_in?
  end

  def signup
  end

  def login
  end

  def other_logged_in_stuff
    current_user
  end
end

