class SubjectsController < ApplicationController
  # layout false # or layout 'layout_name'

  # before_action(:confirm_logged_in)

  def index
    @subjects = Subject.sorted # or Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({visible: false})
    @subject_count = Subject.count + 1  
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      flash[:notice] = "Subject '#{@subject.name}' created successfully."
      redirect_to({action: 'index'})
    else
      flash[:error]= "Subject '#{@subject.name}' creation failed."
      @subject_count = Subject.count + 1  
      render('new')
    end
  end

  def edit 
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count + 1  
  end

  def update
    @subject = Subject.find(params[:id])

    before_action(:confirm_logged_in)

    if @subject.update(subject_params)
      flash[:notice] = "Subject '#{@subject.name}' updated successfully."
      redirect_to({action: 'show', id: @subject.id})
    else
      flash[:error]= "Subject '#{@subject.name}' update failed."
      @subject_count = Subject.count + 1  
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully."
    redirect_to({action: 'index'})
  end

  private 
  def subject_params
    params.require(:subject).permit(:name, :position, :visible)
  end
end
