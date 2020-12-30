require "csv"
require "time"
START_CODE = "START"
FIN_CODE = "FIN"
DATA_LIST = CSV.read("test-log.csv")
timeout_buffer = Hash.new([])
output_timeout = []
output_timeover = Hash.new{ |h, key| h[key] = [] }
index = 0

N = ARGV[0].nil? ? 0 : ARGV[0].to_i
t = ARGV[1].nil? ? 200 : ARGV[1].to_i
m = ARGV[2].nil? ? 3 : ARGV[2].to_i

hash_buf = Hash.new{ |hash, key| hash[key] = [] }
DATA_LIST.each do |datetime, address, ping|
  if ping == "-"
    timeout_buffer.store(datetime, address)
  else
    hash_buf["#{address}"] << ping.to_i
  end

  ping_average = hash_buf["#{address}"].last(m).sum / hash_buf["#{address}"].last(m).count
  
  if ping_average > t
    output_timeover["#{address}"] << datetime
  elsif output_timeover.key?(address) && output_timeover["#{address}"].last != FIN_CODE
    output_timeover["#{address}"] << datetime
    output_timeover["#{address}"] << FIN_CODE
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
p output_timeover
