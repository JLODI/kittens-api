class KittensController < ApplicationController
  before_action :setup_kitten, only: [:show, :edit, :update, :destroy]

  def index
    @kittens = Kitten.all
  end

  def show
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save
      flash[:notice] = "Your Kitten has been born!"
      redirect_to kittens_path
    else
      flash.now[:error] = @kitten.errors.full_messages.join ('<br/>')
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
      if @kitten.update(kitten_params)
          flash[:notice] = "Your Kitten has been updated!"
          redirect_to kitten_path(params[:id])
      else
          flash.now[:error] = @kitten.errors.full_messages.join ('<br/>')
          render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @kitten.destroy    
        if @kitten.destroy
            flash[:notice] = "Your kitten has been delivered to the animal shelter. I hope they find a new family soon"
            redirect_to kittens_path
        else
            flash.now[:error] = @kitten.errors.full_messages.join ('<br/>')
            render :destroy, status: :unprocessable_entity
        end
  end  

  private

  def setup_kitten
    @kitten = Kitten.find(params[:id])
  end

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
