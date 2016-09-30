var app = angular.module('app',['ngMaterial','ngMessages','ui.router','auth'])
    .constant('API_URL',document.getElementById('root').getAttribute('content') + 'api/')
    .constant('TOKEN',document.querySelector('meta[name="csrf-token"]').getAttribute('content'))
    .run(function (CurrentUser) {
        CurrentUser.check();
    })
    .run(function ($rootScope,Auth,$state,CurrentUser,AccessLevel) {
        $rootScope.$on('$stateChangeStart',function (event, toState, toParams, fromState, fromParams) {
            if(!Auth.authorize(toState.data.access)){
                event.preventDefault();
                $state.go('page.login');
            }
            else if(toState.data.access == AccessLevel.openAuthenticated && CurrentUser.check()){
                event.preventDefault();
                $state.go('static.home');
            }
        });
        $rootScope.$on('$stateChangeError',function (event) {
            event.preventDefault();
            alert('Error');
        });
    })
    .run(function($rootScope, $state){
        $rootScope.$on('$stateChangeSuccess',function () {
            document.title = $state.current.title;
        });
    })
    .directive('unique',function(){
        return {
            require: 'ngModel'
            
        }
    })
    .config(function($stateProvider,$locationProvider,$urlRouterProvider,AccessLevel){
        // $locationProvider.html5Mode(true);
        $stateProvider
            .state('static',{
                abstract: true,
                template: '<ui-view></ui-view>',
                data: {
                    access: AccessLevel.nonAuthenticated
                }
            })
            .state('page',{
                abstract: true,
                template: '<ui-view></ui-view>',
                data: {
                    access: AccessLevel.openAuthenticated
                }
            })
            .state('static.home',{
                url: '/',
                title: 'Sinergi Tani',
                templateUrl: '/templates/index',
                controller: 'HomeController'
            })
            .state('page.login',{
                url: '/login',
                title: 'Login',
                templateProvider: function ($templateCache) {
                    return $templateCache.get('login.html');
                },
                controller: 'LoginController'
            })
            .state('page.register',{
                url: '/register',
                title: 'Register',
                templateProvider: function ($templateCache) {
                    return $templateCache.get('register.html');
                },
                controller: 'RegisterController'
            })
            .state('access',{
                abstract: true,
                template: '<ui-view></ui-view>',
                data: {
                    access: AccessLevel.authenticated
                }
            })
            .state('access.index',{
                template: '<h1>Authorized</h1>',
                url: '/access',
                title: 'Need Access',
                controller: 'HomeController'
            })
            .state('kelompok_tani',{
                abstract: true,
                template: '<ui-view></ui-view>',
                data: {
                    access: AccessLevel.authenticated
                }
            })
            .state('kelompok_tani.index',{
                title: 'Kelompok Tani - Dashboard',
                url: '/kelompok_tani/dashboard',
                templateUrl: '/templates/kelompok_tani/index',
                controller: 'KelompokTaniController'
            })
            .state('funding',{
                abstract: true,
                template: '<ui-view></ui-view>',
                data: {
                    access: AccessLevel.authenticated
                }
            })
            .state('funding.index',{
                url: '/funding',
                templateUrl: '/templates/funding/index',
                title: 'Donasikan',
                controller: 'FundingController'
            });
        $urlRouterProvider.otherwise('/');

    })
    .controller('HomeController',function($scope,$q){
        
    })
    .controller('FundingController',function ($scope, $q) {
        $scope.fundings = [
            {
                title: 'Sinergi Tani',
                description: 'Sinergi Tani adalah sebuah platform penggalangan dana untuk membantu petani-petani di indonesia yang menghadapi masalah pertanian',
                total: '60000000'
            },{
                title: 'Sinergi Tani',
                description: 'Sinergi Tani adalah sebuah platform penggalangan dana untuk membantu petani-petani di indonesia yang menghadapi masalah pertanian',
                total: '60000000'
            },{
                title: 'Sinergi Tani',
                description: 'Sinergi Tani adalah sebuah platform penggalangan dana untuk membantu petani-petani di indonesia yang menghadapi masalah pertanian',
                total: '60000000'
            },{
                title: 'Sinergi Tani',
                description: 'Sinergi Tani adalah sebuah platform penggalangan dana untuk membantu petani-petani di indonesia yang menghadapi masalah pertanian',
                total: '60000000'
            },{
                title: 'Sinergi Tani',
                description: 'Sinergi Tani adalah sebuah platform penggalangan dana untuk membantu petani-petani di indonesia yang menghadapi masalah pertanian',
                total: '60000000'
            },
        ]
    })
    .controller('KelompokTaniController',function ($scope) {

    })
    .controller('RegisterController',function ($scope,$http,API_URL,$q,Auth,$state,CurrentUser) {
        $scope.currentUser = CurrentUser;
        $scope.currentNavItem = 'kelompok_tani';
        $scope.processing = false;
        $scope.donaturRegister = function (user) {
            Auth.register(user,2).then(function (data) {
                $scope.user = data.user;
                $scope.processing = false;
                $scope.$parent.user = data.user;
                $scope.currentUser.setValidUser(data.user);
                $state.go('access.index');
            });
            $scope.processing = true;
        };

        $scope.kelompokTaniRegister = function(group){
            Auth.register({
                name: group.name,
                group_name: group.groupName,
                email: group.email,
                password: group.password,
                province_id: group.province,
                regency_id: group.regency,
                district_id: group.district,
                village_id: group.village
            },1).then(function (data) {
                $scope.user = data.user;
                $scope.processing = false;
                $scope.currentUser.setValidUser(data.user);
                $state.go('access.index');
            });
            $scope.processing = true;
        };
        $scope.loadProvinces = function(){
            $http.get(API_URL + 'provinces').then(function(res){
                $scope.provinces = res.data;
            })
        };

        function getData(id,endpoint,message,container){
            if(id){
                $http.get(API_URL + endpoint + '/' + id ).then(function(res){
                    if(endpoint == 'regencies'){
                        $scope.regencies = res.data;
                    } else if (endpoint == 'districts'){
                        $scope.districts = res.data;
                    } else {
                        $scope.villages = res.data;
                    }
                })
            } else {
                alert(message);
            }
        }
        
        $scope.loadRegencies = function (id) {
            getData(id,'regencies','Pilih provinsi terlebih dahulu!')
        };

        $scope.loadDistricts = function(id){
            getData(id,'districts','Pilih Kabupaten terlebih dahulu!')
        };

        $scope.loadVillages = function(id){
            getData(id,'villages','Pilih Kecamatan terlebih dahulu!')
        };
    })
    .controller('LoginController',function ($scope,Auth,CurrentUser,$state) {
        $scope.currentNavItem = 'kelompok_tani';
        $scope.login = function (user) {
            Auth.login(user,user.category).then(function (data) {
                $scope.user = data.user;
                $scope.processing = false;
                $scope.currentUser.setValidUser(data.user);
                $state.go('access.index');
            });
            $scope.processing = true;
        }
    })
    .controller('MainController',function($scope,$timeout,$mdSidenav,Auth,$state,CurrentUser){
        $scope.currentUser = CurrentUser;
        $scope.toggleLeft = toggler('left');
        $scope.logout = function () {
            Auth.logout();
            $state.go('page.login');
        };
        function toggler(componentId) {
            return function () {
                $mdSidenav(componentId).toggle();
            }
        }    
    });