class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :update, :destroy]

  # GET /authors
  def index
    @authors = Author.all

    render json: @authors
  end

  # GET /authors/1
  def show
    render json: @author
  end

  # POST /authors
  def create
    @author = Author.new(author_params)

    if @author.save
      render json: @author, status: :created, location: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /authors/1
  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /authors/1
  def destroy
    @author.destroy
  end

  # POST /authors/batch_create
  def batch_create
    # call the batch create method within the author model
    success = Author.batch_create(request.raw_post)
    if success
      render json: {success: 'authors created'}, status: :created
    else
      render json: {failed: 'authors not created'}, status: :unprocessable_entity
    end
  end

  # PUT /authors/batch_update
  def batch_update
    success = Author.batch_update(request.raw_post)
    if success
      render json: {success: 'authors updated'}, status: :ok
    else
      render json: {failed: 'authors not updated'}, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def author_params
      # params.require(:author).permit(:name)
      params.require(:data)
            .require(:attributes)
            .permit(:name)
    end
end
