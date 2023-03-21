class DemoController < ApplicationController

  # layout false # or layout 'layout_name'

  def index
    @array = [1,2,3,4,5]
  end

  def hello
    #render(controller: 'demo', action: 'index') # or render('index')
    @id = params['id'].to_i
    @page = params[:page].to_i
  end

  def other_hello
    redirect_to(controller: 'demo', action: 'index') # or redirect_to(action: 'index')
  end

  def lynda
    redirect_to("http://lynda.com")
  end

  def text_helpers
  end

  def numbers_helpers
  end

  def dateTime_helpers
  end

  def escaping_helpers
  end
end
