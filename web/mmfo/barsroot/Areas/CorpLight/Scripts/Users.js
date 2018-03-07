$(function () {
    $.get(bars.config.urlContent('/api/kernel/params/MFO'))
        .success(function (request) {
            $('#bankId').val(request.Value);
        })
        .error(function () {
            bars.ui.error({ text: 'Неможливо визначити МФО банку' });
        })
        .complete();


    kendo.bind($(".cl-admin"));
    $('#LoginProviderValue').change(function () {
        isConfirmedPhone = false;
    });

    var window = $('#newUserWindow');

    $("#addNewUserBtn").bind("click", function () {

        window.data("kendoWindow").center().open();
    });

    window.kendoWindow({
        width: '500px',
        height: '500px',
        title: " ",
        modal: true,
        actions: [
            "Pin",
            "Minimize",
            "Maximize",
            "Close"
        ],
        close: function () {
            clearNewUserForm();
        }
    });

    $('#customerDetailWindow').kendoWindow({
        width: '600px',
        height: '500px',
        title: " ",
        modal: true,
        actions: [
            "Pin",
            "Minimize",
            "Maximize",
            "Close"
        ],
        close: function () {
            clearNewUserForm();
            $('#existingUserList').html(); 
        }
    });

    $('#customersGrid').kendoGrid({
        height: 120,
        autoBind: true,
        selectable: 'single',
        groupable: false,
        sortable: true,
        resizable: true,
        filterable: true,
        scrollable: true,
        //pageable: {
        //    refresh: true,
        //    pageSizes: [10, 20, 50, 100, 200],
        //    buttonCount: 1
        //},
        pageable: {
            previousNext: false,
            info: false,
            refresh: true,
            pageSizes: [10, 20, 50, 100, 200],
            buttonCount: 1,
            messages: {
                itemsPerPage: '',
                next: '>',
                last: '<',
                previous: "<"
            }
        },
        dataBound: function (e) {
            var data = e.sender.dataSource.data();
            if (data.length === 0) {
                //if (e.sender.dataSource.total() === 0) {
                var colCount = e.sender.columns.length;
                $(e.sender.wrapper)
                    .find('tbody')
                    .append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data">' + e.sender.pager.options.messages.empty + ' </td></tr>');
            }
            var grid = this;
            grid.element.height("auto");
            grid.element.find(".k-grid-content").height("auto");
            kendo.resize(grid.element);
        },
        dataBinding: function () {
            //enableToolbarButtons(false);
        },
        change: function () {
            //enableToolbarButtons(true, selectedCustGridRow());
        },
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
            /*sort: {
                field: "Id",
                dir: "desc"
            },*/
            filter: {
                // leave data items which are "Food" or "Tea"
                logic: "or",
                filters: [
                  { field: "Sed", operator: "eq", value: "91" },
                  { field: "TypeId", operator: "eq", value: 2 }
                ]
            },
            transport: {
                read: {
                    //url: bars.config.urlContent('/api/v1/clients/customers/'),
                    url: bars.config.urlContent('/api/corpLight/customers') + ((bars.ext.getParamFromUrl('clmode') === 'visa') ? 'ForVisa/' : '/'),
                    dataType: 'json',
                    data: function () { return customersFilter; }

                    /*,
                    data: {filter1: function () { return vm.customersFilter; }} /*function () { return vm.customersFilter; } /* {
                        type: function () { return vm.customersFilter.type; },
                        showClosed: function () { return vm.customersFilter.showClosed; },
                        customFilter: function() { return vm.customersFilter; }
                    }*/
                }/*,
                        parameterMap: function (data, operation) {
                            debugger
                            return $.extend(data, vm.customersFilter);
                        }*/
            },
            schema: {
                data: "Data",
                total: "Total",
                errors: "Errors",
                model: {
                    id: 'Id',
                    fields: {
                        Id: {
                            type: 'number'
                        },
                        ContractNumber: {
                            type: 'string'
                        },
                        Code: {
                            type: 'string'
                        },
                        TypeId: {
                            type: 'number'
                        },
                        TypeName: {
                            type: 'string'
                        },
                        Sed: {
                            type: 'string'
                        },
                        Name: {
                            type: 'string'
                        },
                        DateOpen: {
                            type: 'date'
                        },
                        DateClosed: {
                            type: 'date'
                        },
                        Branch: {
                            type: 'string'
                        }
                    }
                }
            }
        },
        columns: [
            {
                field: 'Id',
                title: 'Реєстр.<br/>номер',
                template: '<a href="#= bars.config.urlContent(\'/corplight/customers/view/\') + Id #" ng-click="custCtrl.viewCustomer(#=Id#)" onclick="viewCustomer(#=Id#);return false;">#= Id #</a>',
                filterable: bars.ext.kendo.grid.uiNumFilter,
                width: '80px'
            }, {
                field: 'ContractNumber',
                title: '№ договору',
                width: '100px'
            }, {
                field: 'Code',
                title: 'ЕДРПОУ /<br/>іден. код',
                width: '100px'
            }, {
                field: 'TypeName',
                title: 'Тип клієнта',
                width: '160px',
                template: '<i class="pf-icon pf-16 pf-{{getClientTypeIcon(dataItem.TypeId)}}"></i> #=TypeName#'
            }, {
                field: 'Sed',
                title: 'Підпр.',
                template: '<input type="checkbox" #= Sed == \"91  \" ?  \"checked\":\"\" # onclick="return false;"/>',
                filterable: false,//{ messages: { isTrue: "trueString", isFalse: "falseString" } },
                width: '60px'
            }, {
                field: 'Name',
                title: 'Найменування',
                width: '200px'
            }, {
                field: 'DateOpen',
                title: 'Дата<br/>реєстрації',
                format: '{0:dd.MM.yyyy}',
                width: '80px'
            }, {
                field: 'DateClosed',
                title: 'Дата<br/>закриття',
                format: '{0:dd.MM.yyyy}',
                width: '80px'
            }, {
                field: 'Branch',
                title: 'Код безб.<br/>відділення',
                width: '170px'
            }
        ]
    });
});

