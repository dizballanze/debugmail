from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', 'project.views.login_view', name='login_view'),
    url(r'^user_register/$', 'project.views.user_register', name='user_register'),
    url(r'^project_list/$', 'project.views.project_list', name='project_list'),
    url(r'^user_logout/$', 'project.views.logout_view', name='logout_view'),
    url(r'^add_project/$', 'project.views.add_project', name='add_project'),
)
