class MemosController < ApplicationController
  before_action :set_memo, only: %i[ show edit update destroy ]
  before_action :set_memos

  def index
    @memo = Memo.new
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
        flash.now[:notice] = 'メモが作成されました'
        format.js { render :index }
      else
        flash.now[:notice] = 'メモの作成に失敗しました'
        format.js { render :index }
      end
    end
  end

  def update
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

  def destroy
    @memo.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end

  private

    def set_memo
      @memo = Memo.find(params[:id])
    end

    def set_memos
      @memos = Memo.all
    end

    def memo_params
      params.require(:memo).permit(:content)
    end
end
