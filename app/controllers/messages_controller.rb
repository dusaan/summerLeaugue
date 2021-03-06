class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    @messages = @current_user.messages
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])
    puts @message.read_at    
    if @message.read_at == nil and @message.receiver_id == @current_user.id
      @message.read_at = Time.now.utc
      @message.save
    end
    
    
  end

  def new
    @message = Message.new
    @users = User.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    @message.sender = @current_user
    respond_to do |format|
      if @message.save
        flash[:notice] = 'Správa bola úspešne odoslaná.'
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

end