var isConfirmedPhone = false;

var customersFilter = {
    type: 'ALL',
    showClosed: false,
    likeClause: '',
    systemFilterId: 0,
    userFilterId: 0,
    whereClause: ''
}


var viewCustomerWinOptions = {
    width: 960,
    height: 610
}
function viewCustomer(id) {
    //$('#customerDetailWindow').data('kendoWindow').center().open();
    //$('#customerId').val(id);
    //loadCustomerUsers();
    
    if (id) {
        var clMode = bars.ext.getParamFromUrl('clmode');
        var url = bars.config.urlContent('/clientregister/registration.aspx?readonly=0&rnk=' + id);
        if (clMode) {
            url += '&clmode=' + clMode;
        }
        bars.ui.dialog({
            actions: [ "Maximize", "Close" ],
            iframe: true,
            content: {
                url: url
            },
            width: viewCustomerWinOptions.width,
            height: viewCustomerWinOptions.height,
            close: function() {
                if (clMode === 'visa') {
                    $('#customersGrid').data('kendoGrid').dataSource.read();
                    //$('#customersGrid').data('kendoGrid').refresh();
                }
            }
        });
    } else {
        this.registerCustomer(vm.customerCreateModel.type, vm.customerCreateModel.isResident);
    }

}

function LoginProvider(type, value) {
    return {
        Type: type,
        Value: value
    }
}

function UserCustomer() {
    this.CustomerId = document.getElementById('customerId').value;
    this.BankId = document.getElementById('bankId').value;
    this.Roles = new Array();
    this.LoginProviders = new LoginProvider();
}

function User() {
    this.Id = '';
    this.Name = '';
    this.DisplayName = '';
    this.Email = '';
    this.Password = '';
    this.Customers = [];
}

