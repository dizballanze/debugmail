Schema = require('mongoose').Schema
ObjectId = Schema.ObjectId
Mixed = Schema.Types.Mixed


Project = new Schema
  user: ObjectId
  title: String
  creation_time: Date
  password: String


Letter = new Schema
  subject: String
  # content_type: String
  # charset: String
  content: String
  sender: String
  to: String
  date: Date
  project: ObjectId
  priority: String
  html: String
  plain: String
  headers: Mixed


User = new Schema
  email: String



exports.Project = (db)->
  return db.model 'Project', Project, 'project'

exports.Letter = (db)->
 return db.model 'Letter', Letter, 'letter' 

exports.User = (db)->
 return db.model 'User', User, 'user'