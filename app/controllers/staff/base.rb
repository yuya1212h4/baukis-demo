class Staff::Base < ApplicationController
  before_action :authorize

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
end
