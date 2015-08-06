class Url < ActiveRecord::Base
    belongs_to :user

    validates :incoming, :outgoing, :http_status, presence: true
    validates :incoming, uniqueness: true, format: {with: /\A^([0-9]*[a-zA-Z][a-zA-Z0-9]*)$\z/}
    # cab adjust regex for better validation
    # todo: add regex for url validation
    # add validation for http_status
end
