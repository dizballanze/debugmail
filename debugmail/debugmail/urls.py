from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', 'project.views.login_view', name='login_view'),
    # url(r'^debugmail/', include('debugmail.foo.urls')),
)
