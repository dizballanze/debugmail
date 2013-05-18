import datetime
from mongoengine import Document, ReferenceField, StringField, DateTimeField, URLField
from mongoengine.django.auth import User
import hashlib


class Project(Document):
    user = ReferenceField(User, required=True)
    title = StringField(max_length=255, required=True)
    creation_time = DateTimeField(default=datetime.datetime.now)
    host = StringField(max_length=255, required=True)
    port = StringField(max_length=6, required=True)
    password = StringField()


class Letter(Document):
    subject = StringField(max_length=255, required=True)
    content_type = StringField(max_length=50, required=True)
    charset = StringField(max_length=30, required=True)
    contents = StringField()
    sender = StringField(max_length=255, required=True)
    to = StringField(max_length=255, required=True)
    date = DateTimeField(required=True)
    #attachments =
    url = URLField(required=True)
    project = ReferenceField(Project)