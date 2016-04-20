class Character
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :account
  belongs_to :user

  field :name, :type => String
end
