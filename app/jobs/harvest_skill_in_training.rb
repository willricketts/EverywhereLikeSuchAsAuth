class HarvestSkillInTraining < ActiveJob::Base
  queue_as :default

  def perform(*args)
    character = JSON.parse(args[0])
    @character = Character.find(character['id'])
    @account = @character.account
    @api = EveApi::Api.new(@account.key_id, @account.vcode)

    @character.update_attributes(skill_in_training: harvest_skill_in_training(@character.character_id).to_json)
  end

  def harvest_skill_in_training(character_id)
    @api.char.skill_in_training(characterID: character_id)
  end
end