class Visitor
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ip,       :type => String
  field :referrer, :type => String

  referenced_in :link
end
