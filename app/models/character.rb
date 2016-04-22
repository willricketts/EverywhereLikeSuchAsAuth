class Character
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  after_create :harvest_skill_queue, :harvest_skill_in_training, :harvest_contracts

  belongs_to :account
  belongs_to :user

  field :name, :type => String
  field :alliance_id, :type => String
  field :alliance_name, :type => String
  field :character_id, :type => String, :unique => true
  field :corporation_id, :type => String
  field :corporation_name, :type => String
  field :faction_id, :type => String
  field :skill_queue, :type => Text
  field :skill_in_training, :type => Text
  field :contracts, :type => Text
  field :risk_level, :type => Integer, :default => 0
  field :flagged, :type => Boolean

  def alts
    alts = self.account.characters.to_a
    payload = []
    alts.each do |char|
      payload.push char unless char.id == self.id
    end
    payload
  end

  def harvest_skill_queue
    HarvestSkillQueue.perform_later(self.to_json)
  end

  def harvest_skill_in_training
    HarvestSkillInTraining.perform_later(self.to_json)
  end

  def harvest_contracts
    HarvestContracts.perform_later(self.to_json)
  end
end
