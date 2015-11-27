class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy, :close]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all.order(:status
      )
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    if @ticket.assigned_to.blank?
      @ticket.status = 1
    else
      @ticket.status = 2
    end
    @ticket.created_by = current_user.email
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.status == 3
        format.html {redirect_to @ticket, alert: 'Closed ticket can not be edited'}
        format.json {render json: "Closed ticket can not be edited", status: :unprocessable_entity}
      end
      if @ticket.update(ticket_params)
        if @ticket.assigned_to.blank?
          @ticket.status = 1
        else
          @ticket.status = 2
        end 
        @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    @ticket.status = 3
    respond_to do |format|
      if @ticket.save
        format.html {redirect_to @ticket, notice: 'Ticket closed successfully.' }
        format.json {render :show, status: :ok, location: @ticket}
      else
        format.html {redirect_to @ticket, alert: 'Could not close the ticket.' }
        format.json {render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:title, :customer_email, :customer_name, :created_by, :assigned_to, :area)
    end
end
