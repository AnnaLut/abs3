'use strict';
angular.module(globalSettings.modulesAreas)
    .factory('CDO.CorpLight.AcskService',
        ['$http', '$q',
        function ($http, $q) {

            var _url = bars.config.urlContent('/api/cdo/corpLight/relatedCustomers/');
            var state = {
                lastUpdate: null,
                isLoading: false,
                error: null
            };
            var factory = {};

            var secret = VegaCrypto("ЦСК АТ", false, false, "");

            var signData = function (data) {
                var pkcs7 = secret.signData("",
                                            "",
                                            data,
                                            false);

                if (pkcs7 == 'canceled') {
                    return '';
                }
                return pkcs7;
            }
                        

            var _getRules = function (registrationId) {
                state.isLoading = true;
                var rules = '<rules registrationId="' + registrationId + '"></rules>';

                var deferred = $q.defer();
                var signedData = signData(secret.base64Encode(rules));
                if (signedData && signedData !== 'canceled') {

                    $http.post(bars.config.urlContent('/api/cdo/CorpLight/UserCertificate/getRules'),
                        { signedData: signedData })
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                } else {
                    deferred.resolve([]);
                }
                return deferred.promise;
            }

            var _enrollRequest = function (relCustId, subjectData) {
                state.isLoading = true;

                var pkcs10 = secret.enrollRequest(subjectData.Subject, false, false);
                debugger;
                var enroll =
                    '<enroll templateId="' + subjectData.TemplateId + '" registrationId="' + subjectData.RegistrationId + '">';
                //enroll += JSON.stringify(pkcs10);
                enroll += pkcs10.pkcs10;
                enroll += '</enroll>';


                var deferred = $q.defer();
                var signedData = signData(secret.base64Encode(enroll));
                if (signedData && signedData !== 'canceled') {

                    $http.post(bars.config.urlContent('/api/cdo/CorpLight/UserCertificate/enrollRequest/' + relCustId),
                        { signedData: signedData })
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                } else {
                    deferred.resolve([]);
                }
                return deferred.promise;
            }

            var _getSubject = function (registrationId, templateId, providerId) {
                state.isLoading = true;

                var subject = '<subject templateId="' + templateId + '"'
                            + ' registrationId="' + registrationId + '"'
                            + ' providerId="' + providerId + '">';
                subject += '</subject>';

                var deferred = $q.defer();
                var signedData = signData(secret.base64Encode(subject));
                if (signedData && signedData !== 'canceled') {

                    $http.post(bars.config.urlContent('/api/cdo/CorpLight/UserCertificate/getSubject'),
                        { signedData: signedData })
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                } else {
                    deferred.resolve([]);
                }
                return deferred.promise;
            }


            var _getCertificatesStatus = function (relCustId, registrationId) {
                state.isLoading = true;

                var requests = '<requests registrationId="' + registrationId + '"></requests>';

                var deferred = $q.defer();
                var signedData = signData(secret.base64Encode(requests));
                if (signedData && signedData !== 'canceled') {

                    $http.post(bars.config.urlContent('/api/cdo/CorpLight/UserCertificate/getSertificatesStatus/' + relCustId),
                        { signedData: signedData })
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                } else {
                    deferred.resolve([]);
                }
                return deferred.promise;
            }

            var _sendProfileToAcsk = function (relCustId, custId) {
                state.isLoading = true;

                var deferred = $q.defer();
                $http.post(bars.config.urlContent('/api/cdo/CorpLight/UserCertificate/sendToAcsk/') + relCustId + '/' + custId)
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }

            var _changeCertificateState = function (relCustId, registrationId, cerialNumber, newId, comment) {
                state.isLoading = true;
                
                var stateReq = '<state registrationId="' + registrationId + '" '
                    + 'serialNumber="' + cerialNumber + '" newState="' + newId + '">';
                stateReq += comment;
                stateReq += '</state>';

                var deferred = $q.defer();
                var signedData = signData(secret.base64Encode(stateReq));
                if (signedData && signedData !== 'canceled') {

                    $http.post(bars.config.urlContent('/api/cdo/CorpLight/UserCertificate/changeState/' + relCustId),
                        { signedData: signedData })
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                } else {
                    deferred.resolve([]);
                }
                return deferred.promise;
            }

            var _displayCertificate = function (base64Crt) {
                return secret.displayCertificate(base64Crt);
            }

            var _installCertificate = function (base64Crt) {
                return secret.installCertificate(base64Crt);
            }

            var _parseBase64Crt = function (base64crt) {
                state.isLoading = true;

                var deferred = $q.defer();
                $http.post(bars.config.urlContent('/cdo/CorpLight/home/parseBase64Crt'), { Base64crt: base64crt })
                    .success(function (response) {
                        state.isLoading = false;
                        deferred.resolve(response);
                    }).error(function (response) {
                        state.isLoading = false;
                        deferred.reject(response);
                    });
                return deferred.promise;
            }


            var _getPrivateKeyParameters = function (options) {
                var params = angular.extend(options, {
                    //required
                    oid: '', //oid, використовуваний для ідентифікації стартового сертифіката
                    //required
                    algorithm: '', //тип алгоритму ключа, визначається (1-ДСТУ-4145-2002, 2-RSA, 3- ECDSA)
                    //required
                    keyUsages: '', //тип використання ключа (keyUsages);
                    commonName: '', //Загальне ім’я
                    patronimic: '', //по-батькові, якщо визначено шаблоном
                    firstName: '', //ім'я клієнта, якщо визначено шаблоном
                    workPosition: '', //місце роботи, - посада
                    workCompany: '', //місце роботи, - компанія
                    workSubDivision: '', //місце роботи, -підролділ1, підрозділ2, підрозділ3
                    //required
                    registrationId: '', //реєстраційний номер користувача
                    //required
                    address: {//країна - "UA" , регіон, адреса
                        country: 'UA',
                        region: '',
                        city: '',
                        street: '',
                        houseNumber: '',
                        addition: ''
                    },
                    //required
                    templateName: '', //назва шаблону
                    //required
                    temolateOid: '', //oid шаблону
                    isUsePreventKeyForSign: 0, //використовувати підпис попереднім ключем клієнта
                    isPrintRequest: 0, //Якщо =1, то друк запиту безпосередньо на клієнтському АРМ до передачі  на сервер
                    //required
                    hashCertSign: 0, //Алгоритм геш, що використовується
                    clienUid: '', //UID клієнта
                    useSubjectEmail: 0, //Якщо =1, то використовувати адресу електронної пошти
                    useExportKey: 0, //Якщо =1, то встановити можлтвість експорту ключа
                    cskClientId: '', //Ідентифікатор Клієнта ЦСК
                    dkeKeyAlgorithm: '', //ДКЕ алгоритму ДСТУ-2002-4145
                    companyId: '', //Реєстровий номер компанії 
                    clientPolicyId: '', //Ідентифікатор політик клієнта
                    vegaId: '', //Ідентифікатор VEGAID
                    certificatDescription: '', //Інформація в полі DESCRIPTION сертифіката
                    //required
                    registratorId: '', //Реєстраційний номер Реєстратора, що підпише запит 
                    isValidateTemplate: 0, //Якщо =1, то перевіряти співпадіння шаблона сертифіката з шаблоном сертифіката підпису
                    //required
                    keyType: 0, //Тип ключа
                    email: '', //Електронна пошта Клієнта. Допускається декілька адрес, розділених комою
                    signedType: 2, //1-Підпис  власним сертифікатом, 2-Підпис запиту стартовим сертифікатом 
                    //required
                    cryptoProviderName: '', //Назва криптопровайдера
                    cryptoContainerName: 'OschadBankAcskKeys', //Ім’я контейнера ключа (опціонально)
                    friendlyCertifiateName: '', //Дружнє імя сертифіката
                    //required
                    keySize: '', //Розмір приватного ключа
                    pkcs11LibraryName: '', //Назва бібліотеки PKCS11 криптопровайдера, якщо виконується контроль носіїв ключів 
                    accessKeySerialNumber: '' //Перелік серійних носіїв ключів, дозволених користувачу для користування
                });

                return params.oid + '\f'
                    + params.algorithm + '\f'
                    + params.keyUsages + '\f'
                    + params.commonName + '\f'
                    + params.patronimic + '\f'
                    + params.firstName + '\f'
                    + params.workPosition + '\f'
                    + params.workCompany + '\f'
                    + params.workSubDivision + '\f'
                    + params.registrationId + '\f'
                        + params.address.country + '\t'
                        + params.address.region + '\t'
                        + params.address.city + '\t'
                        + params.address.street + '\t'
                        + params.address.houseNumber + '\t'
                        + params.address.addition + '\f'
                    + params.templateName + '\f'
                    + params.temolateOid + '\f'
                    + params.isUsePreventKeyForSign + '\f'
                    + params.isPrintRequest + '\f'
                    + params.hashCertSign + '\f'
                    + params.clienUid + '\f'
                    + params.useSubjectEmail + '\f'
                    + params.useExportKey + '\f'
                    + params.cskClientId + '\f'
                        + params.dkeKeyAlgorithm + '\f'
                    + params.companyId + '\f'
                    + params.clientPolicyId + '\f'
                    + params.vegaId + '\f'
                    + params.certificatDescription + '\f'
                    + params.registratorId + '\f'
                    + params.isValidateTemplate + '\f'
                    + params.keyType + '\f'
                    + params.email + '\f'
                    + params.signedType + '\f'
                    + params.cryptoProviderName + '\f'
                    + params.cryptoContainerName + '\f'
                    + params.friendlyCertifiateName + '\f'
                    + params.keySize + '\f'
                    + params.pkcs11LibraryName + '\f'
                    + params.accessKeySerialNumber + '\f';
            }

            factory.getRules = _getRules;
            factory.getSubject = _getSubject;
            factory.enrollRequest = _enrollRequest;
            factory.getCertificatesStatus = _getCertificatesStatus;
            factory.displayCertificate = _displayCertificate;
            factory.installCertificate = _installCertificate;
            factory.changeCertificateState = _changeCertificateState;
            factory.getPrivateKeyParameters = _getPrivateKeyParameters;
            factory.sendProfileToAcsk = _sendProfileToAcsk;
            factory.parseBase64Crt = _parseBase64Crt;
            factory.signData = signData;

            return factory;
        }
        ]);