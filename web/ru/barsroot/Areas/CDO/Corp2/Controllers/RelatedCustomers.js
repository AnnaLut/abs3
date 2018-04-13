
angular.module(globalSettings.modulesAreas)
    .controller('CDO.Corp2.RelatedCustomers',
    [
        '$scope',
        'CDO.commonCustomersService',
        'CDO.Corp2.relatedCustomersService', 
        'CDO.Corp2.AcskService', 
        'CDO.Corp2.ProfileSignService', 
        function ($scope,
            commonCustomersService,
            relatedCustomersService,
            acskService,
            profileSignService
        ) {
            'use strict';

            var vm = this;
            $scope.dateTimeNow = new Date();

            vm.relCustServiceState = relatedCustomersService.state;

            vm.currentCustomerAccount = null;
            vm.currentUserId = null;
            vm.reatedCustomers = null;
            var limitDictionary = null;

            vm.toDate = function (dateStr) {
                if (typeof dateStr === 'string') {
                    return new Date(parseInt(/\d+/.exec(dateStr)[0]));
                }
                return new Date();
            }

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


                if (customerData.DocType == '1') {
                    vm.currentUser.DocSeries = customerData.DocSeries;
                    vm.currentUser.DocNumber = customerData.DocNumber;
                    vm.currentUser.DocOrganization = customerData.DocOrganization;
                    vm.currentUser.DocDate = customerData.DocDate ?
                        new Date(parseInt(customerData.DocDate.substr(6))) : null;
                }
                vm.validateTaxCode();
            }

            var getCustomerRelatedCustomers = function (custId) {
                commonCustomersService.getCustomerRelatedCustomers(custId).then(
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

            var validateEmail = function (email) {
                var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                return re.test(email);
            }

            var RelatedCustomer = function (custId, userId, firstName, lastName, secondName, email, relatedCustId, isExistCust) {
                this.Id = userId || null;

                this.Name = '';
                this.FullNameGenitiveCase = '';

                this.TaxCode = '';
                //this.NoInn = 0;
                this.FirstName = firstName || '';
                this.LastName = lastName || '';
                this.SecondName = secondName || '';
                this.Login = '';

                this.DocType = '1';
                this.DocSeries = '';
                this.DocNumber = '';
                this.DocOrganization = '';
                this.DocDate = null;

                this.BirthDate = null;

                this.CreatedDate = null;
                this.ActivateDate = null;

                this.CellPhone = '';
                this.Email = email || '';
                this.SignNumber = 0;

                this.UserId = null;
                this.LockoutEnabled = false;

                this.Address = '';

                this.Password = '';
                this.CustId = document.getElementById('custId').value;
                //this.Customers = [new UserCustomer(custId)];
                //this.isConfirmedPhone = false;
                this.RelatedCustId = relatedCustId || null;
                this.IsExistCust = isExistCust || null;

                this.SignNumber = null;
                this.SequntialVisa = null;
            }

            vm.validateTaxCode = function () {
                var taxCode = vm.currentUser.TaxCode;

                if (!/^\d{8,10}$/.test(taxCode)) return;

                var userForm = $('#userCartNew');
                bars.ui.loader(userForm, true);
                var custId = document.getElementById('custId').value;
                relatedCustomersService.getByTaxCode(custId, taxCode, vm.currentUser.DocSeries, vm.currentUser.DocNumber).then(
                    function (response) {
                        bars.ui.loader(userForm, false);
                        if (response) {
                            if (response.error) {
                                bars.ui.error({
                                    text: response.error +
                                    "<br> <span style='color:red;'>Ви можете продовжити процедуру заведення користувача, але це може призвести до видачі ще одного ключа одному користувачу, який можливо вже є в системі CorpLight!<span>"
                                });
                            }
                            else {
                                vm.currentUser = new RelatedCustomer();
                                bars.ui.confirm({
                                    text: 'Користувач з ІПН ' + taxCode + ' вже існує. Бажаєте відкрити його дані?',
                                    func: function () {
                                        vm.currentUser = response;
                                        vm.currentUser.SignNumber = 0;
                                        //Якщо знайшли не в АБС Корп2, то Id буде дорівнювати null -> vm.saveUser -> relatedCustomersService.create,
                                        //де корисувач також буде прив'язаний до клієнта.
                                        //Якщо знайшли в АБС Корп2, то -> relatedCustomersService.updateAndMap
                                        vm.currentUser.isNotMaped = (response.Id && response.CustId != custId);
                                        vm.currentUser.CustId = custId;
                                        $scope.$apply();
                                    }
                                });
                            }
                        }
                    },
                    function (response) {
                        bars.ui.loader(userForm, false);
                        vm.currentUser.TaxCode = null;
                    }
                );
            }

            vm.currentUser = new RelatedCustomer();

            var dateNow = new Date();
            vm.minBirthDate = new Date(dateNow.getFullYear() - 18, dateNow.getMonth(), dateNow.getDate());

            var validate = function () {
                if (!/^\d{8,10}$/.test(vm.currentUser.TaxCode)) {
                    bars.ui.error({ text: 'ІПН може складатися лише з 8-10 числових значень.' });
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

                //if (!vm.currentUser.CellPhone) {
                //    bars.ui.error({ text: 'не заповнено телефон користувача' });
                //    return false;
                //}

                //var docNumber = vm.currentUser.DocNumber.toString();
                //while (docNumber.length < 6) docNumber = "0" + docNumber;
                //vm.currentUser.DocNumber = docNumber;

                return true;
            }

            vm.saveUser = function () {
                if (validate()) {

                    var userForm = $('#userCartNew');
                    bars.ui.loader(userForm, true);
                    if (!vm.currentUser.Id) {
                        relatedCustomersService.create(vm.currentUser).then(
                            function (response) {
                                bars.ui.loader(userForm, false);
                                bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                vm.relCustsGridCorp2.dataSource.read();
                                vm.userDetailWindow.close();
                            },
                            function (response) {
                                bars.ui.loader(userForm, false);
                            }
                        );
                    }
                    else if (vm.currentUser.isNotMaped) {
                        relatedCustomersService.updateAndMap(vm.currentUser).then(
                            function (response) {
                                bars.ui.loader(userForm, false);
                                bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                vm.relCustsGridCorp2.dataSource.read();
                                vm.userDetailWindow.close();
                            },
                            function (response) {
                                bars.ui.loader(userForm, false);
                            }
                        );
                    }
                    else {
                        relatedCustomersService.update(vm.currentUser).then(
                            function (response) {
                                bars.ui.loader(userForm, false);
                                bars.ui.notify('Успішно', 'Зміни успішно збережено', 'success');
                                vm.relCustsGridCorp2.dataSource.read();
                                vm.userDetailWindow.close();
                            },
                            function (response) {
                                bars.ui.loader(userForm, false);
                            }
                        );
                    }
                }
            }

            $scope.showEditCustomerAccWindow = vm.showEditCustomerAccWindow = function (bankAcc) {
                vm.accountDetailWindow.center().open();
                vm.getAccInfo(bankAcc, $('#custId').val());
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
                change: function (e) {
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
                    if (value instanceof Date == false || value == 'Invalid Date') {
                        bars.ui.notify('Помилка', "Не вірний формат дати народження", 'error');
                        value = vm.minBirthDate;
                    }
                    else if (value > vm.minBirthDate) {
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
                change: function () {
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
                        bars.ui.notify('Помилка', "Не вірний формат дати видачі", 'error');
                        value = minDate;
                    }
                    else if (value > dateNow) {
                        bars.ui.notify('Помилка', 'Дата видачі не може бути більшою за сьогодня', 'error');
                        value = minDate;
                    }
                    else if (minDate && value < minDate) {
                        bars.ui.notify('Помилка', 'Дата видачі не може бути більшою за ' + minDate.getDate() + '/' + (minDate.getMonth() + 1) + '/' + minDate.getFullYear(), 'error');
                        value = minDate;
                    }

                    vm.custDocDate.options.inputDate = value;
                }
            };

            vm.sendProfileToAcsk = $scope.sendProfileToAcsk = function (relCustId, custId) {
                bars.ui.loader('body', true);

                acskService.sendProfileToAcsk(relCustId, custId).then(
                    function (response) {
                        bars.ui.loader('body', false);
                        bars.ui.notify('Успішно',
                            'Профіль успішно відправлено. Присвоєно номер ' + response.Data.RegistrationId,
                            'success');
                        vm.relCustsGridCorp2.dataSource.read();
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
                        vm.relCustsGridCorp2.dataSource.read();
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
                    bars.ui.loader(vm.acskRulesWindow, true);

                    acskService.enrollRequest(relCustId, subjectData).then(
                        function (response) {
                            bars.ui.loader(vm.acskRulesWindow, false);

                            bars.ui.notify('Успішно', 'Запит успішно відправлено', 'success');
                            vm.relCustsGridCorplight.dataSource.read();
                            vm.acskRulesWindow.close();
                        },
                        function (response) {
                            bars.ui.loader(vm.acskRulesWindow, false);
                            bars.ui.error({
                                text: 'Виникла помилка при запиті Enroll. <small>' +
                                (response.Message || response.ErrorMessage || '') + '</small>' });
                        });
                },
                getSubject: function () {
                    bars.ui.loader(vm.acskRulesWindow, true);
                    acskService.getSubject(
                        vm.acsk.certificateRequest.AcskRegistrationId,
                        vm.acsk.selectedTemplate.TemplateId,
                        vm.acsk.selectedProvider.Id).then(
                        function (response) {
                            bars.ui.loader(vm.acskRulesWindow, false);
                            vm.acsk.enrollRequest(vm.acskRulesWindow.userId, response.Data);
                        },
                        function (response) {
                            bars.ui.loader(vm.acskRulesWindow, false);
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
                //showPrintWindow: function () {
                //    var docPrint = window.open("", "Print", 'scrollbars=yes,resizable=yes,height=900px,width=950px');
                //    docPrint.document.open();
                //    docPrint.document.write('<html><head><title>Повідомлення про запит сертифіката</title>');
                //    docPrint.document.write('</head><body onLoad="self.print(); self.close();"><left>');
                //    docPrint.document.write('</left><br/><table width="800px" border=0><tr><td><left>');
                //    docPrint.document.write(document.getElementById("docPage").innerHTML);
                //    docPrint.document.write('</td></tr></table></left></font></body></html>');
                //    //docPrint.document.close();
                //    docPrint.focus();
                //    //docPrint.close();
                //},
                printCertificate: function (certificateInfo) {
                    //var user = vm.relCustsGridCorp2.dataSource.get(certificateInfo.RelCustId);

                    document.location.href =
                        '/barsroot/api/cdo/corp2/UserCertificate/print/' + certificateInfo.RelCustId + '/' + $('#custId').val();
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
                //saveAcskRules: function () {
                //    var keyOptions = {
                //        oid: '',
                //        //required
                //        algorithm: vm.acsk.selectedProvider.Value,
                //        //required
                //        keyUsages: '',
                //        commonName: '',
                //        patronimic: '',
                //        firstName: '',
                //        workPosition: '',
                //        workCompany: '',
                //        workSubDivision: '',
                //        //required
                //        registrationId: '',
                //        //required
                //        address: {
                //            country: 'UA',
                //            region: '',
                //            city: '',
                //            street: '',
                //            houseNumber: '',
                //            addition: ''
                //        },
                //        //required
                //        templateName: '',
                //        //required
                //        temolateOid: '',
                //        isUsePreventKeyForSign: 0,
                //        isPrintRequest: 0,
                //        //required
                //        hashCertSign: 0,
                //        clienUid: '',
                //        useSubjectEmail: 0,
                //        useExportKey: 0,
                //        cskClientId: '',
                //        dkeKeyAlgorithm: '',
                //        companyId: '',
                //        clientPolicyId: '',
                //        vegaId: '',
                //        certificatDescription: '',
                //        //required
                //        registratorId: '',
                //        isValidateTemplate: 0,
                //        //required
                //        keyType: 0,
                //        email: '',
                //        signedType: 2,
                //        //required
                //        cryptoProviderName: '',
                //        cryptoContainerName: 'OschadBankAcskKeys',
                //        friendlyCertifiateName: '',
                //        //required
                //        keySize: '',
                //        pkcs11LibraryName: '',
                //        accessKeySerialNumber: ''

                //    }

                //    var privateKeyParameters = acskService.getPrivateKeyParameters(keyOptions);
                //},
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

            vm.getCertificatesStatus = $scope.getCertificatesStatus = function (relCustId) {
                var user = vm.relCustsGridCorp2.dataSource.get(relCustId);

                if (!user.AcskRegistrationId) {
                    bars.ui.notify('Помилка',
                        'Клієнт не зареєстрований в АЦСК!',
                        'error');
                    return;
                }
                bars.ui.loader('body', true);
                acskService.getCertificatesStatus(relCustId, user.UserId, user.AcskRegistrationId).then(
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
                            'Виникла помилка при оновленні статусу сертифікатів. <small>' +
                            (response.Message || response.ErrorMessage || '') + '</small>',
                            'error');
                    }
                );
            }

            vm.generateTokenRequest = $scope.generateTokenRequest = function (id) {
                var user = vm.relCustsGridCorp2.dataSource.get(id);

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

            vm.userDetailWindowOptions = {
                width: '600px',
                height: '400px',
                title: ' ',
                modal: true,
                actions: ["Maximize", "Close"],
                close: function (e) {
                    vm.currentUser = new RelatedCustomer();
                    vm.custBirthDate.enable(true);
                    vm.custDocDate.enable(true);
                }
            }

            ///-CORP2-////////////////--C-O-R-P-2--///////////////////////////////////
            ////////////Corp2 Users//////////////////////////////////
            var relCustsDataSource = createDataSource({
                type: "webapi",
                transport: {
                    read: {
                        url: bars.config.urlContent('api/cdo/corp2/RelatedCustomers/'),
                        cache: false,
                        data: function () { return { custId: $('#custId').val() }; }
                    }
                },
                schema: {
                    model: {
                        id: 'Id',
                        fields: {
                            UserId: { type: "string" },
                            FirstName: { type: "string", editable: false },
                            LastName: { type: "string", editable: false },
                            SecondName: { type: "string", editable: false },
                            TaxCode: { type: 'string', editable: false },
                            CellPhone: { type: 'string', editable: false },
                            Email: { type: 'string', editable: false },
                            ApprovedType: { type: 'string', editable: false },
                            AcskRegistrationId: { type: "number", editable: false },
                            DocSeries: { type: 'string', editable: false },
                            DocNumber: { type: 'string', editable: false }
                        }
                    }
                }
            });
            vm.relCustsGridCorp2Options = createGridOptions({
                autoBind: false, //load data when tabstrip activated
                dataSource: relCustsDataSource,
                columns: [
                    {
                        title: ' ',
                        width: '60px',
                        template: function (data) {
                            var html = '';
                            html += "<button class='btn btn-default' ng-click=\"showEditUserForm("
                                + data.Id + ");\" title='Редагувати'><i class='fa fa-pencil fa-lg text-success'></i></button>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        title: 'Статус в Corp2',
                        width: '110px',
                        template: function (data) {
                            var html = '';
                            if (data.UserId && data.IsApproved) {
                                html += '<label style="width:15px; " class="text-' + (data.LockoutEnabled ? 'danger' : 'success') + '">\
                                                <i >' + (data.LockoutEnabled ? 'за' : 'роз') + 'блокований' + '</i>\
                                            </label>';
                            }
                            return html;
                        }
                    },{
                        title: 'ПІБ Користувача',
                        width: '280px',
                        template: function (data) {
                            var html = '';
                            html += '<a href="#" ng-click="viewUser(' + data.Id + ')" style="text-decoration: underline; color: steelblue;">'
                                + data.LastName + ' ' + data.FirstName + ' ' + data.SecondName + '</a>';
                            return html;
                        }
                    }, {
                        field: 'TaxCode',
                        title: 'ІПН',
                        width: '110px',
                        template: function (data) {
                            return data.TaxCode;
                        }
                    }, {
                        field: 'CellPhone',
                        title: 'Телефон',
                        width: '140px',
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'Email',
                        title: 'E-mail',
                        width: '250px'
                    }, {
                        title: 'Статус',
                        width: '150px',
                        template: function (data) {
                            var html = '';
                            switch (data.ApprovedType) {
                                case 'add':
                                    html += '<a href="#" class="label label-primary" style="display: inline-block; font-size: larger;" ng-click="open_userConnectionParamsWindow(' + data.Id + ')">новий</a>';
                                    break;
                                case 'update':
                                    html += '<a href="#" class="label label-warning" style="display: inline-block; font-size: larger;" ng-click="open_userConnectionParamsWindow(' + data.Id + ')">оновлено</a>';
                                    break;
                                case 'delete':
                                    html += '<h3><span class="label label-danger">видалено</span></h3>';
                                    break;
                                case 'rejected':
                                    html += '<a href="#" class="label label-default" style="display: inline-block; font-size: larger;" ng-click="open_userConnectionParamsWindow(' + data.Id + ')">відхилено</a>';
                                    break;
                                default:
                                    if (data.IsApproved) {
                                        html += '<a href="#" class="label label-success" style="display: inline-block; font-size: larger;" ng-click="open_userConnectionParamsWindow(' + data.Id + ')">підтверджено</a>';
                                    }
                            }
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        title: 'АЦСК',
                        //width: '200px',
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
                                        + 'ng-click="sendProfileToAcsk(' + data.Id + ',' + data.CustId + ');" '
                                        + 'title="Відправити дані клієнта в АЦСК">\
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
                                } else {

                                }
                            }
                            return html;
                        }
                    }
                ]
            });

            $scope.$on('CDO.Corp2.readCustomersGrid', function () {
                vm.relCustsGridCorp2.dataSource.read();
            });

            $scope.showUserForm = vm.showUserForm = function () {
                vm.currentUser = new RelatedCustomer();
                if (!vm.reatedCustomers) {
                    vm.reatedCustomers = [];
                    getCustomerRelatedCustomers(vm.currentUser.CustId);
                }
                vm.userDetailWindow.center().open();
            }
            $scope.showEditUserForm = vm.showEditUserForm = function (userId) {
                vm.currentUser = vm.relCustsGridCorp2.dataSource.get(userId);
                vm.currentUser.isReadOnly = false;
                vm.userDetailWindow.center().open();
            };
            $scope.viewUser = vm.viewUser = function (userId) {
                vm.SignNumber = null;
                vm.currentUser = vm.relCustsGridCorp2.dataSource.get(userId);
                vm.custBirthDate.enable(false);
                vm.custDocDate.enable(false);
                vm.currentUser.isReadOnly = true;
                vm.userDetailWindow.center().open();
            }

            //$scope.lockUser = vm.lockUser = function (userId) {
            //    bars.ui.loader('body', true);
            //    relatedCustomersService.blockUser(userId)
            //        .then(function (response) {
            //                bars.ui.loader('body', false);
            //                bars.ui.notify('Успішно', 'Користувача заблоковано', 'success');
            //                vm.relCustsGridCorp2.dataSource.read();
            //            },
            //            function (response) { bars.ui.loader('body', false); }
            //        );
            //}
            //$scope.unLockUser = vm.unLockUser = function (userId) {
            //    bars.ui.loader('body', true);
            //    relatedCustomersService.unblockUser(userId)
            //        .then(function (response) {
            //                bars.ui.loader('body', false);
            //                bars.ui.notify('Успішно', 'Користувача розблоковано', 'success');
            //                vm.relCustsGridCorp2.dataSource.read();
            //            },
            //            function (response) { bars.ui.loader('body', false); }
            //        );
            //}
            ////////////Corp2 Customer Accounts - db: V_CORP2_ACCOUNTS
            var custAccGridDataSource = createDataSource({
                type: "webapi",
                transport: {
                    read: {
                        url: bars.config.urlContent('api/cdo/corp2/getcustaccs/'),
                        cache: false,
                        data: function () { return { custId: $('#custId').val() }; }
                    }
                },
                schema: {
                    model: {
                        fields: {
                            BANK_ACC: { type: "number" },
                            CORP2_ACC: { type: "number" },
                            NUM_ACC: { type: 'string' },
                            NAME: { type: 'string' },
                            CODE_CURR: { type: "number" },
                            OPEN_DATE: { type: 'date' },
                            LAST_MOVE_DATE: { type: 'date' },
                            CLOSE_DATE: { type: 'date' },
                            REST_VIEW: { type: "number" },
                            DEB_TURNOVER_VIEW: { type: "number" },
                            KRED_TURNOVER_VIEW: { type: "number" },
                            EXECUTOR_NAME: { type: 'string' },
                            BRANCH: { type: 'string' },
                            BRANCH_NAME: { type: 'string' },
                            VISA_COUNT: { type: "number" }
                        }
                    }
                }
            });
            vm.custAccGridOptions = createGridOptions({
                dataSource: custAccGridDataSource,
                columns: [
                    {
                        title: 'Вигрузка',
                        width: '70px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = "<label class='btn'><input type='checkbox' name='unloadAcc' bankAcc='" + data.BANK_ACC + "'";
                            if (data.IS_CORP2_ACC) {
                                html += " checked disabled";
                            }
                            html += " /></label>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    },
                    {
                        field: 'BANK_ACC',
                        title: 'Код<br>рахунку<br>в АБС',
                        width: '100px'
                    }, {
                        field: 'CORP2_ACC',
                        title: 'Код<br>рахунку',
                        width: '80px'
                    }, {
                        field: 'NUM_ACC',
                        title: 'Номер<br>рахунку',
                        width: '120px'
                    }, {
                        field: 'NAME',
                        title: 'Найменування<br>рахунку',
                        width: '170px'
                    }, {
                        field: 'CODE_CURR',
                        title: 'Код<br>валюти',
                        width: '80px',
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'OPEN_DATE',
                        title: 'Дата<br>відкриття',
                        width: '100px',
                        format: "{0:dd.MM.yyyy}",
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'LAST_MOVE_DATE',
                        title: 'Дата<br>останнього<br>руху',
                        width: '101px',
                        format: "{0:dd.MM.yyyy}",
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'CLOSE_DATE',
                        title: 'Дата<br>закриття',
                        width: '100px',
                        format: "{0:dd.MM.yyyy}",
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'REST_VIEW',
                        title: 'Залишок',
                        width: '100px',
                        format: "{0:n2}",
                        attributes: { "class": "cell-horiz-align-right" }
                    }, {
                        field: 'DEB_TURNOVER_VIEW',
                        title: 'Дебетові<br>обороти',
                        width: '100px',
                        format: "{0:n2}",
                        attributes: { "class": "cell-horiz-align-right" }
                    }, {
                        field: 'KRED_TURNOVER_VIEW',
                        title: 'Кредитові<br>обороти',
                        width: '100px',
                        format: "{0:n2}",
                        attributes: { "class": "cell-horiz-align-right" }
                    }, {
                        field: 'EXECUTOR_NAME',
                        title: 'ПІБ<br>виконавця'
                        //width: '3px'
                    }, {
                        field: 'BRANCH',
                        title: 'Код<br>відділення',
                        width: '120px'
                    }, {
                        field: 'BRANCH_NAME',
                        title: 'Назва<br>відділення',
                        width: '170px'
                    }, {
                        title: 'Налаштування<br>віз по<br>рахунку',
                        width: '70px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = '';
                            if (data.IS_CORP2_ACC) {
                                html += "<button class='btn btn-default' ng-click='openCustAccVisaSettingWindow(" + data.NUM_ACC + ", " + data.BANK_ACC + ", " + data.CORP2_ACC + ", " + data.KF + ", " + data.VISA_COUNT + ")' title='Перегляд/редагування'><i class='fa fa-pencil fa-lg' style='color:green;'></i></button>";
                            }
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    }
                ]
            });

            vm.unloadCustomerAccountsToCorp2 = function () {
                var checkedAccs = $('input[name = "unloadAcc"]:checked');
                var accIdList = [];

                for (var i = 0; i < checkedAccs.length; i++) {
                    if (checkedAccs[i].disabled) continue;
                    accIdList.push(parseInt(checkedAccs[i].getAttribute('bankAcc')));
                }
                if (accIdList.length) {
                    bars.ui.loader('body', true);
                    relatedCustomersService.unloadCustomerAccountsToCorp2(accIdList).then(
                        function () {
                            bars.ui.loader('body', false);
                            bars.ui.notify('Успішно', 'Рахунки відправлено до Corp2', 'success');
                            vm.custAccGrid.dataSource.read();
                        },
                        function (response) {
                            bars.ui.error({ text: response });
                            bars.ui.loader('body', false);
                        }
                    );
                }
                else {
                    bars.ui.notify('Увага!', 'Відсутні рахунки для вигрузки. Всі відмічені рахунки раніше вже були відправлені до Corp2', 'success');
                }
            };

            ////////////Corp2 Customer Account Visa Setting///////////////
            vm.custAccVisaSettingWindowOptions = {
                width: '600px',
                height: '500px',
                title: 'Налаштування віз по рахунку',
                modal: true,
                actions: ["Maximize", "Close"],
                close: function () {
                    vm.currentCustomerAccount = null;
                }
            }
            $scope.openCustAccVisaSettingWindow = function openCustAccVisaSettingWindow(numAcc, bankAccId, corp2AccId, kf, visaQty) {
                vm.currentCustomerAccount = {};
                vm.currentCustomerAccount.NUM_ACC = numAcc;
                vm.currentCustomerAccount.BANK_ACC = bankAccId;
                vm.currentCustomerAccount.CORP2_ACC = corp2AccId;
                vm.currentCustomerAccount.KF = kf;
                vm.currentCustomerAccount.VISA_COUNT = visaQty || 1;
                vm.custAccVisaSettingGrid.dataSource.read();
                vm.custAccVisaSettingWindow.center().open();
            }
            var custAccVisaSettingWindowDataSource = createDataSource({
                type: "webapi",
                transport: {
                    read: {
                        url: bars.config.urlContent('api/cdo/corp2/getaccvisacounts'),
                        cache: false,
                        data: function () { return { accId: vm.currentCustomerAccount.BANK_ACC }; }
                    }
                },
                schema: {
                    model: {
                        id: 'Id',
                        fields: {
                            //ACC_ID: { type: "number" },
                            VISA_ID: { type: "number" },
                            COUNT: { type: "number" }
                        }
                    }
                }
            });

            vm.custAccVisaSettingGridOptions = createGridOptions({
                dataSource: custAccVisaSettingWindowDataSource,
                toolbar: [
                    {
                        name: "btAddVisa",
                        text: "Додати",
                        template: "<button class='btn btn-default' ng-click=\"openAddEditVisaWindow();\" title='Додати'><i class='fa fa-plus fa-lg text-success' style='margin-right:10px;'></i>Додати</button>"
                    }
                ],
                autoBind: false,
                filterable: false,
                sortable: false,
                dataBound: function (e) {
                    $.each(e.sender._data, function (i, el) { el.CORP2_ACC_ID = vm.currentCustomerAccount.CORP2_ACC; });
                    bars.ext.kendo.grid.noDataRow(e);
                },
                columns: [
                    {
                        field: 'Edit',
                        title: 'Налаштування',
                        width: '65px',
                        template: function (data) {
                            var html = '';
                            html += "<button class='btn btn-default' ng-click=\"openAddEditVisaWindow("
                                + data.Id + ");\" title='Редагувати'><i class='fa fa-pencil fa-lg text-success'></i></button>";
                            html += "<button class='btn btn-default' style='margin-left: 5px;' ng-click=\"deleteVisa("
                                + data.Id + ");\" title='Видалити'><i class='fa fa-trash-o fa-lg text-danger'></i></button>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    //}, {
                    //    field: 'ACC_ID',
                    //    title: 'Номер рахунку',
                    //    width: '80px'
                    }, {
                        field: 'VISA_ID',
                        title: 'Рівень візи',
                        width: '70px',
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'COUNT',
                        title: 'Кількість віз рівня',
                        width: '90px',
                        attributes: { "class": "cell-horiz-align-center" }
                    }
                ]
            });
            $scope.saveVisaQuantity = vm.saveVisaQuantity = function () {
                if (!vm.currentCustomerAccount.VISA_COUNT) { //від 1 до 99
                    bars.ui.error({ text: 'Вкажіть кількість віз' });
                    return;
                }
                var form = $('#custAccVisaSettingForm');
                bars.ui.loader(form, true);
                relatedCustomersService.saveAccountVisaQuantity(vm.currentCustomerAccount)
                    .then(function (response) {
                        bars.ui.loader(form, false);
                        bars.ui.notify('Успішно',
                            'Налаштування віз по рахунку збережено успішно',
                            'success');
                        vm.custAccGrid.dataSource.read();
                        vm.custAccVisaSettingWindow.close();
                    },
                    function (response) {
                        bars.ui.loader(form, false);
                        bars.ui.notify('Помилка',
                            'Виникла при збереженні налаштувань віз по рахунку. <small>' +
                            (response.Message || response.ErrorMessage || '') + '</small>',
                            'error');
                    }
                    );
            }

            $scope.openAddEditVisaWindow = function openAddEditVisaWindow(rowId) {
                //Edit
                if (rowId) {
                    vm.currentAccountVisa = vm.custAccVisaSettingGrid.dataSource.get(rowId);
                    vm.currentAccountVisa.ACC_ID = vm.currentCustomerAccount.BANK_ACC;
                    vm.currentAccountVisa.NUM_ACC = vm.currentCustomerAccount.NUM_ACC;
                    vm.currentAccountVisa.Old_VISA_ID = vm.currentAccountVisa.VISA_ID;
                    vm.currentAccountVisa.EditMode = true;
                }
                //Add
                else {
                    vm.currentAccountVisa = {
                        Id: 0,
                        NUM_ACC: vm.currentCustomerAccount.NUM_ACC,
                        ACC_ID: vm.currentCustomerAccount.BANK_ACC,
                        CORP2_ACC_ID: vm.currentCustomerAccount.CORP2_ACC,
                        VISA_ID: 1,
                        Old_VISA_ID: 1,
                        COUNT: 1
                    };
                    vm.currentAccountVisa.EditMode = false;
                }

                vm.addEditVisaWindow.center().open();
            }

            $scope.deleteVisa = function deleteVisa(rowId) {
                var form = $('#custAccVisaSettingForm');
                bars.ui.loader(form, true);
                var item = vm.custAccVisaSettingGrid.dataSource.get(rowId);
                relatedCustomersService.deleteVisa(item).then(
                    function (response) {
                        bars.ui.loader(form, false);
                        bars.ui.notify('Успішно',
                            'Видалено',
                            'success');
                        vm.custAccVisaSettingGrid.dataSource.read();
                    },
                    function (response) {
                        bars.ui.loader(form, false);
                        bars.ui.notify('Помилка',
                            'Виникла при видаленні. <small>' +
                            (response.Message || response.ErrorMessage || '') + '</small>',
                            'error');
                    });
            }

            $scope.addEditVisa = vm.addEditVisa = function addEditVisa() {
                //if (!$scope.addEditVisaForm.$valid) {
                //    bars.ui.notify('Помилка',
                //        'Заповніть поля. Поля приймають тільки числові значення.',
                //        'error');
                //    return;
                //}
                if (!vm.currentAccountVisa.VISA_ID) { //від 1 до 9
                    bars.ui.error({ text: 'Вкажіть рівень візи' });
                    return;
                }
                if (!vm.currentAccountVisa.COUNT) { //від 1 до 99
                    bars.ui.error({ text: 'Вкажіть кількість віз рівня' });
                    return;
                }
                var form = $('#addEditVisaForm');
                bars.ui.loader(form, true);

                relatedCustomersService.addEditVisa(vm.currentAccountVisa).then(
                    function (response) {

                        bars.ui.loader(form, false);
                        bars.ui.notify('Успішно',
                            'Додано / Відредаговано',
                            'success');
                        vm.custAccVisaSettingGrid.dataSource.read();
                        vm.addEditVisaWindow.close();
                    },
                    function (response) {
                        bars.ui.loader(form, false);
                        //bars.ui.notify('Помилка',
                        //    'Виникла при додаванні / редагуванні. <small>' +
                        //    (response.Message || response.ErrorMessage || '') + '</small>',
                        //    'error');
                    });
            }

            ////////////Corp2 User Connection Params Setting////////////

            vm.userConnectionParamsWindow_Options = {
                //width: '600px',
                //height: '400px',
                title: 'Налаштування користувача Корп2',
                modal: true,
                actions: ["Maximize", "Close"],
                close: function () {
                    vm.userConnectionParamsWindow_Model = null;
                    vm.userConnectionParamsWindow_LimitModel = null;
                    vm.currentUserId = null;
                    //clear grids
                    vm.corp2_UserConnParamsWindow_AccsGrid.dataSource.data([]);
                    vm.corp2_UserConnParamsWindow_availableModulesGrid.dataSource.data([]);
                    vm.corp2_UserConnParamsWindow_userModulesGrid.dataSource.data([]);
                    vm.corp2_UserConnParamsWindow_userFuncsGrid.dataSource.data([]);
                    vm.corp2_UserConnParamsWindow_availableFuncsGrid.dataSource.data([]);
                    vm.ModuleName = null;
                    allUserFuncs.length = 0;
                    allAvailableFuncs.length = 0;
                    //$scope.$apply();
                    //vm.custCreatedDate.enable(true);
                    //vm.custBirthDate.enable(true);
                    //vm.custDocDate.enable(true);
                }
            }

            $scope.open_userConnectionParamsWindow = vm.open_userConnectionParamsWindow = function (id) {
                vm.currentUserId = id;
                initUserConnectionParamsWindow(id);
                vm.userConnectionParamsWindow.center().open();
            }

            function initUserConnectionParamsWindow(userId) {

                vm.userConnectionParamsWindow_Model = vm.relCustsGridCorp2.dataSource.get(userId);
                if (!limitDictionary) {
                    relatedCustomersService.getLimitDictionary().then(
                        function (response) { limitDictionary = response; },
                        function (response1) { bars.ui.notify('Помилка', 'Сталася помилка при отриманні словника лімітів', 'error'); }
                    );
                }

                relatedCustomersService.getUserLimit(userId).then(
                    function (response1) { vm.userConnectionParamsWindow_LimitModel = response1; },
                    function (response1) { bars.ui.notify('Помилка', 'Сталася помилка при отриманні лімітів по користувачу', 'error'); }
                );
                vm.corp2_UserConnParamsWindow_AccsGrid.dataSource.read();
                vm.corp2_UserConnParamsWindow_availableModulesGrid.dataSource.read();
                vm.corp2_UserConnParamsWindow_userModulesGrid.dataSource.read();

                relatedCustomersService.getAvailableFuncs(userId).then(
                    function (response2) { allAvailableFuncs = response2; },
                    function (response2) { bars.ui.notify('Помилка', 'Сталася помилка при отриманні доступних до видачі функцій', 'error'); }
                );
                relatedCustomersService.getUserFuncs(userId).then(
                    function (response3) { allUserFuncs = response3; },
                    function (response3) { bars.ui.notify('Помилка', 'Сталася помилка при отриманні доступних функцій по користувачу', 'error'); }
                );
            }

            $scope.saveUserConnectionParamsWindow = vm.saveUserConnectionParamsWindow = function () {
                var error = validateUserConnectionParamsWindow();
                if (error) {
                    bars.ui.error({ text: 'Не заповнені обов\'язкові поля:<br><br>' + error });
                    return;
                }
                var form = $('#connParamsWindowForm');
                bars.ui.loader(form, true);
                relatedCustomersService.saveUserConnectionParamsWindow(
                    vm.userConnectionParamsWindow_Model,
                    vm.userConnectionParamsWindow_LimitModel,
                    vm.corp2_UserConnParamsWindow_userModulesGrid.dataSource.view(),
                    allUserFuncs,
                    getAccsSettinsForSave()
                ).then(function (response) {
                    bars.ui.loader(form, false);
                    bars.ui.notify('Успішно',
                        'Налаштування користувача збережено успішно',
                        'success');
                    vm.relCustsGridCorp2.dataSource.read();
                    vm.userConnectionParamsWindow.close();
                },
                    function (response) {
                        bars.ui.loader(form, false);
                    }
                    );
            };
            function validateUserConnectionParamsWindow() {
                var limit = vm.userConnectionParamsWindow_LimitModel;
                if (!vm.userConnectionParamsWindow_Model.SignNumber) return 'вкажіть номер візи';
                if (!vm.userConnectionParamsWindow_Model.SequentialVisa) return 'вкажіть послідовність візи';
                if (!limit.DOC_SUM && limit.DOC_SUM != 0) return 'вкажіть суму документів введених за день';
                if (!limit.DOC_CREATED_COUNT && limit.DOC_CREATED_COUNT != 0) return 'вкажіть кількість документів введених за день';
                if (!limit.DOC_SENT_COUNT && limit.DOC_SENT_COUNT != 0) return 'вкажіть кількість документів відправлених в банк за день';
            }
            //----------Limits
            $scope.setLimitSettingsByType = vm.setLimitSettingsByType = function () {
                if (!limitDictionary) return;
                var settings = limitDictionary[vm.userConnectionParamsWindow_LimitModel.LIMIT_ID];
                vm.userConnectionParamsWindow_LimitModel.DOC_SUM = settings.DOC_SUM;
                vm.userConnectionParamsWindow_LimitModel.DOC_CREATED_COUNT = settings.DOC_CREATED_COUNT;
                vm.userConnectionParamsWindow_LimitModel.DOC_SENT_COUNT = settings.DOC_SENT_COUNT;
            }
            //----------Accounts
            var corp2_UserConnParamsWindow_AccsGrid_DataSource = createDataSource({
                type: "webapi",
                transport: {
                    read: {
                        url: bars.config.urlContent('api/cdo/corp2/getcorp2useraccspermissions'),
                        cache: false,
                        data: function () { return { custId: $('#custId').val(), userId: vm.currentUserId }; }
                    }
                },
                schema: {
                    model: {
                        id: 'Id',
                        fields: {
                            CAN_WORK: { type: "boolean" },
                            CAN_VIEW: { type: "boolean" },
                            CAN_DEBIT: { type: "boolean" },
                            CAN_VISA: { type: "boolean" },
                            CORP2_ACC: { type: "number" },

                            //кількість
                            VISA_ID: { type: "number" },
                            SEQUENTIAL_VISA: { type: "boolean" },
                            KF: { type: "string" },
                            KV: { type: "string" },
                            NUM_ACC: { type: "string" },
                            NAME: { type: "string" }
                        }
                    }
                }
            });
            vm.corp2_UserConnParamsWindow_AccsGridOptions = createGridOptions({
                dataSource: corp2_UserConnParamsWindow_AccsGrid_DataSource,
                autoBind: false,
                columns: [
                    {
                        field: 'CAN_WORK',
                        title: ' ',
                        width: '50px',
                        filterable: false,
                        sortable: false,
                        headerTemplate: "<label class='btn' ng-click='switchUserAccCheckBoxes()' title='Вибрати всі'><input type='checkbox' id='accHeaderChbx'/></label>",
                        template: function (data) {
                            var html = "<label class='btn'><input type='checkbox' fieldName='CAN_WORK'";
                            if (data.CAN_WORK) html += ' checked';
                            html += " /></label>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    },
                    {
                        field: 'CAN_VIEW',
                        title: 'Виписка',
                        width: '55px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = "<label class='btn'><input type='checkbox' fieldName='CAN_VIEW'";
                            if (data.CAN_VIEW) html += ' checked';
                            html += " /></label>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'CAN_DEBIT',
                        title: 'Дебет',
                        width: '50px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = "<label class='btn'><input type='checkbox' fieldName='CAN_DEBIT'";
                            if (data.CAN_DEBIT) html += ' checked';
                            html += " /></label>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'CAN_VISA',
                        title: 'Віза',
                        width: '50px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = "<label class='btn'><input type='checkbox' fieldName='CAN_VISA'";
                            if (data.CAN_VISA) html += ' checked';
                            html += " /></label>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'VISA_ID',
                        title: '№ візи',
                        width: '50px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = "<input fieldName='VISA_ID' kendo-numeric-text-box k-min='1' k-max='9' data-k-format=\"'n0'\" class='k-input w-100' value='" + (data.VISA_ID || vm.userConnectionParamsWindow_Model.SignNumber) + "'/>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'SEQUENTIAL_VISA',
                        title: 'Послідовна',
                        width: '70px',
                        filterable: false,
                        sortable: false,
                        template: function (data) {
                            var html = "<label class='btn'><input type='checkbox' fieldName='SEQUENTIAL_VISA'";
                            if (data.SEQUENTIAL_VISA) html += ' checked';
                            html += " /></label>";
                            return html;
                        },
                        attributes: { "class": "cell-horiz-align-center" }
                    }, {
                        field: 'NUM_ACC',
                        title: 'Рахунок',
                        width: '120px'
                    }, {
                        field: 'NAME',
                        title: 'Найменування',
                        width: '180px'
                    }
                ]
            });
            $scope.switchUserAccCheckBoxes = vm.switchUserAccCheckBoxes = function () {
                var chexkBoxes = document.querySelectorAll('input[fieldName = "CAN_WORK"]');
                var checked = document.getElementById('accHeaderChbx').checked;
                $(chexkBoxes).each(function (i, e) { e.checked = checked; });
            }
            function getAccsSettinsForSave() {
                var rowModels = vm.corp2_UserConnParamsWindow_AccsGrid.dataSource.data();
                var accsSettings = [];
                for (var i = 0; i < rowModels.length; i++) {
                    //var modelUID = rowModels[i].get("uid");
                    //var tableRow = $("[data-uid='" + modelUID + "']");
                    //var cells = tableRow[0].cells;

                    var accSetiingsItem = {};
                    //for (var j = 0; j < cells.length; j++) {
                    //    var cell = cells[j].firstChild;
                    //    var fieldValue;
                    //    if (cell && cell.nodeName == 'LABEL') {
                    //        cell = cell.firstChild;
                    //        if (cell /*&& cell.nodeName == 'INPUT' */ && cell.type == 'checkbox') {
                    //            fieldValue = cell.checked;
                    //            //if (cell.getAttribute('fieldName') == 'CAN_WORK' && !fieldValue) break; // не додаємо не вибрані рахунки (CAN_WORK - false)
                    //        }
                    //    }
                    //    else if (cell && cell.nodeName == 'SPAN') {
                    //        cell = cell.firstChild;
                    //        if (cell && cell.nodeName == 'SPAN') {
                    //            cell = cell.children[1];
                    //            if (cell /*&& cell.nodeName == 'INPUT' */ && cell.type == 'text') {
                    //                fieldValue = cell.value;
                    //            }
                    //        }
                    //    }
                    //    else continue;

                    //    if (cell) {
                    //        var fieldName = cell.getAttribute('fieldName');
                    //        accSetiingsItem[fieldName] = fieldValue;
                    //    }

                    //}
                    //if (!$.isEmptyObject(accSetiingsItem)) {

                    accSetiingsItem.CAN_WORK = $("[fieldName='CAN_WORK']")[i].checked;
                    accSetiingsItem.CAN_VIEW = $("[fieldName='CAN_VIEW']")[i].checked;
                    accSetiingsItem.CAN_DEBIT = $("[fieldName='CAN_DEBIT']")[i].checked;
                    accSetiingsItem.CAN_VISA = $("[fieldName='CAN_VISA']")[i].checked;
                    accSetiingsItem.VISA_ID = $("[fieldName='VISA_ID']")[i].value;
                    accSetiingsItem.SEQUENTIAL_VISA = $("[fieldName='SEQUENTIAL_VISA']")[i].checked;
                    accSetiingsItem.KF = rowModels[i].KF;
                    accSetiingsItem.KV = rowModels[i].KV;
                    accSetiingsItem.NUM_ACC = rowModels[i].NUM_ACC;
                    accSetiingsItem.CORP2_ACC = rowModels[i].CORP2_ACC;
                    accsSettings.push(accSetiingsItem);
                    //}
                }
                $.each(accsSettings, function (i, el) {
                    if (/^[^1-9]$/.test(el.VISA_ID)) el.VISA_ID = vm.userConnectionParamsWindow_Model.SignNumber;
                });
                return accsSettings;
            }

            //----------Modules & Functions
            var allUserFuncs;
            var allAvailableFuncs;

            vm.corp2_UserConnParamsWindow_userModulesGridOptions = createGridOptions({
                dataSource: createDataSource({
                    type: "webapi",
                    transport: {
                        read: {
                            //async: false,
                            url: bars.config.urlContent('api/cdo/corp2/getusermodules'),
                            cache: false,
                            data: function () { return { userId: vm.currentUserId }; }
                        }
                    },
                    schema: {
                        model: {
                            id: 'Id',
                            fields: { Name: { type: "string" } }
                        }
                    }
                }),
                editable: "popup",
                selectable: "multiple, row",
                pageable: false,
                autoBind: false,
                filterable: false,
                sortable: false,
                columns: [{
                    field: 'Name',
                    title: 'Перелік виданих модулів',
                    width: '200px'
                }],
                change: function (e) {
                    var selectedRows = this.select();
                    if (selectedRows.length != 1) return;
                    var dataItem = this.dataItem(selectedRows[0]);
                    vm.ModuleName = dataItem.Name;
                    initFuncsGrids(dataItem.id);
                }
            });
            vm.corp2_UserConnParamsWindow_availableModulesGridOptions = createGridOptions({
                dataSource: createDataSource({
                    type: "webapi",
                    transport: {
                        read: {
                            url: bars.config.urlContent('api/cdo/corp2/getavailablemodules'),
                            cache: false,
                            data: function () { return { userId: vm.currentUserId }; }
                        }
                    },
                    schema: {
                        model: {
                            id: 'Id',
                            fields: { Name: { type: "string" } }
                        }
                    }
                    //pageSize: 10,
                    //page: 1,
                    //total: 0
                }),
                //height: 50,
                filterable: false,
                sortable: false,
                pageable: false,
                editable: "popup",
                selectable: "multiple, row",
                autoBind: false,
                columns: [{
                    field: 'Name',
                    title: 'Перелік доступних до видачі модулів',
                    width: '200px'
                }]
            });

            $scope.copySelectedToAvailableModulesGrid = vm.copySelectedToAvailableModulesGrid = function () {
                var selected = vm.corp2_UserConnParamsWindow_userModulesGrid.select();
                //Видаляємо функції користувача по видаленому модулю та заносимо їх до переліку всіх доступних функцій
                $.each(selected, function (idx, elem) {
                    elem = vm.corp2_UserConnParamsWindow_userModulesGrid.dataItem(elem);
                    allAvailableFuncs = allAvailableFuncs.concat(allUserFuncs.filter(function (el) { return el.ModuleId == elem.id; }));
                    allUserFuncs = allUserFuncs.filter(function (el) { return el.ModuleId != elem.id; });
                });

                moveBetweenGrids(vm.corp2_UserConnParamsWindow_userModulesGrid, vm.corp2_UserConnParamsWindow_availableModulesGrid);
                vm.ModuleName = null;
                initFuncsGrids();
            };
            $scope.copySelectedToUserModulesGrid = vm.copySelectedToUserModulesGrid = function () {
                moveBetweenGrids(vm.corp2_UserConnParamsWindow_availableModulesGrid, vm.corp2_UserConnParamsWindow_userModulesGrid);
                vm.ModuleName = null;
                initFuncsGrids();
            };

            vm.corp2_UserConnParamsWindow_userFuncsGridOptions = createGridOptions({
                editable: "popup",
                selectable: "multiple, row",
                filterable: false,
                sortable: false,
                pageable: false,
                //autoBind: false,
                columns: [{
                    field: 'Name',
                    title: 'Перелік виданих функцій',
                    width: '200px'
                }]
            });
            vm.corp2_UserConnParamsWindow_availableFuncsGridOptions = createGridOptions({
                editable: "popup",
                selectable: "multiple, row",
                filterable: false,
                sortable: false,
                pageable: false,
                //autoBind: false,
                columns: [{
                    field: 'Name',
                    title: 'Перелік доступних до видачі функцій',
                    width: '200px'
                }]
            });

            $scope.copySelectedToAvailableFuncsGrid = vm.copySelectedToAvailableFuncsGrid = function () {
                var selected = vm.corp2_UserConnParamsWindow_userFuncsGrid.select();
                if (selected.length > 0) {
                    $.each(selected, function (idx, elem) {
                        elem = vm.corp2_UserConnParamsWindow_userFuncsGrid.dataItem(elem);
                        allAvailableFuncs = allAvailableFuncs.concat(allUserFuncs.filter(function (el) { return el.Id == elem.Id }));
                        allUserFuncs = allUserFuncs.filter(function (el) { return el.Id != elem.Id });
                    });
                }
                moveBetweenGrids(vm.corp2_UserConnParamsWindow_userFuncsGrid, vm.corp2_UserConnParamsWindow_availableFuncsGrid);
            };
            $scope.copySelectedToUserFuncsGrid = vm.copySelectedToUserFuncsGrid = function () {
                var selected = vm.corp2_UserConnParamsWindow_availableFuncsGrid.select();
                if (selected.length > 0) {
                    $.each(selected, function (idx, elem) {
                        elem = vm.corp2_UserConnParamsWindow_availableFuncsGrid.dataItem(elem);
                        allUserFuncs = allUserFuncs.concat(allAvailableFuncs.filter(function (el) { return el.Id == elem.Id }));
                        allAvailableFuncs = allAvailableFuncs.filter(function (el) { return el.Id != elem.Id });
                    });
                }
                moveBetweenGrids(vm.corp2_UserConnParamsWindow_availableFuncsGrid, vm.corp2_UserConnParamsWindow_userFuncsGrid);
            };

            function initFuncsGrids(moduleId) {
                var availableFuncs = allAvailableFuncs.filter(function (el) { return el.ModuleId == moduleId; });
                var userFuncs = allUserFuncs.filter(function (el) { return el.ModuleId == moduleId; });
                var availableFuncsDS = new kendo.data.DataSource({
                    data: availableFuncs,
                    schema: {
                        model: {
                            id: 'Id',
                            fields: {
                                Name: { type: "string" },
                                ModuleId: { type: "string" }
                            }
                        }
                    }
                });
                var userFuncsDS = new kendo.data.DataSource({
                    data: userFuncs,
                    schema: {
                        model: {
                            id: 'Id',
                            fields: {
                                Name: { type: "string" },
                                ModuleId: { type: "string" }
                            }
                        }
                    }
                });
                vm.corp2_UserConnParamsWindow_availableFuncsGrid.setDataSource(availableFuncsDS);
                vm.corp2_UserConnParamsWindow_userFuncsGrid.setDataSource(userFuncsDS);
            };

            function moveBetweenGrids(from, to) {
                var selected = from.select();
                if (selected.length > 0) {
                    var items = [];
                    $.each(selected, function (idx, elem) {
                        items.push(from.dataItem(elem));
                    });
                    var fromDS = from.dataSource;
                    var toDS = to.dataSource;
                    $.each(items, function (idx, elem) {
                        toDS.add({ Id: elem.Id, Name: elem.Name });
                        fromDS.remove(elem);
                    });
                    toDS.sync();
                    fromDS.sync();
                }
            }

            // private helpers
            function extend(src, dst) {
                for (var key in src) {
                    if (src[key] === null || src[key] instanceof Array || ["number", "boolean", "string", "function", "undefined"].indexOf(typeof src[key]) !== -1) {
                        dst[key] = src[key];
                    }
                    else {
                        if (!dst.hasOwnProperty(key)) { dst[key] = {}; }
                        extend(src[key], dst[key]);
                    }
                }
            }

            function createDataSource(ds) {
                var _ds = {
                    type: "aspnetmvc-ajax",
                    pageSize: 12,
                    serverPaging: true,
                    serverFiltering: true,
                    serverSorting: true,
                    transport: {
                        read: {
                            type: "GET",
                            dataType: "json",
                            url: ""
                        }
                    },
                    requestStart: function () { bars.ui.loader("body", true); },
                    requestEnd: function (e) { bars.ui.loader("body", false); },
                    schema: {
                        data: "Data",
                        total: "Total",
                        errors: "Errors",
                        model: { fields: {} }
                    }
                };

                extend(ds, _ds);

                return _ds;
            }

            function createGridOptions(go) {
                var _go = {
                    autoBind: true,
                    resizable: true,
                    selectable: "row",
                    scrollable: true,
                    sortable: true,
                    pageable: {
                        messages: {
                            allPages: "Всі"
                        },
                        refresh: true,
                        pageSizes: [10, 50, 200, 1000, "All"],
                        buttonCount: 5
                    },
                    filterMenuInit: function (e) { e.container.addClass("widerMenu"); },        // resize filter menu
                    reorderable: true,
                    change: function () {
                        var grid = this;
                        var row = grid.dataItem(grid.select());
                    },

                    columns: [],
                    filterable: true,
                    dataBound: function (e) {
                        bars.ext.kendo.grid.noDataRow(e);
                    },
                    dataBinding: function () { }
                };

                extend(go, _go);

                return _go;
            }
        }
    ]);