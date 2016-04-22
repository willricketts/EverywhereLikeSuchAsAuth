class CheckCharacterEligibility < ActiveJob::Base
  queue_as :semi_hourly

  ALLOWED_ALLIANCE = ENV['ALLOWED_ALLIANCE']

  def perform
    Account.all.each do |account|
      @api = EveApi::Api.new(account.key_id, account.vcode)
      characters = character_reharvest
      characters.each do |char|
        target = Character.where(character_id: char.id)
        target.update_attributes(corporation_id: char.corporationID,
                                 corporation_name: char.corporationName,
                                 alliance_id: char.allianceID,
                                 alliance_name: char.allianceName
        )

        unless char.allianceID == ALLOWED_ALLIANCE
          target.update_attributes(flagged: true)
        end

        unless account.eligible?
          account.user.update_attributes(eligible: false)
        end
      end
    end
  end

  private
  def character_reharvest
    @api.account.Characters
  end
end

