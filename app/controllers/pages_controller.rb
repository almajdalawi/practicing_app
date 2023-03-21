class PagesController < ApplicationController
  require_relative '../models/subject'
  # layout false # or layout 'layout_name'

  # before_action(:confirm_logged_in)

  def index
    @pages = Page.sorted 
  end

  def show
    @page = Page.find(params[:id])
    @subject_name = Subject.find(@page.subject_id).name
  end

  def new
    @page = Page.new({visible: false})
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1  
  end

  def create
    @page = Page.new(page_params)


    if @page.save
      flash[:notice] = "Page '#{@page.name}' is created successfully"
      redirect_to({action: 'index'})
    else 
      flash[:error] = "Page '#{@page.name}' creation failed."
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1  
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1  
  end

  def update
    @page = Page.find(params[:id])

    if @page.update(page_params)
      flash[:notice] = "Page '#{@page.name}' updated successfully."
      redirect_to({action:'show', id: @page.id})
    else
      flash[:error] = "Page '#{@page.name}' update failed."
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1  
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
