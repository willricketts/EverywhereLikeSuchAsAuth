class Account
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :user
  has_many :characters

  field :key_id, :type => String
  field :vcode, :type => String
end
