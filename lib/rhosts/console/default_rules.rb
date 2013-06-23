# print all mappings
rule /^(A|all)$/ do
  display 'actives', actives
  display 'inactives', inactives
end

# print only active mappings
rule /^(a|actives)$/ do
  display 'actives', actives
end

# print only inactive mappings
rule /^(i|inactives)$/ do
  display 'inactives', inactives
end

# add mapping
rule /^(m|map) +(.*?) +(.*?)$/ do |command, host, ip|
  map host => ip
end

# add unmapping
rule /^(u|unmap) +(.*?) +(.*?)$/ do |command, host, ip|
  unmap host => ip
end

# print command history
rule /^(hist|history)$/ do
  puts Readline::HISTORY.to_a.join("\n")
end

# print registored rules
rule /^rules$/ do
  puts rules.keys.join("\n")
end

# print help
rule /^(h|help)$/ do
  # TODO: help message
  #help
end

# quit rhosts
rule /^(q|quit|exit)$/ do
  exit
end