function validateMobilePhone() {
    var phone = $('#LoginProviderValueMobilePhone').val();
    if (!phone) {
        bars.ui.error({ text: 'незаповнено поле Мобільний телефон' });
        return;
    }

    var phoneNum = $('#LoginProviderValueMobilePhone').val();
    bars.ui.loader('body', false);
    $.ajax({
        dataType: "json",
        //contentType: "application/json",
        type: 'POST',
        url: bars.config.urlContent('/corpLight/users/validateMobilePhone'),
        data: { phoneNumber: phoneNum },
        success: function (data) {
            if (data.Status === 'Ok') {
                bars.ui.loader('body', false);
                bars.ui.notify('Успішно!', 'Успішно відправлено одноразовий пароль ', 'success');

                $('#confirmCode').show();
                $('#validateMobPhoneBtn').hide();
                $('#otp').val('');
                $('#LoginProviderValueMobilePhone').attr('disabled', 'disabled');
            } else {
                bars.ui.notify('Помилка', data.Message, 'error');
                bars.ui.loader('body', false);
            }
        },
        error: function () {
            bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');
            bars.ui.loader('body', false);
        },
        complete: function () {
            bars.ui.loader('body', false);
        }
    });
}

function validateOneTimePass() {
    var code = $('#otp').val();
    if (!code) {
        bars.ui.error({ text: 'незаповнено поле пароля' });
        return;
    }
    var phoneNum = $('#LoginProviderValueMobilePhone').val();


    bars.ui.loader('body', true);
    $.ajax({
        dataType: "json",
        //contentType: "application/json",
        type: 'POST',
        url: bars.config.urlContent('/corpLight/users/validateOneTimePass'),
        data: { phoneNumber: phoneNum, code: code },
        success: function (data) {
            bars.ui.loader('body', false);
            if (data.Status == 'Ok') {
                bars.ui.notify('Успішно!', 'Пароль перевірено успішно', 'success');
                isConfirmedPhone = true;

                $('#confirmCode').hide();
                $('#confirmCode input').val('');
                $('#validateMobPhoneBtn').show();
            } else {
                bars.ui.notify('Помилка', 'Помилка валідації OTP', 'error');
                isConfirmedPhone = false;
            }
        },
        error: function () {
            bars.ui.loader('body', false);
            bars.ui.notify('Помилка', 'Помилка валідації OTP', 'error');
            isConfirmedPhone = false;

            //bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');
            //bars.ui.loader('body', false);
        },
        complete: function () {
            bars.ui.loader('body', false);
        }
    });
}

function loadCustomerUsers() {
    var usersList = $('#existingUserList');

    bars.ui.loader(usersList, true);

    $.ajax({
        type: 'GET',
        url: bars.config.urlContent('/api/corpLight/users/GetCustomerUsers?customerId=' + $('#customerId').val() + '&bankId=' + $('#bankId').val()),
        success: function (data) {
            bars.ui.loader(usersList, false);
            usersList.html('');
            if (data && data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    addUserToList(data[i]);
                }
            }
        },
        error: function () {
            bars.ui.loader(usersList, false);
        },
        complete: function () {
            bars.ui.loader(usersList, false);
        }
    });
}

function createUser(user) {
    var form = $('#userCartNew');
    bars.ui.loader(form, true);
    $.ajax({
        dataType: "json",
        contentType: "application/json",
        type: 'POST',
        url: bars.config.urlContent('/api/corpLight/users/AddNewUser'),
        data: JSON.stringify(user),
        success: function () {
            bars.ui.loader(form, false);
            clearNewUserForm();
            $('#newUserWindow').data('kendoWindow').close();
            bars.ui.notify('Успішно!', 'Користувачу ' + user.FirstName + ' ' + user.LastName +
                ' надано доступ до системи CorpLight', 'success');
            loadCustomerUsers();
            //addUserToList(data);

        },
        error: function () {
            //console.log(error);
            bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');
            bars.ui.loader(form, false);
        },
        complete: function () {
            bars.ui.loader(form, false);
        }
    });
}

