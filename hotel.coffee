db = require('riak-js').getClient()

styles = ['single', 'double', 'queen', 'king', 'suite']

buildFloor = (floor) ->
  current_rooms_block = floor * 100
  console.log "Making rooms #{current_rooms_block} - #{current_rooms_block + 100}"
  # Put 100 rooms on each floor (huge hotel!)
  buildRoom room, current_rooms_block for room in [1...100]

buildRoom = (room, current_rooms_block) ->
  # Create a unique room number as the key
  key = current_rooms_block + room
  console.log "key #{key}"
  # Randomly grab a room style, and make up a capacity
  style = styles[Math.floor (Math.random() * styles.length)]
  capacity = Math.floor(Math.random() * 8) + 1
  # Store the room information as a JSON value
  db.save 'rooms', key,
    style: style,
    capacity: capacity

# Create 100 floors to the building
buildFloor floor for floor in [1..100]
