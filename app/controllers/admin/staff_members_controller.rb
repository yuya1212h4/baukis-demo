class Admin::StaffMembersController < Admin::Base
  def index
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
  end

  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to [ :edit, :admin, staff_member ]
  end

  def new
    @staff_member = StaffMember.new
  end

  def create
    @staff_member = StaffMember.new(params[:staff_member])
    if @staff_member.save
      flash.notice = '職員アカウントを新規登録しました。'
      redirect_to :admin_staff_members
    else
      render action: 'new'
    end
  def edit
    @staff_member = StaffMember.find(params[:id])
  end
end
