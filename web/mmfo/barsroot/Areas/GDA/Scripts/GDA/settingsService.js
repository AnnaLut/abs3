/**
 * Created by serhii.karchavets on 16-Nov-17.
 */

angular.module(globalSettings.modulesAreas).factory("settingsService", function () {
    var _dataFactory = function () {
        this.dictHandBook = {
            placementTranche: {     //model in scope
                CurrencyId: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "1=1 order by case kv when 980 then -3 when 840 then -2 when 978 then -1  else kv end",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ CurrencyId: "KV" }],  // scope model ID: field from 'tableName'

                },
                accDebit: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ accDebit: "KV", accDebitBalance: "KV" }]    // scope model ID: field from 'tableName'
                },
                payingInterest: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ payingInterest: "KV" }]    // scope model ID: field from 'tableName'
                }
            },
            replacementTranche: {
                CurrencyId: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "1=1 order by case kv when 980 then -3 when 840 then -2 when 978 then -1  else kv end",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ CurrencyId: "KV" }],  // scope model ID: field from 'tableName'

                },
                accDebit: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ accDebit: "KV", accDebitBalance: "KV" }]    // scope model ID: field from 'tableName'
                },
                payingInterest: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ payingInterest: "KV" }]    // scope model ID: field from 'tableName'
                }
            },
            earlyRepaymentTranche: {
                accCreit: {
                    tableName: "TABVAL",
                    clause: "1=1 order by case kv when 980 then -3 when 840 then -2 when 978 then -1  else kv end",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ accCreit: "KV" }]
                }
            },
            depositDemand: {
                currency: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "1=1 order by case kv when 980 then -3 when 840 then -2 when 978 then -1  else kv end",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ currency: "KV" }],  // scope model ID: field from 'tableName'

                },
                accDebit: {
                    tableName: "TABVAL",
                    clause: "",
                    // clause: "where acc='{0}' and rnk={1}",
                    // clauseFields: ["ACC", "RNK"],
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ accDebit: "KV" }, { accBalance: "KV" }]
                },
                accCreit: {
                    tableName: "TABVAL",
                    clause: "",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ accCreit: "KV" }]
                }
            },
            closeDepositDemand: {
                currency: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "1=1 order by case kv when 980 then -3 when 840 then -2 when 978 then -1  else kv end",
                    columns: "KV,LCV,NAME",     //columns
                    modelValueFields: [{ currency: "KV" }],  // scope model ID: field from 'tableName'

                },
                accDebit: {
                    tableName: "TABVAL",
                    clause: "",
                    // clause: "where acc='{0}' and rnk={1}",
                    // clauseFields: ["ACC", "RNK"],
                    columns: "LCV,KV,NAME",
                    modelValueFields: [{ accDebit: "KV" }, { accBalance: "KV" }]
                },
                accCreit: {
                    tableName: "TABVAL",
                    clause: "",
                    columns: "LCV,KV,NAME",
                    modelValueFields: [{ accCreit: "KV" }]
                }
            },
            editDepositDemand: {
                currency: {
                    tableName: "TABVAL",    //table in metatables db
                    clause: "1=1 order by case kv when 980 then -3 when 840 then -2 when 978 then -1  else kv end",
                    columns: "LCV,KV,NAME",     //columns
                    modelValueFields: [{ currency: "KV" }],  // scope model ID: field from 'tableName'

                },
                accDebit: {
                    tableName: "tabval",
                    clause: "",
                    // clause: "where acc='{0}' and rnk={1}",
                    // clauseFields: ["ACC", "RNK"],
                    columns: "LCV,KV,NAME",
                    modelValueFields: [{ accDebit: "KV" }, { accBalance: "KV" }]
                },
                accCreit: {
                    tableName: "tabval",
                    clause: "",
                    columns: "LCV,KV,NAME",
                    modelValueFields: [{ accCreit: "KV" }]
                }
            }
        };

        this.toolbars = {
            //ng-disabled="onClickDisabledMain(\'placementTranche\')"
            MainOptions: {
                items: [
                    { template: '<a  class="k-button" ng-disabled="true" ng-click="onClickMain(\'placementTranche\')" title="Розміщення траншу" ><i class="pf-icon pf-16 pf-add"></i>Розміщення траншу</a>' },
                    { template: '<a class="k-button" ng-disabled="onClickDisabledMain(\'replacementTranche\')" ng-click="onClickMain(\'replacementTranche\)" title="Редагування траншу" ><i class="pf-icon pf-16 pf-application-update"></i>Редагування траншу</a>' },
                    { template: '<a class="k-button" ng-disabled="onClickDisabledMain(\'replenishmentTranche\')" ng-click="onClickMain(\'replenishmentTranche\')" title="Поповнення траншу" ><i class="pf-icon pf-16 pf-bank-account"></i>Поповнення траншу</a>' },
                    { template: '<a class="k-button" ng-disabled="onClickDisabledMain(\'earlyRepaymentTranche\')" ng-click="onClickMain(\'earlyRepaymentTranche\')" title="Дострокове повернення траншу" ><i class="pf-icon pf-16 pf-money"></i>Дострокове повернення траншу</a>' },
                    { template: '<a class="k-button" ng-disabled="onClickDisabled(\'\', \'print\')" ng-click="onClick(\'\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</a>' }
                ]
            },
            TimeTranshOptions: {
                items: [
                    { template: '<button class="btn btn-default"  ng-click="onClickMain(\'placementTranche\')" title="Розміщення траншу"><i class="pf-icon pf-16 pf-add"></i>Розміщення траншу</button>' },
                    { template: '<button id="replacementTrancheBtn" disabled class="btn btn-default"  ng-click="onClickMain(\'replacementTranche\')" title="Редагування траншу" ><i class="pf-icon pf-16 pf-application-update"></i>Редагування траншу</button>' },
                    { template: '<button id="replenishmentTrancheBtn"  class="btn btn-default" ng-click="onClickMain(\'replenishmentHistory\')" disabled="disabled" title="Поповнення траншу" ><i class="pf-icon pf-16 pf-bank-account" ></i>Поповнення траншу</button>' },
                    { template: '<button id="earlyRepaymentTrancheBtn"  class="btn btn-default" ng-click="onClickMain(\'earlyRepaymentTranche\')" title="Дострокове повернення траншу" disabled="disabled"><i class="pf-icon pf-16 pf-money"></i>Дострокове повернення траншу</button>' },
                    { template: '<button id="cancelTrancheBtn" ng-click="CancelTranche()"  class="btn btn-default"  title="Видалити транш"><i class="pf-icon pf-16 pf-delete"></i>Видалення траншу</button>' },
                    { template: '<button id="printBtn" disabled class="btn btn-default" ng-click="onClick(\'replacementTranche\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</button>' },
                    { template: '<button class="btn btn-default" ng-click="ExportToExcel(\'timetranchesgrid\')" title="Імпортувати у Ексель" ><i class="pf-icon pf-16 pf-exel"></i></button>' }
                ]
            },
            RequireDepositOptions: {
                items: [
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabledMain(\'depositDemand\')" ng-click="onClickMain(\'depositDemand\')" title="Відкриття вкладу на вимогу" ><i class="pf-icon pf-16 pf-add"></i>Відкриття вкладу на вимогу</a>' },
                    { template: '<button id="editDepositBtn" disabled class="btn btn-default" ng-click="onClickMain(\'editDepositDemand\')" title="Редагування вкладу на вимогу" ><i class="pf-icon pf-16 pf-tool_pencil"></i>Редагування вкладу на вимогу</button>' },
                    { template: '<button id="closeDepositBtn" disabled class="btn btn-default"  ng-click="onClickMain(\'closeDepositDemand\')" title="Закриття вкладу на вимогу" ><i class="pf-icon pf-16 pf-delete_button_error"></i>Закриття вкладу на вимогу</button>' },
                    { template: '<button id="changeDepositBtn" disabled class="btn btn-default"   ng-click="onClickMain(\'changeDepositDemand\')" title="Зміна методу нарахування відсотків" ><i class="pf-icon pf-16 pf-application-update"></i>Зміна методу нарахування відсотків</button>' },
                    { template: '<button id="cancelTrancheBtn" ng-click="CancelRequireDeposit()"  class="btn btn-default"  title="Видалення вкладу на вимогу"><i class="pf-icon pf-16 pf-delete"></i>Видалення вкладу на вимогу</button>' },
                    { template: '<button id="printDepositBtn" disabled class="btn btn-default"  ng-click="onClick(\'editDepositDemand\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</a>' },
                    { template: '<button class="btn btn-default" ng-click="ExportToExcel(\'requireDepositGrid\')" title="Імпортувати до Ексель" ><i class="pf-icon pf-16 pf-exel"></i></button>' }

                ]
            },
            PlacementTrancheOptions: {
                items: [
                    { template: '<button class="btn btn-default" id="placementSaveBtn"  ng-click="onClick(\'placementTranche\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</button>' },
                    //{ template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'placementTranche\', \'auth\')" ng-click="onClick(\'placementTranche\', \'auth\')" title="Передати на авторизаціюЮЮЮЮ" ><i class="pf-icon pf-16 pf-user"></i>Передати на авторизацію</a>' },
                    //{ template: '<button class="btn btn-default" ng-disabled="onClickDisabled(\'placementTranche\', \'print\')" ng-click="onClick(\'placementTranche\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</a>'}
                ]
            },

            ReplacementTrancheOptions: {
                items: [
                    { template: '<button class="btn btn-default" id="replacementSaveBtn" ng-disabled="onClickDisabled(\'replacementTranche\', \'save\')" ng-click="onClick(\'replacementTranche\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</button>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'replacementTranche\', \'auth\')" ng-click="onClick(\'replacementTranche\', \'auth\')" title="Передати на авторизацію" ><i class="pf-icon pf-16 pf-user"></i>Передати на авторизацію</a>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'replacementTranche\', \'print\')" ng-click="onClick(\'replacementTranche\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</a>' }
                ]
            },
            ReplenishmentTrancheOptions: {
                items: [
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'replacementTranche\', \'save\')" ng-click="onClick(\'replenishmentTranche\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</a>' },
                    //{ template: '<button id="printBtn" class="btn btn-default" ng-click="onClick(\'replenishmentTranche\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</button>' },
                ]
            },
            EarlyReplacementTrancheOptions: {
                items: [
                    { template: '<button id="saveEarlyRepaymentTranche" class="btn btn-default" ng-disabled="onClickDisabled(\'earlyRepaymentTranche\', \'save\')" ng-click="onClick(\'earlyRepaymentTranche\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</button>' },
                    { template: '<button id="authEarlyRepaymentTranche"  class="btn btn-default" ng-disabled="onClickDisabled(\'earlyRepaymentTranche\', \'auth\')" ng-click="onClick(\'earlyRepaymentTranche\', \'auth\')" title="Передати на авторизаціюТЕст" ><i class="pf-icon pf-16 pf-user"></i>Передати на авторизацію</button>' },
                    { template: '<button id="printBtnEarly" disabled class="btn btn-default" ng-click="onClick(\'earlyRepaymentTranche\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</button>' },

                ]
            },
            depositDemandOptions: {
                items: [
                    { template: '<button id="depositDemandSaveBtn" class="btn btn-default" ng-disabled="onClickDisabled(\'depositDemand\', \'save\')" ng-click="onClick(\'depositDemand\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</a>' },
                ]
            },
            closeDepositDemandOptions: {
                items: [
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'closeDepositDemand\', \'save\')" ng-click="onClick(\'closeDepositDemand\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</a>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'closeDepositDemand\', \'auth\')" ng-click="onClick(\'closeDepositDemand\', \'auth\')" title="Передати на авторизацію" ><i class="pf-icon pf-16 pf-user"></i>Передати на авторизацію</a>' },
                    { template: '<button id="btnPrintCloseDeposit" disabled class="btn btn-default" ng-click="onClick(\'closeDepositDemand\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</button>' },
                ]
            },
            editDepositDemandOptions: {
                items: [
                    { template: '<button id="editDepositDemandSaveBtn" class="btn btn-default" ng-disabled="onClickDisabled(\'editDepositDemand\', \'save\')" ng-click="onClick(\'editDepositDemand\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</a>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'editDepositDemand\', \'auth\')" ng-click="onClick(\'editDepositDemand\', \'auth\')" title="Передати на авторизацію" ><i class="pf-icon pf-16 pf-user"></i>Передати на авторизацію</a>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'editDepositDemand\', \'print\')" ng-click="onClick(\'editDepositDemand\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</a>' }
                ]
            },
            СhangeDepositDemandOptions: {
                items: [
                    { template: '<button id="saveChangeDepositType" class="btn btn-default" ng-disabled="onClickDisabled(\'changeDepositDemand\', \'save\')" ng-click="onClick(\'changeDepositDemand\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</a>' },
                    { template: '<button id="authChangeDepositType" class="btn btn-default" ng-disabled="onClickDisabled(\'changeDepositDemand\', \'auth\')" ng-click="onClick(\'changeDepositDemand\', \'auth\')" title="Передати на авторизацію" ><i class="pf-icon pf-16 pf-user"></i>Передати на авторизацію</a>' },
                ]
            },
            BackAdminOptions: {
                items: [
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabledMain(\'\')" ng-click="onClickMain(\'\')" title="Перегляд документів в ЕА"><i class="pf-icon pf-16 pf-book"></i>Перегляд документів в ЕА</a>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabledMain(\'\')" ng-click="onClickMain(\'\')" title="Перегляд операції" ><i class="pf-icon pf-16 pf-business_report"></i>Перегляд операцій </a>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabledMain(\'\')" ng-click="onClickMain(\'\')" title="Блокування траншу" ><i class="pf-icon pf-16 pf-stop"></i>Блокування траншу</a>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabledMain(\'\')" ng-click="onClickMain(\'\')" title="Розблокування траншу" ><i class="pf-icon pf-16 pf-list-ok"></i>Розблокування траншу</a>' },
                ]
            },
            ReplenishmentTrancheHistoryOptions: {
                items: [
                    { template: '<button class="btn btn-default" ng-click="onClickMain(\'replenishmentTranche\')" title="Поповнення траншу" ><i class="pf-icon pf-16 pf-bank-account"></i>Поповнити транш</button>' },
                    { template: '<button id="editreplenish" class="btn btn-default" ng-click="onClickMain(\'editreplenishmentTranche\')" title="Редагування траншу" ><i class="pf-icon pf-16 pf-tool_pencil"></i>Редагувати поповнення</button>' },
                    { template: '<button class="btn btn-default" ng-click="CancelReplenishment()" title="Видалення операції поповнення" ><i class="pf-icon pf-16 pf-delete"></i>Видалення операції поповнення</button>' },
                    { template: '<button id="printBtnHistory" class="btn btn-default" ng-click="onClick(\'replenishmentTranche\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</button>' }
                ]
            },
            EditreplenishmentTrancheOptions: {
                items: [
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'editreplenishmentTranche\', \'saveeditreplenishment\')" ng-click="onClick(\'editreplenishmentTranche\', \'save\')" title="Зберегти" ><i class="pf-icon pf-16 pf-save"></i>Зберегти</a>' },
                    { template: '<a class="btn btn-default" ng-disabled="onClickDisabled(\'editreplenishmentTranche\', \'auth\')" ng-click="onClick(\'editreplenishmentTranche\', \'auth\')" title="Передати на авторизацію" ><i class="pf-icon pf-16 pf-user"></i>Передати на авторизацію</a>' },
                    { template: '<button id="printBtn" class="btn btn-default" ng-click="onClick(\'replenishmentTranche\', \'print\')" title="Друк" ><i class="pf-icon pf-16 pf-print"></i>Друк</button>' },
                ]
            }
        };

        this.TrancheStates = {
            TS_CREATED: 0,
            TS_EDITING: 1,
            TS_ON_AUTHORIZATION: 2,
            TS_AUTHORIZED: 3,
            TS_CLOSED: 4
        };
        this.UserRoles = {
            OPERATOR: 0,
            CONTROLLER: 1,
            CONTROLLER_2: 2
        };

        var _parent = this;
        this.getTrancheStateLocalize = function (id) {
            switch (id) {
                case _parent.TrancheStates.TS_CREATED:
                    return "Створено";
                case _parent.TrancheStates.TS_EDITING:
                    return "Редагування";
                case _parent.TrancheStates.TS_ON_AUTHORIZATION:
                    return "На авторизації";
                case _parent.TrancheStates.TS_AUTHORIZED:
                    return "Авторизовано";
                case _parent.TrancheStates.TS_CLOSED:
                    return "Закрито";
            }
        };
        this.getUserRoleLocalize = function (id) {
            switch (id) {
                case _parent.UserRoles.OPERATOR:
                    return "Оператор";
                case _parent.UserRoles.CONTROLLER:
                    return "Контролер";
                case _parent.UserRoles.CONTROLLER_2:
                    return "Контролер 2";
            }
        };

        var _titles = {
            placementTranche: 'Розміщення траншу',
            replacementTranche: 'Редагування траншу',
            replenishmentTranche: 'Поповнення траншу',
            earlyRepaymentTranche: 'Дострокове повернення траншу',
            depositDemand: 'Відкриття вкладу на вимогу',
            trancheinfo: 'Транші з поповненням',
            trancheautolog: 'Автолонгація траншу',
            closeDepositDemand: 'Закриття вкладу на вимогу',
            editDepositDemand: 'Редагування вкладу на вимогу',
            editreplenishmentTranche: 'Поповнення траншу(редагування)',
            changeDepositDemand: 'Зміна методу нарахування відсотків',
            replenishmentHistory: 'Історія поповнення траншу'
        };
        this.getFormTitle = function (formId, nd, dateNd) {
            if (formId === 'trancheinfo') {
                return _titles[formId];
            } else if (formId === 'trancheautolog') {
                return _titles[formId];
            } else {
                return _titles[formId] + ' №ДБО <strong>' + nd + "</strong> від <strong>" + dateNd + "</strong>";
            }
        };

        this.formWindows = {
            placementTranche: "placementTrancheWindow",
            replacementTranche: "replacementTrancheWindow",
            replenishmentTranche: "replenishmentTrancheWindow",
            editreplenishmentTranche: "editreplenishmentTrancheWindow",
            earlyRepaymentTranche: "earlyRepaymentTrancheWindow",
            depositDemand: "depositDemandWindow",
            trancheinfo: "trancheinfoWindow",
            trancheautolog: "trancheAutoLogWindow",
            closeDepositDemand: "closeDepositDemandWindow",
            editDepositDemand: "editDepositDemandWindow",
            changeDepositDemand: "changeDepositDemandWindow",
            opHistory: "opHistoryWindow",
            replenishmentHistory: "replenishmentTrancheHistoryWindow"

        };
    };
    return {
        settings: function () {
            return new _dataFactory();
        }
    }
});
//ТестРелиз