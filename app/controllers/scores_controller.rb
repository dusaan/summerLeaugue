class ScoresController < ApplicationController
  def index
    @scores = Newz.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @newzs }
    end
  end

end
