angular.module(globalSettings.modulesAreas).constant(
    'FILES_CONSTS', {
        createPay: {
            ID: {
                PAY_SUM_ZERO: 1,
                BALANCE_2560_EMPTY: 2,
                BALANCE_2560: 3
            },
            TEXT: {
                1: "Створити загальний платіж неможливо. Сума до сплати = 0",
                2: "Створити загальний платіж неможливо. Залишок по рахунку 2560 відсутній",
                3: "Створити загальний платіж неможливо.  Залишок по рахунку 2560 не достатній для оплати"
            }
        },
        getBalanceRu: {
            ID: {
                PAY_SUM_ZERO: 1,
                BALANCE_2560_EMPTY: 2
            },
            TEXT: {
                1: "Запит залишку неможливий. Сума до сплати = 0",
                2: "Повторний запит залишку неможливий. Запит залишку вже відправлено в РУ, очікуйте появи залишку"
            }
        },
        pay: {
            ID: {
                PAY_SUM_ZERO: 1,
                BALANCE_2909: 2
            },
            TEXT: {
                1: "Виконати оплату реєстра неможливо. Сума до сплати = 0",
                2: "Виконати оплату реєстра неможливо. Залишоку коштів на 2909 недостатньо для здійснення операції"
            }
        }
}).constant('FILE_STATES', {
    NEW: "-1",
    IN_PARSE: "1",
    PARSE_ERROR: "2",
    PARSED: "3",
    IN_CHECK: "4",
    CHECK_ERROR: "5",
    CHECKED: "0",
    CHECKING_PAY: "6",
    CHECKED2: "7",
    IN_PAY: "8",
    PAYED: "9",
    ERROR: "10"
});
