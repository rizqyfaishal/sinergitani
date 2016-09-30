var auth = angular.module('auth',[])
    .constant('API_AUTH_URL',document.getElementById('root').getAttribute('content') + 'api/auth/')
    .constant('AccessLevel',{
        nonAuthenticated: 0,
        openAuthenticated: 1,
        authenticated: 3
    })
    .config(function($httpProvider){
        $httpProvider.interceptors.push('AuthInterceptor');
    })
    .factory('CurrentUser',function (LocalService) {
        return {
            user: null,
            setValidUser: function (user) {
                this.user = user;
            },
            check: function () {
                if(LocalService.getToken()){
                    this.setValidUser(angular.fromJson(LocalService.getToken()).user);
                    return this.user;
                }
            },
            unset: function () {
                this.user = null;
            }
        }
    })
    .factory('LocalService',function ($window) {
        return {
            key: 'auth-token',
            storage: $window.localStorage,
            getToken: function(){
                return this.storage.getItem(this.key);
            },
            setToken: function (payload) {

                if(payload){
                    this.storage.setItem(this.key,payload)
                } else {
                    this.storage.removeItem(this.key);
                }

            },
            clear: function(){
                this.storage.removeItem(this.key);
            }
        }
    })
    .factory('Auth',function ($http,LocalService,$state,AccessLevel,API_AUTH_URL,$q,$window,CurrentUser) {
        return {
            authorize: function(access){
                if(access == AccessLevel.authenticated){
                    return this.isAuthenticated();
                } else {
                    return true;
                }
            },
            login: function (credentials,category) {
                var url = category == 1 ? API_AUTH_URL + 'kelompok_tani/login' : API_AUTH_URL + 'donatur/login';
                var loginProcess = $http.post(url,credentials);
                var defer = $q.defer();
                loginProcess
                    .success(function(response){
                        LocalService.setToken(JSON.stringify(response));
                        defer.resolve(response);
                    })
                    .error(function(msg){
                        defer.reject(msg);
                    });
                return defer.promise;
            },
            register: function (user,category) {
                LocalService.setToken();
                var url = category == 1 ? API_AUTH_URL + 'kelompok_tani/register' : API_AUTH_URL  +'donatur/register';
                var defer = $q.defer();
                $http.post(url,user)
                    .success(function (res) {
                        LocalService.setToken(JSON.stringify(res));
                        defer.resolve(res);
                    })
                    .error(function(err){
                        defer.reject(err);
                    });
                return defer.promise;
            },
            isAuthenticated: function(){
                return LocalService.getToken();
            },
            logout: function () {
                if(LocalService.getToken()){
                    LocalService.setToken();
                    CurrentUser.unset();
                }
            }
        }
    })
    .factory('AuthInterceptor',function (LocalService,$q,$injector) {
        return {
            request: function(config){
                var token = LocalService.getToken();
                if(token){
                    token = angular.fromJson(token).token;
                    config.headers.Authorization = 'Bearer ' + token;
                }
                return config;
            },
            responseError: function(response){
                if(response.status == 401 || response.status == 403){
                    LocalService.setToken();
                    $injector.get('$state').transitionTo('page.login');
                }
                return $q.reject(response);
            }
        }
    });