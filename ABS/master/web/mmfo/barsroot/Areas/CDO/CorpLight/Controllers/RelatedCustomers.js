angular.module(globalSettings.modulesAreas)
    .controller('CDO.CorpLight.RelatedCustomers',
    [
        '$scope',
        'CDO.commonCustomersService',
        'CDO.CorpLight.relatedCustomersService',
        'CDO.CorpLight.AcskService',
        'CDO.CorpLight.ProfileSignService',
        function ($scope, commonCustomersService, relatedCustomersService, acskService, profileSignService) {
            'use strict';

            var vm = this;
            vm.relCustServiceState = relatedCustomersService.state;
            //var clMode = bars.ext.getParamFromUrl('clmode'); // TODO 
            //var isReadOnly = (clMode === 'visa'); // TODO
            vm.isShowClUserForm = false;


            vm.toDate = function (dateStr) {
                if (typeof dateStr === 'string') {
                    return new Date(parseInt(/\d+/.exec(dateStr)[0]));
                }
                return new Date();
            }
            vm.reatedCustomers = null;

            vm.selectRelatedCustomers = function (customerData) {
                vm.currentUser = new RelatedCustomer(
                    customerData.CustId,
                    null,
                    customerData.FirstName,
                    customerData.LastName,
                    customerData.SecondName,
                    customerData.Email,
                    null,
                    null);
                vm.currentUser.TaxCode = customerData.TaxCode;
                vm.currentUser.Address = customerData.Address;
                vm.currentUser.AddressCity = customerData.AddressCity;
                vm.currentUser.AddressStreet = customerData.AddressStreet;
                vm.currentUser.AddressHouseNumber = customerData.AddressHouseNumber;
                vm.currentUser.BirthDate = customerData.BirthDate ?
                    new Date(parseInt(customerData.BirthDate.substr(6))) : null;

                vm.currentUser.DocSeries = customerData.DocSeries;
                vm.currentUser.DocNumber = customerData.DocNumber;
                vm.currentUser.DocOrganization = customerData.DocOrganization;
                vm.currentUser.DocDate = customerData.DocDate ?
                    new Date(parseInt(customerData.DocDate.substr(6))) : null;

                if (customerData.DocType == '7') {
                    vm.currentUser.DocDateTo = customerData.DocDateTo ? new Date(parseInt(customerData.DocDateTo.substr(6))) : null;
                }
                vm.currentUser.DocType = customerData.DocType;
                SetDropDocListValue();
                vm.validateTaxCode();
            }

            var getCustomerRelatedCustomers = function (custId) {
                commonCustomersService.getCustomerRelatedCustomers(custId).then( // TODO get common
                    function (response) {
                        if (response instanceof Array && response.length > 0) vm.reatedCustomers = response;
                    },
                    function (response) { }
                ).then(function () {
                    return commonCustomersService.getFOPData(custId);
                }).then(function (res) {
                    if (res && res != 'null')
                        vm.reatedCustomers.unshift(res);
                }, function (err) {
                });
            }

            relatedCustomersService.getModuleVersion().then(
                function (response) {
                    vm.moduleVersion = 'v' + response;
                },
                function () { });

            var getSelectedUser = function () {
                return vm.relatedCustomersGrid.dataItem(vm.relatedCustomersGrid.select());
            }


            var validateEmail = function (email) {
                var emailPattern = /^[a-z0-9_.-]+@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                var check = emailPattern.test(email.toLowerCase());
                if (check) {
                    vm.currentUser.Email = email.toLowerCase();
                }
                return check;
            }
            vm.validateMobilePhone = function () {
                var phoneNum = vm.currentUser.CellPhone;
                if (!phoneNum) {
                    bars.ui.error({ text: 'незаповнено поле Мобільний телефон' });
                    return;
                }
                var phonePattern = /\+[0-9]{12}$/;
                var check = phonePattern.test(phoneNum);
                if (!check) {
                    bars.ui.error({ text: 'поле Мобільний телефон заповнено некорректно' });
                    return;
                }

                bars.ui.loader('body', true);

                relatedCustomersService.validateMobilePhone(phoneNum).then(
                    function (data) {
                        bars.ui.loader('body', false);
                        if (data.Status === 'Ok') {
                            bars.ui.notify('Успішно!', 'Успішно відправлено одноразовий пароль ', 'success');

                            vm.validatePhoneMode = true;
                            //$('#confirmCode').show();
                            $('#validateMobPhoneBtn').hide();
                            $('#otp').val('');
                            $('#LoginProviderValueMobilePhone').attr('disabled', 'disabled');
                        } else {
                            bars.ui.notify('Помилка', data.Message, 'error');
                        }
                    },
                    function (response) {
                        bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');
                        bars.ui.loader('body', false);
                    }
                );
            }

            vm.validateOneTimePass = function () {
                var code = $('#otp').val();
                if (!code) {
                    bars.ui.error({ text: 'незаповнено поле пароля' });
                    return;
                }
                var phoneNum = vm.currentUser.CellPhone;
                bars.ui.loader('body', true);

                relatedCustomersService.validateOneTimePass(phoneNum, code).then(
                    function (data) {
                        bars.ui.loader('body', false);
                        if (data.Status === 'Ok') {
                            bars.ui.notify('Успішно!', 'Пароль перевірено успішно', 'success');
                            vm.currentUser.isConfirmedPhone = true;

                            vm.validatePhoneMode = false;
                            //$('#confirmCode').hide();
                            $('#confirmCode input').val('');
                            $('#validateMobPhoneBtn').show();
                        } else {
                            bars.ui.notify('Помилка', 'Помилка валідації OTP', 'error');
                            vm.currentUser.isConfirmedPhone = false;
                        }
                    },
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Помилка', 'Помилка валідації OTP: ' + response.Message, 'error');
                        vm.currentUser.isConfirmedPhone = false;
                    }
                );
            }

            function getUserInfo(id, custId, calbackFunc) {
                var userForm = $('#userCart');
                bars.ui.loader(userForm, true);
                relatedCustomersService.getById(id, custId).then(
                    function (response) {
                        bars.ui.loader(userForm, false);
                        if (response) {
                            vm.currentUser = response;
                            vm.currentUser.isConfirmedPhone = true;
                            vm.currentUser.isExistUser = true;
                            SetDropDocListValue();
                            if (calbackFunc) {
                                calbackFunc.apply();
                            }
                        } else {
                            bars.ui.notify('Помилка', 'Користувач не знайдений', 'error');
                        }
                    },
                    function (response) {
                        bars.ui.loader(userForm, false);
                        bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');
                    }
                );
            }

            $scope.viewRelatedCustomer = vm.viewRelatedCustomer = function (id, custId) {
                vm.userDeailWindow.center().open();
                vm.custBirthDate.enable(false);
                vm.custDocDate.enable(false);
                vm.custDocDateTo.enable(false);
                getUserInfo(id, custId,
                    function () {
                        vm.currentUser.isReadOnly = true;
                        vm.SignNumber = null;
                    });
            }

            function SetDropDocListValue() {
                var DropDocType = $("#dropDocsType").data("kendoDropDownList");
                DropDocType.value(vm.currentUser.DocType);
            }

            function LoginProvider(type, value) {
                return {
                    Type: type,
                    Value: value
                }
            }
            function UserCustomer(custId) {
                this.CustomerId = custId;
                this.BankId = document.getElementById('bankId').value;
                this.Roles = ['Director'];
                this.LoginProviders = new LoginProvider();
            }

            var RelatedCustomer = function (custId, userId, firstName, lastName, secondName, email, relatedCustId, isExistCust) {
                this.Id = userId || null;

                this.Name = '';
                this.DisplayName = '';

                this.TaxCode = '';
                this.NoInn = 0;
                this.FirstName = firstName || '';
                this.LastName = lastName || '';
                this.SecondName = secondName || '';

                this.DocType = ''; // [1,7,15,13,5] 7-IDcard 
                this.DocSeries = '';
                this.DocNumber = '';
                this.DocOrganization = '';
                this.DocDate = null;
                this.DocDateTo = null; // field only for doctype = 7 → IDCard
                this.BirthDate = null;

                this.CellPhone = '';
                this.Email = email || '';
                this.SignNumber = 0;

                this.UserId = null;
                this.LockoutEnabled = false;

                this.Address = '';

                this.Password = '';
                this.CustId = document.getElementById('custId').value;
                this.Customers = [new UserCustomer(custId)];
                this.isConfirmedPhone = false;
                this.RelatedCustId = relatedCustId || null;
                this.IsExistCust = isExistCust || null;
            }

            vm.validateTaxCode = function () {
                var taxCode = vm.currentUser.TaxCode;
                var custId = document.getElementById('custId').value;
                if (taxCode) {
                    relatedCustomersService.getByTaxCode(taxCode, custId).then(
                        function (response) {
                            if (response) {
                                vm.currentUser = new RelatedCustomer();
                                bars.ui.confirm({
                                    text: 'Користувач з ІПН ' + taxCode + ' вже існує. Бажаєте відкрити його дані?',
                                    func: function () {
                                        vm.currentUser = response;
                                        vm.currentUser.isMappingCustomers = true;
                                        vm.currentUser.SignNumber = null;

                                        vm.currentUser.CustId = custId;

                                        vm.currentUser.isReadOnly = true;
                                        vm.currentUser.isMaped = true;
                                        $scope.$apply();
                                    }
                                });
                            }
                        },
                        function (response) {
                            bars.ui.notify('Помилка', 'Сталася помилка при перавірці ІПН', 'error');
                        }
                    );
                }
            }


            vm.toggleNoInn = function () {
                vm.currentUser.TaxCode = null;
                if (vm.currentUser.NoInn == 0) {
                    vm.currentUser.NoInn = 1;
                }
                else {
                    vm.currentUser.NoInn = 0;
                }
            }

            vm.currentUser = new RelatedCustomer();

            var dateNow = new Date();
            vm.minBirthDate = new Date(dateNow.getFullYear() - 18, dateNow.getMonth(), dateNow.getDate());

            var validate = function () {
                if (vm.currentUser.NoInn == 0 && !vm.currentUser.TaxCode) {
                    bars.ui.error({ text: 'не заповнено ЄДРПО користувача.' });
                    return false;
                }
                if (!vm.currentUser.BirthDate || vm.currentUser.BirthDate > vm.minBirthDate) {
                    bars.ui.error({ text: 'не вірно заповнено дату народження користувача.' });

                    return false;
                }
                if (!vm.currentUser.LastName) {
                    bars.ui.error({ text: 'не заповнено прізвище користувача.' });
                    return false;
                }
                if (!vm.currentUser.FirstName) {
                    bars.ui.error({ text: 'не заповнено ім\'я користувача.' });
                    return false;
                }
                if (!vm.currentUser.SecondName) {
                    bars.ui.error({ text: 'не заповнено по батькові користувача.' });
                    return false;
                }
                if (!vm.currentUser.DocSeries) {
                    bars.ui.error({ text: 'не заповнено серію паспорту.' });
                    return false;
                }
                if (!vm.currentUser.DocNumber) {
                    bars.ui.error({ text: 'не заповнено номер паспорту.' });
                    return false;
                }
                if (!vm.currentUser.DocDate) {
                    bars.ui.error({ text: 'не заповнено дату видачі паспорту.' });
                    return false;
                }
                if (!vm.currentUser.DocDateTo && vm.currentUser.DocType == '7') { //check TODO
                    bars.ui.error({ text: 'не заповнено поле "Дійсний до".' });
                    return false;
                }
                if (!vm.currentUser.DocOrganization) {
                    bars.ui.error({ text: 'не заповнено орган що видав паспорт.' });
                    return false;
                }

                if (!vm.currentUser.Email) {
                    bars.ui.error({ text: 'не заповнено e-mail користувача.' });
                    return false;
                }
                var testEmail = validateEmail(vm.currentUser.Email);
                if (!testEmail) {
                    bars.ui.error({ text: 'перевірте коректність поля e-mail.' });
                    return false;
                }

                // Address
                if (!vm.currentUser.AddressRegionId) {
                    bars.ui.error({ text: 'помилка заповнення адреси: Не вибрано регіон.' });
                    return false;
                }
                if (!vm.currentUser.AddressCity) {
                    bars.ui.error({ text: 'помилка заповнення адреси: Не заповнено місто.' });
                    return false;
                }
                if (!vm.currentUser.AddressStreet) {
                    bars.ui.error({ text: 'помилка заповнення адреси: Не заповнено вулицю.' });
                    return false;
                }

                //підпис
                if (!vm.currentUser.SignNumber) {
                    bars.ui.error({ text: 'не задано тип підпису для користувача.' });
                    return false;
                }

                
                if (!vm.currentUser.isConfirmedPhone && !vm.currentUser.isMappingCustomers) {
                    bars.ui.error({ text: 'Не підтверджено мобільний телефон.' });
                    return false;
                } 

                return true;
            }

            vm.saveUser = function () {
                if (validate()) {

                    if (vm.currentUser.NoInn == 1) {
                        vm.currentUser.TaxCode = vm.currentUser.DocSeries + vm.currentUser.DocNumber;
                    }

                    var userForm = $('#userCart');
                    bars.ui.loader(userForm, true);
                    if (vm.currentUser.isMappingCustomers) {
                        relatedCustomersService.mapCustomer(
                            vm.currentUser.Id, vm.currentUser.CustId, vm.currentUser.SignNumber
                        ).then(
                            function (response) {
                                bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                vm.relatedCustomersGrid.dataSource.read();
                                vm.userDeailWindow.close();
                                vm.hideClUserForm();
                            },
                            function (response) {
                                bars.ui.notify('Помилка', response.Message, 'error');
                            }
                            );
                    } else if (!vm.currentUser.Id) {
                        relatedCustomersService.create(vm.currentUser).then(
                            function (response) {
                                bars.ui.loader(userForm, false);
                                bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                vm.relatedCustomersGrid.dataSource.read();
                                vm.userDeailWindow.close();
                                vm.hideClUserForm();
                            },
                            function (response) {
                                bars.ui.loader(userForm, false);
                                bars.ui.notify('Помилка', response.ExceptionMessage || response.Message || response, 'error');
                            }
                        );
                    } else {
                        relatedCustomersService.update(vm.currentUser).then(
                            function (response) {
                                bars.ui.loader(userForm, false);
                                bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                vm.relatedCustomersGrid.dataSource.read();
                                vm.userDeailWindow.close();
                                vm.hideClUserForm();
                            },
                            function (response) {
                                bars.ui.loader(userForm, false);
                                bars.ui.notify('Помилка', response.ExceptionMessage || response.Message || response, 'error');
                            }
                        );;
                    }
                }
            }

            var visaExistingUser = function (relCustId, custId, userId) {
                bars.ui.loader('body', true);
                relatedCustomersService.visaExistingUser(relCustId, custId, userId)
                    .then(
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                        vm.relatedCustomersGrid.dataSource.read();

                    },
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Помилка',
                            response.ExceptionMessage || response.Message || response,
                            'error');
                    }
                    );
            }

            $scope.visaMapedCustomers = vm.visaMapedCustomers =
                function (relCustId, custId) {
                    vm.currentUser = vm.relatedCustomersGrid.dataSource.get(relCustId);
                    vm.currentUser.isConfirmedPhone = true;
                    if (validate()) {
                        bars.ui.loader('body', true);
                        relatedCustomersService.visaMapedCustomer(relCustId, custId)
                            .then(
                            function (response) {
                                bars.ui.loader('body', false);
                                if (response.Status === 'ERROR' && response.Data) {
                                    bars.ui.confirm({ text: response.Message + ' Бажаєте надати доступ цьому користувачеві?' },
                                        function () {
                                            visaExistingUser(relCustId, custId, response.Data.Id);
                                        });
                                } else {
                                    bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                    vm.relatedCustomersGrid.dataSource.read();
                                }
                            },
                            function (response) {
                                bars.ui.loader('body', false);
                                bars.ui.notify('Помилка',
                                    response.ExceptionMessage || response.Message || response,
                                    'error');
                            }
                            );
                    }
                    vm.currentUser = new RelatedCustomer();
                }

            vm.showClUserForm = function (custId,
                userId,
                firstName,
                lastName,
                patronymic,
                email,
                relCustId,
                isExistUser) {
                vm.isShowClUserForm = false;
                vm.userDeailWindow.center().open();

                $('#customerId').val(custId);
                if (userId) {
                    getUserInfo(relCustId, custId);
                } else {
                    vm.currentUser = new RelatedCustomer(custId, userId, firstName, lastName, patronymic, email, relCustId, isExistUser);
                    vm.currentUser.DocType = 1;
                    SetDropDocListValue();
                    if (!vm.reatedCustomers) {
                        vm.reatedCustomers = [];
                        getCustomerRelatedCustomers(vm.currentUser.CustId);
                    }
                }
            }

            $scope.showEditUserWindow = vm.showEditUserWindow = function (relCustId, custId) {
                vm.userDeailWindow.center().open();
                getUserInfo(relCustId, custId);
            };

            vm.custBirthDateOptions = {
                open: function () {
                    if (vm.currentUser.isReadOnly) {
                        vm.custBirthDate.close();
                    }
                    vm.custBirthDate.options.inputDate = null;
                },
                format: '{0:dd.MM.yyyy}',
                mask: '00.00.0000',
                max: vm.minBirthDate,
                change: function (event) {
                    var value = vm.custBirthDate.options.inputDate;
                    if (value) {
                        vm.custBirthDate.value(value); return;
                    }
                    else value = this.value();
                    if (typeof value === 'string' && value) {
                        var valueArray = value.split('.');
                        if (valueArray.length == 3) {
                            value = new Date(valueArray[2], parseInt(valueArray[1]) - 1, valueArray[0]);
                        }
                    }
                    if (value instanceof Date == false || value == 'Invalid Date' ) {
                        bars.ui.notify('Помилка', "Не вірний формат дати народження", 'error');
                        value = vm.minBirthDate;
                    }
                    else if(value > vm.minBirthDate) {
                        bars.ui.notify('Помилка', 'Дата народження не може бути більшою за ' + vm.minBirthDate.getDate() + '/' + (vm.minBirthDate.getMonth() + 1) + '/' + vm.minBirthDate.getFullYear(), 'error');
                        value = vm.minBirthDate;
                    }
                    vm.custDocDate.min(new Date(value.getFullYear() + 16, value.getMonth(), value.getDate()));

                    if (vm.custDocDate.value() && vm.custDocDate.min() && new Date(vm.custDocDate.value() - vm.custDocDate.min()).getUTCFullYear() - 1970 < 0)
                        vm.custDocDate.value(null);

                    vm.custBirthDate.options.inputDate = value;
                }
            };

            vm.custDocDateOptions = {
                open: function () {
                    if (vm.currentUser.isReadOnly) {
                        vm.custDocDate.close();
                    }
                    vm.custDocDate.options.inputDate = null;
                },
                format: '{0:dd.MM.yyyy}',
                mask: '00.00.0000',
                max: dateNow,
                change: function (e) {
                    var value = vm.custDocDate.options.inputDate;
                    if (value) {
                        vm.custDocDate.value(value); return;
                    }
                    else value = this.value();

                    if (typeof value === 'string' && value) {
                        var valueArray = value.split('.');
                        if (valueArray.length == 3) {
                            value = new Date(valueArray[2], parseInt(valueArray[1]) - 1, valueArray[0]);
                        }
                    }
                    var minDate = vm.custDocDate.min();
                    if (value instanceof Date == false || value == 'Invalid Date') {
                        bars.ui.notify('Помилка', "Не вірний формат дати видачі.", 'error');
                        value = minDate;
                    }
                    else if (value > dateNow) {
                        bars.ui.notify('Помилка', 'Дата видачі не може бути більшою за сьогодня.', 'error');
                        value = minDate;
                    }
                    else if (minDate && value < minDate) {
                        bars.ui.notify('Помилка', 'Дата видачі не може бути більшою за ' + minDate.getDate() + '/' + (minDate.getMonth() + 1) + '/' + minDate.getFullYear(), 'error');
                        value = minDate;
                    }

                    vm.custDocDate.options.inputDate = value;
                }
            };

            vm.custDocDateToOptions = {
                open: function () {
                    if (vm.currentUser.isReadOnly) {
                        vm.custDocDateTo.close();
                    }
                    vm.custDocDateTo.options.inputDate = null;
                },
                format: '{0:dd.MM.yyyy}',
                mask: '00.00.0000',

                change: function () {
                    var value = vm.custDocDateTo.options.inputDate;
                    if (value) {
                        vm.custDocDateTo.value(value); return;
                    }
                    else value = this.value();

                    if (typeof value === 'string' && value) {
                        var valueArray = value.split('.');
                        if (valueArray.length == 3) {
                            value = new Date(valueArray[2], parseInt(valueArray[1]) - 1, valueArray[0]);
                        }
                    }
                    var docDate = vm.custDocDate.value();
                    if (value instanceof Date == false || value == 'Invalid Date') {
                        bars.ui.notify('Помилка', "Не вірний формат поля 'Дійсний до'.", 'error');
                        this.value(null);
                        value = null;
                    }
                    else if (docDate instanceof Date && docDate > value) {
                        bars.ui.notify('Помилка', "Дата видачі не може бути більшою за дату закінчення дії.", 'error');
                        this.value(null);
                        value = null;
                    }
                    else if (value < dateNow){
                        bars.ui.notify('Увага', "Строк дії документу закінчився.", 'error');
                    }

                    vm.custDocDateTo.options.inputDate = value;
                }
            };

            //vm.custDocDateTo.enable(true);

            $scope.lockUser = vm.lockUser = function (userId, custId) {
                var userForm = $('#userCart' + userId);
                bars.ui.loader(userForm, true);
                $.ajax({
                    type: 'PUT',
                    url: bars.config.urlContent('/api/cdo/corpLight/users/LockUser/' + userId +
                        '/' + custId),
                    success: function (data, textStatus, jqXHR) {
                        bars.ui.loader(userForm, false);
                        bars.ui.notify('Успішно!', 'Користувача заблоковано', 'success');
                        vm.relatedCustomersGrid.dataSource.read();
                    },
                    error: function () {
                        bars.ui.loader(userForm, false);
                        bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');
                    },
                    complete: function () {
                        bars.ui.loader(userForm, false);
                    }
                });
            }
            $scope.unLockUser = vm.unLockUser = function (userId, custId) {
                var userForm = $('#userCart' + userId);
                bars.ui.loader(userForm, true);
                $.ajax({
                    type: 'PUT',
                    url: bars.config.urlContent('/api/cdo/corpLight/users/unLockUser/' + userId +
                        '/' + custId),
                    success: function (data, textStatus, jqXHR) {
                        bars.ui.loader(userForm, false);
                        bars.ui.notify('Успішно!', 'Користувача розблоковано', 'success');
                        vm.relatedCustomersGrid.dataSource.read();
                    },
                    error: function () {
                        bars.ui.loader(userForm, false);
                        bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');
                    },
                    complete: function () {
                        bars.ui.loader(userForm, false);
                    }
                });
            }

            $scope.deleteUser = vm.deleteUser = function deleteUser(userId, custId, relCustId) {
                var user = vm.relatedCustomersGrid.dataSource.get(relCustId);
                bars.ui.confirm({
                    text: 'Ви впеснені що хочете видалити користувача <div><b>' +
                    user.LastName + ' ' +
                    user.FirstName + ' ' +
                    user.SecondName + '</b></div>',
                    func: function () {
                        var userForm = $('#userCart' + userId);
                        bars.ui.loader(userForm, true);


                        $.ajax({
                            type: 'DELETE',
                            url: bars.config.urlContent('/api/cdo/corpLight/users/DeleteUser/' +
                                userId +
                                '/' + custId +
                                '/' + relCustId),
                            success: function (data, textStatus, jqXHR) {
                                bars.ui.loader(userForm, false);

                                bars.ui.notify('Успішно!', 'Користувача успішно видалено', 'success');

                                vm.relatedCustomersGrid.dataSource.read();

                            },
                            error: function () {
                                bars.ui.loader(userForm, false);
                                bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');
                            },
                            complete: function () {
                                bars.ui.loader(userForm, false);
                            }
                        });
                    }
                });
            }

            $scope.unMapUserCustomer = vm.unMapUserCustomer = function (id, customerId) {
                bars.ui.confirm({ text: 'Видалити користувача?' }, function () {
                    relatedCustomersService.unMapUserCustomer(id, customerId).then(
                        function () {
                            bars.ui.notify('Успішно', 'Зміни відправлено на підтвердження', 'success');
                            vm.relatedCustomersGrid.dataSource.read();
                        },
                        function (response) {
                            bars.ui.notify('Помилка',
                                'Помилка обробки запиту <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>',
                                'error');
                        }
                    );
                });
            }

            $scope.deleteRequest = vm.deleteRequest = function (id, customerId) {
                bars.ui.confirm({ text: 'Видалити запит на підтвердження даних?' }, function () {
                    relatedCustomersService.deleteRequest(id, customerId).then(
                        function () {
                            bars.ui.notify('Успішно', 'Зміни збережено', 'success');
                            vm.relatedCustomersGrid.dataSource.read();
                        },
                        function (response) {
                            bars.ui.notify('Помилка',
                                'Помилка обробки запиту <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>',
                                'error');
                        }
                    );
                });
            }

            vm.requestCertificate = $scope.requestCertificate = function (relCustId) {
                if (relCustId) {
                    bars.ui.loader('body', true);
                    relatedCustomersService.requestCertificate(relCustId).then(
                        function () {
                            bars.ui.loader('body', false);
                            bars.ui.notify('Успішно', 'Запит на сертифікат успішно сформовано', 'success');
                            vm.relatedCustomersGrid.dataSource.read();
                        },
                        function (response) {
                            bars.ui.loader('body', false);
                            bars.ui.notify('Помилка',
                                'Виникла помилка при формувванні запиту на сертифікат. <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>',
                                'error');
                        }
                    );
                }
            }

            commonCustomersService.getDocsType().then(
                function (response) {
                    //bars.ui.notify('Успішно');
                    $scope.docstypeData = response;
                });

            $scope.docsTypeDataOption = {
                dataSource: $scope.docstypeData
            };

            //vm.toggleDocView = function (doctypes) {
            //    if (doctypes.includes(Number(vm.currentUser.DocType))) {
            //        return true;
            //    }
            //};

            vm.sendProfileToAcsk = $scope.sendProfileToAcsk = function (relCustId) {
                bars.ui.loader('body', true);
                var user = vm.relatedCustomersGrid.dataSource.get(relCustId);
                acskService.sendProfileToAcsk(relCustId, user.CustId).then(
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Успішно',
                            'Профіль успішно відправлено. Присвоєно номер ' + response.Data.RegistrationId,
                            'success');
                        vm.relatedCustomersGrid.dataSource.read();
                    },
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Помилка',
                            'Виникла при відправці профіля користувача. <small>' +
                            (response.Message || response.ErrorMessage || '') + '</small>',
                            'error');
                    });
            }

            var setProfileSign = function (relCustId, visaId, signedData) {
                bars.ui.loader('body', true);
                profileSignService.setProfileSign(relCustId, visaId, signedData).then(
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Успішно', 'Підпис успішно збережено', 'success');
                        vm.relatedCustomersGrid.dataSource.read();
                    },
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Помилка',
                            'Виникла помилка при збереженні підпису. <small>' +
                            (response.Message || response.ErrorMessage || '') + '</small>',
                            'error');
                    }
                );
            }

            vm.addProfileSign = $scope.addProfileSign = function (relCustId) {
                bars.ui.loader('body', true);
                profileSignService.getProfileSignBuffer(relCustId).then(
                    function (response) {
                        bars.ui.loader('body', false);
                        var id = response.id;
                        var signedData;
                        if (id === 1) {
                            var buffer = response.buffer.replace(/\"/g, '');
                            signedData = profileSignService.signData(buffer);
                        } else {
                            signedData = profileSignService.coSignData(response.buffer, '');
                        }

                        if (signedData) {
                            setProfileSign(relCustId, id, signedData);
                        }
                    },
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Помилка',
                            'Виникла при отримані буфера для підпису профіля користувача. <small>' +
                            (response.Message || response.ErrorMessage || '') + '</small>',
                            'error');

                    }
                );
            }

            vm.acsk = {
                rules: [],
                changeStateOptions: {
                    relCustId: null,
                    newState: 0,
                    comment: ''
                },
                certificates: [],
                certificateRequest: {
                    templateId: null,
                    cryptoProviderValue: null,
                    keySize: null
                },
                enrollRequest: function (relCustId, subjectData) {
                    bars.ui.loader('body', true);

                    acskService.enrollRequest(relCustId, subjectData).then(
                        function (response) {
                            bars.ui.loader('body', false);

                            bars.ui.notify('Успішно', 'Запит успішно відправлено', 'success');
                            vm.relatedCustomersGrid.dataSource.read();
                            vm.acskRulesWindow.close();
                        },
                        function (response) {
                            bars.ui.loader('body', false);
                            bars.ui.notify('Помилка',
                                'Виникла помилка при запиті Enroll. <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>',
                                'error');
                        });
                },
                getSubject: function () {
                    bars.ui.loader('body', true);
                    acskService.getSubject(
                        vm.acsk.certificateRequest.AcskRegistrationId,
                        vm.acsk.selectedTemplate.TemplateId,
                        vm.acsk.selectedProvider.Id).then(
                        function (response) {
                            bars.ui.loader('body', false);

                            vm.acsk.enrollRequest(vm.acskRulesWindow.userId, response.Data);
                        },
                        function (response) {
                            bars.ui.loader('body', false);
                            bars.ui.notify('Помилка',
                                'Виникла помилка при запиті Subject. <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>',
                                'error');
                        }
                        );
                },
                installCertificate: function (certificateInfo) {
                    var info = acskService.installCertificate(certificateInfo.CertificateBody);
                    if (info) {
                        bars.ui.notify('Наші вітання!',
                            'Здається, що процедура встановлення сертифікату пройшла досить успішно!',
                            'success');
                        vm.certificatesWindow.close();
                    } else {
                        bars.ui.notify('Помилка',
                            'Виникла помилка при встановленні сертифікату. '
                            + 'Перевірте наявність пристрою.',
                            'error');
                    }
                },
                displayCertificate: function (base64Crt) {
                    acskService.displayCertificate(base64Crt);
                },
                showPrintWindow: function () {
                    var docPrint = window.open("", "Print", 'scrollbars=yes,resizable=yes,height=900px,width=950px');
                    docPrint.document.open();
                    docPrint.document.write('<html><head><title>Повідомлення про запит сертифіката</title>');
                    docPrint.document.write('</head><body onLoad="self.print(); self.close();"><left>');
                    docPrint.document.write('</left><br/><table width="800px" border=0><tr><td><left>');
                    docPrint.document.write(document.getElementById("docPage").innerHTML);
                    docPrint.document.write('</td></tr></table></left></font></body></html>');
                    //docPrint.document.close();
                    docPrint.focus();
                    //docPrint.close();
                },
                printCertificate: function (certificateInfo) {
                    var user = vm.relatedCustomersGrid.dataSource.get(certificateInfo.RelCustId);
                    document.location.href =
                        '/barsroot/api/cdo/CorpLight/UserCertificate/print/' + user.Id + '/' + user.CustId;

                    //acskService.parseBase64Crt(certificateInfo.CertificateBody).then(
                    //    function (response) {
                    //        bars.ui.loader('#acskCertificatesWindow', false);
                    //        vm.acsk.printCertificateData = angular.extend(user, response);
                    //        $scope.$apply();
                    //        vm.acsk.showPrintWindow();
                    //    },
                    //    function (response) {
                    //        bars.ui.loader('#acskCertificatesWindow', false);
                    //        bars.ui.notify('Помилка',
                    //                        'Виникла помилка при отриманні даних сертифікату. <small>' +
                    //                        (response.Message || response.ErrorMessage || '') + '</small>',
                    //                        'error');
                    //    });
                },
                showChangeCertificateStateWindow: function (certificateInfo) {
                    vm.acsk.changeStateOptions.relCustId = certificateInfo.RelCustId;
                    vm.acsk.changeStateOptions.serialNumber = certificateInfo.CertificateSn;
                    vm.acsk.changeCertificatesStateWindow.center().open();
                },
                changeCertificateState: function () {
                    bars.ui.loader('#AcskChangeCertificatesStatesWindow', true);
                    acskService.changeCertificateState(
                        vm.acsk.changeStateOptions.relCustId,
                        vm.acsk.changeStateOptions.registrationId,
                        vm.acsk.changeStateOptions.serialNumber,
                        vm.acsk.changeStateOptions.newState,
                        vm.acsk.changeStateOptions.comment).then(
                        function (response) {
                            bars.ui.loader('#AcskChangeCertificatesStatesWindow', false);
                            bars.ui.notify('Успішно!',
                                'Статус сертифіката успішно змінено!',
                                'success');
                            vm.acsk.changeCertificatesStateWindow.close();


                        },
                        function (response) {
                            bars.ui.loader('#AcskChangeCertificatesStatesWindow', false);
                            bars.ui.notify('Помилка',
                                'Виникла помилка при запиті на зміну статусу. <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>',
                                'error');
                        });
                },
                saveAcskRules: function () {
                    var keyOptions = {
                        oid: '',
                        //required
                        algorithm: vm.acsk.selectedProvider.Value,
                        //required
                        keyUsages: '',
                        commonName: '',
                        patronimic: '',
                        firstName: '',
                        workPosition: '',
                        workCompany: '',
                        workSubDivision: '',
                        //required
                        registrationId: '',
                        //required
                        address: {
                            country: 'UA',
                            region: '',
                            city: '',
                            street: '',
                            houseNumber: '',
                            addition: ''
                        },
                        //required
                        templateName: '',
                        //required
                        temolateOid: '',
                        isUsePreventKeyForSign: 0,
                        isPrintRequest: 0,
                        //required
                        hashCertSign: 0,
                        clienUid: '',
                        useSubjectEmail: 0,
                        useExportKey: 0,
                        cskClientId: '',
                        dkeKeyAlgorithm: '',
                        companyId: '',
                        clientPolicyId: '',
                        vegaId: '',
                        certificatDescription: '',
                        //required
                        registratorId: '',
                        isValidateTemplate: 0,
                        //required
                        keyType: 0,
                        email: '',
                        signedType: 2,
                        //required
                        cryptoProviderName: '',
                        cryptoContainerName: 'OschadBankAcskKeys',
                        friendlyCertifiateName: '',
                        //required
                        keySize: '',
                        pkcs11LibraryName: '',
                        accessKeySerialNumber: ''

                    }

                    var privateKeyParameters = acskService.getPrivateKeyParameters(keyOptions);
                },
                certificatesWindowOptions: {
                    width: '600px',
                    height: '450px',
                    title: ' ',
                    modal: true,
                    actions: [
                        "Close"
                    ],
                    close: function () {
                        vm.acsk.certificates = [];
                    }
                },
                changeCertificatesStateWindowOptions: {
                    width: '400px',
                    height: '350px',
                    title: ' ',
                    modal: true,
                    actions: [
                        "Close"
                    ],
                    close: function () {
                        vm.acsk.changeStateOptions = {
                            newState: 0,
                            comment: ''
                        }
                    }
                },
                acskRulesWindowOptions: {
                    width: '400px',
                    height: '350px',
                    title: ' ',
                    modal: true,
                    actions: [
                        "Close"
                    ],
                    close: function () {
                        vm.acsk.rules = [];
                        vm.acsk.selectedTemplate = null;
                        vm.acsk.certificateRequest.templateId = null;
                        vm.acsk.certificateRequest.cryptoProviderValue = null;
                        vm.acsk.certificateRequest.keySize = null;

                        vm.acsk.selectedProvider = null;

                        vm.acskRulesWindow.userId = null;

                    }
                },
                GetCrtState: function (revokeCode) {
                    switch (revokeCode) {
                        case -1:
                            return '-1 - Чинний';
                        case 0:
                            return '0 - Не визначено';
                        case 1:
                            return '1 - Компрометація ключа';
                        case 2:
                            return '2 - Компрометація ЦСК';
                        case 3:
                            return '3 - Зміна повноважень ';
                        case 4:
                            return '4 - Заміщення';
                        case 5:
                            return '5 - Припинення операцій';
                        case 6:
                            return '6 - Блокування';
                        case 8:
                            return '8 - Виключення з СВС';
                        case 9:
                            return '9 - Скасування привілеїв';
                        case 10:
                            return '10 - Компрометація Центру авторизації';
                        default:
                            return 'Не визначено';
                    }
                }
            }





            var showRulesWindow = function (id) {
                vm.acskRulesWindow.userId = id;
                vm.acskRulesWindow.center().open();
            }

            var setSelectedTemplate = function (template) {
                vm.acsk.selectedTemplate = template;
                vm.acsk.certificateRequest.templateId = template.TemplateId;
                vm.acsk.certificateRequest.keySize = template.KeySize;
                vm.acsk.selectedProvider = template.CryptoProviders[0];
            }

            vm.onChangeTemplate = function () {
                vm.acsk.certificateRequest.templateId = vm.acsk.selectedTemplate.TemplateId;
                vm.acsk.certificateRequest.keySize = vm.acsk.selectedTemplate.KeySize;
                vm.acsk.selectedProvider = vm.acsk.selectedTemplate.CryptoProviders[0];
            }

            vm.onChangeCriptoProvider = function (selectedProvider) {
                vm.acsk.certificateRequest.criptoProvider = vm.acsk.selectedProvider;
            }

            vm.getCertificatesStatus =
                $scope.getCertificatesStatus =
                function (relCustId) {
                    var user = vm.relatedCustomersGrid.dataSource.get(relCustId);
                    if (!user.AcskRegistrationId) {
                        bars.ui.notify('Помилка',
                            'Клієнт не зареєстрований в АЦСК!',
                            'error');
                        return;
                    }
                    bars.ui.loader('body', true);
                    acskService.getCertificatesStatus(relCustId, user.AcskRegistrationId).then(
                        function (response) {
                            bars.ui.loader('body', false);
                            if (response.Data && response.Data.length > 0) {
                                vm.acsk.certificates = response.Data;
                                vm.acsk.changeStateOptions.registrationId = user.AcskRegistrationId;
                                vm.certificatesWindow.center().open();
                            } else {
                                bars.ui.notify(
                                    'Запити відсутні',
                                    'Список оброблених сертифікатів порожній',
                                    'warning');

                            }
                        },
                        function (response) {
                            bars.ui.loader('body', false);
                            bars.ui.notify('Помилка',
                                'Виникла помилка при оновленні статусу сертафікатів. <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>',
                                'error');
                        }
                    );
                }

            vm.generateTokenRequest =
                $scope.generateTokenRequest =
                function (id) {
                    var user = vm.relatedCustomersGrid.dataSource.get(id);
                    if (!user.AcskRegistrationId) {
                        bars.ui.notify('Помилка',
                            'Клієнт не зареєстрований в АЦСК!',
                            'error');
                        return;
                    }

                    vm.acsk.certificateRequest.AcskRegistrationId = user.AcskRegistrationId;
                    bars.ui.loader('body', true);
                    acskService.getRules(user.AcskRegistrationId).then(
                        function (response) {
                            bars.ui.loader('body', false);
                            if (response && response.length !== 0) {
                                vm.acsk.rules = response;
                                setSelectedTemplate(response[0]);
                                showRulesWindow(id);
                            }
                        },
                        function (response) {
                            bars.ui.loader('body', false);
                            bars.ui.notify('Помилка',
                                'Виникла помилка при формувванні запиту на сертифікат. <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>',
                                'error');
                        }
                    );
                }

            vm.hideClUserForm = function () {
                vm.userDeailWindow.close();
                vm.currentUser = new RelatedCustomer();
            }

            vm.userDeailWindowOptions = {
                width: '600px',
                height: '400px',
                title: ' ',
                modal: true,
                actions: [
                    "Pin",
                    "Minimize",
                    "Maximize",
                    "Close"
                ],
                close: function () {
                    vm.currentUser = new RelatedCustomer();
                    vm.custBirthDate.enable(true);
                    vm.custDocDate.enable(true);
                    vm.custDocDateTo.enable(true);
                }
            }

            vm.showUserManual = function () {
                window.open(
                    '/barsroot/areas/cdo/CorpLight/doc/userManual.htm',
                    'UserManual',
                    'scrollbars=yes,resizable=yes,height=900px,width=950px',
                    true);
            }

            vm.relatedCustomersGridOptions = {
                toolbar: [
                    {
                        name: 'Add',
                        text: 'Створити',
                        template: '<button ng-click="relCustCtrl.showClUserForm()" class="k-button" title="Створити">Створити</button>'
                    }, {
                        name: 'ShowUserManual',
                        text: 'Інструкція користувача',
                        template: '<button ng-click="relCustCtrl.showUserManual()" '
                        + 'style="float:right;" '
                        + 'class="k-button" title="Інструкція користувача">Інструкція користувача</button>'
                    }],
                editable: "popup",
                height: 120,
                width: 300,
                autoBind: true,
                selectable: 'single',
                groupable: false,
                sortable: true,
                resizable: true,
                filterable: true,
                scrollable: true,
                pageable: {
                    refresh: true,
                    pageSizes: [10, 20, 50, 100, 200],
                    buttonCount: 5
                },
                dataBound: function (e) {
                    bars.ext.kendo.grid.noDataRow(e);
                    vm.isShowClUserForm = false;
                },
                dataBinding: function () { },
                dataSource: {
                    type: 'webapi',
                    pageSize: 10,
                    page: 1,
                    total: 0,
                    serverPaging: true,
                    serverSorting: true,
                    serverFiltering: true,
                    serverGrouping: true,
                    serverAggregates: true,
                    sort: {
                        field: "Id",
                        dir: "desc"
                    },
                    transport: {
                        read: {
                            url: bars.config.urlContent('/api/cdo/corplight/relatedcustomers/') + $('#custId').val() + "/" + $('#clmode').val(),
                            dataType: 'json',
                            cache: false,
                            data: function () {
                                return vm.customersFilter;
                            }
                        }
                    },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: {
                            id: 'Id',
                            fields: {
                                RelatedCustId: {
                                    type: 'number'
                                },
                                CustId: {
                                    type: 'number'
                                },
                                TaxCode: {
                                    type: 'string'
                                },
                                FirstName: {
                                    type: 'string'
                                },
                                LastName: {
                                    type: 'string'
                                },
                                SecondName: {
                                    type: 'string'
                                },
                                DocType: {
                                    type: 'string'
                                },
                                DocSeries: {
                                    type: 'string'
                                },
                                DocNumber: {
                                    type: 'string'
                                },
                                DocOrganization: {
                                    type: 'string'
                                },
                                DocDate: {
                                    type: 'date'
                                },
                                BirthDate: {
                                    type: 'date'
                                },
                                CellPhone: {
                                    type: 'string'
                                },
                                Email: {
                                    type: 'string'
                                },
                                SignNumber: {
                                    type: 'string'
                                },
                                UserId: {
                                    type: 'string'
                                },
                                LockoutEnabled: {
                                    type: 'bool'
                                },
                                IsApproved: {
                                    type: 'bool'
                                },
                                ApprovedType: {
                                    type: 'string'
                                }
                            }
                        }
                    }
                },
                columns: [
                    {
                        field: 'ApprovedType',
                        title: ' ',
                        width: '100px',
                        template: function (data) {
                            var html = '';
                            switch (data.ApprovedType) {
                                case 'add':
                                    html += '<span class="label label-primary">новий</span>';
                                    break;
                                case 'update':
                                    html += '<span class="label label-warning">оновлено</span>';
                                    break;
                                case 'delete':
                                    html += '<span class="label label-danger">видалено</span>';
                                    break;
                                case 'rejected':
                                    html += '<span class="label label-default">відхилено</span>';
                                    break;
                                default:
                                    if (data.IsApproved) {
                                        html += '<span class="label label-success">підтверджено</span>';
                                    }
                            };
                            return html;
                        }
                    }, {
                        field: 'TaxCode',
                        title: 'ІПН',
                        width: '90px',
                        template: function (data) {
                            return '<a href="#" ng-click="viewRelatedCustomer(' + data.Id + ', ' + data.CustId + ')">' + data.TaxCode + '</a>';
                        }
                    }, {
                        field: 'FirstName',
                        title: 'ПІБ',
                        width: '200px',
                        template: function (data) {
                            return data.LastName + ' ' + data.FirstName + ' ' + data.SecondName;
                        }
                    }, {
                        field: 'CellPhone',
                        title: 'Телефон',
                        width: '110px'
                    }, {
                        field: 'Email',
                        title: 'e-mail',
                        width: '200px'
                    }, {
                        field: 'DocType',
                        title: 'документ',
                        width: '80px',
                        template: function (data) {
                            return '<span title="видано: ' + data.DocOrganization + ' ' + data.DocDate + '">' + data.DocSeries + ' ' + data.DocNumber;
                        }
                    }, {
                        field: 'SignNumber',
                        title: '№<br>підпису',
                        width: '60px',
                        template: function (data) {
                            return '<b>' + data.SignNumber + '</b>';
                        }
                    }, {
                        field: 'LockoutEnabled',
                        title: ' ',
                        width: '160px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = '';

                            html += '<button style="min-width: 40px;" class="k-button" ng-click="showEditUserWindow('
                                + data.Id + ', ' + data.CustId + ');" title="Редагувати">\
                                                <i style="font-size:18px;" class="fa fa-pencil text-success"></i>\
                                            </button>';
                            if (data.UserId) {
                                html += '<button style="min-width: 40px;" class="k-button" ng-click="' + ((data.LockoutEnabled ? 'unL' : 'l') + 'ockUser(\'' + data.UserId + '\', \'' + data.CustId + '\')') + '" title="' + (data.LockoutEnabled ? 'Роз' : 'За') + 'блокувати">\
                                                    <i style="font-size:18px;" class="fa fa-' + (data.LockoutEnabled ? 'un' : '') + 'lock text-warning"></i>\
                                                </button>';
                            }
                            if (data.IsApproved || data.ApprovedType === 'rejected') {
                                html += '<button style="min-width: 40px;" class="k-button" ng-click="unMapUserCustomer(\'' + data.Id + '\', \'' + data.CustId + '\');" title="Видалити">\
                                                    <i style="font-size:18px;" class="fa fa-times-circle text-danger"></i>\
                                                </button>';
                            }


                            return html;
                        }
                    }, {
                        field: 'LockoutEnabled',
                        title: 'АЦСК',
                        width: '190px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = '';
                            if (data.IsApproved) {
                                if (!data.HasAllSignes) {
                                    html +=
                                        '<button style="min-width: 40px;" class="k-button" '
                                        + 'ng-click="addProfileSign(' + data.Id + ');" '
                                        + 'title="Підписати профіль користувача">\
                                                <i style="font-size:18px;" class="fa fa-hand-o-down"></i>\
                                            </button>';
                                }
                                if (data.HasAllSignes && !data.IsAcskActual) {
                                    html +=
                                        '<button style="min-width: 40px;" class="k-button" '
                                        + 'ng-click="sendProfileToAcsk(' + data.Id + ');" '
                                        + 'title="Відправити дані користувача в АЦСК">\
                                                <i style="font-size:18px;" class="fa fa-paper-plane"></i>\
                                            </button>';
                                }
                                if (data.HasAllSignes && data.IsAcskActual) {
                                    html +=
                                        '<button style="min-width: 40px;" class="k-button" '
                                        + 'ng-click="generateTokenRequest(' + data.Id + ');" '
                                        + 'title="Генерація приватного ключа">\
                                                <i style="font-size:18px;" class="fa fa-paw"></i>\
                                            </button>';
                                    html +=
                                        '<button style="min-width: 40px;" class="k-button" '
                                        + 'ng-click="getCertificatesStatus(' + data.Id + ');" '
                                        + 'title="Перегляд зареєстрованих сертифікатів">\
                                                <i style="font-size:18px;" class="fa fa-refresh"></i>\
                                            </button>';
                                }
                            } else {

                            }
                            return html;
                        }
                    }
                ]
            };

            $scope.$on('CDO.CorpLight.readCustomersGrid', function(){
                vm.relatedCustomersGrid.dataSource.read();
            });
        }
    ]);