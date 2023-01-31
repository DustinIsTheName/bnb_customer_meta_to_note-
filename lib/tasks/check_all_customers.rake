task :check_all_customers => :environment do
  Customer.check_all
end