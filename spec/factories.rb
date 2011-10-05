Factory.define :rumor do |rumor|
  rumor.content "Here is a rumor"
  rumor.location "41.231N,12.12W"
end

Factory.sequence :location do |n|
  "#{n}.31N,#{n}.41W"
end

