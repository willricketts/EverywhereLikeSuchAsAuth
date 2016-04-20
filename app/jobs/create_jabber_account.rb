class CreateJabberAccount < ActiveJob::Base
  queue_as :default

  def perform(user)

  end
end