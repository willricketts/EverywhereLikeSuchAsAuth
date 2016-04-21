class HarvestKillLog < ActiveJob::Base
  queue_as :default

  def perform(*args)
    character = JSON.parse(args[0])
    @character = Character.find(character['id'])
    @account = @character.account
    @api = EveApi::Api.new(@account.key_id, @account.vcode)

    @character.update_attributes(kill_log: harvest_kill_log(@character.character_id).kill.to_json)
  end

  def harvest_kill_log(character_id)
    @api.char.kill_log(characterID: character_id)
  end
end