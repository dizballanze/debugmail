from django.contrib.auth import login, logout
from django.http import HttpResponse
from django.shortcuts import redirect
from handy.decorators import render_to
from mongoengine import DoesNotExist, NotUniqueError, ValidationError
from mongoengine.django.auth import User


@render_to('project/user-login.html')
def login_view(request):
    """
        @TODO: validate email
    """
    if request.user.is_authenticated():
        return redirect('project_list')
    if request.method == 'POST':
        try:
            uemail = request.POST.get('email', None)
            user = User.objects.get(email=uemail)
            if user.check_password(request.POST['password']):
                user.backend = 'mongoengine.django.auth.MongoEngineBackend'
                login(request, user)
                request.session.set_expiry(60 * 60 * 10) # 10 hour timeout
                return redirect('project_list')
            else:
                return {
                    'error': 'Login failed',
                    'email': uemail
                }
        except DoesNotExist:
            return {
                    'error': 'User does not exist',
                    'email': uemail
                }
        except Exception, e:
            return HttpResponse(str(e))
    else:
        return {}


def logout_view(request):
    request.session.items = []
    request.session.modified = True
    logout(request)
    return redirect('login_view')


@render_to('project/user-register.html')
def user_register(request):
    if request.method == 'POST':
        uemail = request.POST.get('email', None)
        upassword = request.POST.get('password', None)
        if (not uemail) or (not upassword):
            return {
                'error': 'All fields are required',
                'email': uemail
            }
        try:
            user = User.create_user(uemail, upassword, request.POST['email'])
            user.backend = 'mongoengine.django.auth.MongoEngineBackend'
            login(request, user)
            request.session.set_expiry(60 * 60 * 10) # 10 hour timeout
            return redirect('project_list')
        except NotUniqueError:
            return {
                'error': 'User with this email already exist',
                'email': uemail
            }
        except ValidationError:
            return {
                'error': 'Incorrect email',
                'email': uemail
            }
    else:
        return {}