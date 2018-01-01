class CheckEmailDiscovered
  class << self

    def email_file email
      special ="!#$%&'*+-/=?^_`{|}~"
      lines = File.open("#{Rails.root}/tmp/start_char_email").map{|e| e.gsub(/\W/, "")}
      lines.each do |line|
        if line.include? 'symbols'
          char = line.gsub('symbols', '')
          if ( email.start_with? char ) and ( special.include? email[char.size] )
            return char + 'symbols_per_user.json'
          end
        else
          if email.start_with? line
            return line + '_per_user.json'
          end
        end
      end
      return nil
    end

    def execute email
      results =[]
      file_email =  email_file email
      file = File.read("#{Rails.root}/tmp/ReducePasswordsOnSimilarEmailsCallback/#{file_email}")
      data_hash = JSON.parse(file)
      keys = data_hash.keys
      keys.each do |key|
        data =  data_hash[key]
        results << data.select {|h| h['email'].include? email}.first if data.select {|h| h['email'].include? email}.size >0
      end
      return results
    end

  end
end
