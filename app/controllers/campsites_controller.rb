class CampsitesController < ApplicationController
    before_action :authorize
    skip_before_action :authorize, only: [:index]

    def show
        campsite = Campsite.find(params[:id])
        render json: campsite 
    end
    
    def index
        campsites = Campsite.all
        render json: campsites 
    end
    
    def create
        campsite = Campsite.create(user_id: session[:user_id])
        render json: campsite, status: :created
    end

    # def update
    #     return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    #     review = Review.find(params[:id])
    # end

    def update
        campsite = Campsite.find(user_id: session[:user_id])
        render json: campsite, status: :accepted
    end

    def destroy
        campsite = Campsite.find(params[:id])
        campsite.destroy 
        head :no_content 
    end


    private
    
    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end

end



#     def index 
#         campsites = Campsite.all
#         render json: campsites, status: :ok
#     end

#     def show 
#         campsite = Campsite.find(params[:id])
#         render json: campsite, status: :ok
#     end

#     def create
#         campsite = Campsite.create!(campsite_params)
#         render json: campsite, status: :created    
#     end

#     def update
#         campsite = Campsite.find(params[:id])
#         campsite.update!(campsite_params)
#         render json: campsite, status: :accepted
#     end

#     def destroy
#         campsite = Campsite.find(params[:id])
#         campsite.destroy 
#         head :no_content 
#     end

#     private 

#     def campsite_params 
#         params.permit(:name, :region, :description, :elevation, :coordinates, :image)
#     end

# end
