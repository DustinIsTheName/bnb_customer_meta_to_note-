class Customer
  def self.save_note(customer)
    unless customer.note
      customer.note ||= ""
    end

    old_note = customer.note
    customer.note = customer.note.gsub(/Business Name: .*\n?/, '').gsub(/Federal Tax ID: .*\n?/, '').gsub(/OTP License: .*\n?/, '')

    metafields = ShopifyAPI::Metafield.all(metafield: {"owner_id" => customer.id, "owner_resource" => "customer"})

    for metafield in metafields
      print metafield.key + ': '
      puts Colorize.cyan(metafield.value)

      if metafield.key == 'Business Name' || metafield.key == 'Federal Tax ID' || metafield.key == 'OTP License'
        customer.note = "#{metafield.key}: #{metafield.value}\n" + customer.note
      end
    end

    if old_note == customer.note
      puts Colorize.cyan("#{customer.first_name} #{customer.last_name} has not changed")
    else
      if customer.save
        puts Colorize.green("#{customer.first_name} #{customer.last_name} saved")
      else
        puts Colorize.red("#{customer.first_name} #{customer.last_name} failed to save")
      end
    end
  end

  def self.check_all
    customers = ShopifyAPI::Customer.all(limit: 250)
    for customer in customers
      save_note(customer)
    end

    while ShopifyAPI::Customer.next_page? do 
      customers = ShopifyAPI::Customer.all(limit: 250, page_info: ShopifyAPI::Customer.next_page_info)
      for customer in customers
        save_note(customer)
      end
    end
  end
end