class AdminController < ApplicationController
  before_action :verify_admin

  def index
  end

  def recently_invalidated
    @feedbacks = Feedback.unscoped.joins('inner join posts on feedbacks.post_id = posts.id').where(:is_invalidated => true).select('posts.title, feedbacks.*').order('feedbacks.invalidated_at DESC')

    @users = User.where(:id => @feedbacks.pluck(:invalidated_by)).map { |u| [u.id, u] }.to_h
  end

  def user_feedback
    @feedbacks = nil
    begin
      @user = User.find_by_email params[:user_name]
      @feedbacks = Feedback.unscoped.joins('inner join posts on feedbacks.post_id = posts.id').where(:user_id => @user.id).select('posts.title, feedbacks.*').order('feedbacks.id DESC').paginate(:page => params[:page], :per_page => 100)
      @feedback_count = Feedback.unscoped.where(:user_id => @user.id).count
      @invalid_count = Feedback.unscoped.where(:user_id => @user.id, :is_invalidated => true).count
    rescue
    end

    if @feedbacks.nil?
      @feedbacks = Feedback.unscoped.joins('inner join posts on feedbacks.post_id = posts.id').where(:user_name => params[:user_name]).select('posts.title, feedbacks.*').order('feedbacks.id DESC').paginate(:page => params[:page], :per_page => 100)
      @feedback_count = Feedback.unscoped.where(:user_name => params[:user_name]).count
      @invalid_count = Feedback.unscoped.where(:user_name => params[:user_name], :is_invalidated => true).count
    end
  end

  def flagged
    @flags = Flag.joins(:post).joins('left outer join users on users.id = flags.user_id').where(:is_completed => false).order('flags.created_at ASC')
             .select('flags.*, posts.*, users.username')
  end

  def clear_flag
    f = Flag.find params[:id]
    f.is_completed = true

    if f.save
      render :plain => "OK"
    else
      render :plain => "Save failed.", :status => :internal_server_error
    end
  end
end