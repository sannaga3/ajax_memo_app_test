class MemosController < ApplicationController
  before_action :set_memo, only: %i[ show edit update destroy ]

  # GET /memos or /memos.json
  def index
    @memo = Memo.new
    @memos = Memo.all
  end

  # GET /memos/1 or /memos/1.json
  def show
  end

  # GET /memos/1/edit
  def edit
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.html { redirect_to @comment }
      format.js { render :edit }
    end
  end

  # POST /memos or /memos.json
  def create
    @memo = Memo.new(memo_params)

    respond_to do |format|
      if @memo.save
        format.html { redirect_to memos_path, notice: "Memo was successfully created." }
        format.json { render :index, status: :created, location: @memo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1 or /memos/1.json
  def update
    @memos = Memo.all
    respond_to do |format|
      if @memo.update(memo_params)
        # flash.now[:notice] = 'メモが編集されました'
        format.js { render :index }
      else
        # flash.now[:notice] = 'コメントの編集に失敗しました'
        format.js { render :index }
      end
    end
  end

  # DELETE /memos/1 or /memos/1.json
  def destroy
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: "Memo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def memo_params
      params.require(:memo).permit(:content)
    end
end
