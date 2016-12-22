class MenusController < ApplicationController

  before_action :find_menu, except: [:index, :new, :create]
  before_action :require_current_chef, except: [:new, :create, :index]

  def index
    @menus = current_user.menus.all
    # list of all current/previous menus
      # past
      # current
  end

  def show
    # details of time period
    # menu items
  end

  def new
    @menu = Menu.new
    @menu.menu_selections.build
  end

  def create
    @menu = current_user.menus.build(whitelist)
    if @menu.save
      flash[:success] = "Menu and items saved."
      redirect_to @menu
    else
      flash.now[:danger] = "Could not save menu."
      render :new
    end
  end

  def edit

  end

  def update
    if @menu.update(whitelist)
      flash[:success] = "Menu updated."
      redirect_to @menu
    else
      flash.now[:danger] = "No changes were made."
      render :edit
    end
  end

  def destroy
    if @menu.destroy
      flash[:succes] = "Menu deleted."
      redirect_to menus_path
    else
      flash.now[:danger] = "Unable to delete menu."
      render :show
    end
  end

  private
    def find_menu
      @menu = Menu.find_by_id(params[:id])
    end

    def whitelist
      params.require(:menu).permit(:start_date,
                                   :end_date,
                                   menu_item_ids: [])
    end

    def require_current_chef
      unless @menu.chef == current_user
        flash[:danger] = "Get outta my menu."
        redirect_to current_user
      end
    end
end