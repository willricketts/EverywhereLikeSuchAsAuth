class Character
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  after_create :harvest_skill_queue

  belongs_to :account
  belongs_to :user

  field :name, :type => String
  field :alliance_id, :type => String
  field :alliance_name, :type => String
  field :character_id, :type => String
  field :corporation_id, :type => String
  field :corporation_name, :type => String
  field :faction_id, :type => String
  field :skill_queue, :type => Text

  def harvest_skill_queue
    HarvestSkillQueue.perform_later(self.to_json)
  end
end
