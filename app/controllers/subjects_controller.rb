class SubjectsController < ApplicationController
  layout false

  def index
    @subjects = Subject.sorted # or Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({visible: false})
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      flash[:notice] = "Subject '#{@subject.name}' created successfully."
      redirect_to({action: 'index'})
    else
      falsh[:error]= "Subject '#{@subject.name}' creation failed."
      render('new')
    end
  end

  def edit 
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])

    if @subject.update(subject_params)
      flash[:notice] = "Subject '#{@subject.name}' updated successfully."
      redirect_to({action: 'show', id: @subject.id})
    else
      falsh[:error]= "Subject '#{@subject.name}' update failed."
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
