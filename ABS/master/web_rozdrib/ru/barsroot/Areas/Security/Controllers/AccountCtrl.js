angular.module(globalSettings.modulesAreas)
    .controller('Security.Account',
        ['$scope', 'accountService',
        function ($scope, accountService) {
            'use strict';

            var vm = this;
            vm.bankDate = new Date();

            vm.validate = {
                login: {
                    text: 'логін',
                    cssClass:''
                },
                password: {
                    text: 'пароль',
                    cssClass:''
                }
            };

            vm.accountModel = {
                login: '',
                password:''
            };

            var validation = function () {
                var result = true;
                if (!vm.accountModel.login || vm.accountModel.login === '') {
                    vm.validate.login.text = 'заповніть поле';
                    vm.validate.login.cssClass = 'invalid';
                    result = false;
                } else {
                    vm.validate.login.text = 'ok';
                    vm.validate.login.cssClass = '';                   
                }


                if (!vm.accountModel.password || vm.accountModel.password === '') {
                    vm.validate.password.text = 'заповніть поле';
                    vm.validate.password.cssClass = 'invalid';
                    result = false;
                } else {
                    vm.validate.password.text = 'ok';
                    vm.validate.password.cssClass = '';                
                }

                return result;
            }

            vm.login = function() {
                if (validation()) {
                    accountService.login(vm.accountModel.login, vm.accountModel.password);
                }
                return false;
            }
            
        }]);