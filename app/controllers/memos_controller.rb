class MemosController < ApplicationController
  before_action :set_memo, only: %i[ show edit update destroy ]

  def index
    @memo = Memo.new
    @memos = Memo.all
  end

  def show
  end

  def edit
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.html { redirect_to @comment }
      format.js { render :edit }
    end
  end

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

  def update
    @memos = Memo.all
    respond_to do |format|
      if @memo.update(memo_params)
        flash.now[:notice] = 'メモが編集されました'
        format.js { render :index }
      else
        flash.now[:notice] = 'コメントの編集に失敗しました'
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

    def set_memo
      @memo = Memo.find(params[:id])
    end

    def memo_params
      params.require(:memo).permit(:content)
    end
end