function saveUser() {
    var form = $('#userCartNew');

    var user = new User();

    user.Id = form.find('#Id').val();

    user.Name = form.find('#Name').val();
    user.DisplayName = form.find('#DisplayName').val();

    user.LastName = form.find('#DisplayNameLastName').val();
    if (!user.LastName) {
        bars.ui.error({ text: 'не заповнено прізвище користувача.' });
        return;
    }

    user.FirstName = form.find('#DisplayNameFirstName').val();
    if (!user.FirstName) {
        bars.ui.error({ text: 'не заповнено ім\'я користувача.' });
        return;
    }

    user.Patronymic = form.find('#DisplayNamePatronymic').val();
    if (!user.Patronymic) {
        bars.ui.error({ text: 'не заповнено Побатькові користувача.' });
        return;
    }
    user.Email = form.find('#Email').val();
    if (!user.Email) {
        bars.ui.error({ text: 'не заповнено e-mail користувача.' });
        return;
    }

    var testEmail = validateEmail(user.Email);
    if (!testEmail) {
        bars.ui.error({ text: 'перевірте коректність поля e-mail.' });
        return;
    }

    var customer = {}; //new UserCustomer();
    customer.CustomerId = document.getElementById('customerId').value;
    customer.BankId = document.getElementById('bankId').value;

    customer.Roles = form.find('#Roles').val();
    if (!customer.Roles) {
        bars.ui.error({ text: 'не задано роль для користувача.' });
        return;
    }

    var loginProviderValueMp = form.find('#LoginProviderValueMobilePhone').val();
    if (!loginProviderValueMp) {
        bars.ui.error({ text: 'не заповнено мобільний телефон.' });
        return;
    }
    if (!isConfirmedPhone && !user.Id) {
        bars.ui.error({ text: 'Не підтверджено мобільний телефон.' });
        return;
    }
    var loginProviderMp = LoginProvider('MobilePhone', loginProviderValueMp);

    customer.LoginProviders = [
       loginProviderMp
    ];

    /*var loginProviderValueOtp = form.find('#LoginProviderValueOtpToken').val();
    if (loginProviderValueOtp) {
        customer.LoginProviders.push(LoginProvider('OtpToken', loginProviderValueOtp));
    }

    var loginProviderValueEkey = form.find('#LoginProviderValueEkey').val();
    if (loginProviderValueEkey) {
        customer.LoginProviders.push(LoginProvider('ElectronicKey', loginProviderValueEkey));
    }*/

    user.Customers = [customer];

    if (!user.Id) {
        createUser(user);
    } else {
        updateUser(user);
    }
}

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}

function clearNewUserForm() {
    var form = $('#userCartNew');

    isConfirmedPhone = false;
    var cfc = $('#confirmCode');
    cfc.find('input').val('');
    cfc.hide();

    form.find('#Id').val('');
    form.find('#Name').val('');
    form.find('#DisplayName').val('');
    form.find('#DisplayNameLastName').val('');
    form.find('#DisplayNameFirstName').val('');
    form.find('#DisplayNamePatronymic').val('');

    form.find('#Email').val('');

    form.find('#Roles').data("kendoMultiSelect").value([]);

    form.find('#LoginProviderValueMobilePhone').val('').removeAttr('disabled');
    form.find('#otp').val('');
    form.find('#confirmCode').hide();
    form.find('#validateMobPhoneBtn').show();


    form.find('#LoginProviderValueOtpToken').val('');
    form.find('#LoginProviderValueEkey').val('');

    return false;
}

function updateUser(user) {
    var form = $('#userCartNew');
    bars.ui.loader(form, true);
    $.ajax({
        dataType: "json",
        contentType: "application/json",
        type: 'PUT',
        url: bars.config.urlContent('/api/corpLight/users/AddNewUser'),
        data: JSON.stringify(user),
        success: function () {
            bars.ui.loader(form, false);
            $('#newUserWindow').data('kendoWindow').close();
            bars.ui.notify('Успішно!', 'Зміни успішно збережено', 'success');

        },
        error: function () {
            bars.ui.loader(form, false);
            bars.ui.notify('Помилка', 'Сталася помилка при виклику сервісу', 'error');

        },
        complete: function () {
            bars.ui.loader(form, false);
        }
    });
}

