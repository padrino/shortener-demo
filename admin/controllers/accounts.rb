Admin.controllers :accounts do

  # GET /accounts
  get :index do
    @accounts = Account.all
    render 'accounts/index'
  end

  # GET /accounts/new
  get :new do
    @account = Account.new
    render 'accounts/new'
  end

  # POST /accounts/create
  post :create do
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = 'Account was successfully created.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/new'
    end
  end

  # GET /accounts/edit/:id
  get :edit, :with => :id do
    @account = Account.find(params[:id])
    render 'accounts/edit'
  end

  # PUT /accounts/update/:id
  put :update, :with => :id do
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = 'Account was successfully updated.'
      redirect url(:accounts, :edit, :id => @account.id)
    else
      render 'accounts/edit'
    end
  end

  # DELETE /accounts/destroy/:id
  delete :destroy, :with => :id do
    account = Account.find(params[:id]) rescue nil
    if account && account != current_account && account.destroy
      flash[:notice] = 'Account was successfully destroyed.'
    else
      flash[:error] = 'Cannot destroy account!'
    end
    redirect url(:accounts, :index)
  end
end
