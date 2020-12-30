require "csv"
require "time"
DATA_LIST = CSV.read("test-log.csv")
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
end

p output_timeout

