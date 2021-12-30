ANDY = 'andy'
SPENCER = 'spencer'
DCHO = 'dcho'
HARRISON = 'harrison'
AMANDA = 'amanda'
JENNY = 'jenny'
RON = 'ron'
DANIEL = 'daniel'
DAVID = 'david'

EVERYONE = [ANDY, SPENCER, DCHO, HARRISON, AMANDA, JENNY, RON, DANIEL, DAVID]
EVERYONE_WITH_SOLO = EVERYONE + ["solo"]

# Pairings
ROUND_1 = [
  [ANDY, HARRISON],
  [SPENCER, JENNY],
  [RON, AMANDA],
  [DCHO, DAVID],
  [DANIEL],
]

ROUND_2 = [
  [ANDY, RON],
  [SPENCER, HARRISON],
  [DCHO, AMANDA],
  [DANIEL, DAVID],
  [JENNY],
]

ROUND_3 = [
  [ANDY, DCHO],
  [SPENCER, AMANDA],
  [HARRISON, JENNY],
  [RON, DAVID],
  [DANIEL],
]

ROUND_4 = [
  [ANDY, JENNY],
  [DAVID, AMANDA],
  [HARRISON, DCHO],
  [DANIEL, SPENCER],
  [RON],
]

ALL_ROUNDS = [
  ROUND_1,
  ROUND_2,
  ROUND_3,
  ROUND_4,
]

pairing_dictionary = EVERYONE.reduce(Hash.new { [] }) do |accum, person|
  accum[person] = [person]
  accum
end


ALL_ROUNDS.each do |round|
  round.each do |pair|
    if pair.length == 1
      pairing_dictionary[pair.first] << 'solo'
    else
      pairing_dictionary[pair.first] << pair[1]
      pairing_dictionary[pair[1]] << pair.first
    end
  end
end

# assign pairs
all_assigned = false
while !all_assigned
  seen = []
  pairings = []
  EVERYONE.each do |person|
    if seen.length == EVERYONE_WITH_SOLO.length
      all_assigned = true
      break
    end
    next if seen.include?(person)
    remaining_pairings = EVERYONE_WITH_SOLO - pairing_dictionary[person].concat(seen).uniq
    break if remaining_pairings.length == 0

    partner = remaining_pairings.sample
    pairings << [person, partner]
    seen << partner
    seen << person
  end
end

pairings = pairings.shuffle
pairings.each_with_index do |pair, idx|
  puts "------- Team #{idx + 1} ------------"
  pair.each do |person| 
    if person != 'solo' 
      puts person.capitalize
    end
  end
  puts "---------------------------"
  puts ""
end





