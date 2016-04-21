class HarvestEveCharacters < ActiveJob::Base
  queue_as :default

  def perform(*args)
    account = JSON.parse(args[0])
    @api = EveApi::Api.new(account['key_id'], account['vcode'])
    @characters = harvest_characters.characters
    @account = Account.find(account['id'])
    save_characters(@account, @characters)
  end


  private

  ## Character Data
  def harvest_characters
    @api.account.Characters
  end

  def save_characters(account, characters)
    characters.map do |char|

      Character.new(name: char.name,
                                    alliance_id: char.allianceID.to_s,
                                    alliance_name: char.allianceName,
                                    character_id: char.characterID.to_s,
                                    corporation_id: char.corporationID.to_s,
                                    corporation_name: char.corporationName,
                                    faction_id: char.factionID.to_s,
                                    user: account.user,
                                    account: account
      ).save
    end
  end
end
