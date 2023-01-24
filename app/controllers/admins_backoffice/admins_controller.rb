class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end
end

def edit
  @admin = Admin.find(params[:id])
end