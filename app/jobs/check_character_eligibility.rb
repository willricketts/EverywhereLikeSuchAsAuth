class CheckCharacterEligibility < ActiveJob::Base
  queue_as :semi_hourly

  ALLOWED_ALLIANCE = ENV['ALLOWED_ALLIANCE']

  def perform
    Account.all.each do |account|
      api = EveApi::Api.new(account.key_id, account.vcode)
      characters = character_reharvest
      char.user.update_attributes(flagged: true) unless char.alliance_id == ALLOWED_ALLIANCE
    end
  end

  private
  def character_reharvest
    @api.account.Characters
  end
end

