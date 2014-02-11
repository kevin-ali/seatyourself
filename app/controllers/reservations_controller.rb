class ReservationsController < ApplicationController
 	
before_filter :load_restaurant 



  def show
    @reservation = Reservation.find(params[:id])
  end

  def create
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.user_id = current_user.id

    @reservations = Reservation.all
    total_seats = @reservation.party_size

    @reservations.each { |r| if (r.time.strftime("%H:%M") == @reservation.time.strftime("%H:%M")) && (r.date == @reservation.date) && (r.restaurant_id == @reservation.restaurant_id)
        total_seats += r.party_size    
      end
      }

    if total_seats <= 100
     # @restaurant.seats -= @reservation.party_size
     # @restaurant.save
    

    # Check out this article on [.build](http://stackoverflow.com/questions/783584/ruby-on-rails-how-do-i-use-the-active-record-build-method-in-a-belongs-to-rel)
    # You could use a longer alternate syntax if it makes more sense to you
    # 
    # @review = Review.new(
    #   :comment    => params[:review][:comment], 
    #   :product_id => @product.id, 
    #   :user_id    => current_user.id
    # )

      @reservation.save
      redirect_to restaurants_path, notice: 'Reservation created successfully'
    else
      render :action => :show, notice: 'Not enough seats'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to users_path
  end


  private
  def reservation_params
    params.require(:reservation).permit(:party_size, :date, :time, :restaurant_id, :user_id)
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id]) if params[:restaurant_id] != nil
  end


end
