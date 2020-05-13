# rest framework 组件

## 认证

```python
# 默认的认证类
from rest_framework.authentication import RemoteUserAuthentication
from rest_framework.authentication import BaseAuthentication
from rest_framework.authentication import BasicAuthentication
from rest_framework.authentication import TokenAuthentication
from rest_framework.authentication import SessionAuthentication
```

```python
#!/usr/bin/env python
# -*- encoding: utf-8 -*-
# 自定义认证类, token

__author__ = 'SamSa'

from rest_framework.authentication import BaseAuthentication
from rest_framework import exceptions

from libs.jwt_token import Token
from app.models import User
from libs.cache import RedisHandler
from common.http import HTTPCode

rds = RedisHandler()

# 继承BaseAuthentication, 返回值为一个元组
class JwtAuthorizationAuthentication(BaseAuthentication):
    """
    drf 自定义token鉴权
    """

    def authenticate(self, request):
        """
        方法重写, 在请求头或者请求参数中获取token
        """
        # token放在请求头中
        token = request.META.get('HTTP_AUTHORIZATION', '')
        if not token:
            # token放在请求参数中
            token = request.data.get('token', '')
        auth = token.split()
        if not auth:
            # 为获取到token
            raise exceptions.AuthenticationFailed(
                {'code': HTTPCode.Unauthorized, 'data': '未获取到 Authorization 请求头', 'token': None})
        if auth[0].lower() != 'jwt':
            # 请求头认证方式有误
            raise exceptions.AuthenticationFailed(
                {'code': HTTPCode.Unauthorized, 'data': 'Authorization 请求头中认证方式有误', 'token': None})

        if len(auth) == 1 or len(auth) > 2:
            # 非法Authorization求头
            raise exceptions.AuthenticationFailed(
                {'code': HTTPCode.Unauthorized, 'data': '非法 Authorization 请求头', 'token': None})

        token = auth[1]
        # 判断token是否在缓存中, 如果在则取出来,判断当前时间是否在刷新时间内,在刷新时间内
        # 则更新token否则, 鉴权通过  redis存储: 例如: 'token': 时间

        result = Token.parse_token(token)
        if result['code'] != HTTPCode.Ok:
            raise exceptions.AuthenticationFailed(result)

        # token 中获取username
        username = result['data']['username']

        # 根据username查找用户
        user = User.get_instance_by_username(username=username)
        if not user:
            raise exceptions.AuthenticationFailed(
                {'code': HTTPCode.Unauthorized, 'data': '用户不存在', 'token': None})
        return user, token

```

### 认证系统使用

1. 可以在 settings 文件中全局配置
2. 在默认的 cbv 类中指定

```python
from rest_framework.views import APIView
from rest_framework.parsers import JSONParser
from rest_framework.parsers import MultiPartParser

from common.auth import JwtAuthorizationAuthentication


class BaseApi(APIView):
    """
    所有restful api 的父类
    """
    # 指定默认的认证类
    authentication_classes = [JwtAuthorizationAuthentication]
    # 指定默认的解析类
    parser_classes = [JSONParser, MultiPartParser]

    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(BaseApi, self).dispatch(request, *args, **kwargs)
```

## 权限

```python
from rest_framework.permissions import BasePermission

# 自定义权限验证
class Permission(BasePermission):
    """
    继承BasePermission类,需要重写has_permission方法,返回boolean值
    """

    def has_permission(self, request, view):
        """
        针对视图的权限验证
        """
        return True

    def has_object_permission(self, request, view, obj):
        """
        针对一个资源的权限验证
        """
        return True

```

### 权限系统使用

1. settings 文件中全局配置
2. 在默认的 cbv 类中指定

