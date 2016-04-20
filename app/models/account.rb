class Account
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :user
  has_many :characters

  field :key_id, :type => String, :uniq => true, :required => true
  field :vcode, :type => String, :uniq => true, :required => true
end
