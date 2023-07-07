class List < ApplicationRecord
    belongs_to :usuario
    has_many :joyas
end
