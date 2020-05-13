# rest framework 安装使用

## 安装

```shell
pip install djangorestframework
```

## 使用

```python
# 在settings文件中配置
INSTALLED_APPS = [
    # ...
    'rest_framework',
    # ...
]

# 一些全局配置
REST_FRAMEWORK = {
    # 默认鉴权验证类
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.TokenAuthentication',
    )
}
```
