class Staff::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

  private
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member # メソッドをテンプレートの中でも使用出来るようにしている

  def authorize
    unless current_staff_member
      flash.alert = '職員としてログインをして下さい。'
      redirect_to :staff_login
    end
  end

  def check_account
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :staff_root
  end

  TIMEOUT = 60.minutes

  def check_timeout
    if current_staff_member
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:staff_member_id)
        flash.alert ='セッションがタイムアウトしました。'
        redirect_to :staff_login
      end
    end
  end
end
