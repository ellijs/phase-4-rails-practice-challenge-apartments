class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    
    def index
        leases = Lease.all
        render json: leases
    end
    
    def show
        lease = Lease.find(params[:id])
        render json: lease
    end

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
    end

    def update
        lease = Lease.find(params[:id])
        lease.update!(lease_params)
        render json: lease, status: :accepted
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content, status: :deleted
    end
    
    private

    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end
    
    def render_not_found_response
        render json: { error: "Lease not found" }, status: :not_found
    end
    
    def render_invalid_response invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

end
