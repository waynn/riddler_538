def calculate_probability
  made = 1
  missed = 1

  # 1, 2 are made and missed, respectively
  (3..99).each do |i|
    # puts "Attempt #{i}:"
    # multiply by 10000 to get slightly higher granularity (I think 1000 would suffice)
    make_percent = (made / (made + missed).to_f) * 10000
    # puts "#{make_percent}%"
    random_number = rand * 10000
    
    if random_number < make_percent
      made += 1
    else
      # if we're on the 99th try and we missed, throw it out
      if i == 99
        return nil
      end
      missed += 1
    end
  end

  # if you're going to run a simulation, then you have to only show runs where the 99th shot was 
  # successful, and throw out the runs where it wasn't
  # TODO: this has to be made, so we have to calculate the percentage where it's made
  # 99 is made
  made += 1
  
  return (made / (made + missed).to_f) * 100
end

results = []


# 1,000,000 takes 22 seconds
t1 = Time.now
(1..200000000).each do |i|
  if i % 1000000 == 0
    puts "processing #{i}"
  end
  results << calculate_probability
end
t2 = Time.now

delta = t2 - t1

results.compact!
results.inject{ |sum, el| sum + el }.to_f / results.size