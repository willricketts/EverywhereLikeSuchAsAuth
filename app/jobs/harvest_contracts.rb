class HarvestContracts < ActiveJob::Base
  queue_as :default

  def perform(*args)
    character = JSON.parse(args[0])
    @character = Character.find(character['id'])
    @account = @character.account
    @api = EveApi::Api.new(@account.key_id, @account.vcode)

    @character.update_attributes(contracts: harvest_contracts(@character.character_id).contractlist.to_json)
  end

  def harvest_contracts(character_id)
    @api.char.contracts(characterID: character_id)
  end
end