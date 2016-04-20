class Character
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :account
  belongs_to :user

  field :name, :type => String
  field :alliance_id, :type => String
  field :alliance_name, :type => String
  field :character_id, :type => String
  field :corporation_id, :type => String
  field :corporation_name, :type => String
  field :faction_id, :type => String
end
