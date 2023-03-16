class PagesController < ApplicationController
  layout false

  def index
    @pages = Page.sorted 
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({visible: false})
    @subjects_ids = Subject.all.map{|s| s.id}
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      flash[:notice] = "Page '#{@page.name}' is created successfully"
      redirect_to({action: 'index'})
    else 
      flash[:error] = "Page '#{@page.name}' creation failed."
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subject_ids = Subject.all.map{|s| s.id}
  end

  def update
    @page = Page.find(params[:id])

    if @page.update(page_params)
      flash[:notice] = "Page '#{@page.name}' updated successfully."
      redirect_to({action:'show', id: @page.id})
    else
      falsh[:error] = "Page '#{@page.name}' update failed."
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed successfully."
    redirect_to({action: 'index'})
  end

  private 
  def page_params
    params.require(:page).permit(:name, :position, :visible, :permalink, :subject_id)
  end
end
