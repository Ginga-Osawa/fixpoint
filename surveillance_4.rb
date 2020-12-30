require "csv"
require "time"
DATA_LIST = CSV.read("test-log.csv")

def return_subnet(address)
  address_ary = address.split(/[\.\/]/)
  if address_ary.last == "16"
    "#{address_ary[0]}.#{address_ary[1]}"
  elsif address_ary.last == "24"
    "#{address_ary[0]}.#{address_ary[1]}.#{address_ary[2]}"
  end
end

timeout_buffer = Hash.new([])
output_timeout = []
index = 0

N = ARGV[0].nil? ? 0 : ARGV[0].to_i

hash_buf = Hash.new{ |hash, key| hash[key] = [] }
DATA_LIST.each do |datetime, address, ping|
  if ping == "-"
    timeout_buffer.store(datetime, address)
  end

  error_hash = timeout_buffer.select { |key, value| value == address }
  error_count = error_hash.count

  
  if timeout_buffer.value?(address) && ping != "-"
    if error_count < N
      timeout_buffer.delete_if{ |key, value| value == address }
    else
      output_timeout.push("#{address}は#{error_hash.min.first}から#{datetime}まで故障していました。")
      timeout_buffer.delete_if{ |key, value| value == address }
    end
  end
p return_subnet(address)
end


p output_timeout

