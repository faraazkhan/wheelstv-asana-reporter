namespace :data do
  desc "TODO"
  task :update => :environment do
    GetData.perform
  end

end
