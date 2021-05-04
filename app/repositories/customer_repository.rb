class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = [] # where I'm storing the customer instances
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def all
    @customers
  end

  def create(customer)
    # 1. Assign the next_id to the customer
    customer.id = @next_id
    # 2. Save the customer in the @customers array
    @customers << customer
    # 3. Update the value of the @next_id
    @next_id += 1
    # 4. Save into the csv file
    save_csv
  end

  private

  def save_csv
    # We don't need options here, we are writting the headers manually
    CSV.open(@csv_file, "wb") do |csv|
      # 1. Write the headers of the csv file
      csv << ["id", "name", "address"]
      # 2. Write all instances of customer in the csv file
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }

    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      loaded_customer = Customer.new(row)
      @customers << loaded_customer
    end
    @next_id = @customers.last.id + 1 unless @customers.empty?
  end
end