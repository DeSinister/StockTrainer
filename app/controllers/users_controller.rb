class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
    update_stock(@tracked_stocks)
    @user = current_user
  end

  def my_list
    @tracked_stocks = current_user.stocks
    update_stock(@tracked_stocks)
    @user = current_user
  end

  def my_friendlist
    @added_friends = current_user.friends
  end


  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search_friend
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/fresult' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'users/fresult' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a friend name or email to search"
        format.js { render partial: 'users/fresult' }
      end
    end
  end
end
