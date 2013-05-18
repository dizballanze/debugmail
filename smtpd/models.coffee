Schema = require('mongoose').Schema
ObjectId = Schema.ObjectId


Project = new Schema
  user: ObjectId
  title: String
  creation_time: Date
  password: String