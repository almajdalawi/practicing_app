class SectionsController < ApplicationController
  layout false

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({visible: false})
    @pages_ids = Page.all.map{|p| p.id}
    @content_types = Section::CONTENT_TYPES
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      flash[:notice] = "Section #{@section.name} created successfully."
      redirect_to({action: 'index'})
    else
      flash[:error] = "Section #{@section.name} creation failed."
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages_ids = Page.all.map{|p| p.id}
    @content_types = Section::CONTENT_TYPES
  end

  def update
    @section = Section.find(params[:id])

    if @section.update(section_params)
      flash[:notice] = "Section #{@section.name} updated successfully."
      redirect_to({action: 'show', id: @section.id})
    else
      flash[:error] = "Section #{@section.name} update failed."
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