```python
from rest_framework.views import APIView
from rest_framework.parsers import JSONParser
from rest_framework.parsers import MultiPartParser
from rest_framework.permissions import BasePermission

from common.auth import JwtAuthorizationAuthentication


class BaseApi(APIView):
    """
    所有restful api 的父类
    """
    # 指定默认的认证类
    authentication_classes = [JwtAuthorizationAuthentication]
    # 指定默认的解析类
    parser_classes = [JSONParser, MultiPartParser]
    permission_classes = [BasePermission,]

    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(BaseApi, self).dispatch(request, *args, **kwargs)

```

## 节流

```python
# 常用这两个类
from rest_framework.throttling import BaseThrottle
from rest_framework.throttling import SimpleRateThrottle

# 自定义访问频率限制, 通常(还有其他的)可以继承这两个类中的某一个
class MyThottle(BaseThrottle):
    # 需要重写下面这两个方法
    def allow_request(self, request, view):
        """
        60/m
        利用缓存对ip或者用户的登录信息进行统计
        将时间列表存入缓存,验证时循环取出最后一个元素(也就是最远的时间戳),然后当前时间和访问频
        率中的时间(duration)限制(例如: 60s)做差, 如果取出的时间小于这个时间差,则弹出最后一个元素.
        此时如果列表的长度大于限制的访问频率中的次数(例如: 60/m, 则是大于60),验证失败,反之成功,成功时
        将当前时间插入到列表中的第0个元素,再次存入缓存.
        """
        pass

    def wait(self):
        """
        当访问频率达到上限之后, 返回等待的时间,(返回下次访问时间在多少秒后)
        例如: {
                "detail": "请求超过了限速。 Expected available in 44 seconds."
              }
        """
        pass

```

### 节流使用

1. 全局配置
2. 在默认的 cbv 类中指定

```python
from rest_framework.throttling import SimpleRateThrottle

class MyThrottle(SimpleRateThrottle):
    scope = 'sam'
    rate = '10/m'

    def get_cache_key(self, request, view):
        """ must be overwrite"""
        return ''
```

## 版本

```python
from rest_framework.versioning import URLPathVersioning


class BaseApi(APIView):
    """
    所有restful api 的父类
    """
    authentication_classes = [JwtAuthorizationAuthentication]
    parser_classes = [JSONParser, MultiPartParser]
    throttle_classes = [MyThrottle]
    # 版本验证类
    versioning_class = URLPathVersioning

    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(BaseApi, self).dispatch(request, *args, **kwargs)
```

### 版本控制使用

1. 全局默认配置
2. 局部 cbv 中配置

```python
class BaseApi(ApiView):
    versioning_class = URLPathVersioning
    pass
```

## 序列化

1. Serializer

```python
# 序列化是常用最多的

from rest_framework.serializers import Serializer
# 之将将model和序列化器连接, 方便
from rest_framework.serializers import ModelSerializer


class UserSerializer(serializers.Serializer):
    id = serializers.CharField()
    username = serializers.CharField()
    email = serializers.EmailField()
    # 取出枚举型数据 get_field_display
    gender = serializers.CharField(source='get_gender_display')
    # 关联外键字段, 例如: 获取用的出生年
    birth = serializers.CharField(source='birth.yeay')
    last_login = serializers.DateTimeField(format='%Y-%m-%d %H:%M:%S')

    # 自定义方法获取值
    password = serializers.SerializerMethodField()

    # 序列化时生成url
    logout = serializers.HyperlinkedIdentityField(view_name='api:logout',
                                                  # model对象中的字段
                                                  lookup_field='id',
                                                  # url中的正则参数为pk
                                                  # 例如: r'^logout/(?P<pk>\d+)$'
                                                  lookup_url_kwarg='pk')

    def get_password(self, row):
        """
        SerializerMethodField 获取值 需要自定义方法
        def get_field(self, row):
            return ''
        """
        """
        row do something

        """
        return '密码都想看,你还想干啥'

# 序列化使用
class Api(BaseApi):
    def post(self, requset, *args, **kwargs):
        # 序列化单个model对象
        data = serializer.UserSerializer(instance=user).data
        # 序列化query_set对象
        data = serializer.UserSerializer(instance=users, many=True).data
        # 序列化中要生成url(HyperlinkedIdentityField),需要将request对象传递过去
        data = serializer.UserSerializer(instance=users, many=True, context={'request': request})).data

```

