angular.module(globalSettings.modulesAreas)
    .config(['$stateProvider', '$urlRouterProvider', '$locationProvider',
		function ($stateProvider, $urlRouterProvider, $locationProvider) {

			// дефолтний роут - домашня сторінка
			$urlRouterProvider.otherwise('/auth/logon');


		    $stateProvider
		        // ------------------------------------------------------------------------------------- 
		        //#region Основний роут (APP)
		        .state('app', {
		            'abstract': true,
		            url: '',
		            templateUrl: 'app/components/main/views/index.html' 
		        })
		        .state('app.dashboard', {
		            url: '/dashboard',
		            templateUrl: 'app/components/main/views/dashboard.html',
		            resolve: {
		                deps: [
		                    '$ocLazyLoad',
		                    function($ocLazyLoad) {
		                        return $ocLazyLoad.load(['app/shared/controllers/chart.js']);
		                    }
		                ]
		            }
		        })

			    // -------------------------------------------------------------------------------------
                //#region Модуль рахунки (ACCT)
                .state('app.acct', {
                	'abstract': true,
                	url: '/acct',
                	template: '<div ui-view></div> ',
                	resolve: {
                		deps: [
                            '$ocLazyLoad',
                            function ($ocLazyLoad) {
                            	return $ocLazyLoad.load([
                                    'app/components/acct/css/acct.css',
                                    'app/components/acct/services/acctService.js'
                            	]);
                            }
                		]
                	}
                })
                .state('app.acct.index', {
                	url: '/index',
                	templateUrl: 'app/components/acct/views/index.html',
                	resolve: {
                		deps: [
                            '$ocLazyLoad',
                            function ($ocLazyLoad) {
                            	return $ocLazyLoad.load([
                                    'app/components/acct/controllers/AccountsCtrl.js',
                                    'app/components/acct/controllers/HistoryCtrl.js'
                            	]);
                            }
                		]
                	}
                })
                .state('app.acct.accounts', {
                	url: '/accounts',
                	templateUrl: 'app/components/acct/views/accounts.html',
                	resolve: {
                		deps: [
                            '$ocLazyLoad',
                            function ($ocLazyLoad) {
                            	return $ocLazyLoad.load(['app/components/acct/controllers/AccountsCtrl.js']);
                            }
                		]
                	}
                })
                .state('app.acct.history', {
                	url: '/history',
                	templateUrl: 'app/components/acct/views/history.html',
                	resolve: {
                		deps: [
                            '$ocLazyLoad',
                            function ($ocLazyLoad) {
                            	return $ocLazyLoad.load([
                                    'app/components/acct/controllers/HistoryCtrl.js'
                            	]);
                            }
                		]
                	}
                })
                .state('app.acct.documents', {
                	url: '/documents',
                	templateUrl: 'app/components/acct/views/index.html',
                	resolve: {
                		deps: [
                            '$ocLazyLoad',
                            function ($ocLazyLoad) {
                            	return $ocLazyLoad.load([
                                    'app/components/acct/controllers/AccountsCtrl.js',
                                    'app/components/acct/controllers/HistoryCtrl.js'
                            	]);
                            }
                		]
                	}
                })
                .state('app.acct.loans', {
                	url: '/loans',
                	templateUrl: 'app/components/acct/views/index.html',
                	resolve: {
                		deps: [
                            '$ocLazyLoad',
                            function ($ocLazyLoad) {
                            	return $ocLazyLoad.load([
                                    'app/components/acct/controllers/AccountsCtrl.js',
                                    'app/components/acct/controllers/HistoryCtrl.js'
                            	]);
                            }
                		]
                	}
                })



    	// use the HTML5 History API
    	$locationProvider.html5Mode(true);
    }]);