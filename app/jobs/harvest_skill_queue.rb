class HarvestSkillQueue < ActiveJob::Base
  queue_as :default

  def perform(*args)
    character = JSON.parse(args[0])
    @character = Character.find(character['id'])
    @account = @character.account
    @api = EveApi::Api.new(@account.key_id, @account.vcode)

    @character.update_attributes(skill_queue: harvest_skill_queue(@character.character_id).skillqueue.to_json)
  end

  def harvest_skill_queue(character_id)
    puts '################################## ' + character_id
    @api.char.skill_queue(characterID: character_id)
  end
end