2. ModelSerializer

```python
from rest_framework.serializers import ModelSerializer

class UserSerializer(serializers.ModelSerializer):
    """
    user模型序列化, 需要添加meta信息,其他的和Serializers一致
    """

    class Meta:
        model = User
        exclude = ['password', 'create_at']
        # depth使用, 他根据关联的数据不停的深入将数据取出(官方建议: 0~10, 太多速度会很慢)
        depth = 1

```

3. 反序列化

```python

class UserSerializer(serializers.ModelSerializer):
    """
    user模型序列化
    """
    username = serializers.CharField(error_messages={'required': 'username 不可以为空'})

    def validate_username(self, validate_value):
        """
        自定义验证规则, 方法命名: validate_username, 最后返回验证后的值
        """
        from rest_framework.exceptions import ValidationError
        if 'old wang' not in validate_value:
            raise ValidationError('username 不合法')
        return validate_value

    class Meta:
        model = User
        exclude = ['password', 'create_at']


# 反序列化使用
class Api(BaseApi):
    def post(self, requset, *args, **kwargs):
        # 反序列化
        user = UsersSerializer(data=request.data)
        # 验证数据有效性, 在save之前必须进行验证
        if user.is_valid():
            user.save()
        else:
            error = user.errors


```

## 解析器

> 首先，我们需要知道 DRF 框架在请求进来的时候，对 django 原生的 request 对象进行一个分装，
接下来才是认证，权限，版本，节流等验证。这一块可以从源码中的`dispatch`方法中找到，分装之后
返回新的 request 对象，django 原生的 request 对象被分装在 `request._requset`中。

### DRF 自带的一些解析器

```python

from rest_framework.parsers import JSONParser   # json
from rest_framework.parsers import FormParser   # form 表单
from rest_framework.parsers import MultiPartParser  # 多种文件类型数据
from rest_framework.parsers import FileUploadParser
```

### 获取数据

> 使用 DRF 的解析器，直接在`request.data`中取 json 或者表单的值。

```python
class RegisterView(BaseApi):
    """
    注册接口
    """
    authentication_classes = []
    parser_classes = [JSONParser, MultiPartParser]

    def post(self, request):
        """
        注册接口
        """
        # 使用drf的解析器, 我们直接在request.data中取值
        form_data = UserForm(request.data)
        response = CommonResponse()
        if form_data.is_valid():
            user = form_data.save()
            data = {
                'id': user.id,
                'username': user.username
            }
            response.data = data
            return Response(response.content)
        response.code = HTTPCode.Register
        return Response(response.content)

```

## 路由系统

```python
from rest_framework import routers
from app import views


router = routers.SimpleRouter()
router.register(r'user', views.UserView)

urlpatterns = [
    url(r'^', include(router.urls, namespace='user')),
]

"""
上述路由系统可以实现以下的路由规则

查询列表, 添加
URL pattern: ^users/$ Name: 'user-list'

查询单个对象, 修改(put, patch), 删除
URL pattern: ^users/{pk}/$ Name: 'user-detail'

"""

# 视图书写
# 视图需要继承ModelViewSet, 非常方便,可以实现简单的增删改查, 但是不能实现复杂的操作, 不推荐使用
from rest_framework.viewsets import ModelViewSet

class UserView(ModelViewSet):
    serializer_class = serializer.UserSerializer
    queryset = User.objects.all()

```

## 视图

## 渲染器

> 使用渲染器，需要在 settings 文件中安装`rest_framework`

```python
INSTALLED_APPS = [
                  'rest_framework',
                 ]

from rest_framework.renderers import BrowsableAPIRenderer,JSONRenderer,AdminRenderer

class BookView(ModelViewSet):
    # 设置渲染器类型
    renderer_classes = [JSONRenderer]

```

## 分页
