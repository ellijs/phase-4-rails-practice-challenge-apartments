class Tenant < ApplicationRecord
    has_many :leases, dependent: :destroy
    has_many :apartments, through: :leases

    validates_presence_of :name
    validates_numericality_of :age, :greater_than_or_equal_to => 18
end