function showEditUserWindow(userId) {
    var userForm = $('#customerDetailWindow');
    bars.ui.loader(userForm, true);
    $.ajax({
        type: 'GET',
        url: bars.config.urlContent('/api/corpLight/users/GetUserById?userId=' + userId),
        success: function (data) {
            bars.ui.loader(userForm, false);

            bindUserData(data);

            $('#newUserWindow').data("kendoWindow").center().open();

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

function bindUserData(user) {
    var form = $('#userCartNew');

    form.find('#Id').val(user.Id);
    form.find('#Name').val(user.Name);
    form.find('#DisplayName').val(user.DisplayName);
    form.find('#DisplayNameLastName').val(user.LastName);
    form.find('#DisplayNameFirstName').val(user.FirstName);
    form.find('#DisplayNamePatronymic').val(user.Patronymic);

    form.find('#Email').val(user.Email);

    form.find('#Roles').data("kendoMultiSelect").value(user.Customers[0].Roles);

    var providers = user.Customers[0].LoginProviders;
    form.find('#LoginProviderValueMobilePhone').val(getLoginProviderValue('MobilePhone', providers));
    form.find('#LoginProviderValueOtpToken').val(getLoginProviderValue('OtpToken', providers));
    form.find('#LoginProviderValueEkey').val(getLoginProviderValue('ElectrinicKey', providers));
}

function getLoginProviderValue(providerType, loginProviders) {
    var result = "";
    if (loginProviders && loginProviders.length > 0) {
        for (var i = 0; i < loginProviders.length; i++) {
            if (loginProviders[i].Type == providerType) {
                result = loginProviders[i].Value;
                break;
            }
        }
    }
    return result;
}

function lockUser(userId) {
    var userForm = $('#userCart' + userId);
    bars.ui.loader(userForm, true);
    $.ajax({
        type: 'PUT',
        url: bars.config.urlContent('/api/corpLight/users/LockUser?userId=' + userId +
            '&customerId=' + document.getElementById('customerId').value +
            '&bankId=' + document.getElementById('bankId').value),
        success: function () {
            bars.ui.loader(userForm, false);
            bars.ui.notify('Успішно!', 'Користувача заблоковано', 'success');
            $("#existingUserList").html('');
            loadCustomerUsers();
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
function unLockUser(userId) {
    var userForm = $('#userCart' + userId);
    bars.ui.loader(userForm, true);
    $.ajax({
        type: 'PUT',
        url: bars.config.urlContent('/api/corpLight/users/unLockUser?userId=' + userId +
            '&customerId=' + document.getElementById('customerId').value +
            '&bankId=' + document.getElementById('bankId').value),
        success: function () {
            bars.ui.loader(userForm, false);
            bars.ui.notify('Успішно!', 'Користувача розблоковано', 'success');
            $("#existingUserList").html(''),
            loadCustomerUsers();
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
function deleteUser(userId) {
    var userForm = $('#userCart' + userId);
    bars.ui.loader(userForm, true);
    $.ajax({
        type: 'DELETE',
        url: bars.config.urlContent('/api/corpLight/users/DeleteUser?userId=' + userId +
            '&customerId=' + document.getElementById('customerId').value +
            '&bankId=' + document.getElementById('bankId').value),
        success: function () {
            bars.ui.loader(userForm, false);

            bars.ui.notify('Успішно!', 'Користувача успішно видалено', 'success');

            userForm.fadeOut(500).remove();

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

function refreshUserInfo(userId) {
    var userForm = $('#userCart' + userId);
    bars.ui.loader(userForm, true);
    $.ajax({
        type: 'GET',
        url: bars.config.urlContent('/api/corpLight/users/GetUserById?userId=' + userId),
        success: function (data) {
            bars.ui.loader(userForm, false);

            if (data && data.length > 0) {

                for (var i = 0; i < data.length; i++) {
                    addUserToList(data[i]);
                }
            }
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

function addUserToList(user) {
    $('#notFindUsersLabel').hide();
    var template = kendo.template($("#existingUserTemplate").html());

    var result = template(user);
    $("#existingUserList").append(result);
    kendo.bind($('#userCart' + user.Id));
}