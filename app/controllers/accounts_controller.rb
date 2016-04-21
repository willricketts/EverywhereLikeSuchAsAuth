class AccountsController < ApplicationController
  def index

  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user

    if @account.save
      HarvestEveCharacters.perform_later(@account.to_json)
      redirect_to :dashboard
    else
      redirect_to :new_account
    end
  end

  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
  end

  def destroy
    @account = Account.find(params[:id])
    @account.update_attributes(:active => false)
  end

  private
  def account_params
    params.require(:account).permit(:key_id, :vcode)
  end
end
