from django.conf.urls import patterns, include, url
from django.views.generic.base import TemplateView

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', 'debugmail.views.login_view', name='login_view'),
    url(r'^user_register/$', 'debugmail.views.user_register', name='user_register'),
    url(r'^logout/$', 'debugmail.views.logout_view', name='logout_view'),
    url(r'^projects/$', 'project.views.project_list', name='project_list'),
    url(r'^edit_project/(?P<project_id>\w+)/$', 'project.views.edit_project', name='edit_project'),
    url(r'^project/add/$', 'project.views.add_project', name='add_project'),
    url(r'^show_project/(?P<project_id>\w+)/$', 'project.views.show_project', name='show_project'),
    url(r'^remove_project/(?P<project_id>\w+)/$', 'project.views.remove_project', name='remove_project'),
    url(r'^about/$', TemplateView.as_view(template_name='about.html'), name='about'),
    url(r'^(?P<letter_id>\w+)/$', 'project.views.show_letter', name='show_letter')
)
