class SectionsController < ApplicationController
  # layout false # or layout 'layout_name'

  # before_action(:confirm_logged_in)</div>

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
    @page_name = Page.find(@section.page_id).name
  end

  def new
    @section = Section.new({visible: false})
    @pages = Page.order('position ASC')
    @content_types = Section::CONTENT_TYPES
    @section_count = Section.count + 1  
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      flash[:notice] = "Section #{@section.name} created successfully."
      redirect_to({action: 'index'})
    else
      flash[:error] = "Section #{@section.name} creation failed."
      @pages = Page.order('position ASC')
      @content_types = Section::CONTENT_TYPES
      @section_count = Section.count + 1  
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages = Page.order('position ASC')
    @content_types = Section::CONTENT_TYPES
    @section_count = Section.count + 1  
  end

  def update
    @section = Section.find(params[:id])

    if @section.update(section_params)
      flash[:notice] = "Section #{@section.name} updated successfully."
      redirect_to({action: 'show', id: @section.id})
    else
      flash[:error] = "Section #{@section.name} update failed."
      @pages = Page.order('position ASC')
      @content_types = Section::CONTENT_TYPES
      @section_count = Section.count + 1  
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy 
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section #{section.name} destroyed successfully."
    redirect_to({action: 'index'})
  end

  private
  def section_params
    params.require(:section).permit(:name, :position, :visible, :content_type, :content, :page_id)
  end
end
