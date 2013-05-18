from django.http import HttpResponse
from mongoengine import DoesNotExist
from mongoengine.django.auth import User
from django.contrib.auth import login
from handy.decorators import render_to


@render_to('project/login.html')
def login_view(request):
    if request.POST:
        try:
            user = User.objects.get(email=request.POST['email'])
            if user.check_password(request.POST['password']):
                user.backend = 'mongoengine.django.auth.MongoEngineBackend'
                login(request, user)
                request.session.set_expiry(60 * 60 * 1) # 1 hour timeout
                return HttpResponse(user)
            else:
                return HttpResponse('login failed')
        except DoesNotExist:
            return HttpResponse('user does not exist')
        except Exception, e:
            return HttpResponse(str(e))
    else:
        return {}

