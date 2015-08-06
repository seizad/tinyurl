class Url < ActiveRecord::Base
    validates :incoming, :outgoing, :http_status, presence: true
    validates :incoming, uniqueness: true, format: {with: /\A^([0-9]*[a-zA-Z][a-zA-Z0-9]*)$\z/}
end
