class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    set_counter
    @items = Item.all.order("cached_votes_up DESC")
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = current_user.items.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to root_path, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/edit/edit/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to root_path, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    set_item
    @item.liked_by current_user
    redirect_to :back
  end

  def downvote
    set_item
    @item.disliked_by current_user
    redirect_to :back
  end

  def votereset
    set_counter
    @counter.liked_by current_user
    redirect_to root_path
  end

  def unvotereset
    set_counter
    @counter.unliked_by current_user
    redirect_to root_path
  end
    
  def resetvotes
    @users = User.all
    @items = Item.all
    set_counter
    reset_counter
    @users.each do |user|
      @items.each do |item|
        item.unvote_by user
      end
    end
    redirect_to root_path
    flash[:notice]="Votes have been reset"
  end

  def resetitems
    set_counter
    reset_counter
    @items = Item.all
    @items.each do |item|
      item.destroy
    end
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    def set_counter

      if Counter.find_by(id:99999, count:0) #see if the counter exists on db reset
        @counter = Counter.find_by(id:99999) #create an unlikely ID number 
      else
        @counter = Counter.new(id:99999, count:0).save #if the db has reset recently
      end
    end

    def reset_counter
      @counter.destroy
      Counter.new(id:99999, count:0).save 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:item, :body)
    end
end