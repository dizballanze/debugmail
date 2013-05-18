import datetime
from mongoengine import Document, ReferenceField, StringField, DateTimeField, CASCADE, DictField
from mongoengine.django.auth import User


class Project(Document):
    user = ReferenceField(User, required=True)
    title = StringField(max_length=255, required=True)
    creation_time = DateTimeField(default=datetime.datetime.now)
    password = StringField()


class Letter(Document):
    subject = StringField(max_length=255, required=True)
    headers = DictField()
    priority = StringField()
    html = StringField()
    plain = StringField()
    content = StringField()
    sender = StringField(max_length=255, required=True)
    to = StringField(max_length=255, required=True)
    date = DateTimeField(required=True)
    #attachments =
    project = ReferenceField(Project, reverse_delete_rule=CASCADE)