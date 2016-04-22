class Account
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  ALLOWED_ALLIANCE = ENV['ALLOWED_ALLIANCE']

  belongs_to :user
  has_many :characters

  field :key_id, :type => String, :uniq => true, :required => true
  field :vcode, :type => String, :uniq => true, :required => true

  def eligible?
    result = self.characters.map { |char| char.alliance_id == ALLOWED_ALLIANCE }
    if result.include? true
      return true
    else
      false
    end
  end
end
