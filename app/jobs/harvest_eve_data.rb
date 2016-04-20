class HarvestEveData < ActiveJob::Base
  queue_as :default

  def perform_async(account)
    @api = EAAL::API.new(account.key_id, account.vcode)
    @characters = harvest_characters.characters
    save_characters(account, @characters)
  end

  private

  ## Character Data
  def harvest_characters
    @api.Characters
  end

  def save_characters(account, characters)
    characters.map do |char|
      Character.new(name: char.name,
                    alliance_id: char.allianceId,
                    alliance_name: char.allianceName,
                    character_id: char.characterId,
                    corporation_id: char.corporationId,
                    corporation_name: char.corporationName,
                    faction_id: char.factionId,
                    user: account.user
      ).save
    end
  end
end