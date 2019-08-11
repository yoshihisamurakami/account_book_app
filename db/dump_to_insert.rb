#
# rails job:keepalive
#

File.open('books.dump') do |f|
  f.each_line do |line|
    cols = line.split("\t")
    if cols.count == 14
      books_date = cols[1]
      user_id = cols[2]
      account_id = cols[3]
      deposit = cols[4] == '1' ? 't' : 'f'
      transfer = cols[5]
      category_id = cols[6]=='\N' ? 'null' : cols[6]
      category_id = 'null' if category_id == '0'
      summary = cols[7]
      # if summary.include?("'")
      #   p summary
      # end
      amount = cols[8]
      common = cols[9]
      business = cols[10]
      special = cols[11]
      created_at = cols[12]
      updated_at = cols[13].chomp

      query = "INSERT INTO books (books_date, user_id, account_id, deposit, transfer, category_id, summary, amount, common, business, special, created_at, updated_at) "
      query += " values "

      query += "('#{books_date}', #{user_id}, #{account_id}, '#{deposit}', '#{transfer}', #{category_id}, '#{summary}', #{amount}, '#{common}', '#{business}', '#{special}', '#{created_at}', '#{updated_at}');"
      puts query
    end
  end
end
