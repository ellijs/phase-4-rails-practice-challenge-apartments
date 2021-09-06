class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    
    def index
        tenants = Tenant.all
        render json: tenants
    end
    
    def show
        tenant = Tenant.find(params[:id])
        render json: tenant
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update(tenant_params)
        render json: tenant, status: :accepted
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content, status: :deleted
    end
    
    private

    def tenant_params
        params.permit(:name, :age)
    end
    
    def render_not_found_response
        render json: { error: "Tenant not found" }, status: :not_found
    end
    
    def render_invalid_response invalid
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end

end
