db = require('riak-js').getClient()

### Basics ###

# Add a value to Riak
db.save 'favs', 'db',
  '<html><body><h1>My new favorite DB is RIAK</h1></body></html>',
  { contentType: 'text/html' }

# Retrieve the value
console.log db.get('favs', 'db')

# Put a value in a bucket
db.save 'animals', 'ace', { nickname: "The Wonder Dog", breed: "German Shepherd" }
# console.log db.get('animals', 'ace')

# View the list of buckets
console.log db.buckets()

# Return the body
db.save 'animals', 'polly', { nickname: "Sweet Polly Purebred", breed: "Purebred" }, { returnbody: true }
# console.log db.get('animals', 'polly')

# Generate a key when passing it as a POST
db.save 'animals', null, { nickname: "Sergeant Stubby", breed: "Terrier" }, { method: 'POST' }
console.log db.keys('animals')

### LINKS ###

# Link Polly to Cage 1
# One way, Cage 1 knows about Polly, but not the other way
db.save 'cages', '1', { room: "101" }, {
  links: [
    {
      tag: 'contains',
      key: 'polly',
      bucket: 'animals'
    }
  ]
}
console.log db.get('animals', 'polly')


