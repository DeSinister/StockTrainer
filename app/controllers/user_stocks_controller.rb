class UserStocksController < ApplicationController




  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  def show
    @stock = Stock.find(params[:id])
    @user_stock = UserStock.where(user: current_user, stock_id: @stock.id).first
    @act = params[:act]
    render 'user_stocks/show'
  end


  def update
    has_error = false
    act = params[:act]
    @user_stock = UserStock.find(params[:id])
    @stock = Stock.find(@user_stock.stock_id)

    if act == "Buy"
      @user_stock.quantity += params[:user_stock][:quantity].to_i
      p = params[:user_stock][:quantity].to_f * @stock.last_price.to_f
      @user_stock.cprice += p
    else
      if @user_stock.quantity >= params[:user_stock][:quantity].to_i
        @user_stock.quantity -= params[:user_stock][:quantity].to_i
        p = params[:user_stock][:quantity].to_f * @stock.last_price.to_f
        @user_stock.cprice -= p
      else
        flash[:alert] = "You cant Sell more Shares than you have"
        has_error = true
      end
    end
    @user_stock.save!
    if !has_error
      flash[:notice] = "You #{act == "Buy" ? "Bought" : "Sold"} #{params[:user_stock][:quantity]} shares of #{@stock.name} worth $#{p}"
    end
    redirect_to my_list_path
  end


  def destroy
    stock = Stock.find(params[:id])
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    user_stock.destroy
    flash[:notice] = "#{stock.ticker} was successfully removed from your portfolio"
    redirect_to my_portfolio_path
  end
end
