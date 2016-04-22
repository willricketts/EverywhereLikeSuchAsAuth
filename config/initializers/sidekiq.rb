Sidekiq.configure_server do |config|
  if Rails.env.production?
    config.redis = {
        url: ENV['REDIS_URL'] || 'redis://localhost',
        namespace: ENV['REDIS_DB'] || 'elsa_development',
        password: ENV['REDIS_PASS'] || nil
    }

    database_url = ENV['DATABASE_URL']
    if database_url
      ENV['DATABASE_URL'] = "#{database_url}?pool=25"
      ActiveRecord::Base.establish_connection
      # Note that as of Rails 4.1 the `establish_connection` method requires
      # the database_url be passed in as an argument. Like this:
      # ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
    end
  end
end

Sidekiq.configure_client do |config|
  if Rails.env.production?
    config.redis = {
        url: ENV['REDIS_URL'] || 'redis://localhost',
        namespace: ENV['REDIS_DB'] || 'elsa_development',
        password: ENV['REDIS_PASS'] || nil
    }
  end
end

hash = {
          'Check Character Eligibility' => {
              'class' => 'CheckCharacterEligibility',
              'cron' => '*/30 * * * *'
          },

          'Harvest Skill Queue' => {
              'class'=> 'HarvestSkillQueue',
              'cron'=> '*/60 * * * *'
          },

          'Harvest Skill in Training' => {
              'class'=> 'HarvestSkillInTraining',
              'cron'=> '*/60 * * * *'
          }
}

Sidekiq::Cron::Job.load_from_hash hash