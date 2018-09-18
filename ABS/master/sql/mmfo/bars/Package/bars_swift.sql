CREATE OR REPLACE PACKAGE BARS.BARS_SWIFT
is

--**************************************************************--
--*                 SWIFT processing Package                   *--
--*                      (C) Unity-Bars                        *--
--*                                                            *--
--*                     для всех банков                        *--
--*                                                            *--
--**************************************************************--
--*                                                            *--
--*  Опции:                                                    *--
--*                                                            *--
--*      3XX  -  формирование MT300/320 по договорам           *--
--*                                                            *--
--**************************************************************--


    CRLF              constant char(2)       := chr(13) || chr(10);

    g_headerVersion   constant varchar2(64)  := 'version 3.44 13.04.2018';
    g_headerDefs      constant varchar2(512) := ''
              || '          для всех банков'           || chr(10)
              || '    3XX - с формированием MT300/320' || chr(10)
;

--**************************************************************--
-- Типы и переменные для ускорения преобразования строк в SWIFT формат
  TYPE TransliterateTable  IS TABLE OF sw_volap%ROWTYPE INDEX BY BINARY_INTEGER;
  TYPE TransliterateTables IS TABLE OF TransliterateTable INDEX BY VARCHAR2(5);

--Таблица замены одного символа на несколлько
  RTables     TransliterateTables;


  subtype t_stmtref  is sw_950.swref%type;
  subtype t_stmtrnum is sw_950d.n%type;
  subtype t_swref    is sw_journal.swref%type;

  type t_listref     is table of oper.ref%type;


--**************************************************************--

--**************************************************************--
-- Константы
--
  FI_IMPMODE_INITIAL  constant number := 1;
  FI_IMPMODE_SERIAL   constant number := 2;

  MSGRET_MSG_ONLY     constant number := 0;
  MSGRET_MSG_DOC      constant number := 1;

  FLAG_FORCE          constant number := 1;
  FLAG_NOFORCE        constant number := 0;




    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2;


FUNCTION SwiftToStr(Value_ VARCHAR2, Charset_ VARCHAR2 DEFAULT 'TRANS') RETURN VARCHAR2 ;


    -------------------------------------------------------------------
    -- STRTOSWIFT()
    --
    --     Функция переконвертации строки в кодировку SWIFT
    --
    --
    function StrToSwift(
                 p_value    in  varchar2,
                 p_charset  in  sw_chrsets.setid%type default 'TRANS') return varchar2;


    -------------------------------------------------------------------
    -- STRVERIFY2()
    --
    --     Функция удаляет из строки все символы, которые не
    --     представлены в указанной таблице перекодировки
    --
    function strVerify2(
                 p_value    in varchar2,
                 p_charset  in sw_chrsets.setid%type ) return varchar2;


--**************************************************************--
-- SWIFT amount into numeric value
-- STA
--**************************************************************--
FUNCTION SW_AMOUNT(tag_ VARCHAR2, value_ VARCHAR2) RETURN NUMBER ;

--**************************************************************--
-- Eve
-- = 0 цифра
-- = 1 не цифра
--**************************************************************--
FUNCTION IS_ALFA (SIM_ CHAR)  RETURN NUMBER ;

--**************************************************************--
-- Получить идентификатор  таблицы транслитерирования
-- Den
--**************************************************************--
FUNCTION GetCharsetID ( BIC_ IN VARCHAR2 ) RETURN VARCHAR2;

--**************************************************************--
-- Вставка нач провода МТ-100 из АБС в SWIFT
-- OPER + OPERW -> SW_JOURNAL + SW_OPER + SW_OPERW
-- STA
--**************************************************************--
PROCEDURE Fr_ABS_To_SW (MT_ int, REF_ int) ;

--**************************************************************--
-- Создает выписки для всех счетов клиентов-банков, у которых тип
-- выписки = 10 за указаный период
-- Eve
--**************************************************************--
PROCEDURE CreateAllStatementMessages(
    date_start      IN DATE,
    date_end        IN DATE);

--**************************************************************--
-- Создает выписки для всех счетов клиентов-банков, если с момента
-- последней выписки прошло достаточное время (в соответствии с
-- периодичностью выписок).
-- Банк должен иметь BIC в custbank.
-- Eve
--**************************************************************--
PROCEDURE SheduleStatementMessages;

--**************************************************************--
-- Создает выписки по всем счетам клиента-банка, имеющего счета
-- в нашем.
-- rnk_ - регистрационный номер клиента-банка.
-- Eve
--**************************************************************--
PROCEDURE CreateBankStatementMessage(
    rnk_            IN NUMBER,
    date_start      IN DATE,
    date_end        IN DATE);

--**************************************************************--
-- Создает выписки по всем счетам клиента, имеющего счета в нашем
-- банке.
-- rnk_         - регистрационный номер клиента;
-- receiver_    - получатель выписки.
-- Eve
--**************************************************************--
PROCEDURE CreateCustomerStatementMessage(
    receiver_       IN VARCHAR2,
    rnk_            IN NUMBER,
    date_start      IN DATE,
    date_end        IN DATE,
        stmt_           IN NUMBER DEFAULT NULL);

--**************************************************************--
-- Создает MT 940/950 сообщение (выписку по счету) для единственного
-- счета.
-- receiver_   -получатель выписки;
-- acc_        -идентификатор счета.
-- Eve
--**************************************************************--
PROCEDURE CreateStatementMessage(
    receiver_       IN VARCHAR2,
    acc_            IN NUMBER,
    date_start      IN DATE,
    date_end        IN DATE,
        stmt_           IN NUMBER DEFAULT 10);

--**************************************************************--
-- Сброс номеров всех сообщений при смене года
-- Eve
--**************************************************************--
PROCEDURE ResetStmtNumbers;

--**************************************************************--
-- Вставка в журнал сообщений (SW_JOURNAL)
-- Abyss
--**************************************************************--
PROCEDURE In_SwJournal(
    ret_        OUT NUMBER,
    swref_      OUT NUMBER,
    mt_         IN  NUMBER,
    mid_        IN  VARCHAR2,
    page_       IN  VARCHAR2,
    io_         IN  VARCHAR2,
    sender_     IN  VARCHAR2,
    receiver_   IN  VARCHAR2,
    transit_    IN  VARCHAR2,
    payer_      IN  VARCHAR2,
    payee_      IN  VARCHAR2,
    ccy_        IN  VARCHAR2,
    amount_     IN  VARCHAR2,
    accd_       IN  NUMBER,
    acck_       IN  NUMBER,
    vdat_       IN  VARCHAR2,
    idat_       IN  VARCHAR2,
    sti_        IN  VARCHAR2  DEFAULT NULL,
    uetr_       IN  VARCHAR2  DEFAULT NULL,
    cov_        IN  VARCHAR2  DEFAULT NULL);

--**************************************************************--
-- Вставка в журнал сообщений (SW_JOURNAL)
-- DG
--**************************************************************--
PROCEDURE In_SwJournalEx(
    ret_        OUT NUMBER,
    swref_      OUT NUMBER,
    mt_         IN  NUMBER,
    mid_        IN  VARCHAR2,
    page_       IN  VARCHAR2,
    io_         IN  VARCHAR2,
    sender_     IN  VARCHAR2,
    receiver_   IN  VARCHAR2,
    transit_    IN  VARCHAR2,
    payer_      IN  VARCHAR2,
    payee_      IN  VARCHAR2,
    ccy_        IN  VARCHAR2,
    amount_     IN  VARCHAR2,
    accd_       IN  NUMBER,
    acck_       IN  NUMBER,
    vdat_       IN  VARCHAR2,
    idat_       IN  VARCHAR2,
    flag_       IN  VARCHAR2,
    sti_        IN  VARCHAR2  DEFAULT NULL,
    uetr_       IN  VARCHAR2  DEFAULT NULL,
    cov_        IN  VARCHAR2  DEFAULT NULL );

--**************************************************************--
-- Вставка в журнал тела сообщения (SW_OPERW)
-- Abyss
--**************************************************************--
PROCEDURE In_SwOperw(
    swref_      IN  NUMBER,
    tag_        IN  VARCHAR2,
    seq_        IN  VARCHAR2,
    recn_       IN  NUMBER,
    opt_        IN  VARCHAR2,
    body_       IN  VARCHAR2);

--**************************************************************--
-- Вставка в журнал оргинала сообщения (SW_OPERW)
-- Abyss
--**************************************************************--
PROCEDURE In_SwMessages(
    swref_      IN  NUMBER,
    body_       IN  VARCHAR2);

--**************************************************************--
-- Разбор и анализ выписок
-- STA
--**************************************************************--
PROCEDURE ParseStatement;

--**************************************************************--
-- IMPORT_SWBANK()
--
--     Процедура импорта строки справочника участников SWIFT
--
-- DG
--**************************************************************--
PROCEDURE import_swbank(
    p_impmode   in  number,
    p_impaction in  char,
    p_fibic     in  char,
    p_finame    in  varchar2,
    p_fioffice  in  varchar2,
    p_ficity    in  varchar2,
    p_ficountry in  varchar2 );

--**************************************************************--
-- GEN_MESSAGE()
--
--     Процедура создания сообщения из платежного документа
--
--
--     Описание параметров:
--
--        p_ref        Референс документа
--
--
-- DG
--**************************************************************--
procedure gen_message(
              p_ref      in  oper.ref%type );

--**************************************************************--
-- GEN3XXMSG()
--
--     Процедура создания сообщения MT300/320 по договору
--     (расширенная)
-- DG
--**************************************************************--
PROCEDURE gen3xxmsg(
    p_mt        in  number,
    p_dealref   in  number  );



--**************************************************************--
-- GEN_MT320_MESSAGE()
--
--     Процедура создания сообщения MT300
--
--     Описание параметров:
--
--        p_dealRef        Референс сделки (FX_DEAL)
--        p_msgFlag        Дополнительная опция
--                           MATU - отмена сделки
--
--
-- DG
--**************************************************************--
PROCEDURE gen_mt320_message(
     p_dealRef   in  number,
     p_msgFlag   in  varchar2,
     p_msgOption in  varchar2 default null);

--**************************************************************--
-- LINK3XXMSG()
--
--     Процедура привязки SWIFT-сообщения MT300/320 к договору
--
-- DG
--**************************************************************--
PROCEDURE Link3xxMsg(
    p_mt        in  number,
    p_swRef     in  number,
    p_dealRef   in  number,
    p_io        in  char  );

--**************************************************************--
-- UNLINK3XXMSG()
--
--     Процедура отвязки сообщения MT300/320 от договора
--
-- DG
--**************************************************************--
PROCEDURE Unlink3xxMsg(
    p_mt        in  number,
    p_swRef     in  number,
    p_dealRef   in  number,
    p_io        in  char  );

--**************************************************************--
-- GET_MT300_FIELDS()
--
--     Процедура получения основных реквизитов сообщения MT300
--
-- DG
--**************************************************************--
PROCEDURE get_mt300_fields(
    p_swRef      in  number,
    p_sender     out varchar2,
    p_receiver   out varchar2,
    p_dealDate   out date,
    p_valueDate  out date,
    p_currencyA  out number,
    p_sumA       out number,
    p_currencyB  out number,
    p_sumB       out number,
    p_swaccA     out varchar2,
    p_swbicA     out varchar2,
    p_swaccB     out varchar2,
    p_swbicB     out varchar2,
    p_swFld57    out varchar2,
    p_swFldA56   out varchar2,
    p_swFldB56   out varchar2,
    p_swAgrNum   out varchar2,
    p_swAgrDate  out date     );

--**************************************************************--
-- GET_MT600_FIELDS()
--
--     Процедура получения основных реквизитов сообщения MT600
--
--**************************************************************--
PROCEDURE get_mt600_fields(
    p_swRef      in  number,
    p_sender     out varchar2,
    p_receiver   out varchar2,
    p_dealDate   out date,
--    p_valueDate  out date,
    p_currencyA  out number,
    p_sumA       out number,
    p_currencyB  out number,
    p_sumB       out number
--    p_swaccA     out varchar2,
--    p_swbicA     out varchar2,
--    p_swaccB     out varchar2,
--    p_swbicB     out varchar2,
--    p_swFld57    out varchar2,
--    p_swFldA56   out varchar2,
--    p_swFldB56   out varchar2,
--    p_swAgrNum   out varchar2,
--    p_swAgrDate  out date
);

--**************************************************************--
-- GET_MT320_FIELDS()
--
--     Процедура получения основных реквизитов сообщения MT320
--
-- DG
--**************************************************************--
PROCEDURE get_mt320_fields(
    p_swRef       in  number,
    p_sender      out varchar2,
    p_receiver    out varchar2,
    p_tradeDate   out date,
    p_valueDate   out date,
    p_maturDate   out date,
    p_dealType    out varchar2,
    p_currency    out number,
    p_amount      out number,
    p_intCurrency out number,
    p_intAmount   out number,
    p_intRate     out number,
    p_intMethod   out varchar2,
    p_swaccA      out varchar2,
    p_swbicA      out varchar2,
    p_swaccB      out varchar2,
    p_swbicB      out varchar2,
    p_swFld57     out varchar2,
    p_swFldA56    out varchar2,
    p_swFldB56    out varchar2 );


--**************************************************************--
-- Convert currency amount from SWIFT format
--
-- DG
--**************************************************************--

PROCEDURE SwiftToAmount(
    p_swiftAmount       IN VARCHAR2,
    p_currCode          OUT NUMBER,
    p_amount            OUT NUMBER );


--**************************************************************--
-- Convert Day Fraction code from Swift format to local
--
-- DG
--**************************************************************--

FUNCTION SwiftToDayFraction(
    p_swiftCode      IN VARCHAR2 ) RETURN NUMBER;

--**************************************************************--
-- Convert Day Fraction code from local format to Swift format
--
-- DG
--**************************************************************--

FUNCTION DayFractionToSwift(
    p_localCode      IN NUMBER ) RETURN VARCHAR2;


--**************************************************************--
-- UNLOCK_MESSAGE()
--
--     Разблокирует указанное блокированное сообщение
--
-- DG
--**************************************************************--
procedure unlock_message(
    p_swRef          in number );



    -----------------------------------------------------------------
    -- EXPMSG_DELETE_MESSAGE()
    --
    --     Функция удаления сообщения, ожидающего экспорт
    --
    --     Параметры:
    --
    --         p_swRef     Референс сообщения
    --
    --         p_retOpt    Опция для возврата
    --                        NULL - умолчательное
    --                        0    - только сообщение     (MSGRET_MSG_ONLY)
    --                        1    - сообщение и документ (MSGRET_MSG_DOC )
    --
    procedure expmsg_delete_message(
                  p_swRef          in sw_journal.swref%type,
                  p_retOpt         in number  default null    );

--**************************************************************--
-- DELETE_MESSAGE()
--
--     Устанавливает состояние "Удалено" для указанного сообщения
--     Для установки данного состояния сообщение должно быть еще
--     не отправленным и содержать флаг L (locked)
--
-- DG
--**************************************************************--
procedure delete_message(
    p_swRef          in number );



--**************************************************************--
-- GEN_FULL_MESSAGE()
--
--     Процедура формирует макет сообщения, которое содержит все
--     возможные для данного типа сообщения поля, на базе
--     указанного существующего сообщения
--
--     Внимание! Данная версия не поддерживает повторяющиеся поля
--     и повторяющиеся блоки
--
-- DG
--**************************************************************--
procedure gen_full_message(
    p_swRef          in sw_journal.swref%type,
    p_mt             in sw_mt.mt%type           );


--**************************************************************--
-- UPDATE_MESSAGE()
--
--     Процедура сохраняет сообщение из временной таблицы, куда
--     его помещает программа ввода/редактирования. В процессе
--     переноса незаполненные поля исключаются
--
--     Внимание! Данная версия не поддерживает повторяющиеся поля
--     и повторяющиеся блоки
--
-- DG
--**************************************************************--
procedure update_message(
    p_swRef          in  sw_journal.swref%type,
    p_mt             in  sw_mt.mt%type         );

--**************************************************************--
-- PREPSTR2()
--
--     Функция перекодирует русские символы в строке в латинские
--     возвращаемое значение не содержит перевода строки
--
-- DG
--**************************************************************--
function PrepStr2(
           p_srcStr in varchar2 ) return varchar2;


FUNCTION WRAP_STR (
  STR VARCHAR2,
  WRAP_WIDTH NUMBER ) RETURN VARCHAR2;


procedure validate_text_field(
    p_tag      in  sw_tag.tag%type,
    p_value    in  varchar2,
    p_rows     in  number,
    p_rowlen   in  number );


-----------------------------------------------------------------
-- VALIDATE_FIELD()
--
--     Проверка формата строки
--
--     Параметры:
--
--        p_tag          Имя поля
--
--        p_opt          Опция
--
--        p_value        Значение поля
--
--        p_mode         Тип режима
--
--        p_chkchar      Признак проверки на допустимые
--                       символы. Возможные значения:
--                         0 - не проверять, умолчательное
--                         1 - проверять допустимые символы
--
procedure validate_field(
    p_tag      in  sw_tag.tag%type,
    p_opt      in  sw_opt.opt%type,
    p_value    in  varchar2,
    p_mode     in  number,
    p_chkchar  in  number  default 1 );

--**********************************************************************
-- VALIDATE_MSGFORMAT()
--
--      Процедура проверки сообщения на соответствие формату
--
--      Замечания: множество ограничений на повторяющиеся поля
--
--**********************************************************************

procedure validate_msgformat(
              p_swRef    in  number );

--**********************************************************************
-- GET_DOCUMENT_REF()
--
--      Функция для получения референса документа, связанного с
--      сообщением Swift. Если с сообщением связано несколько
--      документов, то будет выбрано первый найденный документ
--
--
--**********************************************************************

function get_document_ref(
              p_swRef    in  number ) return sw_oper.ref%type;






--**********************************************************************
-- IMPMSG_AFTER()
--
--      Процедура, выполняющаяся после импорта сообщения с помощью
--      программы файлового процессинга (SWTOSS)
--
--
--
--**********************************************************************

procedure impmsg_after(
              p_swRef    in  sw_journal.swref%type );


--**********************************************************************
-- IMPMSG_SET_STAFF()
--
--      Процедура выполняет распределение импортированного сообщения
--      для указанного пользователя
--
--
--
--**********************************************************************

procedure impmsg_set_staff(
              p_swRef    in  sw_journal.swref%type,
              p_staffID  in  staff.id%type          );

--**********************************************************************
-- IMPMSG_CHANGE_STAFF()
--
--      Процедура выполняет перераспределение всех распределенных на
--      пользователя сообщений на другого пользователя
--
--
--
--**********************************************************************

procedure impmsg_change_staff(
              p_swRef       in  sw_journal.swref%type,
              p_swStaffID   in  staff.id%type,
              p_staffID     in  staff.id%type         );

--**********************************************************************
-- IMPMSG_DELETE_MESSAGE()
--
--      Процедура удаления импортированного сообщения
--
--
--
--
--**********************************************************************

procedure impmsg_delete_message(
              p_swRef    in  sw_journal.swref%type  );

--**********************************************************************
-- PROCESS_AUTH_MESSAGE()
--
--      Процедура удаления сообщения, которое не прошло проверку
--      аутентификации с помощью кода LAU
--
--
--
--**********************************************************************

procedure process_auth_message(
              p_swRef    in  sw_journal.swref%type,
              p_action   in  number                );



FUNCTION GetSWIFTField20 ( swref_ IN NUMBER, receiver_ VARCHAR2,
                           trans_ IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2;

function genmsg_existsru(
    p_value    in  sw_operw.value%type ) return boolean;


    function get_ourbank_bic return sw_banks.bic%type;

PROCEDURE In_SwJournalInt(
    ret_        OUT NUMBER,
    swref_      OUT NUMBER,
    mt_         IN  NUMBER,
    mid_        IN  VARCHAR2,
    page_       IN  VARCHAR2,
    io_         IN  VARCHAR2,
    sender_     IN  VARCHAR2,
    receiver_   IN  VARCHAR2,
    transit_    IN  VARCHAR2,
    payer_      IN  VARCHAR2,
    payee_      IN  VARCHAR2,
    ccy_        IN  VARCHAR2,
    amount_     IN  VARCHAR2,
    accd_       IN  NUMBER,
    acck_       IN  NUMBER,
    vdat_       IN  VARCHAR2,
    idat_       IN  VARCHAR2,
    flag_       IN  VARCHAR2,
    trans_      IN  VARCHAR2  DEFAULT NULL,
    apphdrflg_  IN  VARCHAR2  DEFAULT NULL,
    sti_        IN  VARCHAR2  DEFAULT NULL,
    uetr_       IN  VARCHAR2  DEFAULT NULL,
    cov_        IN  VARCHAR2  DEFAULT NULL);

FUNCTION AmountToSWIFT(
    Amount_             IN NUMBER,
    Currency_Code       IN NUMBER,
    IsLeading           IN BOOLEAN,
    HasCurrency         IN BOOLEAN ) RETURN VARCHAR2;


--**********************************************************************
-- STMT_LINK_DOC()
--
--      Процедура привязки документа АБС к строке выписки
--
--      Параметры:
--
--          p_stmtRef        Референс выписки
--
--          p_stmtRow        Номер строки выписки
--
--
--**********************************************************************

procedure stmt_link_doc(
              p_stmtRef  in  sw_950.swref%type,
              p_stmtRow  in  sw_950d.n%type,
              p_docRef   in  oper.ref%type     );


--**********************************************************************
-- STMT_UNLINK_DOC()
--
--      Процедура отвязки документа АБС от строки выписки
--      При отвязке документ отвязывается и от исходного
--      сообщения, если он был привязан к исходному сообщению
--
--      Параметры:
--
--          p_stmtRef        Референс выписки
--
--          p_stmtRow        Номер строки выписки
--
--
--**********************************************************************

procedure stmt_unlink_doc(
              p_stmtRef  in  sw_950.swref%type,
              p_stmtRow  in  sw_950d.n%type    );


    -----------------------------------------------------------------
    -- STMT_GET_STATE()
    --
    --     Функция возвращает состояние выписки.  Возможно  два
    --     состояние выписки: "Выписка обработана" и   "Выписка
    --     не обработана"
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --
    function stmt_get_state(
                 p_stmtRef  in  sw_950.swref%type) return number;


    -----------------------------------------------------------------
    -- STMT_SET_STATE()
    --
    --     Процедура устанавливает состояние выписки.    Возможно
    --     два состояние выписки: "Выписка обработана" и "Выписка
    --     не обработана". В обработанной выписке каждая из строк
    --     должна иметь ссылку на документ,   который  отображает
    --     транзакцию по корсчету
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtState      Новое состояние выписки
    --
    procedure stmt_set_state(
                 p_stmtRef   in  sw_950.swref%type,
                 p_stmtState in  sw_950.done%type  );

    -----------------------------------------------------------------
    -- STMT_SET_STATE2()
    --
    --     Расширенная процедура установки состояния выписки.
    --     Работа процедуры аналогична процедуре  STMT_SET_STATE()
    --     с возможностью отключения проверки на полноту обработки
    --     строк выписки
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtState      Новое состояние выписки
    --
    --          p_stmtFlag       Признак принудительной установки
    --
    procedure stmt_set_state2(
                 p_stmtRef   in  sw_950.swref%type,
                 p_stmtState in  sw_950.done%type,
                 p_stmtFlag  in  number  default 0  );



    -----------------------------------------------------------------
    -- STMT_DOCUMENT_LINK()
    --
    --     Процедура привязки документа АБС к строке выписки.
    --     Строка выписки, к которой выполняется привязка сообщения,
    --     должна иметь признак наличия сообщения,  а  также  должны
    --     совпадать референс, дата валютирования и сумма транзакции
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtRow        Номер строки выписки
    --
    --          p_docRef         Референс документа
    --
    --          p_force          Признак принудительной привязки,
    --                           без выполнения проверок
    --
    procedure stmt_document_link(
                  p_stmtRef  in  sw_950.swref%type,
                  p_stmtRow  in  sw_950d.n%type,
                  p_docRef   in  oper.ref%type,
                  p_force    in  number  default 0 );

    -----------------------------------------------------------------
    -- STMT_DOCUMENT_LINK()
    --
    --     Процедура привязки документов АБС к строке выписки
    --
    --
    --      Параметры:
    --
    --          p_stmtref        Референс выписки
    --
    --          p_stmtrow        Номер строки выписки
    --
    --          p_listref        Список документов
    --
    --          p_force          Признак принудительной привязки,
    --                           без выполнения проверок
    --
    procedure stmt_document_link(
                  p_stmtref  in  t_stmtref,
                  p_stmtrow  in  t_stmtrnum,
                  p_listref  in  t_listref,
                  p_force    in  number    default 0 );


    -----------------------------------------------------------------
    -- STMT_DOCUMENT_UNLINK()
    --
    --     Процедура удаляет привязку документа к строке выписки.
    --     Если   к  указанной  строке  выписки привязан исходное
    --     сообщение, то будет удалена привязка документа к этому
    --     сообщению
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtRow        Номер строки выписки
    --
    --
    procedure stmt_document_unlink(
                  p_stmtref  in  t_stmtref,
                  p_stmtrow  in  t_stmtrnum );


    -----------------------------------------------------------------
    -- STMT_SRCMSG_GETRELMSG()
    --
    --     Процедура получения референса и типа начального сообщения
    --     по цепочке связанных сообщения для строки выписки
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtRow        Номер строки выписки
    --
    --          p_msgSwRef       Референс сообщения (выходной)
    --
    --          p_msgMt          Тип сообщения      (выходной)
    --
    --
    procedure stmt_srcmsg_getrelmsg(
                  p_stmtRef  in  sw_950.swref%type,
                  p_stmtRow  in  sw_950d.n%type,
                  p_msgSwRef out sw_journal.swref%type,
                  p_msgMt    out sw_journal.mt%type     );

    -----------------------------------------------------------------
    -- STMT_SRCMSG_LINK()
    --
    --     Процедура привязки исходного сообщения  к строке выписки.
    --     Строка выписки, к которой выполняется привязка сообщения,
    --     должна иметь признак наличия сообщения,  а  также  должны
    --     совпадать референс, дата валютирования и сумма транзакции
    --
    --
    --      Параметры:
    --
    --          p_stmtref        Референс выписки
    --
    --          p_stmtrow        Номер строки выписки
    --
    --          p_srcswref       Референс исходного сообщения
    --
    --          p_force          Признак принудительной привязки,
    --                           без выполнения проверок
    --
    --
    procedure stmt_srcmsg_link(
                  p_stmtref  in  t_stmtref,
                  p_stmtrow  in  t_stmtrnum,
                  p_srcswref in  t_swref,
                  p_force    in  number  default FLAG_FORCE);


    -----------------------------------------------------------------
    -- STMT_SRCMSG_UNLINK()
    --
    --     Процедура удаляет привязку исходного сообщения к строке
    --     выписки. Выписка при выполнении данной процедуры должна
    --     иметь статус "Не обработана"
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtRow        Номер строки выписки
    --
    --
    procedure stmt_srcmsg_unlink(
                  p_stmtref  in  t_stmtref,
                  p_stmtrow  in  t_stmtrnum  );


    -----------------------------------------------------------------
    -- STMT_SRCMSG_AUTOLINK()
    --
    --     Процедура автоматической привязки исходных  сообщений  к
    --     строкам выписки, которые имеют признак наличия исходного
    --     сообщения.  Поиск исходного сообщения,  соответствующего
    --     строке  выписки  выполняется  по   референсу   сообщения
    --     (подполе 8 или подполе 7 выписки), дате валютирования  и
    --     сумме транзакции
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --
    --
    procedure stmt_srcmsg_autolink(
                  p_stmtref  in t_stmtref );



    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_LINK()
    --
    --     Процедура привязки документа к импортированному сообщению
    --     Привязываемый документ не должен быть привязан  к  такому
    --     же типу сообщения (кроме выписок).
    --
    --
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_SwRef        Референс сообщения
    --
    --
    procedure impmsg_document_link(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type );

       procedure impmsg_document_link_all(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type );

    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_UNLINK()
    --
    --     Процедура  удаления привязки документа к импортированному
    --     сообщению.
    --
    --
    --
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_SwRef        Референс сообщения
    --
    --
    procedure impmsg_document_unlink(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type );

    -----------------------------------------------------------------
    -- IMPMSG_MESSAGE_CHANGEUSER()
    --
    --     Процедура распределяет/перераспределяет сообщение  на
    --     указанного пользователя или в группу нераспределенных
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс сообщения
    --
    --          p_srcUserID    Идентификатор пользователя, на  которого
    --                         распределено(ы) сообщение(я)
    --
    --          p_tgtUserID    Идентификатор пользователя, на  которого
    --                         необходимо распределить/перераспределить
    --                         сообщение(я)
    --
    procedure impmsg_message_changeuser(
                  p_swRef     in  sw_journal.swref%type,
                  p_srcUserID in  staff.id%type,
                  p_tgtUserID in  staff.id%type          );

    -----------------------------------------------------------------
    -- IMPMSG_MESSAGE_DELETE()
    --
    --     Процедура удаляет импортированное сообщение
    --
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс сообщения
    --
    --
    procedure impmsg_message_delete(
                  p_swRef    in  sw_journal.swref%type  );

    -----------------------------------------------------------------
    -- STMT_SET_NOSTROACC()
    --
    --     Процедура устанавливает счет выписки. Данная процедура
    --     используется в том случае, когда счет выписки  не  был
    --     установлен в момент ее приема и разбора.
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtNosAcc     Идентификатор счета
    --
    procedure stmt_set_nostroacc(
                  p_stmtRef    in  sw_950.swref%type,
                  p_stmtNosAcc in  sw_950.nostro_acc%type  );

    -----------------------------------------------------------------
    -- IMPMSG_MESSAGE_GETACCB()
    --
    --     Функция получения счета из сообщения
    --
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс сообщения
    --
    --
    function impmsg_message_getaccb(
                 p_swRef    in  sw_journal.swref%type  ) return accounts.acc%type;

    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_STORETAG()
    --
    --     Процедура дополняет документ доп. реквизитами из полей
    --     указанного сообщения SWIFT
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_swRef        Референс сообщения
    --
    --
    procedure impmsg_document_storetag(
                 p_docRef   in  oper.ref%type,
                 p_swRef    in  sw_journal.swref%type,
                 p_swRowNum in  number                 );

    -----------------------------------------------------------------
    -- IMPMSG_MESSAGE_GETRELMSG()
    --
    --     Процедура получения референса и типа начального сообщения
    --     по цепочке связанных сообщения для указанного сообщения
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс выписки
    --
    --          p_msgSwRef       Референс сообщения (выходной)
    --
    --          p_msgMt          Тип сообщения      (выходной)
    --
    --
    procedure impmsg_message_getrelmsg(
                  p_swRef    in  sw_journal.swref%type,
                  p_msgSwRef out sw_journal.swref%type,
                  p_msgMt    out sw_journal.mt%type     );

    -----------------------------------------------------------------
    -- GET_MESSAGE_FIELDNAME()
    --
    --     Функция получения имени поля по метаописанию
    --
    --
    --      Параметры:
    --
    --          p_msgMt        Тип сообщения
    --
    --          p_msgSeq       Фрагмент сообщения
    --
    --          p_msgTag       Поле сообщения
    --
    --          p_msgOpt       Опция поля
    --
    --
    function get_message_fieldname(
                  p_msgMt    in  sw_mt.mt%type,
                  p_msgSeq   in  sw_seq.seq%type,
                  p_msgTag   in  sw_tag.tag%type,
                  p_msgOpt   in  sw_opt.opt%type   ) return varchar2;


    -----------------------------------------------------------------
    -- GET_MESSAGE_FIELDVALUE()
    --
    --     Функция получения полного значения поля
    --     Функция возвращает значение поля и наименование участника
    --     если данное поле содержит BIC
    --
    --      Параметры:
    --
    --          p_msgMt        Тип сообщения
    --
    --          p_msgSeq       Фрагмент сообщения
    --
    --          p_msgTag       Поле сообщения
    --
    --          p_msgOpt       Опция поля
    --
    --
    function get_message_fieldvalue(
                  p_msgMt    in  sw_mt.mt%type,
                  p_msgSeq   in  sw_seq.seq%type,
                  p_msgTag   in  sw_tag.tag%type,
                  p_msgOpt   in  sw_opt.opt%type,
                  p_msgValue in  sw_operw.value%type  ) return varchar2;




    -----------------------------------------------------------------
    --                                                             --
    --             Функции  визирования  сообщений                 --
    --                                                             --
    -----------------------------------------------------------------



    -----------------------------------------------------------------
    -- MSGCHK_PUT_CHECKSTAMP()
    --
    --     Процедура наложения специальной визы на документ, которая
    --     определяется как виза сообщения SWIFT,   порожденного  по
    --     данному документу
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_swRef        Референс порожденного сообщения
    --
    --          p_chkGrp       Код группы визирования
    --
    --          p_chkAct       Тип действия (наложение визы/отказ)
    --
    --          p_chkOpt       Опции
    --
    procedure msgchk_put_checkstamp(
                  p_docRef   in  oper.ref%type,
                  p_swRef    in  sw_journal.swref%type,
                  p_chkGrp   in  sw_chklist.idchk%type,
                  p_chkAct   in  number,
                  p_chkOpt   in  number                 );


    -----------------------------------------------------------------
    -- MSGCHK_GETEDITSTATUS()
    --
    --     Функция возвращает признак возможности редактирования
    --     сообщения. Сообщение можно редактировать если на него
    --     не была наложена ни одна виза
    --
    --      Параметры:
    --
    --          p_swRef        Референс порожденного сообщения
    --
    --
    function msgchk_geteditstatus(
                  p_swRef    in  sw_journal.swref%type ) return number;


    -----------------------------------------------------------------
    -- MSGCHK_GETEXPSTATUS()
    --
    --     Функция возвращает признак возможности экспорта сообщения
    --     из БД в транспортный файл.
    --
    --      Параметры:
    --
    --          p_swRef        Референс порожденного сообщения
    --
    --
    function msgchk_getexpstatus(
                  p_swRef    in  sw_journal.swref%type ) return number;


    -----------------------------------------------------------------
    -- GENMSG_MESSAGE_VALIDATE()
    --
    --     Процедура проверки корректности сообщения SWIFT
    --
    --
    --
    --
    --
    procedure genmsg_message_validate(
                  p_swRef     in  sw_journal.swref%type );


    -----------------------------------------------------------------
    -- GENMSG_VALIDATE_APPHDRFLAGS()
    --
    --   Процедура проверки корректности пользовательских флагов
    --   в сообщении SWIFT
    --
    --
    --
    procedure genmsg_validate_apphdrflags(
                  p_msgAppHdrFlg   in varchar2,
                  p_msgMt          in sw_mt.mt%type default null );


    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_CORACCSKIP()
    --
    --   Процедура выполняет снятие документа с подбора корсчета
    --
    --
    procedure genmsg_document_coraccskip(
                  p_ref   in oper.ref%type );


    -----------------------------------------------------------------
    -- IN_SWMSGFIELD()
    --
    --   Процедура сохраняет значения полей сообщения
    --
    --
    --
    --
    procedure in_swmsgfield(
                  p_swRef     in  sw_msgfield.swref%type,
                  p_recnum    in  sw_msgfield.recnum%type,
                  p_msgBlk    in  sw_msgfield.msgblk%type,
                  p_msgTag    in  sw_msgfield.msgtag%type,
                  p_value     in  sw_msgfield.value%type  );


    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_GETPARAMS()
    --
    --   Процедура получения реквизитов для формируемого документа
    --   по входящему (импортированному) сообщению
    --
    --
    --
    procedure impmsg_document_getparams(
                  p_swRef        in      sw_journal.swref%type,
                  p_docMfoB      in out  oper.mfob%type,
                  p_docCurCode   in out  oper.kv2%type,
                  p_docAccNum    in out  oper.nlsb%type,
                  p_docRcvrId    in out  oper.id_a%type,
                  p_docRcvrName  in out  oper.nam_b%type,
                  p_docAmount    in out  oper.s%type,
                  p_docValueDate in out  oper.vdat%type  );


    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_SYNCTAG()
    --
    --     Процедура дополняет документ доп. реквизитами SWIFT,
    --     аналогичными доп. реквизитам в исходном документе
    --
    --
    --      Параметры:
    --
    --          p_docRefSrc    Референс исходного документа
    --
    --          p_docRefTgt    Референс целевого сообщения
    --
    --
    procedure impmsg_document_synctag(
                 p_docRefSrc   in  oper.ref%type,
                 p_docRefTgt   in  oper.ref%type );

    -----------------------------------------------------------------
    -- GET_MESSAGE_CONDITION()
    --
    --     Функция проверяет вхождение указанной подстроки в
    --     сообщение. Если подстрока найдена в сообщении, то
    --     функция возвращает значение 1, иначе 0
    --
    --      Параметры:
    --
    --          p_swRef   Референс сообщения
    --
    --          p_text    Текстовая подстрока
    --
    --
    function get_message_condition(
                 p_swRef   in  sw_journal.swref%type,
                 p_text    in  varchar2               ) return number;


    -----------------------------------------------------------------
    -- DOCUMENT_UNLINK()
    --
    --     Процедура удаления привязок всех сообщений и выписок от
    --     указанного документа
    --
    --      Параметры:
    --
    --          p_docRef  Референс документа
    --
    --
    procedure document_unlink(
                 p_docRef  in  oper.ref%type );


     ----------------------------------------------------------------
     -- STMT_GEN_INFDOC()
     --
     --      Процедура формирования информационных документов для
     --      филиалов (уведомлений по проведенным платежам)
     --
     --      Параметры:
     --
     --          p_stmtRef        Референс выписки
     --
     --
     --
     function stmt_gen_infdoc(
                   p_stmtRef  in  sw_950.swref%type ) return number;

     ----------------------------------------------------------------
     -- STMT_GEN_INFDOC2()
     --
     --      Процедура формирования информационных документов для
     --      филиалов (уведомлений по проведенным платежам)
     --
     --      Параметры:
     --
     --          p_stmtRef        Референс выписки
     --
     --          p_docCnt         Кол-во сформир. документов
     --
     procedure stmt_gen_infdoc2(
                   p_stmtRef  in  sw_950.swref%type,
                   p_docCnt   out number             );



     ----------------------------------------------------------------
     -- STMT_PROCESS_REGINFDOC()
     --
     --      Регистрация инф. документа в очереди для обработки
     --      в филиале и формирование текст сообщения SWIFT
     --
     --      Параметры:
     --
     --          p_rec        Ид. записи
     --
     --
     --
     procedure stmt_process_reginfdoc(
                   p_rec  in  arc_rrp.rec%type );


     ----------------------------------------------------------------
     -- STMT_PROCESS_INFDOC()
     --
     --      Процедура обработки входящих информационных документов
     --      в филиале и формирование текст сообщения SWIFT
     --
     --      Параметры:
     --
     --          p_rec        Ид. записи
     --
     --
     --
     procedure stmt_process_infdoc(
                   p_rec   in  arc_rrp.rec%type );


    -----------------------------------------------------------------
    -- STMT_PARSE_QUEUE()
    --
    --     Процедура разбора принятых выписок
    --
    --
    --
    procedure stmt_parse_queue;


    ----------------------------------------------------------------
    -- GET_INFDOC_BIS2REC()
    --
    --     Получение массива записей из БИС инф. документа
    --
    --      Параметры:
    --
    --          p_rec     Ид. строки первой записи
    --
    --
    --
    function get_infdoc_bis2rec(
                 p_rec  in  arc_rrp.rec%type ) return t_sw_dtmtab pipelined;


    ----------------------------------------------------------------
    -- GENMSG_NOTIFY_LISTADD()
    --
    --     Добавление документа в список документов
    --     для формирования уведомлений
    --
    --      Параметры:
    --
    --          p_docref     Ид. документа
    --
    --
    --
    procedure genmsg_notify_listadd(
                   p_docref      in  number );


    ----------------------------------------------------------------
    -- GENMSG_NOTIFY_PROCESS()
    --
    --     Обработка список документов и формирование уведомлений
    --
    --
    --
    --
    procedure genmsg_notify_process;


    ----------------------------------------------------------------
    -- GENMSG_NOTIFY_INSEP()
    --
    --     Отправка информационных уведомлений
    --
    --
    procedure genmsg_notify_insep;

	-- GET_MESSAGE_RELMSG()
    --
    --   Функция поиска связанного сообщения. Если связанное сообщение
    --   найдено, то функция возвращает его референс, иначе возвращает
    --   значение NULL
    --
    --
    --
    function get_message_relmsg(p_swRef    in  sw_journal.swref%type ) return sw_journal.swref%type;

	-- GET_NAME_BANK
	-- ф-ция получения наименования банка
	-- по связаному NOS находим входящий документ из РУ
	--
	--
	--
    function get_name_bank(p_swref sw_journal.swref%type) return varchar2;

	-----------------------------------------------------------------
    -- PAY_190_STMT
    --
    --    Дополнительная бизнес-логика по обработке 190 сообщений.
    --    Оплата и наложение визы на связанные документы
    --
    procedure pay_190_stmt( p_docref number, p_swref number);

    procedure auto_create_swt(p_ref oper.ref%type, p_swref sw_journal.swref%type);

    function generate_uetr return varchar2;


end bars_swift;

/

CREATE OR REPLACE PACKAGE BODY BARS.BARS_SWIFT
is

--**************************************************************--
--*                 SWIFT processing Package                   *--
--*                      (C) Unity-Bars                        *--
--*                                                            *--
--*                  для всех банков                           *--
--*                                                            *--
--**************************************************************--
--*                                                            *--
--*  Опции:                                                    *--
--*                                                            *--
--*      3XX  -  формирование MT300/320 по договорам           *--
--*                                                            *--
--**************************************************************--


    g_bodyVersion   constant varchar2(64)  := 'version 3.92 12.09.2018';
    g_bodyDefs      constant varchar2(512) := ''
              || '          для всех банков'           || chr(10)
              || '    3XX - с формированием MT300/320' || chr(10)
;


    --**************************************************************--
    --                                                              --
    -- Types                                                        --
    --                                                              --
    --**************************************************************--
    type t_strlist  is table of varchar2(200);


    subtype t_stmtstt  is sw_950d.checked_ind%type;

    subtype t_swmt     is sw_mt.mt%type;

    subtype t_docref   is oper.ref%type;

    type    t_doclist  is table of t_docref;

    type    t_swmsg    is record ( bicReceiver   varchar2(11),
                                   tradeDate     date,
                                   valueDate     date,
                                   maturDate     date,
                                   fld17         varchar2(1),
                                   prcCurrAmount number,
                                   prcCurrCode   number,
                                   intRate       number,
                                   intAmount     number,
                                   baseyCode     number,
                                   agreementNum  varchar2(20),
                                   agreementDate date,
                                   swiRef        number,
                                   bicPartyA     varchar2(11),
                                   accPartyA     varchar2(35),
                                   prevSwRef     number,
                                   bicPartyB     varchar2(11),
                                   accPartyB     varchar2(35),
                                   altPartyB     varchar2(250),
                                   intermB       varchar2(250),
                                   intPartyA     varchar2(250),
                                   intIntermA    varchar2(250),
                                   intPartyB     varchar2(250),
                                   intIntermB    varchar2(250) );



    --**************************************************************--
    --                                                              --
    -- Constants                                                    --
    --                                                              --
    --**************************************************************--


    PKG_CODE                  constant varchar2(100)   := 'swt.';


    MODPAR_MSGRL              constant params.par%type := 'SWTMSGRL';
    MODPAR_DOCVDTMNI          constant params.par%type := 'SWTDVMNI';
    MODPAR_DOCVDTMAX          constant params.par%type := 'SWTDVMAX';
    MODPAR_MSGLCKSEC          constant params.par%type := 'SWTMSGLK';
    MODPAR_MSGDELDOC          constant params.par%type := 'SWTMSGRD';
    MODPAR_STMINFDOC          constant params.par%type := 'SWTSTMID';
    MODPAR_MSGLCK             constant params.par%type := 'SWTMSGLC';

    MODVAL_MSGRL_TRUE         constant params.val%type := '1';
    MODVAL_MSGRL_FALSE        constant params.val%type := '0';

    MODVAL_MSGLCKSEC_TRUE     constant params.val%type := '1';
    MODVAL_MSGLCKSEC_FALSE    constant params.val%type := '0';

    MODVAL_MSGDELDOC_TRUE     constant params.val%type := '1';
    MODVAL_MSGDELDOC_FALSE    constant params.val%type := '0';

    MODPAR_DOCVDTMNI_DEFAULT  constant number := 0;
    MODPAR_DOCVDTMAX_DEFAULT  constant number := 30;

    MODPAR_STMINFDOC_TRUE     constant params.val%type := '1';
    MODPAR_STMINFDOC_FALSE    constant params.val%type := '0';

    MODVAL_MSGLCK_ON          constant params.val%type := '1';
    MODVAL_MSGLCK_OFF         constant params.val%type := '0';

    /* Максимальная длина сообщения без учета служебных полей */

    MAXMSGSIZE_MT950          constant number := 1817;

    /* направление сообщения (входящееб исходящее) */
    DIRECTION_INPUT           constant sw_journal.io_ind%type := 'O';
    DIRECTION_OUTPUT          constant sw_journal.io_ind%type := 'I';

    /* параметры работы с ошибками разбора выписки */
    STMT_PARSEERROR_CLEAR     constant number  := 0;
    STMT_PARSEERROR_SET       constant number  := 1;

    /* код модуля для ошибок и сообщений */
    MODCODE                   constant varchar2(3) := 'SWT';


    /* максимальная глубина поиска связанных сообщений */
    MAX_RELMSG_RECURSION       constant number := 10;


    STMTROW_PROCESSED         constant sw_950d.checked_ind%type := 'Y';
    STMTROW_UNPROCESSED       constant sw_950d.checked_ind%type := 'N';




    /* текущий ид. записи инф. документа */
    g_curinfrec    arc_rrp.rec%type;
    g_currelmsgrl  number;
    g_notifylist   t_doclist;

    --**************************************************************--
    -- GET_PARAM_VALUE()
    --
    --     Функция получения значения конфигурационного параметра
    --     Если такого параметра нет,  то  функция  возвращает
    --     значение NULL
    --
    --     Параметры:
    --
    --         p_parname    Код (имя) параметра (params.par)
    --
    --**************************************************************--

    function get_param_value(
                 p_parname  in  params.par%type ) return params.val%type
    is

    l_value     params.val%type;

    begin

        select val into l_value
          from params
         where par = p_parname;

        return l_value;

    exception
        when NO_DATA_FOUND then return null;
    end get_param_value;






    --**************************************************************--
    -- GET_CHARSET_ID()
    --
    --     Функция получения кода таблицы перекодировки, установленной
    --     для указанного получателя.  Если  для  получателя   таблица
    --     перекодировки не устанавливалась, то будет использована
    --     таблица с кодом TRANS
    --
    --     Параметры:
    --
    --         p_bic        BIC-код участника
    --
    --
    --**************************************************************--

    function get_charset_id(
                 p_bic      in  sw_banks.bic%type ) return sw_chrsets.setid%type
    is

    l_charset  sw_chrsets.setid%type;

    begin

        select nvl(chrset, 'TRANS') into l_charset
          from sw_banks
         where bic = p_bic;

        return l_charset;

    exception
        when NO_DATA_FOUND then return 'TRANS';
    end get_charset_id;


    --**************************************************************--
    -- GET_SWIFT_REF()
    --
    --     Функция получения уникального референса SWIFT сообщения
    --     по BIC-коду получателя и идентификатору сообщения в АБС
    --
    --     Параметры:
    --
    --         p_swref      Идентификатор сообщения в АБС
    --
    --         p_receiver   BIC-код получателя сообщения
    --
    --         p_charset    Код таблицы перекодировки, если
    --                      код не задан, то таблица перекодировки
    --                      будет получена на основании получателя
    --
    --**************************************************************--

    function get_swift_ref(
                 p_swref    in  sw_journal.swref%type,
                 p_receiver in  sw_banks.bic%type,
                 p_charset  in  sw_chrsets.setid%type  default null ) return sw_journal.trn%type
    is

    l_trn        sw_journal.trn%type;
    l_charset    sw_chrsets.setid%type;

    l_dat        date := sysdate;
    l_count      number;

        BarsBankID  VARCHAR2(3);
        MaxRefLen   NUMBER;
        Prefix      VARCHAR2(5);
    begin

        --
        -- Получаем префикс для референса
        --
        -- l_trn := nvl(substr(get_param_value('SWFTID'), 1, 3), 'BRS'); -- delete pref COBUMMFO-5564

        --
        -- Получаем код используемое перекодировки
        --
        if (p_charset is null) then
            l_charset := get_charset_id(p_receiver);
        else
            l_charset := p_charset;
        end if;

        --
        -- Если используется перекодировка RUR6, то первым символом
        -- в референсе должен быть "+"
        --
        if (l_charset = 'RUR6') then
           --COBUMMFO-5564
           -- l_trn := '+' || l_trn || '-' || substr(p_receiver, 1, 4) || '-';
           l_trn := '+' || substr(p_receiver, 1, 4) || '-';
        else
            --COBUMMFO-5564
            --l_trn := l_trn || '-' || substr(p_receiver, 1, 4) || '-';
            l_trn := substr(p_receiver, 1, 4) || '-';
        end if;
        l_trn := l_trn || substr('0000000000' || to_char(p_swref), -16+length(l_trn));

        return l_trn;

    end get_swift_ref;


    --**************************************************************--
    -- GET_OURBANK_BIC()
    --
    --     Функция получения BIC-кода нашего банка
    --
    --
    --**************************************************************--

    function get_ourbank_bic return sw_banks.bic%type
    is
    begin

        return nvl(substr(get_param_value('BICCODE'), 1, 11), 'XXXXXXXXXXX');

    end get_ourbank_bic;





--**************************************************************--
--
-- Функция устарела - не использовать
--
-- Новая функция get_swift_ref()
--
--**************************************************************--

FUNCTION GetSWIFTField20 ( swref_ IN NUMBER, receiver_ VARCHAR2,
                           trans_ IN VARCHAR2 DEFAULT NULL) RETURN VARCHAR2
IS
    BarsBankID  VARCHAR2(3);
    MaxRefLen   NUMBER;
    Prefix      VARCHAR2(5);
BEGIN

    if (trans_ = '+') then
        return get_swift_ref(swref_, receiver_, 'RUR6');
    else
        return get_swift_ref(swref_, receiver_, trans_);
    end if;


END GetSWIFTField20;



--**************************************************************--
-- Функция устарела - не использовать
--
-- Новая функция get_swift_ref()
--
-- Получить идентификатор  таблицы транслитерирования
-- Den
--**************************************************************--
FUNCTION GetCharsetID ( BIC_ IN VARCHAR2 ) RETURN VARCHAR2
IS
BEGIN

   return get_charset_id(bic_);

END;


--**************************************************************--
--
-- Returns our bank as S.W.I.F.T. Sender
-- Eve
--**************************************************************--
FUNCTION GetOurBankAsSender RETURN VARCHAR2
IS
BEGIN

  return get_ourbank_bic;

END GetOurBankAsSender;



--**************************************************************--
-- Creates a message record in SW_JOURNAL and return newly
-- created SWREF
-- Abyss
--**************************************************************--
FUNCTION CreateMessageHeader(
    mt_             IN NUMBER,
    sender_         IN VARCHAR2,
    receiver_       IN VARCHAR2,
    page_no_        IN NUMBER
    )
    RETURN NUMBER
IS

    return_val  NUMBER;
    mtid        VARCHAR2(16);
    l_msgAppHdrFlg sw_journal.app_flag%type  := 'N';


BEGIN
    SELECT s_sw_journal.NEXTVAL INTO return_val FROM dual;
    mtid := GetSWIFTField20(return_val, receiver_);

    INSERT INTO sw_journal
        (swref,mt,io_ind,trn,page,date_in,sender,receiver, app_flag, flags, sti, uetr)
    VALUES
        ( return_val, mt_, 'I', mtid, SUBSTR('000'||page_no_,-3), sysdate, sender_, receiver_, l_msgAppHdrFlg, 'L', '001', bars_swift.generate_uetr);

    RETURN return_val;

END CreateMessageHeader;






--**************************************************************--
-- Convert currency amount to SWIFT format
-- Eve
--**************************************************************--
FUNCTION AmountToSWIFT(
    Amount_             IN NUMBER,
    Currency_Code       IN NUMBER,
    IsLeading           IN BOOLEAN,
    HasCurrency         IN BOOLEAN ) RETURN VARCHAR2 IS

    work_str            VARCHAR2(100);  --Work string
    diggital_places     NUMBER;         --Digital palces for spesific curency
    currency_str        CHAR(3);        --3 chars of curency code
BEGIN
    --Selecting Dig fraction
    BEGIN
       SELECT dig,lcv INTO diggital_places, currency_str
       FROM tabval WHERE kv=Currency_Code;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
        diggital_places := 2;
     currency_str    := 'UAH';
    END;

    --Defining amount and converting it to string
    SELECT ABS(Amount_)/Power(10,diggital_places) INTO work_str FROM DUAL;

    --Substituting '.' to ','
    SELECT REPLACE(work_str,'.',',') INTO work_str FROM dual;

    --Adding ',' if integer
    IF INSTR(work_str,',')=0 THEN
        work_str:=work_str || ',';
    END IF;

    --Adding leading zero if needed
    IF SUBSTR(work_str,1,1)=',' THEN
        work_str:='0' || work_str;
    END IF;

    --Adding currency code
    IF HasCurrency THEN
        IF IsLeading THEN
            work_str:=currency_str || work_str;
        ELSE
            work_str:=work_str || currency_str;
        END IF;
    END IF;

    RETURN work_str;
END AmountToSWIFT;

--**
FUNCTION WRAP_STR (
  STR VARCHAR2,
  WRAP_WIDTH NUMBER ) RETURN VARCHAR2
IS
  RESULT VARCHAR2(2000);
  TAIL VARCHAR2(2000);
  l_flag  boolean;

BEGIN
  RESULT:='';
  TAIL :=STR;
  WHILE LENGTH(TAIL)>0
  LOOP
    IF LENGTH(RESULT)>0 THEN
      RESULT:=RESULT || CHR(13) || CHR(10);
    END IF;

      --
      -- В поле новая строка не может начинаться с
      -- символов - : { }
      --
      l_flag := true;

      while (l_flag)
      loop

          if (substr(tail, 1, 1) in ('-', ':', '{', '}')) then
              tail := substr(tail, 2);
          else
              l_flag := false;
          end if;

      end loop;

      --
      -- В поле первый символ '.' меняем на ','
      --
      if (substr(tail, 1, 1) = '.') then
          tail := ',' || substr(tail, 2);
      end if;


    RESULT := RESULT || SUBSTR(TAIL,1,WRAP_WIDTH);

    IF LENGTH(TAIL)>WRAP_WIDTH THEN
       TAIL:=SUBSTR(TAIL,WRAP_WIDTH+1, LENGTH(TAIL)-WRAP_WIDTH );
    ELSE
       TAIL:='';
    END IF;

  END LOOP;

  RESULT := rtrim(RESULT);

  -- Убираем последний символ "перевод строки"
  if ( substr(RESULT,-2) = CHR(13) || CHR(10) ) then
      RESULT := substr(RESULT, 1, length(RESULT)-2);
  end if;

  RETURN RESULT;

END;





--**************************************************************--
-- FormatFieldOption()
--     Функция форматирует неформатированные данные согласно
--     заранее определенному формату. Если входная строка со-
--     держит символы разметки (CRLF), то функция производит
--     выход и не выдает сообщений об ошибке
--
-- DG
--**************************************************************--
function FormatFieldOption(
    p_fldTag      in  varchar2,
    p_fldOption   in  varchar2,
    p_fldValue    in  varchar2 ) return varchar2
is

l_pos      number;
l_firPart  varchar2(35);

begin

    -- Если входная строка содержит форматирование - выходим
    if (instr(p_fldValue, CRLF) != 0) then
        return p_fldValue;
    end if;

    if (p_fldTag in ('56', '57') and p_fldOption = 'D') then

        -- Значение должно иметь след. вид:
        --     /XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        --     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        --     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        --     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        --     AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
        --

        if (substr(p_fldValue, 1, 1) != '/') then
            return p_fldValue;
        end if;

        l_pos := instrc(p_fldValue, ' ');
        if (l_pos != 0) then

            if (l_pos > 35) then
                l_pos:= 35;
            end if;

            l_firPart := substr(p_fldValue, 1, l_pos);

            return l_firPart || CRLF || substr(ltrim(wrap_str(substr(p_fldValue, l_pos+1), 40)), 1, 167);

        else
            return p_fldValue;
        end if;

    end if;

    return p_fldValue;

end FormatFieldOption;




--**************************************************************--
-- Convert currency amount from SWIFT format
--
-- DG
--**************************************************************--

PROCEDURE SwiftToAmount(
    p_swiftAmount       IN  VARCHAR2,
    p_currCode          OUT NUMBER,
    p_amount            OUT NUMBER )
IS

    l_currency          varchar2(3);
    l_currCode          number;
    l_currDig           number;
    l_amount            varchar2(38);

BEGIN

    -- extracting currency
    l_currency := substr(ltrim(rtrim(p_swiftAmount)), 1, 3);

    -- validate currency and selecting dig fraction
    begin
        select kv, dig into l_currCode, l_currDig
          from tabval
         where lcv = l_currency;
    exception
       when NO_DATA_FOUND then
           raise_application_error(-20787, '\001 Не найден код для валюты ' || l_currency);
    end;

    l_amount := substr(ltrim(rtrim(p_swiftAmount)), 4);

    -- check to decimal separator
    if (instr(l_amount, ',') is null or instr(l_amount, ',') = 0) then
           raise_application_error(-20787, '\002 Ошибка в формате суммы. Символ "," не найден');
    end if;

    -- searching position ','
    while (length(l_amount) - instr(l_amount, ',') < l_currDig)
    loop
        l_amount := l_amount || '0';
    end loop;

    p_currCode   := l_currCode;
    p_amount := to_number(replace(l_amount, ',', ''));

END SwiftToAmount;


--**************************************************************--
-- Load translation table
-- Eve
--**************************************************************--
PROCEDURE LoadTransTable(Charset_ VARCHAR2)
IS
  CURSOR substitution_table IS
    SELECT ru_char,sw_char,chrset
    FROM sw_volap
    WHERE (chrset=Charset_)
    ORDER BY LENGTH(sw_char) DESC, ru_char DESC;
  i  BINARY_INTEGER;
  loaded BOOLEAN;
BEGIN
  -- Loading only if it is not loaded
  BEGIN
    IF RTables(Charset_).COUNT=0 THEN
      NULL;
    END IF;
    loaded:=True;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      loaded:=False;
  END;
  IF NOT loaded THEN
    i:=0;
    OPEN substitution_table;
    LOOP
      i := i + 1;
      FETCH substitution_table INTO RTables(Charset_)(i);
      EXIT WHEN substitution_table%NOTFOUND;
    END LOOP;
    CLOSE substitution_table;
  END IF;
END LoadTransTable;

--**************************************************************--
-- Returns Value_ with string Old_ replaced with New_
-- Text within quotes ' ' remains unchanged
-- Eve
--**************************************************************--
FUNCTION REPLACE_SW(Value_ IN VARCHAR2, Old_ IN VARCHAR2, New_ IN VARCHAR2) RETURN VARCHAR2
IS
  tmpStr   VARCHAR2(4000);
  i        BINARY_INTEGER;
  InQuote  BOOLEAN;
  CurChar  VARCHAR2(1);
BEGIN
  -- Пока не в кавычках
  InQuote:=False;
  i:=1;
  tmpStr:='';
  -- Цикл по символам строки
  LOOP
    -- Если дошли до конца строки - выход
    IF i>NVL(LENGTH(Value_),0) THEN
      EXIT;
    END IF;
    -- Текущий символ
    CurChar:=SUBSTR(Value_,i,1);
    IF InQuote THEN  -- Если мы в кавычках
      -- Определяем закрытие кавычек
      IF CurChar='''' THEN
        InQuote:=False;
      END IF;
      -- Сборка строки результата
      tmpStr:=tmpStr || CurChar;
    ELSE -- Если мы не в кавычках
      -- Определяем открытие кавычек
      IF CurChar='''' THEN
        InQuote:=True;
        -- Сборка строки результата
        tmpStr:=tmpStr || CurChar;
      ELSIF SUBSTR(Value_,i,LENGTH(Old_))=Old_ THEN
        -- Мы не в кавычках и нашли строку для замены - заменяем
        tmpStr:=tmpStr || trim(New_);
        i:=i+LENGTH(Old_)-1;
      ELSE
        tmpStr:=tmpStr || CurChar;
      END IF;
    END IF;
    i:=i+1;
  END LOOP;
  RETURN tmpStr;
END REPLACE_SW;

--**************************************************************--
-- Returns Value_ with english words in quotes ' '
-- and single quote replaced with doubled
-- Eve   + (mik прирезал разные вольности)
--**************************************************************--
FUNCTION T2SW(Value_ IN VARCHAR2) RETURN VARCHAR2
IS
 tmpStr   VARCHAR2(4000):='';
 i        INT           := 1;
BEGIN
   WHILE i <= LENGTH(Value_) LOOP
      IF SUBSTR(Value_,i) LIKE '(VO_____)%'
      OR SUBSTR(Value_,i) LIKE '(ВО_____)%' THEN
         tmpStr:=tmpStr||''''||SUBSTR(Value_,i,9)||'''';
         i := i + 9;
      ELSIF SUBSTR(Value_,i,1)='''' THEN
         i := i + 1;
      ELSE
         tmpStr:=tmpStr||SUBSTR(Value_,i,1);
         i := i + 1;
      END IF;
   END LOOP;
   RETURN tmpStr;
END;
/* mik
FUNCTION T2SW(Value_ IN VARCHAR2) RETURN VARCHAR2
IS
  tmpStr   VARCHAR2(4000);
  i        BINARY_INTEGER;
  InEn     BOOLEAN;
  CurChar  VARCHAR2(1);
  NextChar VARCHAR2(1);
  -- Детектор английских букв
  FUNCTION IsEN( Value_ IN VARCHAR2 ) RETURN BOOLEAN
  IS
  BEGIN
    RETURN (Value_>='A' AND Value_<='Z') OR
           (Value_>='a' AND Value_<='z');
  END;
  -- Детектор русских букв
  FUNCTION IsRU( Value_ IN VARCHAR2 ) RETURN BOOLEAN
  IS
  j        BINARY_INTEGER;
  BEGIN
    RETURN (Value_>='А' AND Value_<='Я') OR
           (Value_>='а' AND Value_<='я');
  END;
  -- Поиск следующего символа в строке
  FUNCTION FindNextChar( Value_ IN VARCHAR2, Position_ BINARY_INTEGER ) RETURN VARCHAR2
  IS
    j        BINARY_INTEGER;
    CurChar  VARCHAR2(1);
  BEGIN
    FOR j IN Position_..NVL(LENGTH(Value_),0) LOOP
      CurChar:=SUBSTR(Value_,j,1);
      IF IsEN(CurChar) OR IsRU(CurChar) THEN
        RETURN CurChar;
      END IF;
    END LOOP;
    RETURN '';
  END;
BEGIN
  -- Язык русский
  InEn:=False;
  i:=1;
  tmpStr:='';
  -- Цикл по символам строки
  LOOP
    -- Если дошли до конца строки - выход
    IF i>NVL(LENGTH(Value_),0) THEN
      EXIT;
    END IF;
    -- Текущий символ
    CurChar:=SUBSTR(Value_,i,1);
    IF CurChar='''' THEN
      -- Одинарную кавычку заменяем на двойную
      tmpStr:=tmpStr || '''''';
    ELSIF InEn THEN -- Если язык английский
      -- Ищем следующий символ
      NextChar:=FindNextChar(Value_,i);
      IF NextChar='' THEN -- Елси до конца строки ни одного символа
        -- Заканчиваем строку кавычкой и выходим из процедуры
        tmpStr:=tmpStr || SUBSTR(Value_,i,LENGTH(Value_)-i) || '''';
        RETURN tmpStr;
      ELSIF IsRU(NextChar) THEN -- Если следующий символ русский
        -- Смена языка
        tmpStr:=tmpStr || '''';
        InEn:=False;
      END IF;
      -- Сборка строки результата
      tmpStr:=tmpStr || CurChar;
    ELSE -- Если язык русский
      IF IsEN(CurChar) THEN  -- И найден английский символ
        -- Смена языка
        tmpStr:=tmpStr || '''';
        InEn:=True;
      END IF;
      -- Сборка строки результата
      tmpStr:=tmpStr || CurChar;
    END IF;
    i:=i+1;
  END LOOP;
  IF InEn THEN
    RETURN tmpStr||'''';
  ELSE
    RETURN tmpStr;
  END IF;
END T2SW;
*/

/* Правила построения таблицы перекодирования (SW_VOLAP)
   1. Для каждого набора символов (CHRSET) должно быть однозначное
      соответствие между последовательностями в обе стороны преобразования
   2. Поле SW_CHAR в пределах каждого набора символов должно cодержать
      все допустиммые единичные символы SWIFT, которые не перекодируются
      (например символ H, (, ) и т.д. в наборе TRANS)
*/
--**************************************************************--
-- Returns Value_ with doubled quotes replaced with single and
-- and single quote removed
-- Eve
--**************************************************************--
FUNCTION SW2T(Value_ IN VARCHAR2) RETURN VARCHAR2
IS
  tmpStr   VARCHAR2(4000);
  i        BINARY_INTEGER;
BEGIN
  tmpStr:='';
  i:=1;
  LOOP
    -- Если дошли до конца строки - выход
    IF i>NVL(LENGTH(Value_),0) THEN
      EXIT;
    END IF;
    IF i<LENGTH(Value_) AND SUBSTR(Value_,i,1)='''' AND SUBSTR(Value_,i+1,1)='''' THEN
      -- Двойная кавычка заменяется на одинарную
      tmpStr:=tmpStr || '''';
      i:=i+1;
    ELSIF SUBSTR(Value_,i,1)<>'''' THEN
      -- Не одинарная кавычка - собираем строку
      tmpStr:=tmpStr || SUBSTR(Value_,i,1);
    END IF;
    i:=i+1;
  END LOOP;
  RETURN tmpStr;
END SW2T;

    -------------------------------------------------------------------
    -- STRVERIFY()
    --
    --     Функция удаляет из строки все символы, которые не
    --     представлены в указанной таблице перекодировки
    --
    function strVerify(
                 p_value    in varchar2,
                 p_charset  in sw_chrsets.setid%type ) return varchar2
    is

    l_tmpStr   varchar2(4000)  := '';
    l_curChar  varchar2(1);
    l_curIncl  boolean;
    l_curFirst boolean;
    RTable     TransliterateTable;

    begin

        -- Получаем указанную таблицу перекодировки
        RTable := RTables(p_charset);

        -- Устанавливаем признак первого символа строки
        l_curFirst := true;

        -- Проверяем допустимость каждого символа строки
        for i in 1..nvl(length(p_value), 0)
        loop

          -- Получаем текущий символ и очищаем фалг вхождения
          l_curChar := substr(p_value, i, 1);
          l_curIncl := false;

          -- Ищем в таблице перекодировки данный символ
          for j in 1..RTable.count
          loop

            if (length(ltrim(rtrim(RTable(j).sw_char))) = 1 and l_curChar = ltrim(rtrim(RTable(j).sw_char))) then
                l_curIncl := true;
                exit;
            end if;

          end loop;

          -- Если установлен флаг или спец. символы, то включаем в строку
          if (l_curIncl or l_curChar in (chr(10), chr(13), ' ')) then

              -- Если это первый символ строки, то доп. контроль
              if (l_curFirst) then

                  if (l_curChar not in (chr(13), chr(10), ' ', ':', '-', '{', '}')) then
                      l_tmpStr:= l_tmpStr || l_curChar;
                  end if;

                  l_curFirst := false;

              else
                  l_tmpStr:= l_tmpStr || l_curChar;
              end if;

              -- Проверяем на перевод строки
              if (l_curChar = chr(10)) then
                  l_curFirst := true;
              end if;

          end if;

        end loop;

        return l_tmpStr;

    end strVerify;



    -------------------------------------------------------------------
    -- STRVERIFY2()
    --
    --     Функция удаляет из строки все символы, которые не
    --     представлены в указанной таблице перекодировки
    --
    function strVerify2(
                 p_value    in varchar2,
                 p_charset  in sw_chrsets.setid%type ) return varchar2
    is
    begin
        LoadTransTable(p_charset);
        return strVerify(p_value, p_charset);
    end strVerify2;



    -------------------------------------------------------------------
    -- STRTOSWIFT()
    --
    --     Функция переконвертации строки в кодировку SWIFT
    --
    --
    function StrToSwift(
                 p_value    in  varchar2,
                 p_charset  in  sw_chrsets.setid%type default 'TRANS') return varchar2
    is

    l_tmpStr              varchar2(4000);

    i                   BINARY_INTEGER;
    RTable              TransliterateTable;

    begin

        if (p_value is null) then return null;
        end if;

        -- Загружаем таблицу транслитерации
        LoadTransTable(p_charset);

        -- Переводим строку в верхний регистр
        l_tmpStr := upper(rtrim(ltrim(p_value)));

        -- Для перекодировки в RUR6 вставляем в строку разметку
        if (p_charset = 'RUR6') then
            l_tmpStr := t2sw(l_tmpStr);
        end if;

        RTable := RTables(p_charset);

        -- Заменяем символы по таблице
        for i in 1..RTable.count
        loop

            -- Заменять нужно только те символы, которые не повторяются
            if (RTable(i).ru_char != ltrim(rtrim(RTable(i).sw_char))) then

                -- Для таблицы перекодировки RUR6 используем
                -- отдельную функцию, которая распознает разметку
                if (p_charset = 'RUR6') then
                    l_tmpStr := replace_sw(l_tmpStr, RTable(i).ru_char, ltrim(rtrim(RTable(i).sw_char)));
                else
                    l_tmpStr := replace(l_tmpStr, RTable(i).ru_char, ltrim(rtrim(RTable(i).sw_char)));
                end if;

            end if;

        end loop;

        -- исключаем из строки все символы, которых нет в таблице перекодировки
        l_tmpStr := strVerify(l_tmpStr, p_charset);

        return l_tmpStr;

    end StrToSwift;

--**************************************************************--
-- SWIFT char set string to actual
-- Eve+mik
--**************************************************************--
FUNCTION SwiftToStr(Value_ IN VARCHAR2, Charset_ VARCHAR2 DEFAULT 'TRANS') RETURN VARCHAR2
IS
    tmpStr              VARCHAR2(300) := '';
    i                   BINARY_INTEGER;
    RTable              TransliterateTable;
    x   smallint :=0;
BEGIN
  IF Value_ IS NULL THEN
    RETURN NULL;
  END IF;
  -- Загружаем таблицу транслитерации
  LoadTransTable(Charset_);
  -- Заменяем символы используя разметку (если она, конечно, есть в тексте )

  if Charset_='RUR6' THEN
-- додамо ще розмітки, по кодовим словам
     for i IN 1..LENGTH(Value_) LOOP
        if i=1 and SUBSTR(Value_,i,1)='/' and SUBSTR(Value_,i,2)<>'//' or
           i=2 and SUBSTR(Value_,i-1,2)='//' or
           i>2 and SUBSTR(Value_,i-1,2)=chr(10)||'/'  then
           if x=0 then x:=1;tmpStr:=tmpStr||'/'''; end if;
        elsif i>2 and SUBSTR(Value_,i,1)='/'  then
           if x=1 then x:=0;tmpStr:=tmpStr||'''/'; else  tmpStr:=tmpStr||SUBSTR(Value_,i,1); end if;  --else оставляем / внутри строки если есть
        elsif SUBSTR(Value_,i,1)=chr(10) and x=1 then
           tmpStr:=tmpStr||SUBSTR(Value_,i,1)||''''; x:=0;
        else
           tmpStr:=tmpStr||SUBSTR(Value_,i,1);
        end if;
     end loop;
  else
     tmpStr:=Value_;
  end if;

  RTable:=RTables(Charset_);
  FOR i IN 1..RTable.COUNT LOOP
    IF NVL(TRIM(RTable(i).ru_char),' ')<>NVL(TRIM(RTable(i).sw_char),' ') THEN
       tmpStr := REPLACE_SW(tmpStr, NVL(TRIM(RTable(i).sw_char),' '),
                                    NVL(TRIM(RTable(i).ru_char),' '));
    END IF;
  END LOOP;
  -- Удаляем разметку из текста
  tmpStr:=SW2T(tmpStr);
  RETURN tmpStr;
END SwiftToStr;


--**************************************************************--
-- Получение строки суммы в формате SWIFT
-- STA
--**************************************************************--
FUNCTION SW_AMOUNT(tag_ VARCHAR2, value_ VARCHAR2) RETURN NUMBER
IS
   n_  NUMBER;
   i_  INT;
   S1_ CHAR(1);
   ss_ VARCHAR2(15);
BEGIN
    n_:=0;
    IF TAG_ IN ('60',62) THEN
        IF substr(VALUE_,1,1)='C' THEN
             N_:= 1;
        ELSE
             N_:= -1;
        END IF;

        SS_ := SUBSTR(VALUE_, 11);
        SS_ := REPLACE(SS_, ',', '.');

        RETURN (N_ * TO_NUMBER(SS_) * 100);

    ELSIF TAG_ = '61' THEN
        IF swift.IS_ALFA(SUBSTR(VALUE_,7,1))=0 THEN
            I_:=11;
        ELSE
            I_:=7;
        END IF;
        IF    SUBSTR( VALUE_,I_,2) = 'RC'  THEN  I_:=I_+ 2; N_:= -1;
        ELSIF SUBSTR( VALUE_,I_,2) = 'RD'  THEN  I_:=I_+ 2; N_:=  1;
        ELSIF SUBSTR( VALUE_,I_,1) = 'D'   THEN  I_:=I_+ 1; N_:= -1;
        ELSIF SUBSTR( VALUE_,I_,1) = 'C'   THEN  I_:=I_+ 1; N_:=  1;
        END IF;
        IF swift.IS_ALFA(SUBSTR(VALUE_,I_,1))<>0 THEN
            I_:=I_+1;
        END if;

        SS_:='0';
        WHILE TRUE
        LOOP
            S1_:= SUBSTR(VALUE_,I_,1);
            IF SWIFT.IS_ALFA(S1_)=0 THEN
                SS_:= SS_ || S1_;
            ELSIF S1_ = ','         THEN
                SS_:= SS_ || '.';
            ELSE
                RETURN(N_*TO_NUMBER(SS_)*100 ) ;
            END IF;
            I_:= I_ + 1;
        END LOOP;
    END IF;
    RETURN 0;
END SW_AMOUNT;

--**************************************************************--
-- STA
--**************************************************************--
FUNCTION IS_ALFA(SIM_ CHAR) RETURN NUMBER
IS
-- = 0 цифра
-- = 1 не цифра
BEGIN
    IF SIM_ IN ('0','1','2','3','4','5','6','7','8','9') THEN
        RETURN 0;
    ELSE
        RETURN 1;
    END IF;
END IS_ALFA;



function PrepStr(
           p_srcStr in varchar2 ) return varchar2
is

l_tmp   varchar2(4000);

begin


    l_tmp := replace(p_srcStr, chr(13) || chr(10), '/+CRLF/');
    l_tmp := substr(StrToSWIFT(l_tmp), 1, 4000);
    l_tmp := replace(l_tmp, '"', '');

    l_tmp := replace(l_tmp, '''''', '"');
    l_tmp := replace(l_tmp, '''', '');
    l_tmp := replace(l_tmp, '"', '''''');
    l_tmp := replace(l_tmp, '/+CRLF/', chr(13) || chr(10));

    -- Убираем лишние переводы строк (сначала строки и в конце строки)
    l_tmp := ltrim(l_tmp, chr(13) || chr(10));
    l_tmp := rtrim(l_tmp, chr(13) || chr(10));

    return l_tmp;

end PrepStr;






--**************************************************************--
-- MT 940/950
-- Satement Message
--**************************************************************--
PROCEDURE CreateAllStatementMessages(
    date_start      IN DATE,
    date_end        IN DATE)
IS
    CURSOR all_stmt_customers IS
    SELECT rnk, bic
    FROM SW_STMT_CUSTOMER_LIST;
BEGIN
    FOR c_var IN all_stmt_customers LOOP
      CreateCustomerStatementMessage(c_var.bic, c_var.rnk, date_start, date_end);
    END LOOP;
END CreateAllStatementMessages;


--**************************************************************--
PROCEDURE ResetStmtNumbers IS
BEGIN
    UPDATE sw_stmt_info
    SET statement_number=0
    WHERE acc IN (
      SELECT a.acc
      FROM accounts a, sw_stmt_info aj, sw_journal j
      WHERE
        a.acc=aj.acc AND
        aj.last_message_ref=j.swref AND
        (j.date_rec IS NOT NULL) AND
        TO_CHAR(j.date_rec,'yyyy')<TO_CHAR(BankDate,'yyyy'));
END ResetStmtNumbers;

--**************************************************************--
FUNCTION Any_Turns(
    acc_            IN NUMBER,
    date_start      IN DATE,
    date_end        IN DATE) RETURN BOOLEAN
IS
  Trans_Count_ NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO Trans_Count_
    FROM OPLDOK
   WHERE ACC=acc_
     AND FDAT BETWEEN date_start AND date_end
     AND S > 0
     AND SOS=5;
  RETURN (Trans_Count_>0);
END Any_Turns;

--**************************************************************--
PROCEDURE SheduleStatementMessages
IS
    CURSOR stmt_accounts IS
    SELECT
      c.bic receiver,
      a.acc,
      NVL(j.date_rec,BankDate-1) last_stmt,
      NVL(s.freq,1) period,
      BankDate cur_dat
    FROM
      accounts a,
      cust_acc ac,
      sw_stmt_customer_list c,
      stmt s,
      sw_journal j,
      sw_stmt_info aj,
      sw_acc_sparam p
    WHERE
      (a.acc=ac.acc) AND
      (ac.rnk=c.rnk) AND
      (c.stmt=s.stmt) AND
      (a.acc=aj.acc(+)) AND
      (aj.last_message_ref=j.swref(+)) AND
      (p.use4mt950=1) AND
      (a.acc = p.acc) AND
      LENGTH(c.bic)>0
    ORDER BY
      c.rnk,a.nls,a.kv;

    FUNCTION NeedForming(
        Term_Begin  DATE,
        Term_End    DATE,
        Code_       NUMBER) RETURN BOOLEAN
    IS
    BEGIN
        IF Code_=1 THEN               --Every day
          RETURN Term_End>Term_Begin;
        ELSIF Code_=3 THEN            --Every week
          RETURN (Term_End-Term_Begin) > 7;
        ELSIF Code_=5 THEN            --Every month
          RETURN (Term_End-Term_Begin) > 30;
        ELSIF Code_=7 THEN            --Every quarter
          RETURN (Term_End-Term_Begin) > 90;
        ELSIF Code_=180   THEN        --Twice a year
          RETURN (Term_End-Term_Begin) > 182;
        ELSIF Code_=360   THEN        --Every year
          RETURN (Term_End-Term_Begin) > 365;
        ELSE
          RETURN FALSE;
        END IF;
    END;

BEGIN
    --Resetting message numbers for sw_stmw_info to zero
    ResetStmtNumbers;
    --Sheduling
    FOR c_var IN stmt_accounts LOOP
        IF (NeedForming(c_var.last_stmt,BankDate,c_var.period)) THEN
            CreateStatementMessage(
              c_var.receiver,
              c_var.acc,
              c_var.last_stmt,
              c_var.cur_dat);
        END IF;
    END LOOP;
END SheduleStatementMessages;

--**************************************************************--
PROCEDURE CreateBankStatementMessage(
    rnk_            IN NUMBER,
    date_start      IN DATE,
    date_end        IN DATE)
IS
    CURSOR all_bank_accounts (cust_id NUMBER)
    IS
    SELECT
      a.acc,
      c.bic,
          b.stmt
    FROM
      cust_acc a,customer b,custbank c,accounts d, sw_acc_sparam p
    WHERE
      a.rnk=cust_id AND
      a.rnk=b.rnk AND
      b.rnk=c.rnk AND
      a.acc=d.acc AND
      d.dazs IS NULL AND
      p.use4mt950=1 AND
      d.acc = p.acc
    ORDER BY
      d.nls,d.kv;
  SWIFTIES_   BOOLEAN;
  N_SWIFTIES_ NUMBER;
BEGIN
  -- Флаг включения в выписку счетов без оборотов за формируемый период
  BEGIN
    SELECT TO_NUMBER(VAL) INTO N_SWIFTIES_ FROM PARAMS WHERE PAR='SWIFTIES';
    SWIFTIES_:=(N_SWIFTIES_=1);
  EXCEPTION
    WHEN OTHERS THEN SWIFTIES_ := TRUE;
  END;
  FOR c_var IN all_bank_accounts(rnk_) LOOP
    IF SWIFTIES_ OR Any_Turns( c_var.acc,date_start,date_end ) THEN
      CreateStatementMessage(c_var.bic,c_var.acc,date_start,date_end,c_var.stmt );
    END IF;
  END LOOP;
END CreateBankStatementMessage;

--**************************************************************--
PROCEDURE CreateCustomerStatementMessage(
    receiver_       IN VARCHAR2,
    rnk_            IN NUMBER,
    date_start      IN DATE,
    date_end        IN DATE,
        stmt_           IN NUMBER DEFAULT NULL)
IS
    CURSOR all_cust_accounts (cust_id NUMBER)
    IS
    SELECT
      a.acc,
      NVL(c.bic,receiver_) bic,
          b.stmt
    FROM
      cust_acc a,customer b,custbank c,accounts d,sw_acc_sparam p
    WHERE
      a.rnk=cust_id AND
      a.rnk=b.rnk AND
      a.acc=d.acc AND
      b.rnk=c.rnk(+) AND
      d.dazs IS NULL AND
      p.use4mt950=1 AND
      d.acc = p.acc
    ORDER BY
      d.nls,d.kv;
  SWIFTIES_   BOOLEAN;
  N_SWIFTIES_ NUMBER;
  true_stmt_  NUMBER;
BEGIN

  -- Флаг включения в выписку счетов без оборотов за формируемый период
  BEGIN
    SELECT TO_NUMBER(VAL) INTO N_SWIFTIES_ FROM PARAMS WHERE PAR='SWIFTIES';
    SWIFTIES_:=(N_SWIFTIES_=1);
  EXCEPTION
    WHEN OTHERS THEN SWIFTIES_ := TRUE;
  END;
  --IF SWIFTIES_ THEN
  --  DBMS_OUTPUT.PUT_LINE('SWIFTIES_ := TRUE');
  --ELSE
  --  DBMS_OUTPUT.PUT_LINE('SWIFTIES_ := FALSE');
  --END IF;
  FOR c_var IN all_cust_accounts(rnk_) LOOP
    IF stmt_ IS NULL THEN
          true_stmt_ := c_var.stmt;
        ELSE
          true_stmt_ := stmt_;
        END IF;
    IF SWIFTIES_ OR Any_Turns( c_var.acc,date_start,date_end ) THEN
      IF LENGTH(c_var.bic)=0 THEN
        CreateStatementMessage(receiver_,c_var.acc,date_start,date_end,true_stmt_);
      ELSE
        CreateStatementMessage(c_var.bic,c_var.acc,date_start,date_end,true_stmt_);
      END IF;
    END IF;
  END LOOP;
END CreateCustomerStatementMessage;

--**************************************************************--
--Internal convertion functions
/* Testing function for REM_LEAD_SIMBOL
PROCEDURE CHECK_REM_LEAD_SIMBOL
IS
BEGIN
  IF REM_LEAD_SIMBOL('---ASDFG346456F', '-' )<>'ASDFG346456F' OR
     REM_LEAD_SIMBOL('-ASDFG346456F', '-' )<>'ASDFG346456F' OR
     REM_LEAD_SIMBOL('-', '-' )<>'' OR
     REM_LEAD_SIMBOL('---', '-' )<>'' OR
     REM_LEAD_SIMBOL('ASDFG346456F---', '-' )<>'ASDFG346456F---' THEN
    RAISE_APPLICATION_ERROR(-(20001),'Ошибка в работе функции!',TRUE);
  END IF;
END;*/

FUNCTION REM_LEAD_SIMBOL (
  S VARCHAR2,
  SIMBOL CHAR ) RETURN VARCHAR2
IS
  RESULT VARCHAR2(2000);
BEGIN
  RESULT:=S;
  WHILE SUBSTR(RESULT,1,1)=SIMBOL
  LOOP
    RESULT := SUBSTR(RESULT,2,LENGTH(RESULT)-1);
  END LOOP;
  RETURN RESULT;
END;
--**************************************************************--
PROCEDURE CreateStatementMessage(
    receiver_       IN VARCHAR2,
    acc_            IN NUMBER,
    date_start      IN DATE,
    date_end        IN DATE,
    stmt_           IN NUMBER DEFAULT 10
        )
IS
    --All account's transactions

    CURSOR all_account_transactions(priod_start date, period_finish date) IS
      SELECT
        a.ref,
        a.stmt,
        a.fdat,
        a.dk,
        NVL(t.swtt,'MCS') tt,
        s.mt swtt,
        s.trn,
        a.s,
        b.nazn
      FROM opldok a, oper b, sw_tt_tts t,sw_oper l, sw_journal s
      WHERE
        (a.ref=b.ref) AND
        (a.tt=t.tt(+)) AND
        (a.ref=l.ref(+)) AND
        (l.swref=s.swref(+)) AND
        (a.sos=5) AND
        (a.acc=acc_) AND
        (a.fdat BETWEEN priod_start AND period_finish)
      ORDER BY
        a.dk, a.s;

    --Variables

    trn_var                     NUMBER;
    sw_ref                      NUMBER;
    trn_                        VARCHAR2(50);
    page_no                     NUMBER;
    account_identification      VARCHAR2(19);
    account_curency_code        NUMBER;
    stmt_number                 NUMBER;
    opening_balance             NUMBER;
    closing_balance             NUMBER;
    balance                     NUMBER;
    account_limit               NUMBER;
    available_funds             NUMBER;
    line_number                 NUMBER(3) := 1;
    field_contents              VARCHAR2(500);
    curency_chars               CHAR(3);
    real_date_start             DATE;
    real_date_end               DATE;
    acc_opened                  DATE;
    acc_closed                  DATE;
    max61count                  INTEGER := 20;
    count_                      INTEGER := 0;
    moves                       NUMBER := 0;
    prev_fdat                   DATE;
    sw_nazn                     VARCHAR2(320);

    l_msgLen                    number;         -- длина сообщения
    l_maxlinesize               number;         -- макс. длина детальной строки выписки
    l_curlinesize               number;         -- длина текущей строки выписки

    l_field61                   sw_operw.value%type;
    l_field86                   sw_operw.value%type;


    --Internal functions
    --************************HEADER************************************
    PROCEDURE CreateFileHeader(
        receiver_                   IN VARCHAR2,
        acc_                        IN NUMBER,
        date_start                  IN DATE,
        trn_var                     IN OUT NUMBER,
        sw_ref                      IN OUT NUMBER,
        page_no                     IN OUT NUMBER,
        account_identification      IN OUT VARCHAR2,
        stmt_number                 IN OUT NUMBER,
        opening_balance             IN OUT NUMBER,
        line_number                 IN OUT NUMBER,
        field_contents              IN OUT VARCHAR2,
        curency_chars               IN OUT CHAR,
        real_date_start             IN OUT DATE,
        is_first_stmt               IN BOOLEAN
    ) IS
        f60modificator_             CHAR(1);
        l_dc                        char(1);
        l_custSWS86                 varchar2(200);

    BEGIN
        --Creating SWIFT message header
        IF stmt_ = 10 THEN
           trn_var := CreateMessageHeader( 950, GetOurBankAsSender(), receiver_, page_no );
        ELSIF stmt_ = 11 THEN
           trn_var := CreateMessageHeader( 940, GetOurBankAsSender(), receiver_, page_no );
        END IF;
        IF trn_var = 0 THEN
           RAISE INVALID_NUMBER;
        END IF;

        IF sw_ref IS NULL THEN
           sw_ref := trn_var;
        END IF;

        --Creating MT header
        --TRN
        --field_contents:= GetSWIFTField20(sw_ref, receiver_);
        IF stmt_ = 10 or stmt_ = 11 THEN
           select trn into field_contents from sw_journal where swref = trn_var;
        else
           field_contents := GetSWIFTField20(sw_ref, receiver_);
        end if;
        trn_ := field_contents;
        INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
        VALUES (trn_var, '20', 'A', line_number, NULL, field_contents);
        line_number := line_number + 1;
        l_msgLen    := l_msgLen + nvl(length(field_contents), 0) + 3 + 2; /* 20: ... CR LF */

        --Acc ID
        field_contents:=account_identification;
        INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
        VALUES (trn_var, '25', 'A', line_number, NULL, field_contents);
        line_number := line_number + 1;
        l_msgLen    := l_msgLen + nvl(length(field_contents), 0) + 3 + 2; /* 25: ... CR LF */

        --Stmt N
        field_contents:=SUBSTR('000'||stmt_number,-3)||'/'||SUBSTR('000'||page_no,-3);
        INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
        VALUES (trn_var, '28', 'A', line_number, 'C', field_contents);
        line_number := line_number + 1;
        l_msgLen    := l_msgLen + nvl(length(field_contents), 0) + 3 + 2; /* 28: ... CR LF */

        IF is_first_stmt THEN
           f60modificator_ := 'F';
        ELSE
           f60modificator_ := 'M';
        END IF;

        --Opening balance
        if (opening_balance < 0) then
            l_dc := 'D';
        else
            l_dc := 'C';
        end if;

        field_contents:= l_dc || TO_CHAR(real_date_start,'yymmdd') ||
                        AmountToSWIFT(abs(opening_balance), account_curency_code, TRUE, TRUE);
        INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
        VALUES (trn_var, '60', 'A', line_number, f60modificator_, field_contents);
        line_number := line_number + 1;
        l_msgLen    := l_msgLen + nvl(length(field_contents), 0) + 4 + 2; /* 60[F|M]: ... CR LF */

        UPDATE sw_journal
        SET
            trn=trn_,
            amount=opening_balance,
            currency=curency_chars,
            date_rec=bankdate()
        WHERE
            swref=trn_var;

        --
        -- Добавляем к длине "заголовка" сообщения прогнозируемую длину "окончания"
        --
        l_msgLen := l_msgLen + 50 + 12;  /* max len of fields 62, 64 */

        if (stmt_ = 11) then

            begin
                select value
                  into l_custSWS86
                  from cust_acc ca, customerw cw
                 where ca.acc = acc_
                   and ca.rnk = cw.rnk
                   and cw.tag = 'SWS86';

                if (l_custSWS86 is not null) then
                    l_custSWS86 := Wrap_Str(PrepStr(l_custSWS86), 65);




                    l_msgLen := l_msgLen + nvl(length(l_custSWS86), 0) + 5;  /* len of field 86 */

                end if;

            exception

                when NO_DATA_FOUND then null;
            end;


        end if;

    END;

    --************************FOOTER************************************
    PROCEDURE CreateFileFooter(
        account_curency_code        IN OUT NUMBER,
        closing_balance             IN OUT NUMBER,
        account_limit               IN OUT NUMBER,
        available_funds             IN OUT NUMBER,
        line_number                 IN OUT NUMBER,
        field_contents              IN OUT VARCHAR2,
        real_date_end               IN OUT DATE,
        is_final_stmt               IN     BOOLEAN
    ) IS
        f62modificator_             CHAR(1);

    l_custSWS86   varchar2(200);
    l_dc          char(1);

    BEGIN
        --Finalizing MT

        IF is_final_stmt THEN
           f62modificator_ := 'F';
        ELSE
           f62modificator_ := 'M';
        END IF;

        if (closing_balance < 0) then
            l_dc := 'D';
        else
            l_dc := 'C';
        end if;

        field_contents:= l_dc || TO_CHAR(real_date_end,'yymmdd') ||
                         AmountToSWIFT(abs(nvl(closing_balance, 0)), account_curency_code, TRUE, TRUE);

        INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
        VALUES (trn_var, '62', 'A', line_number, f62modificator_, field_contents);
        line_number := line_number + 1;

        --Available funds (only in last stmt subsequental)
        IF ( is_final_stmt ) THEN

            available_funds:=closing_balance+account_limit;

            if (available_funds < 0) then
                l_dc := 'D';
            else
                l_dc := 'C';
            end if;

            field_contents:= l_dc || TO_CHAR(real_date_end,'yymmdd') ||
                             AmountToSWIFT(abs(nvl(available_funds, 0)), account_curency_code, TRUE, TRUE);
            INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
            VALUES (trn_var, '64', 'A', line_number, NULL, field_contents);
            line_number := line_number + 1;

        END IF;

        -- Для выписки 940 добавляем поле 86, если такое определено для клиента
        if (stmt_ = 11) then

            begin
                select value
                  into l_custSWS86
                  from cust_acc ca, customerw cw
                 where ca.acc = acc_
                   and ca.rnk = cw.rnk
                   and cw.tag = 'SWS86';

                if (l_custSWS86 is not null) then
                    l_custSWS86 := Wrap_Str(PrepStr(l_custSWS86), 65);
                end if;

                if (l_custSWS86 is not null) then
                    insert into sw_operw (swref, tag, seq, n, opt, value)
                    values (trn_var, '86', 'A', line_number, null, l_custSWS86);
                    line_number := line_number + 1;
                end if;

            exception
                when NO_DATA_FOUND then null;
            end;

        end if;

    END;


    PROCEDURE CreateFileBody(
        c_all_acc                  IN all_account_transactions%ROWTYPE,
        account_curency_code       IN NUMBER,
        trn_var                    IN NUMBER,
                moves                      IN OUT NUMBER,
                line_number                IN OUT NUMBER)
        IS
        BEGIN
        --Subfield 1: Date
        field_contents:=    TO_CHAR(c_all_acc.fdat,'yymmdd');

        --Subfield 3: Debit/Credit
        IF c_all_acc.dk=0 THEN
            field_contents:=  field_contents || 'D';
            moves:=moves-c_all_acc.s;
        ELSE
            field_contents:=  field_contents || 'C';
            moves:=moves+c_all_acc.s;
        END IF;

        --Subfield 5: Amount
        field_contents:=    field_contents || AmountToSWIFT(c_all_acc.s,account_curency_code,FALSE,FALSE);

        -- Subfield 6: Transaction type
        -- +
        -- Subfield 7: Refference for the Acount Owner
        -- +
        -- Subfield 8: Acount Servicing Institution's Reference
        IF (c_all_acc.swtt IS NOT NULL) AND (c_all_acc.trn IS NOT NULL) THEN
            --Transaction originated by SWIFT message
            field_contents:=  field_contents || 'S' || c_all_acc.swtt;
            field_contents:=  field_contents || c_all_acc.trn || '//' || c_all_acc.ref;
        ELSE

            --Transaction originated by bank
            field_contents:=  field_contents || 'N' || c_all_acc.tt;
            field_contents:=  field_contents || c_all_acc.ref;
        END IF;

        --Subfield 9: Suplementary detais
        IF LENGTH(LTRIM(c_all_acc.nazn))>0 THEN
            field_contents:=  field_contents || CHR(13) || CHR(10) ||
              REPLACE(SUBSTR(StrToSwift(c_all_acc.nazn),1,34),'"','');
        END IF;

        --Dumping
        INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
        VALUES (trn_var, '61', 'A', line_number, NULL, field_contents);
        line_number := line_number + 1;
        l_msgLen := l_msgLen + nvl(length(field_contents), 0) + 5;

        -- Field 86 for MT940 only
        IF stmt_=11 THEN
          sw_nazn:=SUBSTR(StrToSwift(c_all_acc.nazn),1,320);
          sw_nazn:=REPLACE(sw_nazn, '"','');
          sw_nazn:=REM_LEAD_SIMBOL(sw_nazn,'-');
          sw_nazn:=REM_LEAD_SIMBOL(sw_nazn,':');

          --Разбить строку на куски по 65 символов здесь...
          field_contents:=WRAP_STR(sw_nazn,65);

          INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
          VALUES (trn_var, '86', 'A', line_number, NULL, field_contents);
          line_number := line_number + 1;
          l_msgLen := l_msgLen + nvl(length(field_contents), 0) + 5;
        END IF;
      END;



        -------------------------------------------------------------
        -- GENSTMT_MT950_LINE()
        --
        --     Процедура получения детальной строки для выписок
        --     МТ940/МТ950
        --
        --
        procedure genstmt_mt950_line(
            p_txRow              in     all_account_transactions%rowtype,
            p_accCurrCode        in     number,
            p_turn               in out number,
            p_field61            out    sw_operw.value%type,
            p_field86            out    sw_operw.value%type )
        is

        l_field61   sw_operw.value%type;    /*             значение для поля 61 */
        l_field86   sw_operw.value%type;   /* значение для поля 86 (только 940) */

        begin

            --Subfield 1: Date
            l_field61 := to_char(p_txRow.fdat, 'yymmdd');

            --Subfield 3: Debit/Credit
            if (p_txRow.dk = 0) then
                l_field61 := l_field61 || 'D';
                p_turn := p_turn - p_txRow.s;
            else
                l_field61 := l_field61 || 'C';
                p_turn := p_turn + p_txRow.s;
            end if;

            --Subfield 5: Amount
            l_field61 := l_field61 || AmountToSwift(p_txRow.s, p_accCurrCode, false, false);

            --
            -- Subfield 6: Transaction type
            -- +
            -- Subfield 7: Refference for the Acount Owner
            -- +
            -- Subfield 8: Acount Servicing Institution's Reference
            --
            if ((p_txRow.swtt is not null) and (p_txRow.trn is not null)) then

                --
                -- Transaction originated by SWIFT message
                --
                l_field61 := l_field61 || 'S' || p_txRow.swtt;
                l_field61 := l_field61 || p_txRow.trn || '//' || p_txRow.ref;

            else

                --
                -- Transaction originated by bank
                --
                l_field61 := l_field61 || 'N' || p_txRow.tt;
                l_field61 := l_field61 || p_txRow.ref;

            end if;

            --Subfield 9: Suplementary detais
            if (length(ltrim(p_txRow.nazn)) > 0) then
                l_field61 := l_field61 || CRLF || replace(substr(StrToSwift(p_txRow.nazn), 1, 34), '"', '');
            end if;

            if (stmt_ = 11) then

              l_field86 := replace(substr(StrToSwift(p_txRow.nazn), 1, 320), '"', '');
              l_field86 := rem_lead_simbol(rem_lead_simbol(l_field86, '-'), ':');
              l_field86 := wrap_str(l_field86, 65);

            else
                l_field86 := null;
            end if;

            p_field61 := l_field61;
            p_field86 := l_field86;

        end genstmt_mt950_line;




    --************************MAIN**************************************
BEGIN

    if (stmt_ = 11) then
        -- Всего 10 полей 61+86 в выписке MT940
        max61count := 10;
    end if;

    --Checking date period
    IF date_end < date_start THEN
        RETURN;
    END IF;
    page_no := 1;
    sw_ref  := NULL;

    --Reading/Creating current statement N
    BEGIN
        SELECT statement_number INTO stmt_number
        FROM sw_stmt_info WHERE acc=acc_;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        BEGIN
            INSERT INTO sw_stmt_info (acc, statement_number, last_message_ref)
            VALUES (acc_,0,NULL);
        END;
    END;

    -- Из account_identification исключен код валюты (в общем случае)
    --Account id, Statement N
    SELECT a.nls, a.lim, a.kv, s.statement_number
    INTO account_identification,account_limit,account_curency_code,stmt_number
    FROM accounts a,tabval t,sw_stmt_info s
    WHERE a.acc=acc_ AND a.kv=t.kv AND s.acc=a.acc
    FOR UPDATE OF s.statement_number NOWAIT;

    stmt_number:=stmt_number+1;

    /********!!Range of dates!!*******/
    --Defining nearest working day from top
    SELECT MIN(fdat) INTO real_date_start FROM fdat WHERE fdat>=date_start;

    --Checking date of account opening
    SELECT daos INTO acc_opened FROM accounts WHERE acc=acc_;

    --No statement before opening
    IF real_date_start < acc_opened THEN
       real_date_start := acc_opened;
    END IF;

    --Defining nearest working day from bottom
    SELECT MAX(fdat) INTO real_date_end FROM fdat WHERE fdat<=date_end;

    --Checking date of account closing
    SELECT dazs INTO acc_closed FROM accounts WHERE acc=acc_;

    --No statement after closing including the day of closing
    IF acc_closed IS NOT NULL AND real_date_end > acc_closed THEN
      SELECT MAX(fdat) INTO real_date_end FROM fdat WHERE fdat<acc_closed;
    END IF;

    --Real period is out off statement period
    IF (real_date_start>date_end) OR
       (real_date_end<date_start) THEN
      RETURN;
    END IF;

    IF real_date_start>real_date_end THEN
      dbms_output.put_line(
        'Period inconsistency detected real_date_start='||real_date_start||
        ' real_date_end='||real_date_end);
      real_date_end := real_date_start;
    END IF;

    dbms_output.put_line('Creating statment using this dates:');
    dbms_output.put_line('real_date_start='||real_date_start);
    dbms_output.put_line('real_date_end='||real_date_end);
    dbms_output.put_line('acc='||acc_);
    --Opening balance
    opening_balance := FOST( acc_, real_date_start ) +
                       FDOS( acc_, real_date_start, real_date_start ) -
                       FKOS( acc_, real_date_start, real_date_start );

    dbms_output.put_line('opening_balance='||opening_balance);

    SELECT lcv INTO curency_chars FROM tabval
    WHERE kv=account_curency_code;

    balance  := opening_balance;
    l_msgLen := 0;

    --HEADER
    CreateFileHeader(
          receiver_,acc_,date_start,trn_var,sw_ref,page_no,account_identification,
          stmt_number,opening_balance,line_number,field_contents,curency_chars,real_date_start, TRUE);
    prev_fdat:=NULL;

    --Creating body
    FOR c_all_acc IN all_account_transactions(real_date_start, real_date_end) LOOP

        dbms_output.put_line('c_all_acc.ref='||c_all_acc.ref||' c_all_acc.stmt='||c_all_acc.stmt||' c_all_acc.s='||c_all_acc.s);

        --
        -- Получаем текущую детальную строку
        --
        genstmt_mt950_line(c_all_acc, account_curency_code, moves, l_field61, l_field86);
        l_curlinesize := nvl(length(l_field61), 0) + nvl(length(l_field86), 0);

        if (l_msgLen >= MAXMSGSIZE_MT950 - l_curlinesize) then

            --Closing current file and starting new
            balance := balance + moves;
            CreateFileFooter(
                  account_curency_code,balance,account_limit,available_funds,line_number,field_contents,prev_fdat,FALSE);
            page_no := page_no + 1;
            line_number := 1;
            l_msgLen    := 0;
            CreateFileHeader(
                  receiver_,acc_,date_start,trn_var,sw_ref,page_no,account_identification,
                  stmt_number,balance,line_number,field_contents,curency_chars,prev_fdat, FALSE);
            moves:=0;
            count_:=0;
        end if;

        -- сохраняем строку выписки
        INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
        VALUES (trn_var, '61', 'A', line_number, NULL, l_field61);
        line_number := line_number + 1;
        l_msgLen := l_msgLen + nvl(length(l_field61), 0) + 5;

        if (stmt_ = 11 and l_field86 is not null) then

            INSERT INTO sw_operw (swref,tag,seq,n,opt,value)
            VALUES (trn_var, '86', 'A', line_number, NULL, l_field86);
            line_number := line_number + 1;
            l_msgLen := l_msgLen + nvl(length(l_field86), 0) + 5;

        end if;

/*
        -- Creating body
        CreateFileBody(
          c_all_acc,
          account_curency_code,
          trn_var,
          moves,
          line_number );
*/
        count_    := count_ + 1;
        prev_fdat := c_all_acc.fdat;
    END LOOP;

    --Closing balance
    closing_balance := FOST( acc_, real_date_end );

    balance := balance + moves;

    IF balance<>closing_balance THEN
        DBMS_OUTPUT.PUT_LINE(
          'Balance inconsistence detected transaction couted balance=' || balance ||
          'real closing_balance='||closing_balance);
    END IF;

    --FOOTER
    CreateFileFooter(
      account_curency_code,closing_balance,account_limit,available_funds,line_number,field_contents,real_date_end,TRUE);

    --Updating statement infornation for account
    UPDATE sw_stmt_info
    SET
       sw_stmt_info.statement_number=stmt_number,
       sw_stmt_info.last_message_ref=sw_ref
    WHERE sw_stmt_info.acc=acc_;

END CreateStatementMessage;



    -----------------------------------------------------------------
    -- GENMSG_VALIDATE_APPHDRFLAGS()
    --
    --   Процедура проверки корректности пользовательских флагов
    --   в сообщении SWIFT
    --
    --
    --
    procedure genmsg_validate_apphdrflags(
                  p_msgAppHdrFlg   in varchar2,
                  p_msgMt          in sw_mt.mt%type default null )
    is

    l_dummy number;

    begin

        bars_audit.trace('validating application header flags (value=>%s)...', p_msgAppHdrFlg);

        -- флаг не может быть пустым
        if (p_msgAppHdrFlg is null) then
            bars_audit.error('SWT2\910 Флаг сообщения не может быть пустым');
            raise_application_error(-20782, '\910 Флаг сообщения не может быть пустым');
        end if;

        --
        -- Первый символ: Приоритет сообщения
        --
        if (substr(p_msgAppHdrFlg, 1, 1) not in ('S', 'U', 'N')) then
            bars_audit.error('SWT2\911 Флаг сообщения: некорректно задан приоритет');
            raise_application_error(-20782, '\911 Флаг сообщения: некорректно задан приоритет');
        end if;

        -- Если передан еще и тип сообщения, то проверяем на допустимость приоритета
        if (p_msgMt is not null and substr(p_msgAppHdrFlg, 1, 1) = 'S') then
            if (p_msgMt > 99) then
                bars_audit.error('SWT2\912 Флаг сообщения: приоритет S (System) не соответствует типу сообщения');
                raise_application_error(-20782, '\912 Флаг сообщения: приоритет S (System) не соответствует типу сообщения');
            end if;
        end if;

        --
        -- Второй символ: Опция мониторинга доставки
        --
        if (substr(p_msgAppHdrFlg, 2, 1) is not null) then

            -- К System опция неприменима
            if (substr(p_msgAppHdrFlg, 1, 1) = 'S') then
                bars_audit.error('SWT2\913 Флаг сообщения: опция мониторинга доставки не может быть применена к сообщению с приоритет S (System)');
                raise_application_error(-20782, '\913 Флаг сообщения: опция мониторинга доставки не может быть применена к сообщению с приоритет S (System)');
            end if;

            if (substr(p_msgAppHdrFlg, 1, 1) = 'U') then
                if (substr(p_msgAppHdrFlg, 2, 1) not in ('1', '3')) then
                    bars_audit.error('SWT2\914 Флаг сообщения: опция мониторинга доставки ' || substr(p_msgAppHdrFlg, 2, 1) || ' не может быть применена к сообщению с приоритет U (Urgent)');
                    raise_application_error(-20782, '\914 Флаг сообщения: опция мониторинга доставки ' || substr(p_msgAppHdrFlg, 2, 1) || ' не может быть применена к сообщению с приоритет U (Urgent)');
                end if;
            else -- 'N'
                if (substr(p_msgAppHdrFlg, 2, 1) != '2') then
                    bars_audit.error('SWT2\914 Флаг сообщения: опция мониторинга доставки ' || substr(p_msgAppHdrFlg, 2, 1) || ' не может быть применена к сообщению с приоритет N (Normal)');
                    raise_application_error(-20782, '\914 Флаг сообщения: опция мониторинга доставки ' || substr(p_msgAppHdrFlg, 2, 1) || ' не может быть применена к сообщению с приоритет N (Normal)');
                end if;
            end if;

        end if;

        --
        -- Период устаревания (три символа - число)
        --
        if (substr(p_msgAppHdrFlg, 3) is not null) then

            if (length(substr(p_msgAppHdrFlg, 3)) != 3) then
                bars_audit.error('SWT2\915 Флаг сообщения: нарушен формат периода устаревания');
                raise_application_error(-20782, '\915 Флаг сообщения: нарушен формат периода устаревания');
            end if;

            begin
                l_dummy := to_number(substr(p_msgAppHdrFlg, 3));
            exception
                when OTHERS then
                bars_audit.error('SWT2\915 Флаг сообщения: нарушен формат периода устаревания');
                raise_application_error(-20782, '\915 Флаг сообщения: нарушен формат периода устаревания');
            end;

        end if;

        bars_audit.trace('application header flags succesfully validated.');

    end genmsg_validate_apphdrflags;



--**************************************************************--
--Вставка в журнал сообщений (закрытая)
-- DG
--**************************************************************--
PROCEDURE In_SwJournalInt(
    ret_        OUT NUMBER,
    swref_      OUT NUMBER,
    mt_         IN  NUMBER,
    mid_        IN  VARCHAR2,
    page_       IN  VARCHAR2,
    io_         IN  VARCHAR2,
    sender_     IN  VARCHAR2,
    receiver_   IN  VARCHAR2,
    transit_    IN  VARCHAR2,
    payer_      IN  VARCHAR2,
    payee_      IN  VARCHAR2,
    ccy_        IN  VARCHAR2,
    amount_     IN  VARCHAR2,
    accd_       IN  NUMBER,
    acck_       IN  NUMBER,
    vdat_       IN  VARCHAR2,
    idat_       IN  VARCHAR2,
    flag_       IN  VARCHAR2,
    trans_      IN  VARCHAR2  DEFAULT NULL,
    apphdrflg_  IN  VARCHAR2  DEFAULT NULL,
    sti_        IN  VARCHAR2  DEFAULT NULL,
    uetr_       IN  VARCHAR2  DEFAULT NULL,
    cov_        IN  VARCHAR2  DEFAULT NULL)
IS
    l_accd      NUMBER  := NULL;
    l_acck      NUMBER  := NULL;
    ern         NUMBER  := 100;
    l_page      VARCHAR2(35);
    l_ccy       VARCHAR2(3);
    l_idate     DATE;
    l_dateOut   date;
    l_trn       varchar2(16);
    l_msgAppHdrFlg sw_journal.app_flag%type;


BEGIN
    ret_   := 0;
    swref_ := -1;

    BEGIN

    -- First make insert into the journal

    IF deb.debug THEN
        deb.trace( ern, 'module/0', 'swift_01');
    END IF;

    -- Если флаг не указан явно, то выставляем умолчательное значение
    if (apphdrflg_ is null) then
        l_msgAppHdrFlg := 'N';
    else
        l_msgAppHdrFlg := apphdrflg_;
    end if;

    -- Выполняем проверку корректности флагов
    genmsg_validate_apphdrflags(l_msgAppHdrFlg, mt_);

    SELECT bars_sqnc.get_nextval('s_sw_journal')   -- Get next value for the PK
        INTO swref_
        FROM DUAL;

    IF deb.debug THEN
        deb.trace( ern, 'swref', swref_);
    END IF;

    IF io_ = 'O'
    THEN
        l_accd := accd_;
        l_acck := acck_;

        -- If this is inbound message, set out date
        l_dateOut := sysdate;
        l_trn := mid_;

    ELSE
        l_acck := accd_;
        l_accd := acck_;

        if (mid_ is null) then
            l_trn := GetSwiftField20(swref_, receiver_, trans_);
        else
            l_trn := mid_;
        end if;
    END IF;

    IF page_ IS NULL THEN
       l_page := 'Page 1/1 (' || idat_ || ')';
    ELSE
       l_page := page_;
    END IF;

    l_ccy := ccy_;

    -- Дата приема сообщения...

    l_idate := TO_DATE(idat_, 'YYYY-MM-DD HH24:MI');

    -- Added by DG
    --
    -- !!! Чтобы не усложнять логику вертушки !!!
    -- Если не прописан счет VOSTRO и счет только 1500 для этого
    -- банка только один (по валюте естественно), то проставляем его
    --
    if (io_ = 'O' and (l_accd is null or l_accd = 0)) then

        begin
            select a.acc
              into l_accd
              from bic_acc b, accounts a, tabval t
             where b.acc = a.acc
               and a.kv  = t.kv
               and b.bic = sender_
               and t.lcv = l_ccy;
        exception
            when NO_DATA_FOUND then l_accd := NULL;
            when TOO_MANY_ROWS then l_accd := NULL;
        end;

    end if;

    IF deb.debug THEN
        deb.trace( ern, 'MT        ', mt_);
        deb.trace( ern, 'Swift ID  ', l_trn);
        deb.trace( ern, 'Msg Page  ', l_page);
        deb.trace( ern, 'IO        ', io_);
        deb.trace( ern, 'Sender    ', sender_);
        deb.trace( ern, 'Receiver  ', receiver_);
        deb.trace( ern, 'Transit   ', transit_);
        deb.trace( ern, 'Payer     ', payer_);
        deb.trace( ern, 'Payee     ', payee_);
        deb.trace( ern, 'Currency  ', l_ccy);
        deb.trace( ern, 'Debit  acc', l_accd);
        deb.trace( ern, 'Credit acc', l_acck);
        deb.trace( ern, 'Amount    ', amount_);
        deb.trace( ern, 'Value Date', vdat_);
        deb.trace( ern, 'Incom Date', l_idate);
        deb.trace( ern, 'Header Flags', l_msgAppHdrFlg);
    END IF;

    ret_ := 0;

    IF l_accd = 0 THEN
       l_accd := NULL;
    END IF;

    IF l_acck = 0 THEN
       l_acck := NULL;
    END IF;


    INSERT INTO sw_journal
        ( swref,mt,trn,page,io_ind,sender,receiver,payer,payee,
          currency,amount,accd,acck,date_in,date_out,vdate,transit, flags, app_flag,sti,uetr, cov )
    VALUES
            ( swref_,mt_,l_trn,l_page,io_,sender_,receiver_,payer_,payee_,
              l_ccy,nvl(amount_, 0),l_accd,l_acck,l_idate, l_dateOut,
              nvl(TO_DATE(vdat_,'MM/DD/YYYY'), gl.bd), transit_, flag_, l_msgAppHdrFlg, sti_, uetr_, cov_);

    EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
            swref_ := -1;
            ret_   :=  5122;
            RETURN;
    END;

END In_SwJournalInt;

--**************************************************************--
--Вставка в журнал сообщений (SW_JOURNAL)
--**************************************************************--
PROCEDURE In_SwJournal(
    ret_        OUT NUMBER,
    swref_      OUT NUMBER,
    mt_         IN  NUMBER,
    mid_        IN  VARCHAR2,
    page_       IN  VARCHAR2,
    io_         IN  VARCHAR2,
    sender_     IN  VARCHAR2,
    receiver_   IN  VARCHAR2,
    transit_    IN  VARCHAR2,
    payer_      IN  VARCHAR2,
    payee_      IN  VARCHAR2,
    ccy_        IN  VARCHAR2,
    amount_     IN  VARCHAR2,
    accd_       IN  NUMBER,
    acck_       IN  NUMBER,
    vdat_       IN  VARCHAR2,
    idat_       IN  VARCHAR2,
    sti_        IN  VARCHAR2  DEFAULT NULL,
    uetr_       IN  VARCHAR2  DEFAULT NULL,
    cov_        IN  VARCHAR2  DEFAULT NULL
    )
IS
BEGIN

    In_SwJournalInt(
        ret_       => ret_,
        swref_     => swref_,
        mt_        => mt_,
        mid_       => mid_,
        page_      => page_,
        io_        => io_,
        sender_    => sender_,
        receiver_  => receiver_,
        transit_   => transit_,
        payer_     => payer_,
        payee_     => payee_,
        ccy_       => ccy_,
        amount_    => amount_,
        accd_      => accd_,
        acck_      => acck_,
        vdat_      => vdat_,
        idat_      => idat_,
        flag_      => null,
        sti_       => sti_,
        uetr_      => uetr_,
        cov_       => cov_);

END In_SwJournal;

PROCEDURE In_SwJournalEx(
    ret_        OUT NUMBER,
    swref_      OUT NUMBER,
    mt_         IN  NUMBER,
    mid_        IN  VARCHAR2,
    page_       IN  VARCHAR2,
    io_         IN  VARCHAR2,
    sender_     IN  VARCHAR2,
    receiver_   IN  VARCHAR2,
    transit_    IN  VARCHAR2,
    payer_      IN  VARCHAR2,
    payee_      IN  VARCHAR2,
    ccy_        IN  VARCHAR2,
    amount_     IN  VARCHAR2,
    accd_       IN  NUMBER,
    acck_       IN  NUMBER,
    vdat_       IN  VARCHAR2,
    idat_       IN  VARCHAR2,
    flag_       IN  VARCHAR2,
    sti_        IN  VARCHAR2  DEFAULT NULL,
    uetr_       IN  VARCHAR2  DEFAULT NULL,
    cov_        IN  VARCHAR2  DEFAULT NULL )
IS
    l_accd      NUMBER  := NULL;
    l_acck      NUMBER  := NULL;
    ern         NUMBER  := 100;
    l_page      VARCHAR2(35);
    l_ccy       VARCHAR2(3);
    l_idate     DATE;

BEGIN

    In_SwJournalInt(
        ret_       => ret_,
        swref_     => swref_,
        mt_        => mt_,
        mid_       => mid_,
        page_      => page_,
        io_        => io_,
        sender_    => sender_,
        receiver_  => receiver_,
        transit_   => transit_,
        payer_     => payer_,
        payee_     => payee_,
        ccy_       => ccy_,
        amount_    => amount_,
        accd_      => accd_,
        acck_      => acck_,
        vdat_      => vdat_,
        idat_      => idat_,
        flag_      => flag_,
        sti_       => sti_,
        uetr_      => uetr_,
        cov_       => cov_ );

END In_SwJournalEx;

--**************************************************************--
--Вставка в журнал тела сообщения (SW_OPERW)
--**************************************************************--
PROCEDURE In_SwOperw(
    swref_      IN  NUMBER,
    tag_        IN  VARCHAR2,
    seq_        IN  VARCHAR2,
    recn_       IN  NUMBER,
    opt_        IN  VARCHAR2,
    body_       IN  VARCHAR2)
IS

l_swTrn   sw_journal.trn%type;
l_value   sw_operw.value%type;

BEGIN

    l_value := body_;

    if (substr(l_value, -2, 2) = CRLF) then
        l_value := substr(l_value, 1, length(l_value)-2);
    end if;


    INSERT INTO sw_operw
        ( swref,tag,seq,n,opt,value  )
    VALUES
        ( swref_,tag_,seq_,recn_,opt_, l_value);

    -- Если вставляется поле 20, то проверяем SWIFT-референс
    -- в заголовке сообщения и в случае необходимости SWIFT-
    -- референс заносится в заголовок сообщения
    if (tag_ = '20' and opt_ is null) then

        select trn
          into l_swTrn
          from sw_journal
         where swref = swref_;

        if (l_swTrn != substr(rtrim(ltrim(body_)), 1, 16) or l_swTrn is null) then

            update sw_journal
               set trn = substr(rtrim(ltrim(body_)), 1, 16)
             where swref = swref_;
        end if;

    end if;

END In_SwOperw;

--**************************************************************--
--Вставка в журнал оргинала сообщения (SW_OPERW)
--**************************************************************--
PROCEDURE In_SwMessages(
    swref_      IN  NUMBER,
    body_       IN  VARCHAR2)
IS
BEGIN
    -- Next is insert the message's body
    INSERT INTO sw_messages ( swref, body )
    VALUES      ( swref_, body_ );
END In_SwMessages;

--**************************************************************--
-- Вставка нач провода из АБС в SWIFT
-- OPER + OPERW -> SW_JOURNAL + SW_OPER + SW_OPERW
-- STA
-- 27.07.2005 DG добавил проверки
--**************************************************************--
PROCEDURE Fr_ABS_To_SW (MT_ int, REF_ int)
IS

l_sender   sw_journal.sender%type;
l_receiver sw_journal.receiver%type;


    BICA_  CHAR(11);
    LCV_   CHAR(3) ;
    F_50_  VARCHAR2(200);
    S_     NUMBER;
    ACCK_  INT;
    FDAT_  DATE;
    MFOA_  VARCHAR2(12);
    MFOB_  VARCHAR2(12);
    KS_    CHAR(2);
    N_     INT;
    F_32_  VARCHAR2(35) ;
    OPT_   CHAR(1);
    SWREF_ INT;
    F_59_  VARCHAR2(200) ;
    -- F_20_  VARCHAR2(35);
    RECEIVER_  CHAR(11);

    ern CONSTANT POSITIVE := 208;
    err EXCEPTION;
    erm VARCHAR2(80);

l_retCode  number;
l_swRef    sw_journal.swref%type;    -- Реф. SWIFT сообщения
l_fld20    varchar2(16);             -- Поле 20: реф. отправителя
l_fld70    varchar2(140);

l_tmpFld70    varchar2(140);
l_tmpFld70Len number;

l_fld59        varchar2(200);
l_tmpFld59Len  number;


l_fldopt   varchar2(1);
l_fldval   varchar2(35);

l_recno    number;

p_ref    number;     -- Референс документа (аналог ref_)
p_mt     number;     -- Тип создаваемого сообщения (аналог mt_)

l_ins70  boolean := false;

l_pos     number;
l_guid varchar2(36);

BEGIN

    -- только на время перехода
    p_ref := ref_;
    p_mt  := mt_;

    KS_:=CHR(13)||CHR(10);
--    BEGIN
    SELECT SUBSTR(P.VAL,1,11), T.LCV,
           '/' || substr(O.NLSA, 1, 35) || KS_ ||
           SUBSTR(StrToSwift(C.NMKV), 1, 35) || KS_ ||
           SUBSTR(StrToSwift(C.ADR),  1, 35)  || KS_ ||
           SUBSTR(StrToSwift(C.ADR), 36, 35),
           L.S, A.ACC, L.FDAT, O.MFOA, O.MFOB ,
           TO_CHAR(L.FDAT,'YYMMDD') || T.LCV ||
           SUBSTR(L.S, 1, LENGTH(L.S)-2 ) || ',' || SUBSTR(TO_CHAR(L.S),-2),
           substr(StrToSWIFT(o.nazn), 1, 140)
    INTO   BICA_  , LCV_   , F_50_  ,  S_    ,
           ACCK_  , FDAT_  , MFOA_   , MFOB_  , F_32_, l_tmpFld70
    FROM OPER     O,  TABVAL   T,   PARAMS   P, CUST_ACC U,
         OPERW    W,  ACCOUNTS A,   OPLDOK   L, CUSTOMER C
    WHERE P.PAR='BICCODE'  AND  O.REF=REF_   AND  O.REF=W.REF  AND
          W.TAG='NOS_A'    AND  TO_NUMBER(W.VALUE)= A.ACC      AND
          A.KV =T.KV       AND  A.ACC=U.ACC  AND  U.RNK=C.RNK  AND
          L.REF=O.REF      AND  L.ACC=A.ACC  AND  L.DK =1      AND
          ROWNUM=1  ;

    UPDATE ARC_RRP SET SOS=5, BLK=-BLK WHERE REF=REF_;

    IF MT_ IN (100,103) THEN
       --20 +
       --32 +
       --50 +
       --52 -
       --53 -
       --54 -
       --56 -
       --57 -
       --59 +
       --70 -
       --71 -
       --72 -

        -- Отправитель: получаем наш BIC-код
        l_sender := GetOurBankAsSender();

        -- Банк получателя (поле 57)
        begin
            select substr(value, 1, 11)
              into l_receiver
              from operw
             where ref = p_ref
               and substr(tag, 1, 2) = '57'
               and rownum = 1;              -- не понимаю зачем ???

            -- Сразу проверяем по справочнику участников
            select bic
              into l_receiver
              from sw_banks
             where bic = l_receiver;

        exception
            when NO_DATA_FOUND then
                raise_application_error(-20781, '\001 Не определен банк получателя (поле 57) Ref=' || to_char(p_ref));
        end;

        if (mfoa_ != mfob_) then

            BEGIN
             --плательщик в другом банке (перебивает/оставляет наше название )
                SELECT SUBSTR(VALUE,1,35)
                INTO F_50_ FROM OPERW WHERE REF=REF_ AND TAG='50' AND ROWNUM=1;
            EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
            END;
        end if;


       -- Получаем реквизиты получателя (поле 59)
       begin
           select substr(value, 1, 200)
             into F_59_
             from operw
            where ref = p_ref
              and substr(tag, 1, 2) = '59'
              and rownum = 1;
       exception
           when NO_DATA_FOUND then
               raise_application_error(-20781, '\003 Не заполнены реквизиты получателя (поле 59) Ref=' || to_char(p_ref));
       end;

       -- Преобразовываем строку
       if (substr(f_59_, 1, 1) = '/') then

           -- Первый пробел будет означать окончание счета
           l_pos := nvl(instrc(f_59_, ' '), 34);

           l_fld59 := substr(f_59_, 1, l_pos) || chr(13) || chr(10);
           f_59_ := substr(f_59_, l_pos);
           l_tmpFld59Len := length(f_59_);

           for i in 0..3
           loop
               if (l_tmpFld59Len > i*33+1) then
                   l_fld59 := l_fld59 || substr(f_59_, i*33+1, 33) || chr(13) || chr(10);
               end if;
           end loop;

       else

           l_tmpFld59Len := length(f_59_);
           for i in 0..4
           loop
               if (l_tmpFld59Len > i*38+1) then
                   l_fld59 := l_fld59 || substr(f_59_, i*38+1, 38) || chr(13) || chr(10);
               end if;
           end loop;

       end if;

       -- F_50_ := substr(StrToSWIFT(F_50_), 1, 35);
       -- F_59_ := substr(StrToSWIFT(F_59_), 1, 35);

       -- Форматируем поле 70 (4*35х)
       l_tmpFld70Len := length(l_tmpFld70);

       for i in 0..3
       loop
           if (l_tmpFld70Len > i*33+1) then
               l_fld70 := l_fld70 || substr(l_tmpFld70, i*33+1, 33) || chr(13) || chr(10);
           end if;
       end loop;


            l_guid :=bars_swift.generate_uetr;
        -- Создаем заголовок сообщения
        In_SwJournalInt(
            ret_        => l_retCode,
            swref_      => l_swRef,
            mt_         => p_mt,
            mid_        => null,
            page_       => null,
            io_         => 'I',
            sender_     => l_sender,
            receiver_   => l_receiver,
            transit_    => null,
            payer_      => substr(F_50_, 1, 35),
            payee_      => F_59_,
            ccy_        => lcv_,
            amount_     => s_,
            accd_       => null,
            acck_       => acck_,
            vdat_       => to_char(gl.bDate, 'MM/DD/YYYY'),

            idat_       => to_char(sysdate, 'YYYY-MM-DD HH24:MI'),
            flag_       => null,
            sti_        =>'001',
            uetr_       =>lower(l_guid)      );

        -- Привязываем сообщение к документу
        insert into sw_oper(ref, swref)
        values (p_ref, l_swRef);

        -- Генерируем референс сообщения (SWIFT)
        l_fld20 := GetSwiftField20(l_swRef, l_receiver);


        -- Добавляем информационные строки
        In_SwOperw(l_swRef, '20', 'A', 1, '', l_fld20); l_recno := 2;

        if (p_mt = 103) then
            In_SwOperw(l_swRef, '23', 'A', l_recno, 'B', 'CRED'); l_recno := l_recno + 1;
        end if;

        In_SwOperw(l_swRef, '32', 'A', l_recno, 'A', f_32_); l_recno := l_recno + 1;
        In_SwOperw(l_swRef, '50', 'A', l_recno, 'A', f_50_); l_recno := l_recno + 1;


        for k in (select tag, value
                    from operw
                   where ref = p_ref
                     and substr(tag, 1, 2) in ('52','53','54','56','57','59','70','71','72')
                  order by tag)
        loop

            if (k.tag = '71A') then                   -- Проверка поля 71A
                l_fldval := substr(k.value, 1, 3);

                if (l_fldval not in ('BEN', 'OUR', 'SHA')) then
                    raise_application_error(-20780, '\004 Недопустимое значение в поле 71 (T08)');
                end if;

            else
                l_fldval := substr(StrToSWIFT(k.value), 1, 35);
            end if;


            l_fldopt := substr(k.tag, 3, 1);

            if (l_fldopt = ' ') then
                l_fldopt := null;
            end if;

            if (substr(k.tag, 1, 2) = '70') then
                l_fldval := l_fld70;
                l_ins70 := true;
            end if;

            if (to_number(substr(k.tag, 1, 2)) > 70 and not l_ins70) then

                -- Вставляем 70 поле
                In_SwOperw(l_swRef, '70', 'A', l_recno, '', l_fld70);
                l_recno := l_recno + 1;

                l_ins70 := true;

            end if;

            In_SwOperw(l_swRef, substr(k.tag, 1, 2), 'A', l_recno, l_fldopt, l_fldval);
            l_recno := l_recno + 1;
        end loop;

        -- Если вставили все поля и не было поля 70
        if (not l_ins70) then

                -- Вставляем 70 поле
                In_SwOperw(l_swRef, '70', 'A', l_recno, '', l_fld70);
                l_recno := l_recno + 1;

                l_ins70 := true;

        end if;



       ------------------------------
       -- заменить на использование стандартной функции
       --
       -- SELECT S_SW_JOURNAL.NEXTVAL INTO  SWREF_ FROM DUAL;
       -- INSERT into SW_JOURNAL
       --   (SWREF,MT ,TRN ,IO_IND  ,CURRENCY,SENDER,RECEIVER,PAYER,PAYEE,AMOUNT,
       --    ACCK ,DATE_PAY,DATE_REC,ID     ,  PAGE    )
       -- VALUES
       --   (SWREF_,MT_,F_20_,'I'     ,LCV_   ,BICA_ ,RECEIVER_ ,F_50_,F_59_,S_,
       --    ACCK_ ,FDAT_    ,gl.BDATE,USER_ID, 'Page 1/1' );

       ------------------------------
       -- заменить на использование стандартной функции
       --
       -- INSERT into SW_OPER ( REF, SWREF) values (REF_, SWREF_);
       ------------------------------
       -- здесь надо что-то умное
       -- пока сделано "в ЛОБ" и только для 100,103
       -- нужна таблица преобразования OPER->SWIFT
       --INSERT INTO SW_OPERW (SWREF,TAG,N,OPT,VALUE) VALUES
       --      (SWREF_,'20',1,NULL,F_20_);
       --
       --INSERT INTO SW_OPERW (SWREF,TAG,N,OPT,VALUE) VALUES
       --      (SWREF_,'32',2,'A',F_32_ );
       --
       --INSERT INTO SW_OPERW (SWREF,TAG,N,OPT,VALUE) VALUES
       --      (SWREF_,'50',3,NULL,F_50_ );
       --
       --N_:=4;
       --
       --FOR K IN (SELECT TAG, VALUE FROM OPERW
       --          WHERE REF=REF_ AND SUBSTR(TAG,1,2) IN
       --               ('52','53','54','56','57','59','70','71','72')
       --          ORDER BY TAG)
       --LOOP
       --deb.trace(ern, k.TAG, k.VALUE );
       --   F_50_:= SUBSTR( SWIFT.STRTOSWIFT(K.VALUE ),1,35);
       --   OPT_ := SUBSTR(K.TAG,3,1);
       --   IF OPT_ = ' ' THEN
       --      OPT_:= NULL;
       --   END IF;
       --   INSERT INTO SW_OPERW (SWREF, TAG, N, OPT,VALUE) VALUES
       --      (SWREF_, SUBSTR(K.TAG,1,2), N_, OPT_, F_50_ );
       --   N_:=N_ + 1;
       --END LOOP;

    else
        raise_application_error(-20998, 'неподдерживаемый формат сообщения МТ=' || to_char(mt_));
    END IF;

    UPDATE ARC_RRP SET BLK=-840 WHERE REF=REF_;

--  EXCEPTION WHEN OTHERS THEN RETURN;
--  END;
END Fr_ABS_To_SW;



--**************************************************************--
-- IMPORT_SWBANK()
--
--     Процедура импорта строки справочника участников SWIFT
--
-- DG
--**************************************************************--
PROCEDURE import_swbank(
    p_impmode   in  number,
    p_impaction in  char,
    p_fibic     in  char,
    p_finame    in  varchar2,
    p_fioffice  in  varchar2,
    p_ficity    in  varchar2,
    p_ficountry in  varchar2 )
IS
BEGIN

    -- Поддерживаем два режима: начальный и текущий

    if (p_impmode = FI_IMPMODE_INITIAL) then

        -- Пытаемся сначало обновить запись, если
        -- она не найдена, то добавляем

        update sw_banks
           set name    = p_finame,
               office  = p_fioffice,
               city    = p_ficity,
               country = p_ficountry
         where bic     = p_fibic;


        if (sql%rowcount = 0) then

            insert into sw_banks (bic, name, office, city, country)
            values (p_fibic, p_finame, p_fioffice, p_ficity, p_ficountry);

        end if;

    elsif (p_impmode = FI_IMPMODE_SERIAL) then

        if (p_impaction = 'D') then

            delete from sw_banks
             where bic = p_fibic;

        elsif (p_impaction = 'M' or p_impaction = 'W' or p_impaction = 'U') then

            update sw_banks
               set name    = p_finame,
                   office  = p_fioffice,
                   city    = p_ficity,
                   country = p_ficountry
             where bic     = p_fibic;

        elsif (p_impaction = 'A') then

            insert into sw_banks (bic, name, office, city, country)
            values (p_fibic, p_finame, p_fioffice, p_ficity, p_ficountry);

        else
            raise_application_error(-20788, 'invalid import action. Action ' || p_impaction || ' not defined');
        end if;

    else
        raise_application_error(-20789, 'invalid import mode');
    end if;

END import_swbank;





--**************************************************************--
-- IS_VALID_A_OPTION()
--
--     Функция проверяет, соответствует ли строка опции А
--     таких полей как 56, 57
--
--     Функция временная, т.к. выбор о опции поля должен принимать
--     пользователь
--
--
--**************************************************************--
function is_valid_a_option(
             p_fieldValue  in varchar2 ) return boolean
is

CRLN    constant char(2)   := chr(13) || chr(10);

l_pos   number;              -- позиция разделителя
l_tmp   varchar2(4000);      -- временный буфер
l_bic   sw_banks.bic%type;   -- BIC-код участника

begin

--    if (substr(p_fieldValue, 1, 1) != '/') then
---        return false;
--    end if;

    if (substr(p_fieldValue, 1, 1) = '/') then

       -- Ищем перевод строки или символ пробела
       l_pos := instr(p_fieldValue, CRLN);

       if (l_pos is null or l_pos = 0) then
           -- Пробуем искать по разделителю - пробел
           l_pos := instr(p_fieldValue, ' ');

           if (l_pos is null or l_pos = 0) then
               return false;                   -- одна строка без разделителя - это не опция A
           end if;
       else
           -- Переводим позицию на последний символ найденного перевода строки
           l_pos := l_pos + 1;
       end if;

    else
        l_pos := 0;
    end if;

    -- Выделяем оставшуюся часть строки
    l_tmp := rtrim(ltrim(substr(p_fieldValue, l_pos+1)));

    -- Убираем возможные лишние переводы строк
    l_tmp := rtrim(ltrim(l_tmp, CRLN), CRLN);

    -- Если получившаяся длина больше 11 символов, то однозначно отбрасываем
    if (length(l_tmp) > 11) then
        return false;
    else
        -- Пытаемся найти код в справочнике участников
        l_bic := l_tmp;

        begin
            select bic
              into l_bic
              from sw_banks
             where bic = l_bic;
        exception
            when NO_DATA_FOUND then return false;
        end;

    end if;

    return true;

end is_valid_a_option;


--**************************************************************--
-- GENMSG_EXISTSRU()
--
--     Функция проверяет строку на наличие русских символов
--
--
--
--
function genmsg_existsru(
    p_value    in  sw_operw.value%type ) return boolean
is

l_symb  char(1);

begin

  if (p_value is null) then return false;
  end if;

  for i in 1..length(p_value)
  loop
      l_symb := substr(p_value, i, 1);
      if ((l_symb >= 'А' and l_symb <= 'Я' ) or
          (l_symb >= 'а' and l_symb <= 'я' )   ) then return true;
      end if;
  end loop;

  return false;

end genmsg_existsru;








--**************************************************************--
-- GENMSG_DOCCHK()
--
--     Процедура начальной проверки документа, до формирования
--     по нему SWIFT-сообщенияя
--
--     Параметры:
--
--         p_mt     Тип SWIFT сообщения
--
--         p_ref    Референс документа, из которого будет
--                  выполняться формирование сообщения
--
--         p_flag   Флаг генерации ошибки, если передано
--                  значение TRUE, то в случае отсутствия
--                  на документе флага генерации сообщения
--                  будет сгенерирована ошибка
--
procedure genmsg_docchk(
    p_mt   in  sw_mt.mt%type,
    p_ref  in  oper.ref%type,
    p_flag in  boolean        )
is

l_ref        oper.ref%type;
l_mt         operw.value%type;
l_accNostro  accounts.acc%type;
l_acc        accounts.acc%type;
l_cnt        number;
l_finflg     sw_mt.mt%type;

begin

    bars_audit.debug('entry point');
    bars_audit.debug('par[0]=>' || p_mt || ' par[1]=>' || to_char(p_ref) || ' par[2]=> <unk>');

    --
    -- Просто ищем документ
    --
    bars_audit.debug('checking document with ref=' || to_char(p_ref) || '...');
    begin

        select ref into l_ref
          from oper
         where ref = p_ref;

         bars_audit.debug('document ref' || to_char(p_ref) || ' found.');

    exception
        when NO_DATA_FOUND then
            bars_audit.error('Документ with ref=' || to_char(p_ref) || ' не найден');
            raise_application_error(-20781, '\001 Документ не найден Ref=' || to_char(p_ref));
    end;

    --
    -- Проверяем нужно ли формировать SWIFT-сообщение
    -- Формировать нужно в случаях:
    --          наличия доп. реквизита SWTMT
    --          наличия доп. реквизита f
    --
    bars_audit.debug('checking document req SWTMT or f ...');
    begin

        select value into l_mt
          from operw
         where ref = p_ref
           and tag = 'SWTMT';

        bars_audit.debug('document req SWTMT=>' || l_mt);

    exception
        when NO_DATA_FOUND then

            bars_audit.debug('document req SWTMT not found, check for req "f" ...');
            begin

                select value into l_mt
                  from operw
                 where ref = p_ref
                   and tag = rpad('f', 5, ' ');

                bars_audit.debug('document req "f"=>' || l_mt);

                -- Формат доп. реквизит f: "MT XXX"
                if (length(l_mt) != 6 or substr(l_mt, 1, 3) != 'MT ') then
                    bars_audit.error('Неверный формат реквизита f. Документ Ref=' || to_char(p_ref));
                    raise_application_error(-20781, '\101 Неверный формат реквизита f. Документ Ref=' || to_char(p_ref));
                end if;

                l_mt := substr(l_mt, 4, 3);

            exception
                when NO_DATA_FOUND then
                    bars_audit.debug('document req "f" not found');
                    bars_audit.info('Документ не предполагает создание swift сообщения');

                    -- В зависимости от флага генерируем ошибку
                    -- или просто выходим
                    if (p_flag) then
                        raise_application_error(-20781, '\003 У документа нет доп. реквизита "Тип Swift сообщения"');
                    else
                        return;
                    end if;
            end;

    end;

    -- Проверяем соответствие типу сообщения
    bars_audit.debug('checking message type eqv...');
    if (p_mt is not null) then

        if (to_char(p_mt) != l_mt) then
            bars_audit.error('Тип сообщения не соответствует заданному (' || l_mt || '!=' || p_mt || ')');
            raise_application_error(-20781, '\004 Тип сообщения не соответствует заданному (' || l_mt || '!=' || p_mt || ')');
        end if;
        bars_audit.debug('message type check passed.');

    else
        bars_audit.debug('skip message type check (first parameter null).');
    end if;

    -- По справочнику типов сообщений проверяем допустим ли тип
    -- и получаем флаг проверки подбора корсчета (необходимо
    -- для случая когда это информационное сообщение и идет
    -- без позиционера и подбора корсчета)
    bars_audit.debug('checking message type on base dict ...');

/*
    begin
        select isfin into l_finflg
          from sw_mt
         where mt = to_number(l_mt);

    exception
        when NO_DATA_FOUND then
            bars_audit.error('Неизвестный тип сообщения (' || l_mt || ')');
            raise_application_error(-20781, '\014 Неизвестный тип сообщения (' || l_mt || ')');
    end;
*/
    bars_audit.debug('message type check passed.');

    -- Для сообщений, которые должны пройти подбор
    -- корсчета флаг должен быть равен 1
    if (l_finflg = 1) then

        -- Проверяем выполнен ли подбор корсчета
        bars_audit.debug('check for doc req NOS_A ...');
        begin

            select to_number(value) into l_accNostro
              from operw
             where ref = p_ref
               and tag = 'NOS_A';

            bars_audit.debug('doc req NOS_A=' || to_char(l_accNostro));

            if (nvl(l_accNostro, 0) = 0) then
                bars_audit.debug('doc req NOS_A = 0, throw error...');
                bars_audit.error('Не выполнена операция подбора корсчета Ref=' || to_char(p_ref));
                raise_application_error(-20781, '\006 Не выполнена операция подбора корсчета Ref=' || to_char(p_ref));
            end if;

            -- на всякий случай проверим корректность счета
            bars_audit.debug('check nostro acc...');
            begin

                select acc into l_acc
                  from accounts
                 where acc = l_accNostro;

                bars_audit.debug('account acc=' || to_char(l_accNostro) || ' found.');

            exception
                when NO_DATA_FOUND then
                    bars_audit.debug('nostro acc not found, throw error...');
                    bars_audit.error('Не найден подобранный корсчет. Acc=' || to_char(l_accNostro));
                    raise_application_error(-20781, '\005 Не найден подобранный корсчет. Acc=' || to_char(l_accNostro));
            end;

        exception
            when NO_DATA_FOUND then
                bars_audit.debug('doc req NOS_A not found, throw error...');
                bars_audit.error('Документ не содержит доп.реквизит подобранного корсчета (NOS_A)');
                raise_application_error(-20781, '\007 В операции нет доп. реквизита NOS_A  Ref=' || to_char(p_ref));
        end;

        -- Проверяем была ли выполнена проводка по корсчету
        bars_audit.debug('check transaction on NOSTRO ...');

        select count(*)
          into l_cnt
          from opldok
         where ref = p_ref
           and dk  = 1
          and acc = l_accNostro;

        bars_audit.debug('transaction count=' || to_char(l_cnt));

        if (l_cnt != 1) then
            raise_application_error(-20781, '\008 Не выполнена проводка по корсчету или выполнено несколько проводок. Ref=' || to_char(p_ref));
        end if;

    end if;

end genmsg_docchk;


--**************************************************************--
-- GENMSG_GETDOCVALUE()
--
--     Функция получения доп. реквизита документа
--
--
--     Параметры:
--
--         p_ref    Референс документа, из которого будет
--                  выполняться получение реквизита
--
--         p_tag    имя доп. реквизита
--
--     Если документ не содержит указанного доп.реквизита
--     то функция возвращает NULL
--
function genmsg_getdocvalue(
    p_ref     in oper.ref%type,
    p_tag     in operw.tag%type ) return operw.value%type
is

l_retval operw.value%type;

begin

    select value
      into l_retval
      from operw
     where ref = p_ref
       and tag = p_tag;

     return l_retval;

exception
    when NO_DATA_FOUND then return null;
end genmsg_getdocvalue;


--**************************************************************--
-- GENMSG_GETVALUELIST()
--
--     Функция получения списка доп. реквизитов
--
--
--     Параметры:
--
--         p_value  Строка содержащаю список значений,
--                  разделенных символами CRLN
--
--
function genmsg_getvaluelist(
    p_value   in sw_operw.value%type ) return t_strlist
is

l_CrLn   char(2) := chr(13) || chr(10);

l_list   t_strlist := t_strlist();

l_value  sw_operw.value%type;
l_tmp    sw_operw.value%type;
l_pos    number;
l_cnt    number  := 1;

begin


    if (p_value is not null) then

        l_value := p_value;

        while (l_value is not null)
        loop

            l_pos := instr(l_value, l_CrLn);

            if (l_pos != 0) then
                l_tmp   := rtrim(ltrim(substr(l_value, 1, l_pos-1)));
                l_value := substr(l_value, l_pos+2);
            else
                l_tmp   := l_value;
                l_value := null;
            end if;

            if (l_tmp is not null) then
                l_list.extend;
                l_list(l_cnt) := l_tmp;
                l_cnt := l_cnt + 1;
            end if;

        end loop;

    end if;

    return l_list;

end genmsg_getvaluelist;


--**************************************************************--
-- GENMSG_USETRANSLATE()
--
--     Функция проверяет нужно ли выполнять транслитерацию
--     полей при формировании данного сообщения. Если в каком-
--     либо доп. реквизите документа, соответствующем полю
--     сообщения предполагающему транслитерацию содержатся
--     русские символы, то все такое сообщение необходимо
--     транслитерировать
--
--
function genmsg_usetranslate(
    p_mt     in  sw_mt.mt%type,
    p_ref    in  oper.ref%type  ) return boolean
is

cursor cursModelTrans(p_mt in sw_mt.mt%type)
is
select tag, opt
  from sw_model
 where mt    = p_mt
   and trans = 'Y';

cursor cursModelOptTrans(p_mt in sw_mt.mt%type)
is
select m.tag, decode(o.opt, '-', null, o.opt) opt
  from sw_model m, sw_model_opt o
 where m.mt    = p_mt
   and m.mt    = o.mt
   and m.num   = o.num
   and o.trans = 'Y';


l_recModelTrans     cursModelTrans%rowtype;
l_recModelOptTrans  cursModelOptTrans%rowtype;
l_value             sw_operw.value%type;

begin

    -- Проход 1
    open cursModelTrans(p_mt);
    loop
        fetch cursModelTrans into l_recModelTrans;
        exit when cursModelTrans%notfound;

        l_value := genmsg_getdocvalue(p_ref, l_recModelTrans.tag || l_recModelTrans.opt);

        if (l_value is not null) then

            if (genmsg_existsru(l_value)) then return true;
            end if;

        end if;

    end loop;
    close cursModelTrans;

    -- Проход 2
    open cursModelOptTrans(p_mt);
    loop
        fetch cursModelOptTrans into l_recModelOptTrans;
        exit when cursModelOptTrans%notfound;

        l_value := genmsg_getdocvalue(p_ref, l_recModelOptTrans.tag || l_recModelOptTrans.opt);

        if (l_value is not null) then

            if (genmsg_existsru(l_value)) then return true;
            end if;

        end if;

    end loop;
    close cursModelOptTrans;

    return false;

end genmsg_usetranslate;


--**************************************************************--
-- GENMSG_TRANSLATE()
--
--     Функция выполняет транслитерацию значения поля
--
--
--
--
--
--
--
function genmsg_translate(
    p_mt       in  sw_mt.mt%type,
    p_tag      in  sw_tag.tag%type,
    p_opt      in  sw_opt.opt%type,
    p_value    in  sw_operw.value%type,
    p_transtab in  varchar2            ) return sw_operw.value%type
is

l_cnt     number;
l_value   sw_operw.value%type := null;
l_pos     number;

begin

    select count(*) into l_cnt
      from sw_model
     where mt    = p_mt
       and tag   = p_tag
       and nvl(opt, '-') = nvl(p_opt, '-')
       and trans = 'Y';

    if (l_cnt = 0) then

        select count(*) into l_cnt
          from sw_model m, sw_model_opt o
         where m.mt    = p_mt
           and m.tag   = p_tag
           and m.mt    = o.mt
           and m.num   = o.num
           and nvl(o.opt, '-')   = nvl(p_opt, '-')
           and o.trans = 'Y';

        if (l_cnt = 0) then return p_value;
        end if;

    end if;

    if ( p_tag || p_opt in
           ('50K', '59', '52D', '53D', '54D', '55D', '56D', '57D', '58D',
            '53B', '54B', '55B', '57B' )) then

        if (substr(p_value, 1, 1) = '/') then

            l_pos := instr(p_value, chr(13) || chr(10));

            if (l_pos is not null and l_pos != 0) then
                l_value := substr(p_value, 1, l_pos+2) || StrToSwift(substr(p_value, l_pos+2), p_transtab);
            else
                l_value := StrToSwift(p_value, p_transtab);
            end if;

        else
            l_value := StrToSwift(p_value, p_transtab);
        end if;

    else
        l_value := StrToSwift(p_value, p_transtab);
    end if;

    return l_value;

end genmsg_translate;


--**************************************************************--
-- GENMSG_INSTAG()
--
--     Процедура вставки тэга сообщения по указанному значению
--     или из соответствующего доп. реквизита документа
--
--
--     Параметры:
--
--         p_mt     Тип SWIFT сообщения
--
--         p_ref    Референс документа, из которого будет
--                  выполняться формирование сообщения
--
--         p_flag   Флаг генерации ошибки, если передано
--                  значение TRUE, то в случае отсутствия
--                  на документе флага генерации сообщения
--                  будет сгенерирована ошибка
--
procedure genmsg_instag(
    p_model      in     sw_model%rowtype,
    p_swref      in     sw_journal.swref%type,
    p_ref        in     oper.ref%type,
    p_recno      in out number,
    p_opt        in     sw_opt.opt%type,
    p_value      in     sw_operw.value%type,
    p_insflag    in     boolean,
    p_usetrans   in     boolean    default false,
    p_transtable in     varchar2   default null  )
is

l_ins   boolean            := false;
l_opt   sw_opt.opt%type;
l_value sw_operw.value%type;
l_cnt   number;
l_list  t_strlist := t_strlist();

begin

    -- Если вставляем заданное значение
    if (p_insflag is not null) then

        bars_audit.debug('attempt insert spec value ...');
        if (p_insflag) then

            l_ins   := true;
            l_value := p_value;

            if (lower(p_model.opt) = p_model.opt) then

                -- Проверяем допустимость опции
                select count(*) into l_cnt
                  from sw_model_opt
                 where mt  = p_model.mt
                   and num = p_model.num
                   and opt = nvl(p_opt, '-');

                if (l_cnt = 0) then
                    raise_application_error(-20782, '\903 Опция ' || p_opt || ' недопустима для поля ' || p_model.tag);
                end if;

                l_opt := p_opt;

            else
                l_opt := p_model.opt;
            end if;

        else
            bars_audit.debug('insert flag FALSE, skip insert');
            return;
        end if;

    elsif (p_model.tag = '20' and p_model.opt is null) then

        select trn into l_value
          from sw_journal
         where swref = p_swref;

        l_opt := p_model.opt;
        l_ins := true;

    else

        -- Получаем значение из доп. реквизита документа
        -- Если переданная опция, маленькая буква, то
        -- такая опция должна подбираться из допустимых
        -- для этого поля
        if (lower(p_model.opt) = p_model.opt) then

            for o in (select opt
                        from sw_model_opt
                       where mt  = p_model.mt
                         and num = p_model.num
                      order by opt )
            loop

                if (o.opt = '-') then
                    l_opt := null;
                 else
                    l_opt := o.opt;
                 end if;

                l_value := genmsg_getdocvalue(p_ref, p_model.tag || l_opt);

                if (l_value is not null) then
                    l_ins := true;
                    exit;
                end if;

            end loop;

        else
            l_opt   := p_model.opt;
            l_value := genmsg_getdocvalue(p_ref, p_model.tag || l_opt);

            if (l_value is null) then
                l_ins := false;
            else
                l_ins := true;
            end if;
        end if;

    end if;

    bars_audit.debug('inserting tag=' || p_model.tag || l_opt || ' ...');
    if (l_ins) then

        -- Если необходимо, то проводим транслитерацию
        if (p_useTrans) then
            l_value := genmsg_translate(p_model.mt, p_model.tag, l_opt, l_value, p_transTable);
        end if;

        if (p_model.rpblk is null ) then


            In_SwOperw(p_swref, p_model.tag, p_model.seq, p_recno, l_opt, l_value);
            p_recno := p_recno + 1;
            bars_audit.debug('tag=' || p_model.tag || l_opt || ' inserted.');

        elsif (p_model.rpblk = 'RI' ) then

            l_list := genmsg_getvaluelist(l_value);

            for i in 1..l_list.count
            loop

              In_SwOperw(p_swRef, p_model.tag, p_model.seq, p_recno, l_opt, l_list(i));
              p_recno := p_recno + 1;
              bars_audit.debug('tag=' || p_model.tag || l_opt || ' inserted.');

            end loop;

        else
            raise_application_error(-20999, 'implementation restriction - unknown repeated flag');
        end if;

    else
        bars_audit.debug('tag=' || p_model.tag || l_opt || ' skipped.');
    end if;

end genmsg_instag;


--**************************************************************--
PROCEDURE igen_mt320_message (
     p_swmsg     in out t_swmsg,
     p_msgFlag   in     varchar2,
     p_msgOption in     varchar2,
     p_ref          out number )
is

l_retCode     number;         -- Код возврата функции In_SwJournal
l_dummy       number;         -- Временная переменая для разл. проверок
l_ref         number;         -- Реф. создаваемого сообщения
l_recno       number;         -- порядковый номер записи

l_bicSender   varchar2(11);   -- BIC-код отправителя
l_fld20       varchar2(16);   -- Поле 20
l_fld37       varchar2(12);   -- Поле 37
l_fld22c      varchar2(16);   -- Поле 22С
l_fld17       varchar2(1);    -- Поле 17
l_amn32       number;         -- сумма для поле 32H

l_swiId       varchar2(16) := null;     -- Ref входящего сообщения


begin

    -----------------------------------------------------------------
    -- ***    Блок проверок заполнения основных реквизитов     *** --
    --                                                             --
        -- BIC-код партнера
        if (p_swmsg.bicReceiver is null) then
            raise_application_error(-20780, '\111 Не задан BIC-код партнера');
        else
            begin
                select 1 into l_dummy from sw_banks WHERE bic = p_swmsg.bicReceiver;
            exception
                when NO_DATA_FOUND then
                    raise_application_error(-20780, '\112 BIC-код партнера не найден в справочнике участников');
            end;
        end if;

        -- Проверяем заполнение BIC-кода и счета по стороне А
        if (p_swmsg.bicPartyA is null or p_swmsg.accPartyA is null) then
            raise_application_error(-20780, '\113 Не указан BIC-код или счет по стороне А');
        end if;

        -- Проверяем заполнение BIC-кода и счета по стороне Б
        -- if (p_swmsg.altPartyB is null and (p_swmsg.bicPartyB is null or p_swmsg.accPartyB is null)) then
        if (p_swmsg.altPartyB is null and p_swmsg.bicPartyB is null) then
            raise_application_error(-20780, '\114 Не указан BIC-код или счет по стороне Б');
        end if;

    --                                                             --
    -- *** Конец блока проверок заполнения основных реквизитов *** --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- ***                 Блок создания сообщения             *** --
    --                                                             --

        l_bicSender := GetOurBankAsSender();

        -- Создаем заголовок сообщения
        In_SwJournalInt(
            ret_      => l_retCode,
            swref_    => l_ref,                                     -- Получ. реф. сообщения
            mt_       => 320,                                       --  Тип сообщения: MT300
            mid_      => null,
            page_     => null,
            io_       => 'I',                                       -- Направление: "Исходящее"
            sender_   => l_bicSender,                               -- BIC-код отправителя
            receiver_ => p_swmsg.bicReceiver,                       -- BIC-код получателя
            transit_  => null,
            payer_    => null,
            payee_    => null,
            ccy_      => null,
            amount_   => null,
            accd_     => null,
            acck_     => null,
            vdat_     => to_char(p_swmsg.valueDate, 'MM/DD/YYYY'),  -- Дата валютирования сообщения
            idat_     => to_char(sysdate, 'YYYY-MM-DD HH24:MI'),    -- Дата создания сообщения
            flag_     => nvl(p_msgFlag, 'L'));


        l_fld20 := getSwiftField20(l_ref, p_swmsg.bicReceiver);
        l_fld37 := substr(AmountToSwift(p_swmsg.intRate*100, 980, false, false), 1, 12);
        --
        -- 22C: Общий реф. отправителя и получателя
        --
        -- AAAA LA XXXX BBBB LB
        --
        --    AAAA - первые четрые символа из BIC-кода отправителя
        --    LA   - код страны отправителя ( поз. 7-8 BIC-кода)
        --    XXXX - четыре последних цифры из поля 37 (доп. лидирующими нулями)
        --    BBBB - первые четрые символа из BIC-кода получателя
        --    LB   - код страны получателя ( поз. 7-8 BIC-кода)
        --
        --

        if (least(substr(l_bicSender, 1, 4), substr(p_swmsg.bicReceiver, 1, 4)) = substr(l_bicSender, 1, 4)) then

            l_fld22c := substr(l_bicSender, 1, 4)                             ||
                        substr(l_bicSender, 7, 2)                             ||
                        substr(lpad(replace(l_fld37, ',', ''), 4, '0'), -4)   ||
                        substr(p_swmsg.bicReceiver, 1, 4)                           ||
                        substr(p_swmsg.bicReceiver, 7, 2);

        else

            l_fld22c := substr(p_swmsg.bicReceiver, 1, 4)                           ||
                        substr(p_swmsg.bicReceiver, 7, 2)                           ||
                        substr(lpad(replace(l_fld37, ',', ''), 4, '0'), -4)   ||
                        substr(l_bicSender, 1, 4)                             ||
                        substr(l_bicSender, 7, 2);

        end if;

        --
        -- Если есть прикрепленное входящее сообщение,
        -- то необходимо получить его Sender Reference (20)
        -- Или исходящего, если происходит его отмена
        --
        if (p_swmsg.swiRef is not null) then

            select rtrim(ltrim(value))
              into l_swiId
              from sw_operw
             where swref = p_swmsg.swiRef
               and tag = '20'
               and opt is null;

         end if;

        -- Если сделка отменяется, то получаем реф. пред. сообщения
        if (p_msgOption in ('MATU', 'ROLL')) then

            begin
                select rtrim(ltrim(value))
                  into l_swiId
                  from sw_operw
                 where swref = p_swmsg.prevSwRef
                   and tag = '20'
                   and opt is null;
            exception
                when NO_DATA_FOUND then null;
/*                    if (p_msgOption = 'ROLL') then
                        raise_application_error(-20780, '\115 Нет предыдущего исходящего сообщения');
                    end if;*/
            end;

        end if;

        -- Добавляем инф. строки сообщения

        --
        -- Секция А: Общая информация
        --
        --    15A          начало секции
        --    20           SWIFT-реф. сообщения
        --    21           SWIFT-реф. входящего сообщения
        --    22A          Тип операции: NEWT - новая
        --    22B          Тип события: CONF - подтверждение
        --    22C          Общий реф. отправителя и получателя
        --    82A          BIC-код стороны А (первые шесть символов)
        --    87A          BIC-код стороны Б (первые шесть символов)
        --
        In_SwOperw(l_Ref, '15', 'A',  1, 'A', '');
        In_SwOperw(l_Ref, '20', 'A',  2, '',  l_fld20); l_recno := 3;

        if (l_swiId is not null) then
            In_SwOperw(l_Ref, '21', 'A',  3, '', l_swiId); l_recno := l_recno + 1;
        end if;

        In_SwOperw(l_Ref, '22', 'A',  l_recno, 'A', 'NEWT'); l_recno := l_recno + 1;

        if (p_msgOption not in ('MATU', 'ROLL') or p_msgOption is null) then
            In_SwOperw(l_Ref, '22', 'A',  l_recno, 'B', 'CONF'); l_recno := l_recno + 1;
        else
            In_SwOperw(l_Ref, '22', 'A',  l_recno, 'B', p_msgOption); l_recno := l_recno + 1;
        end if;

        In_SwOperw(l_Ref, '22', 'A',  l_recno, 'C', l_fld22c); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '82', 'A',  l_recno, 'A', substr(l_bicSender,   1, 8)); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '87', 'A',  l_recno, 'A', substr(p_swmsg.bicReceiver, 1, 8)); l_recno := l_recno + 1;

        if (p_swmsg.agreementNum is not null or p_swmsg.agreementDate is not null) then
            In_SwOperw(l_Ref, '77', 'A',  l_recno, 'D', 'GEN AGR ' || PrepStr(p_swmsg.agreementNum) || ' DD '|| to_char(p_swmsg.agreementDate, 'dd.mm.yyyy')); l_recno := l_recno + 1;
        end if;

        --
        -- Секция Б: Описание сделки
        --
        --    15B          начало секции
        --    17R          роль стороны A               [L-депозит | B-кредит]
        --    30T          дата заключения сделки       [YYYYMMDD]
        --    30V          дата валютирования           [YYYYMMDD]
        --    30P          дата завершения              [YYYYMMDD]
        --    32B          код валюты и сумма сделки    [EUR123445,55]
        --    32H
        --    30X
        --    34E          код валюты и сумма процентов [EUR123,]
        --    37G          Процентная ставка            [10,]
        --    14D          метод учета дней             [ACT/360...]
        --
        In_SwOperw(l_Ref, '15', 'B', l_recno, 'B', null);  l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '17', 'B', l_recno, 'R', p_swmsg.fld17);  l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '30', 'B', l_recno, 'T', to_char(p_swmsg.tradeDate, 'YYYYMMDD'));  l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '30', 'B', l_recno, 'V', to_char(p_swmsg.valueDate, 'YYYYMMDD'));  l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '30', 'B', l_recno, 'P', to_char(p_swmsg.maturDate, 'YYYYMMDD'));  l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '32', 'B', l_recno, 'B', AmountToSWIFT(p_swmsg.prcCurrAmount, p_swmsg.prcCurrCode, true, true));  l_recno := l_recno + 1;


        --
        -- Если поле 22B = ROLL, то необходимо заполнение поля 32H
        -- Если сумма сделки не поменялась, то 0, иначе сумму сделки
        --

        if (p_msgOption = 'MATU') then

            -- Определяем сумму, которую нужно показать основная или основная+проц.
            if (p_swmsg.intPartyA is null) then
                l_amn32 := p_swmsg.prcCurrAmount + p_swmsg.intAmount;
            else
                l_amn32 := p_swmsg.prcCurrAmount;
            end if;

            if (p_swmsg.fld17 = 'L') then
                In_SwOperw(l_Ref, '32', 'B', l_recno, 'H', 'N' || AmountToSWIFT(l_amn32, p_swmsg.prcCurrCode, true, true));  l_recno := l_recno + 1;
            else
                In_SwOperw(l_Ref, '32', 'B', l_recno, 'H', AmountToSWIFT(l_amn32, p_swmsg.prcCurrCode, true, true));  l_recno := l_recno + 1;
            end if;

        elsif (p_msgOption = 'ROLL') then
            In_SwOperw(l_Ref, '32', 'B', l_recno, 'H', AmountToSWIFT(0, p_swmsg.prcCurrCode, true, true));  l_recno := l_recno + 1;
        end if;


        --
        -- Если поле 22B = (CONF|ROLL),  то необходимо заполнение поля 30X
        --
        In_SwOperw(l_Ref, '30', 'B',  l_recno, 'X', to_char(p_swmsg.maturDate, 'YYYYMMDD')); l_recno := l_recno + 1;

        if (p_msgOption != 'MATU') then
            In_SwOperw(l_Ref, '34', 'B', l_recno, 'E', AmountToSWIFT(p_swmsg.intAmount, p_swmsg.prcCurrCode, true, true));  l_recno := l_recno + 1;
        else
            -- если проценты нужно возвращать, то нужно поставить букву N впереди
            if (p_swmsg.fld17 = 'L') then
                In_SwOperw(l_Ref, '34', 'B', l_recno, 'E', 'N' || AmountToSWIFT(p_swmsg.intAmount, p_swmsg.prcCurrCode, true, true));  l_recno := l_recno + 1;
            else
                In_SwOperw(l_Ref, '34', 'B', l_recno, 'E', AmountToSWIFT(p_swmsg.intAmount, p_swmsg.prcCurrCode, true, true));  l_recno := l_recno + 1;
            end if;
        end if;

        In_SwOperw(l_Ref, '37', 'B', l_recno, 'G', l_fld37);  l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '14', 'B', l_recno, 'D', DayFractionToSwift(p_swmsg.baseyCode));  l_recno := l_recno + 1;

        --
        -- Секция C: Платежные инструкции для платежей проводимых стороной А
        --           (основная сумма договора)
        --           Таким образом здесь указываются счета стороны Б
        --
        --    15C          начало секции
        --    56A          реквизиты посредника стороны Б [/999999 XXXXXXXXXXX]
        --     или 56D     опция D                        [/999999
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX]
        --    57A          реквизиты стороны Б             [/123456 XXXXXXXXXXX]
        --     или 57D     опция D                         [/123456
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX]
        --

        In_SwOperw(l_Ref, '15', 'C', l_recno, 'C', '');  l_recno := l_recno + 1;

        --
        if (p_swmsg.intermB is not null) then
            p_swmsg.intermB := PrepStr(p_swmsg.intermB);
        end if;

        if (p_swmsg.altPartyB is not null) then
            p_swmsg.altPartyB := PrepStr(p_swmsg.altPartyB);
        end if;

        -- Если посредник указан определяем опцию и заносим
        if (p_swmsg.intermB is not null) then
            if (is_valid_a_option(p_swmsg.intermB)) then
                In_SwOperw(l_Ref, '56', 'C', l_recno, 'A', p_swmsg.intermB); l_recno := l_recno + 1;
            else
                In_SwOperw(l_Ref, '56', 'C', l_recno, 'D', FormatFieldOption('56', 'D', p_swmsg.intermB)); l_recno := l_recno + 1;
            end if;
        end if;

        -- Реквизиты стороны Б
        --if (l_accPartyB is not null and l_bicPartyB is not null) then
        if (p_swmsg.bicPartyB is not null) then
            if (p_swmsg.accPartyB is not null) then
                In_SwOperw(l_Ref, '57', 'C', l_recno, 'A', '/' || p_swmsg.accPartyB || chr(13) || chr(10) || p_swmsg.bicPartyB);  l_recno := l_recno + 1;
            else
                In_SwOperw(l_Ref, '57', 'C', l_recno, 'A', p_swmsg.bicPartyB);  l_recno := l_recno + 1;
            end if;
        else
            if (p_swmsg.altPartyB is not null) then
                In_SwOperw(l_Ref, '57', 'C', l_recno, 'D', FormatFieldOption('57', 'D', p_swmsg.altPartyB));  l_recno := l_recno + 1;
            else
                raise_application_error(-20780, '\115 Для поля 57 по стороне Б не заполнена ни опция А, ни опция D');
            end if;
        end if;

        --
        -- Секция D: Платежные инструкции для платежей проводимых стороной Б
        --           (основная сумма договора)
        --           Таким образом здесь указываются счета стороны А
        --
        --    15D          начало секции
        --    56A          реквизиты посредника стороны А [/999999 XXXXXXXXXXX]
        --     или 56D     опция D                        [/999999
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX]
        --    57A          реквизиты стороны А             [/123456 XXXXXXXXXXX]
        --     или 57D     опция D                         [/123456
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX]
        --

        In_SwOperw(l_Ref, '15', 'D', l_recno, 'D', '');  l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '57', 'D', l_recno, 'A', '/' || p_swmsg.accPartyA || chr(13) || chr(10) || p_swmsg.bicPartyA);  l_recno := l_recno + 1;


        --
        -- Секция E: Платежные инструкции для платежей проводимых стороной А
        --           (проценты)
        --           Таким образом здесь указываются счета стороны Б
        --
        --    15E          начало секции
        --    56A          реквизиты посредника стороны Б [/999999 XXXXXXXXXXX]
        --     или 56D     опция D                        [/999999
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX]
        --    57A          реквизиты стороны Б             [/123456 XXXXXXXXXXX]
        --     или 57D     опция D                         [/123456
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX]
        --

        if (p_swmsg.intIntermB is not null) then
            p_swmsg.intIntermB := PrepStr(p_swmsg.intIntermB);
        end if;

        if (p_swmsg.intPartyB is not null) then
            p_swmsg.intPartyB := PrepStr(p_swmsg.intPartyB);
        end if;

        -- Заполняем только если задан получатель процентов
        if (p_swmsg.intPartyB is not null) then

            In_SwOperw(l_Ref, '15', 'E', l_recno, 'E', '');  l_recno := l_recno + 1;

            -- Если задан посредник - вносим
            if (p_swmsg.intIntermB is not null) then

                if (is_valid_a_option(p_swmsg.intIntermB)) then
                    In_SwOperw(l_Ref, '56', 'E', l_recno, 'A', p_swmsg.intIntermB);  l_recno := l_recno + 1;
                else
                    In_SwOperw(l_Ref, '56', 'E', l_recno, 'D', FormatFieldOption('56', 'D', p_swmsg.intIntermB));  l_recno := l_recno + 1;
                end if;

            end if;

            -- определяем в какой опции получатель
            if (is_valid_a_option(p_swmsg.intPartyB)) then
               In_SwOperw(l_Ref, '57', 'E', l_recno, 'A', p_swmsg.intPartyB);  l_recno := l_recno + 1;
            else
               In_SwOperw(l_Ref, '57', 'E', l_recno, 'D', FormatFieldOption('57', 'D', p_swmsg.intPartyB));  l_recno := l_recno + 1;
            end if;

        end if;


        --
        -- Секция F: Платежные инструкции для платежей проводимых стороной Б
        --           (основная сумма договора)
        --           Таким образом здесь указываются счета стороны А
        --
        --    15F          начало секции
        --    56A          реквизиты посредника стороны А [/999999 XXXXXXXXXXX]
        --     или 56D     опция D                        [/999999
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX
        --                                                 XXXXXXXXXXXXXXXXXXX]
        --    57A          реквизиты стороны А             [/123456 XXXXXXXXXXX]
        --     или 57D     опция D                         [/123456
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX
        --                                                  XXXXXXXXXXXXXXXXXXX]
        --

        if (p_swmsg.intIntermA is not null) then
            p_swmsg.intIntermA := PrepStr(p_swmsg.intIntermA);
        end if;

        if (p_swmsg.intPartyA is not null) then
            p_swmsg.intPartyA := PrepStr(p_swmsg.intPartyA);
        end if;

        -- Заполняем только если задан получатель процентов
        if (p_swmsg.intPartyA is not null) then

            In_SwOperw(l_Ref, '15', 'F', l_recno, 'F', '');  l_recno := l_recno + 1;

            -- Если указан посредник - добавляем
            if (p_swmsg.intIntermA is not null) then

                if (is_valid_a_option(p_swmsg.intIntermA)) then
                     In_SwOperw(l_Ref, '56', 'F', l_recno, 'A', p_swmsg.intIntermA); l_recno := l_recno + 1;
                else
                     In_SwOperw(l_Ref, '56', 'F', l_recno, 'D', FormatFieldOption('56', 'D', p_swmsg.intIntermA)); l_recno := l_recno + 1;
                end if;
            end if;

            -- Заносим получателя
            if (is_valid_a_option(p_swmsg.intPartyA)) then
                In_SwOperw(l_Ref, '57', 'F', l_recno, 'A', p_swmsg.intPartyA);  l_recno := l_recno + 1;
            else
                In_SwOperw(l_Ref, '57', 'F', l_recno, 'D', FormatFieldOption('57', 'D', p_swmsg.intPartyA));  l_recno := l_recno + 1;
            end if;

        end if;

    p_ref := l_ref;

    --                                                             --
    -- ***            Конец блока создания сообщения           *** --
    -----------------------------------------------------------------

end igen_mt320_message;


--**************************************************************--
-- GEN_MT320dsw_MESSAGE()
--
--     Процедура создания сообщения MT320 по сделкам ДЕПО СВОП
--     (описаны в таблице ФОРЕКС fx_dealб формируются как МБДК)
--
--     Описание параметров:
--
--        p_dealRef        Референс сделки (FX_DEAL)
--        p_msgFlag        Дополнительная опция
--                           MATU - отмена сделки
--
--**************************************************************--
PROCEDURE gen_mt320dsw_message(
     p_dealRef   in  number,
     p_msgFlag   in  varchar2,
     p_msgOption in  varchar2 default null )
IS

l_fxswap1  fx_deal%rowtype;
l_fxswap2  fx_deal%rowtype;
l_swmsg    t_swmsg;
l_ref      number;         -- Реф. создаваемого сообщения

BEGIN

    begin
        select f.* into l_fxswap1
          from fx_deal f
         where f.deal_tag = ( select swap_tag from fx_deal where deal_tag = p_dealRef )
         and exists (select 1 from oper where ref = f.ref and sos > 0);

    exception when no_data_found then
        raise_application_error(-20780, '\110 Договор с реф. ' || to_char(p_dealRef) || ' не найден (FX_DEAL) или не является договором ДЕПО СВОП');
    end;

    begin
        select f.* into l_fxswap2
          from fx_deal f
         where f.swap_tag = l_fxswap1.deal_tag and f.kva = l_fxswap1.kvb and f.suma = l_fxswap1.sumb
         and exists (select 1 from oper where ref = f.ref and sos > 0);
    exception when no_data_found then
        raise_application_error(-20780, '\110 Договор-2 не найден (FX_DEAL)');
    end;


    -- 1. Получаем из договора необходимые реквизиты на заход валюты (привлечение)
    l_swmsg.bicReceiver   := l_fxswap1.bicb;
    l_swmsg.tradeDate     := l_fxswap1.dat;
    l_swmsg.valueDate     := l_fxswap1.dat_a;
    l_swmsg.maturDate     := l_fxswap2.dat_b;
    l_swmsg.fld17         := 'B';
    l_swmsg.prcCurrAmount := l_fxswap1.suma;
    l_swmsg.prcCurrCode   := l_fxswap1.kva;
    begin
        select ir into l_swmsg.intRate
          from int_ratn r
         where acc = l_fxswap2.acc9b
           and bdat = (select max(bdat) from int_ratn where acc = r.acc and bdat <= l_fxswap2.dat_b);
    exception when no_data_found then
        l_swmsg.intRate := 0;
    end;
    select nvl(sum(f.sumb),0) into l_swmsg.intAmount from fx_deal f where f.swap_tag = l_fxswap1.deal_tag and f.deal_tag not in (l_fxswap1.deal_tag, l_fxswap2.deal_tag)
    and exists (select 1 from oper where ref=f.ref and sos>0);

       /* raise_application_error(-20000,'l_fxswap1.deal_tag='||l_fxswap1.deal_tag||',
                      l_fxswap1.kvb='||l_fxswap1.kvb||',
                     l_fxswap1.sumb='||l_fxswap1.sumb||',
                     l_fxswap1.suma='||l_fxswap1.suma||',
                 l_fxswap2.deal_tag='||l_fxswap2.deal_tag||',
                 l_swmsg.intAmount='||l_swmsg.intAmount);*/
    begin
        select basey into l_swmsg.baseyCode
          from int_accn_update r
         where acc = l_fxswap2.acc9b
           and chgdate = (select max(chgdate) from int_accn_update where acc = r.acc and effectdate <= l_fxswap2.dat_b);
    exception when no_data_found then
        l_swmsg.baseyCode := null;
    end;

    begin
        select nvl(substr(value,1,20),l_fxswap2.agrmnt_num) into l_swmsg.agreementNum from customerw where rnk=l_fxswap1.rnk and tag = 'BGD';
    exception when no_data_found then
       l_swmsg.agreementNum  := l_fxswap2.agrmnt_num;
    end;

    begin
        select nvl(to_date(value, 'dd/mm/yyyy'),l_fxswap2.agrmnt_date) into l_swmsg.agreementDate from customerw where rnk=l_fxswap1.rnk and tag = 'DGD';
    exception when no_data_found then
        l_swmsg.agreementDate := l_fxswap2.agrmnt_date;
    end;



    l_swmsg.swiRef        := l_fxswap1.swi_ref;
    l_swmsg.bicPartyA     := l_fxswap1.swi_bic;
    l_swmsg.accPartyA     := l_fxswap1.swi_acc;
    l_swmsg.prevSwRef     := l_fxswap1.swo_ref;
    l_swmsg.bicPartyB     := l_fxswap2.swo_bic;
    l_swmsg.accPartyB     := l_fxswap2.swo_acc;
    l_swmsg.altPartyB     := l_fxswap2.alt_partyb;
    l_swmsg.intermB       := l_fxswap2.interm_b;
    l_swmsg.intPartyA     := null;
    l_swmsg.intIntermA    := null;
    l_swmsg.intPartyB     := null;
    l_swmsg.intIntermB    := null;

    -- формирование сообщения
    igen_mt320_message(l_swmsg, p_msgFlag, p_msgOption, l_ref);

    -- Привязываем созданное сообщение к договору
    update fx_deal
       set swo_ref = l_Ref
     where deal_tag = l_fxswap1.deal_tag;


    -- 2. Получаем из договора необходимые реквизиты на отправку валюты (размещение)
    l_swmsg.bicReceiver   := l_fxswap1.bicb;
    l_swmsg.tradeDate     := l_fxswap1.dat;
    l_swmsg.valueDate     := l_fxswap1.dat_b;
    l_swmsg.maturDate     := l_fxswap2.dat_a;
    l_swmsg.fld17         := 'L';
    l_swmsg.prcCurrAmount := l_fxswap1.sumb;
    l_swmsg.prcCurrCode   := l_fxswap1.kvb;
    begin
        select ir into l_swmsg.intRate
          from int_ratn r
         where acc = l_fxswap2.acc9a
           and bdat = (select max(bdat) from int_ratn where acc = r.acc and bdat <= l_fxswap2.dat_a);
    exception when no_data_found then
        l_swmsg.intRate := 0;
    end;
    select nvl(sum(f.suma),0) into l_swmsg.intAmount from fx_deal f where f.swap_tag = l_fxswap1.deal_tag and f.deal_tag not in (l_fxswap1.deal_tag, l_fxswap2.deal_tag)
    and exists (select 1 from oper where ref=f.ref and sos>0);
    begin
        select basey into l_swmsg.baseyCode
          from int_accn_update r
         where acc = l_fxswap2.acc9a
           and chgdate = (select max(chgdate) from int_accn_update where acc = r.acc and effectdate <= l_fxswap2.dat_a);
    exception when no_data_found then
        l_swmsg.baseyCode := null;
    end;
    l_swmsg.agreementNum  := l_fxswap1.agrmnt_num;
    l_swmsg.agreementDate := l_fxswap1.agrmnt_date;
    l_swmsg.swiRef        := l_fxswap2.swi_ref;
    l_swmsg.bicPartyA     := l_fxswap2.swi_bic;
    l_swmsg.accPartyA     := l_fxswap2.swi_acc;
    l_swmsg.prevSwRef     := l_fxswap2.swo_ref;
    l_swmsg.bicPartyB     := l_fxswap1.swo_bic;
    l_swmsg.accPartyB     := l_fxswap1.swo_acc;
    l_swmsg.altPartyB     := l_fxswap1.alt_partyb;
    l_swmsg.intermB       := l_fxswap1.interm_b;
    l_swmsg.intPartyA     := null;
    l_swmsg.intIntermA    := null;
    l_swmsg.intPartyB     := null;
    l_swmsg.intIntermB    := null;

    -- формирование сообщения
    igen_mt320_message(l_swmsg, p_msgFlag, p_msgOption, l_ref);

    -- Привязываем созданное сообщение к договору
    update fx_deal
       set swo_ref = l_Ref
     where deal_tag = l_fxswap2.deal_tag;

END gen_mt320dsw_message;


--**************************************************************--
-- GEN_MT600_MESSAGE()
--
--     Процедура создания сообщения MT600
--
--     Описание параметров:
--
--        p_dealRef        Референс сделки (FX_DEAL)
--
--**************************************************************--
PROCEDURE gen_mt600_message(
     p_dealRef   in  number,
     p_msgFlag   in  varchar2 )
IS


l_metall      number := 0;      -- =1-покупка металла / 2-продажа металла

l_retCode     number;           -- Код возврата функции In_SwJournal
l_dummy       number;           -- Временная переменая для разл. проверок
l_ref         number;           -- Реф. создаваемого сообщения

l_dealDate    date;             -- Дата сделки
l_valueDate   date;             -- Дата валютирования
l_bicSender   varchar2(11);     -- BIC-код отправителя
l_bicReceiver varchar2(11);     -- BIC-код получателя

l_dateA       date;             -- Дата покупки валюты А
l_currAmountA number;           -- Сумма валюты А
l_currCodeA   number;           -- Код валюты А
l_dateB       date;             -- Дата продажи валюты Б
l_currAmountB number;           -- Сумма валюты Б
l_currCodeB   number;           -- Код валюты Б

l_agreementNum   varchar2(10);  -- Номер ген.соглашения
l_agreementDate  date;          -- Дата ген.соглашения


l_swiRef      number;           -- Реф. входящего сообщ.
l_swiId       varchar2(16);     -- Идентификатор входящего сообщения
l_bicPartyA   varchar2(11);     -- BIC-код стороны А
l_accPartyA   varchar2(35);     -- счет строны А
l_bicPartyB   varchar2(11);     -- BIC-код стороны Б
l_accPartyB   varchar2(35);     -- счет строны Б
l_altPartyB   varchar2(250);    -- поле 57 option D

l_intermB     varchar2(250);    -- посредник по стороне Б

l_fld20       varchar2(16);     -- Поле 20
l_fld22c      varchar2(16);     -- Поле 22С
l_fld26c      varchar2(100);    -- Поле 26С
l_fld33g      varchar2(12);     -- Поле 33G

l_recno       number;           -- порядковый номер поля
l_baseCurr    varchar2(1);      -- Признак базовой валюты сделки


BEGIN


    -- Получаем из договора необходимые реквизиты
    begin
        select
               bicb                  receiver_bic,
               dat                   trace_date,
               least(dat_a, dat_b)   value_date,
               dat_a                 date_a,
               kva                   currency_a,
               suma                  amount_a,
               dat_b                 date_b,
               kvb                   currency_b,
               sumb                  amount_b,
               agrmnt_num            agrmnt_num,
               agrmnt_date           agrmnt_date,
               curr_base             base_curr,
               swi_ref               inbound_msg,
               swi_bic               partya_bic,
               swi_acc               partya_acc,
               swo_bic               partyb_bic,
               swo_acc               partyb_acc,
               alt_partyb            partyb_alt,
               interm_b              intermb
          into l_bicReceiver,
               l_dealDate,
               l_valueDate,
               l_dateA,
               l_currCodeA,
               l_currAmountA,
               l_dateB,
               l_currCodeB,
               l_currAmountB,
               l_agreementNum,
               l_agreementDate,
               l_baseCurr,
               l_swiRef,
               l_bicPartyA,
               l_accPartyA,
               l_bicPartyB,
               l_accPartyB,
               l_altPartyB,
               l_intermB
          FROM fx_deal
         WHERE deal_tag = p_dealRef;

    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\110 Договор или параметры договора с реф. ' || to_char(p_dealRef) || ' не найдены (FOREX)');
    end;

    begin
       select 1 into l_metall from tabval where kv = l_currCodeA and prv = 1;
       l_fld26c := case when l_currCodeA = 959 then 'GOLD'
                        when l_currCodeA = 964 then 'PALL'
                        when l_currCodeA = 962 then 'PLAT'
                        when l_currCodeA = 961 then 'SILV'
                        else null
                        end;
    exception when no_data_found then
       begin
          select 2 into l_metall from tabval where kv = l_currCodeB and prv = 1;
          l_fld26c := case when l_currCodeB = 959 then 'GOLD'
                           when l_currCodeB = 964 then 'PALL'
                           when l_currCodeB = 962 then 'PLAT'
                           when l_currCodeB = 961 then 'SILV'
                           else null
                           end;
       exception when no_data_found then
          l_metall := 0;
          l_fld26c := null;
       end;
    end;
    if l_metall = 0 then
       raise_application_error(-20000, 'Not MT600!!!');
    end if;
    if l_fld26c is null then
       raise_application_error(-20000, 'Unknown metall!!!');
    end if;
    l_fld26c := '/METALL-ACCOUNT/UNALL' || l_fld26c;

    -----------------------------------------------------------------
    -- ***    Блок проверок заполнения основных реквизитов     *** --
    --                                                             --
        -- BIC-код партнера
        if (l_bicReceiver is null) then
            raise_application_error(-20780, '\111 Не задан BIC-код партнера');
        else
            begin
                select 1 into l_dummy from sw_banks WHERE bic = l_bicReceiver;
            exception
                when NO_DATA_FOUND then
                    raise_application_error(-20780, '\112 BIC-код партнера не найден в справочнике участников');
            end;
        end if;

        --
        -- Убрал проверки в связи с возможность работы без списания/зачисления
        -- с/на корсчет
        --
        /*
        -- Проверяем заполнение BIC-кода и счета по стороне А
        if (l_bicPartyA is null or l_accPartyA is null) then
            raise_application_error(-20780, '\113 Не указан BIC-код или счет по стороне А');
        end if;

        -- Проверяем заполнение BIC-кода и счета по стороне Б
        if (l_bicPartyB is null or l_accPartyB is null) then
            if (l_altPartyB is null) then
                raise_application_error(-20780, '\114 Не указан BIC-код или счет по стороне Б');
            end if;
        end if;
        */

    --                                                             --
    -- *** Конец блока проверок заполнения основных реквизитов *** --
    -----------------------------------------------------------------

    l_bicSender := GetOurBankAsSender();

    if (l_swiRef is not null) then

        select rtrim(ltrim(value))
          into l_swiId
          from sw_operw
         where swref = l_swiRef
           and tag = '20'
           and opt is null;

    end if;


    -----------------------------------------------------------------
    -- ***                 Блок создания сообщения             *** --
    --                                                             --

        -- Создаем заголовок сообщения
        In_SwJournalEx(
            ret_      => l_retCode,
            swref_    => l_ref,                                     -- Получ. реф. сообщения
            mt_       => 600,                                       --  Тип сообщения: MT600
            mid_      => null,
            page_     => null,
            io_       => 'I',                                       -- Направление: "Исходящее"
            sender_   => l_bicSender,                               -- BIC-код отправителя
            receiver_ => l_bicReceiver,                             -- BIC-код получателя
            transit_  => null,
            payer_    => null,
            payee_    => null,
            ccy_      => null,
            amount_   => null,
            accd_     => null,
            acck_     => null,
            vdat_     => to_char(l_valueDate, 'MM/DD/YYYY'),        -- Дата валютирования сообщения
            idat_     => to_char(sysdate, 'YYYY-MM-DD HH24:MI'),    -- Дата создания сообщения
            flag_     => p_msgFlag );


        l_fld20 := getSwiftField20(l_ref, l_bicReceiver);

        if l_metall = 1 then
            l_fld33g := substr(AmountToSWIFT(l_currAmountB/l_currAmountA*100, l_currCodeB, true, true), 1, 12);
        else
            l_fld33g := substr(AmountToSWIFT(l_currAmountA/l_currAmountB*100, l_currCodeA, true, true), 1, 12);
        end if;

        --
        -- 22C: Общий реф. отправителя и получателя
        --
        -- AAAA LA XXXX BBBB LB
        --
        --    AAAA - первые четрые символа из BIC-кода отправителя
        --    LA   - код страны отправителя ( поз. 7-8 BIC-кода)
        --    XXXX - четыре последних цифры из поля 33G (доп. лидирующими нулями)
        --    BBBB - первые четрые символа из BIC-кода получателя
        --    LB   - код страны получателя ( поз. 7-8 BIC-кода)
        --
        --
        if (least(substr(l_bicSender, 1, 4), substr(l_bicReceiver, 1, 4)) = substr(l_bicSender, 1, 4)) then

            l_fld22c := substr(l_bicSender, 1, 4)                               ||
                        substr(l_bicSender, 7, 2)                               ||
                        substr('0000'||substr(replace(l_fld33g, ',', ''),4),-4) ||
                        substr(l_bicReceiver, 1, 4)                             ||
                        substr(l_bicReceiver, 7, 2);
        else

            l_fld22c := substr(l_bicReceiver, 1, 4)                             ||
                        substr(l_bicReceiver, 7, 2)                             ||
                        substr('0000'||substr(replace(l_fld33g, ',', ''),4),-4) ||
                        substr(l_bicSender, 1, 4)                               ||
                        substr(l_bicSender, 7, 2);
        end if;


        -- Добавляем инф. строки сообщения

        --
        -- Секция А: Общая информация
        --
        --    15A          начало секции
        --    20           SWIFT-реф. сообщения
        --    21           SWIFT-реф. входящего сообщения
        --    22A          Тип операции: NEWT - новая
        --    22C          Общий реф. отправителя и получателя
        --    82A          BIC-код стороны А (первые шесть символов)
        --    87A          BIC-код стороны Б (первые шесть символов)
        --
        --    30    Date Contract Agreed/Amended
        --    26C    Identification of the Metal
        --    33G    Price per Unit
        --
        In_SwOperw(l_Ref, '15', 'A',  1, 'A', '');
        In_SwOperw(l_Ref, '20', 'A',  2, '',  l_fld20);

        if (l_swiRef is not null and l_swiId is not null) then
            In_SwOperw(l_Ref, '21', 'A',  3, '', l_swiId); l_recno := 4;
            In_SwOperw(l_Ref, '22', 'A',  l_recno, 'A', 'EXOP'); l_recno := l_recno + 1;
        else
            In_SwOperw(l_Ref, '22', 'A',  3, 'A', 'NEWT'); l_recno := 4;
        end if;

        In_SwOperw(l_Ref, '22', 'A',  l_recno, 'C', l_fld22c); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '82', 'A',  l_recno, 'A', substr(l_bicSender,   1, 8)); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '87', 'A',  l_recno, 'A', substr(l_bicReceiver, 1, 8)); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '30', 'A',  l_recno, '',  to_char(l_dealDate, 'YYMMDD')); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '26', 'A',  l_recno, 'C', l_fld26c); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '33', 'A',  l_recno, 'G', l_fld33g); l_recno := l_recno + 1;

        --
        -- Секция B/C: Описание сделки
        --
        if l_metall = 1 then
        -- Optional Sequence B Precious Metal Bought
        --    15B   New Sequence
        --    32F   Quantity of the Metal
        --             FORMAT
        --                Option F
        --                   3!a15d   (Unit) (Amount)
        --             DEFINITION
        --                This field specifies the type of unit and the quantity of the precious metal bought by the Sender
        --             CODES
        --                Unit must contain one of the following codes:
        --                FOZ   Fine ounce
        --                GOZ   Gross ounce
        --                GRM   Gramme
        --                KLO   Kilo
        --                LOT   Lot
        --                TAL   Tael
        --                TOL   Tola
        --                UNT   Unit
        --    87a   Receiver of the Metal
        --             FORMAT
        --                Option A
        --                   [/1!a][/34x]   (Party Identifier)
        --                   4!a2!a2!c[3!c] (BIC)
        --                Option B
        --                   [/1!a][/34x]   (Party Identifier)
        --                   [35x]          (Location)
        --                Option D
        --                   [/1!a][/34x]   (Party Identifier)
        --                   4*35x          (Name and Address)
        --             DEFINITION
        --                This field identifies the party at which the Sender will receive the metal bought
        --    34P   Consideration
        --             FORMAT
        --                Option P
        --                   6!n3!a15d   (Date) (Currency) (Amount)
        --             DEFINITION
        --                This field specifies the value date, currency code and the consideration paid by the Sender
        --    57a   Account With Institution
        --             DEFINITION
        --                This field identifies the financial institution and account where the Receiver wants to receive the funds specified in field 34P
        --

           In_SwOperw(l_Ref, '15', 'B',  l_recno, 'B', null); l_recno := l_recno + 1;
           In_SwOperw(l_Ref, '32', 'B',  l_recno, 'F', 'FOZ' || AmountToSWIFT(l_currAmountA, l_currCodeA, false, false)); l_recno := l_recno + 1;
           if (l_accPartyA is not null and l_bicPartyA is not null) then
               In_SwOperw(l_Ref, '87', 'B', l_recno, 'A', '/' || l_accPartyA || chr(13) || chr(10) || l_bicPartyA);
           elsif (l_bicPartyA is not null) then
               In_SwOperw(l_Ref, '87', 'B', l_recno, 'A', l_bicPartyA);
           else
               In_SwOperw(l_Ref, '87', 'B', l_recno, 'A', substr(l_bicSender, 1, 8));
           end if;
           l_recno := l_recno + 1;
           In_SwOperw(l_Ref, '34', 'B',  l_recno, 'P', to_char(l_dateB, 'YYMMDD') || AmountToSWIFT(l_currAmountB, l_currCodeB, true, true)); l_recno := l_recno + 1;
           --
           --    57A          реквизиты      [/123456 XXXXXXXXXXX]
           --     или 57D     реквизиты      [/123456
           --                                 XXXXXXXXXXXXXXXXXXX
           --                                 XXXXXXXXXXXXXXXXXXX
           --                                 XXXXXXXXXXXXXXXXXXX
           --                                 XXXXXXXXXXXXXXXXXXX]
           --
           if (l_accPartyB is not null and l_bicPartyB is not null) then
               In_SwOperw(l_Ref, '57', 'B', l_recno, 'A', '/' || l_accPartyB || chr(13) || chr(10) || l_bicPartyB);
           else
               if (l_altPartyB is not null) then
                   l_altPartyB := PrepStr(l_altPartyB);
               end if;
               if (l_altPartyB is not null) then
                   In_SwOperw(l_Ref, '57', 'B', l_recno, 'D', FormatFieldOption('57', 'D', l_altPartyB));
               else
                   if (l_accPartyA is null and l_bicPartyA is null) then
                       In_SwOperw(l_Ref, '57', 'B', l_recno, 'D', 'NONE');
                   else
                       In_SwOperw(l_Ref, '57', 'B', l_recno, 'D', 'NET');
                   end if;
               end if;
           end if;
           l_recno := l_recno + 1;

        else
        --
        -- Optional Sequence C Precious Metal Sold
        --    15C   New Sequence
        --    32F   Quantity of the Metal
        --    87a   Deliverer of the Metal
        --             DEFINITION
        --                This field identifies the party to which the Sender will deliver the metal sold
        --    34R   Consideration
        --             FORMAT
        --                Option R
        --                   6!n3!a15d   (Date) (Currency) (Amount)
        --             DEFINITION
        --                This field specifies the value date, currency code and the consideration received by the Sender
        --    57a   Account With Institution
        --             DEFINITION
        --                This field identifies the financial institution and account at which the Sender wishes to receive the funds specified in field 34R
        --

           In_SwOperw(l_Ref, '15', 'C',  l_recno, 'C', null); l_recno := l_recno + 1;
           In_SwOperw(l_Ref, '32', 'C',  l_recno, 'F', 'FOZ' || AmountToSWIFT(l_currAmountB, l_currCodeB, false, false)); l_recno := l_recno + 1;
           if (l_accPartyB is not null and l_bicPartyB is not null) then
               In_SwOperw(l_Ref, '87', 'C', l_recno, 'A', '/' || l_accPartyB || chr(13) || chr(10) || l_bicPartyB);
           elsif (l_bicPartyB is not null) then
               In_SwOperw(l_Ref, '87', 'C', l_recno, 'A', l_bicPartyB);
           else
               In_SwOperw(l_Ref, '87', 'C', l_recno, 'A', substr(l_bicReceiver, 1, 8));
           end if;
           l_recno := l_recno + 1;
           In_SwOperw(l_Ref, '34', 'C',  l_recno, 'R', to_char(l_dateA, 'YYMMDD') || AmountToSWIFT(l_currAmountA, l_currCodeA, true, true)); l_recno := l_recno + 1;
           if (l_accPartyA is null and l_bicPartyA is null) then
               if (l_altPartyB is not null or (l_accPartyB is not null and l_bicPartyB is not null)) then
                   In_SwOperw(l_Ref, '57', 'C', l_recno, 'D', 'NET'); l_recno := l_recno + 1;
               else
                   In_SwOperw(l_Ref, '57', 'C', l_recno, 'D', 'NONE'); l_recno := l_recno + 1;
               end if;
           else
               if (l_accPartyA is null) then
                  In_SwOperw(l_Ref, '57', 'C', l_recno, 'A', l_bicPartyA); l_recno := l_recno + 1;
               else
                  In_SwOperw(l_Ref, '57', 'C', l_recno, 'A', '/' || l_accPartyA || chr(13) || chr(10) || l_bicPartyA); l_recno := l_recno + 1;
               end if;
           end if;

        end if;

    --                                                             --
    -- ***            Конец блока создания сообщения           *** --
    -----------------------------------------------------------------

    -- Привязываем созданное сообщение к договору
    Link3xxMsg(600, l_Ref, p_dealRef, 'I');


END gen_mt600_message;



--**************************************************************--
-- GEN_MT300_MESSAGE()
--
--     Процедура создания сообщения MT300
--
--     Описание параметров:
--
--        p_dealRef        Референс сделки (FX_DEAL)
--
--
-- DG
--**************************************************************--
PROCEDURE gen_mt300_message(
     p_dealRef   in  number,
     p_msgFlag   in  varchar2 )
IS


l_metall      number := 0;      -- признак металла

l_retCode     number;           -- Код возврата функции In_SwJournal
l_dummy       number;           -- Временная переменая для разл. проверок
l_ref         number;           -- Реф. создаваемого сообщения

l_dealDate    date;             -- Дата сделки
l_valueDate   date;             -- Дата валютирования
l_bicSender   varchar2(11);     -- BIC-код отправителя
l_bicReceiver varchar2(11);     -- BIC-код получателя

l_currAmountA number;           -- Сумма валюты А
l_currCodeA   number;           -- Код валюты А
l_currAmountB number;           -- Сумма валюты Б
l_currCodeB   number;           -- Код валюты Б

l_agreementNum   varchar2(20);  -- Номер ген.соглашения
l_agreementDate  date;          -- Дата ген.соглашения


l_swiRef      number;           -- Реф. входящего сообщ.
l_swiId       varchar2(16);     -- Идентификатор входящего сообщения
l_swoRef      number;           -- Реф. исходящего сообщ.
l_bicPartyA   varchar2(11);     -- BIC-код стороны А
l_accPartyA   varchar2(35);     -- счет строны А
l_bicPartyB   varchar2(11);     -- BIC-код стороны Б
l_accPartyB   varchar2(35);     -- счет строны Б
l_altPartyB   varchar2(250);    -- поле 57 option D

l_intermB     varchar2(250);    -- посредник по стороне Б

l_fld20       varchar2(16);     -- Поле 20
l_fld36       varchar2(12);     -- Поле 36
l_fld22c      varchar2(16);     -- Поле 22С

l_recno       number;           -- порядковый номер поля
l_baseCurr    varchar2(1);      -- Признак базовой валюты сделки

l_swaptag     number;
i             number;
l_rnk         number;


BEGIN


    -- Получаем из договора необходимые реквизиты
    begin
        select
               bicb                  receiver_bic,
               dat                   trace_date,
               least(dat_a, dat_b)   value_date,
               kva                   currency_a,
               suma                  amount_a,
               kvb                   currency_b,
               sumb                  amount_b,
               agrmnt_num            agrmnt_num,
               agrmnt_date           agrmnt_date,
               curr_base             base_curr,
               swi_ref               inbound_msg,
               swi_bic               partya_bic,
               swi_acc               partya_acc,
               swo_ref               outbound_msg,
               swo_bic               partyb_bic,
               swo_acc               partyb_acc,
               alt_partyb            partyb_alt,
               interm_b              intermb,
               swap_tag,
               rnk
          into l_bicReceiver,
               l_dealDate,
               l_valueDate,
               l_currCodeA,
               l_currAmountA,
               l_currCodeB,
               l_currAmountB,
               l_agreementNum,
               l_agreementDate,
               l_baseCurr,
               l_swiRef,
               l_bicPartyA,
               l_accPartyA,
               l_swoRef,
               l_bicPartyB,
               l_accPartyB,
               l_altPartyB,
               l_intermB,
               l_swaptag,
               l_rnk
          FROM fx_deal
         WHERE deal_tag = p_dealRef;

    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\110 Договор или параметры договора с реф. ' || to_char(p_dealRef) || ' не найдены (FOREX)');
    end;

       begin
            select nvl(substr(value,1,20),l_agreementNum) into l_agreementNum from customerw where rnk=l_rnk and tag = 'BGD';
          exception when no_data_found then
           null;
       end;

    begin
        select nvl(to_date(value,'dd/mm/yyyy'),l_agreementDate) into l_agreementDate from customerw where rnk=l_rnk and tag = 'DGD';
    exception when no_data_found then
      null;
    end;

    if l_swoRef is not null then
        raise_application_error(-20780, '\027 К договору уже привязано исходящее сообщение MT300 с реф. ' || to_char(l_sworef));
    end if;

    -- проверка на сделку ДЕПО-СВОП - формирование MT320
    if l_swaptag is not null then
       select count(*) into i from fx_deal where swap_tag = l_swaptag;
       -- ДЕПО-СВОП (с процентами) = MT320, иначе - обычный СВОП (без процентов) или обычный форекс = MT300
       if i > 2 then
          -- первая сделка ДЕПО СВОП
          if l_swaptag = p_dealRef then
             gen_mt320dsw_message(p_dealRef, p_msgFlag);
             return;
          else
             begin
                -- вторая сделка ДЕПО СВОП
                select 1 into i from fx_deal where swap_tag = l_swaptag and kva = l_currCodeB and suma = l_currAmountB;
                gen_mt320dsw_message(p_dealRef, p_msgFlag);
                return;
             exception when no_data_found then
                -- промежуточная сделка ДЕПО СВОП (проценты) - формируем обычное MT300
                null;
             end;
          end if;
       -- обычный СВОП (без процентов) = ВАЛЮТНЫЙ СВОП - вторая сделка: формируем сначала 300 по первой сделке СВОП
       elsif i = 2 and p_dealRef <> l_swaptag then
          begin
             select swo_ref into i from fx_deal where deal_tag = l_swaptag;
             if i is null then
                gen_mt300_message(l_swaptag, 'L');
             end if;
          exception when no_data_found then null;
          end;
       end if;
    end if;

    -- проверка на сделку с металлами - формирование MT600
    begin
       select 1 into l_metall from tabval where kv = l_currCodeA and prv = 1;
    exception when no_data_found then
       begin
          select 1 into l_metall from tabval where kv = l_currCodeB and prv = 1;
       exception when no_data_found then
          l_metall := 0;
       end;
    end;
    if l_metall = 1 then
       gen_mt600_message(p_dealRef, p_msgFlag);
       return;
    end if;

    -----------------------------------------------------------------
    -- ***    Блок проверок заполнения основных реквизитов     *** --
    --                                                             --
        -- BIC-код партнера
        if (l_bicReceiver is null) then
            raise_application_error(-20780, '\111 Не задан BIC-код партнера');
        else
            begin
                select 1 into l_dummy from sw_banks WHERE bic = l_bicReceiver;
            exception
                when NO_DATA_FOUND then
                    raise_application_error(-20780, '\112 BIC-код партнера не найден в справочнике участников');
            end;
        end if;

        --
        -- Убрал проверки в связи с возможность работы без списания/зачисления
        -- с/на корсчет
        --
        /*
        -- Проверяем заполнение BIC-кода и счета по стороне А
        if (l_bicPartyA is null or l_accPartyA is null) then
            raise_application_error(-20780, '\113 Не указан BIC-код или счет по стороне А');
        end if;

        -- Проверяем заполнение BIC-кода и счета по стороне Б
        if (l_bicPartyB is null or l_accPartyB is null) then
            if (l_altPartyB is null) then
                raise_application_error(-20780, '\114 Не указан BIC-код или счет по стороне Б');
            end if;
        end if;
        */

    --                                                             --
    -- *** Конец блока проверок заполнения основных реквизитов *** --
    -----------------------------------------------------------------

    l_bicSender := GetOurBankAsSender();

    if (l_swiRef is not null) then

        select rtrim(ltrim(value))
          into l_swiId
          from sw_operw
         where swref = l_swiRef
           and tag = '20'
           and opt is null;

    end if;


    -----------------------------------------------------------------
    -- ***                 Блок создания сообщения             *** --
    --                                                             --

        -- Создаем заголовок сообщения
        In_SwJournalEx(
            ret_      => l_retCode,
            swref_    => l_ref,                                     -- Получ. реф. сообщения
            mt_       => 300,                                       --  Тип сообщения: MT300
            mid_      => null,
            page_     => null,
            io_       => 'I',                                       -- Направление: "Исходящее"
            sender_   => l_bicSender,                               -- BIC-код отправителя
            receiver_ => l_bicReceiver,                             -- BIC-код получателя
            transit_  => null,
            payer_    => null,
            payee_    => null,
            ccy_      => null,
            amount_   => null,
            accd_     => null,
            acck_     => null,
            vdat_     => to_char(l_valueDate, 'MM/DD/YYYY'),        -- Дата валютирования сообщения
            idat_     => to_char(sysdate, 'YYYY-MM-DD HH24:MI'),    -- Дата создания сообщения
            flag_     => p_msgFlag );


        l_fld20 := getSwiftField20(l_ref, l_bicReceiver);

        if (l_baseCurr is not null) then

            if (l_baseCurr = 'A') then
                l_fld36 := substr(AmountToSWIFT(l_currAmountB/l_currAmountA*100, 980, false, false), 1, 12);
            else
                l_fld36 := substr(AmountToSWIFT(l_currAmountA/l_currAmountB*100, 980, false, false), 1, 12);
            end if;

        else

            if (l_currAmountA > l_currAmountB) then
                l_fld36 := substr(AmountToSWIFT(l_currAmountA/l_currAmountB*100, 980, false, false), 1, 12);
            else
                l_fld36 := substr(AmountToSWIFT(l_currAmountB/l_currAmountA*100, 980, false, false), 1, 12);
            end if;

        end if;


        --
        -- 22C: Общий реф. отправителя и получателя
        --
        -- AAAA LA XXXX BBBB LB
        --
        --    AAAA - первые четрые символа из BIC-кода отправителя
        --    LA   - код страны отправителя ( поз. 7-8 BIC-кода)
        --    XXXX - четыре последних цифры из поля 36 (доп. лидирующими нулями)
        --    BBBB - первые четрые символа из BIC-кода получателя
        --    LB   - код страны получателя ( поз. 7-8 BIC-кода)
        --
        --
        if (least(substr(l_bicSender, 1, 4), substr(l_bicReceiver, 1, 4)) = substr(l_bicSender, 1, 4)) then

            l_fld22c := substr(l_bicSender, 1, 4)                           ||
                        substr(l_bicSender, 7, 2)                           ||
                        substr(lpad(replace(l_fld36, ',', ''), 4, '0'), -4) ||
                        substr(l_bicReceiver, 1, 4)                         ||
                        substr(l_bicReceiver, 7, 2);
        else

            l_fld22c := substr(l_bicReceiver, 1, 4)                         ||
                        substr(l_bicReceiver, 7, 2)                         ||
                        substr(lpad(replace(l_fld36, ',', ''), 4, '0'), -4) ||
                        substr(l_bicSender, 1, 4)                           ||
                        substr(l_bicSender, 7, 2);
        end if;


        -- Добавляем инф. строки сообщения

        --
        -- Секция А: Общая информация
        --
        --    15A          начало секции
        --    20           SWIFT-реф. сообщения
        --    21           SWIFT-реф. входящего сообщения
        --    22A          Тип операции: NEWT - новая
        --    22C          Общий реф. отправителя и получателя
        --    82A          BIC-код стороны А (первые шесть символов)
        --    87A          BIC-код стороны Б (первые шесть символов)
        --    77D          Номер и дата ген. соглашения
        --
        In_SwOperw(l_Ref, '15', 'A',  1, 'A', '');
        In_SwOperw(l_Ref, '20', 'A',  2, '',  l_fld20);

        if (l_swiRef is not null and l_swiId is not null) then

            In_SwOperw(l_Ref, '21', 'A',  3, '', l_swiId); l_recno := 4;
            In_SwOperw(l_Ref, '22', 'A',  l_recno, 'A', 'EXOP'); l_recno := l_recno + 1;

        else

            In_SwOperw(l_Ref, '22', 'A',  3, 'A', 'NEWT'); l_recno := 4;

        end if;

        In_SwOperw(l_Ref, '22', 'A',  l_recno, 'C', l_fld22c); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '82', 'A',  l_recno, 'A', substr(l_bicSender,   1, 8)); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '87', 'A',  l_recno, 'A', substr(l_bicReceiver, 1, 8)); l_recno := l_recno + 1;

        if (l_agreementNum is not null or l_agreementDate is not null) then
            In_SwOperw(l_Ref, '77', 'A',  l_recno, 'D', 'GEN AGR ' || PrepStr(l_agreementNum) || ' DD '|| to_char(l_agreementDate, 'dd.mm.yyyy')); l_recno := l_recno + 1;
        end if;

        --
        -- Секция Б: Описание сделки
        --
        --    15B          начало секции
        --    30T          дата заключения сделки  [YYYYMMDD]
        --    30V          дата валютирования      [YYYYMMDD]
        --    36           курс обмена             [1,]
        --
        In_SwOperw(l_Ref, '15', 'B',  l_recno, 'B', null); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '30', 'B',  l_recno, 'T', to_char(l_dealDate, 'YYYYMMDD')); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '30', 'B',  l_recno, 'V', to_char(l_valueDate,  'YYYYMMDD')); l_recno := l_recno + 1;
        In_SwOperw(l_Ref, '36', 'B',  l_recno, '',  l_fld36); l_recno := l_recno + 1;

        -- Подсекция Б1: Покупаемая сумма
        --
        --    32B          валюта и сумма [USD10000,]
        --    57A          реквизиты      [/123456 XXXXXXXXXXX]
        --
        In_SwOperw(l_Ref, '32', 'B', l_recno, 'B', AmountToSWIFT(l_currAmountA, l_currCodeA, true, true)); l_recno := l_recno + 1;


        if (l_accPartyA is null and l_bicPartyA is null) then

            if (l_altPartyB is not null or (l_accPartyB is not null and l_bicPartyB is not null)) then
                In_SwOperw(l_Ref, '57', 'B', l_recno, 'D', 'NET'); l_recno := l_recno + 1;
            else
                In_SwOperw(l_Ref, '57', 'B', l_recno, 'D', 'NONE'); l_recno := l_recno + 1;
            end if;

        else
            if (l_accPartyA is null) then
               In_SwOperw(l_Ref, '57', 'B', l_recno, 'A', l_bicPartyA); l_recno := l_recno + 1;
            else
               In_SwOperw(l_Ref, '57', 'B', l_recno, 'A', '/' || l_accPartyA || chr(13) || chr(10) || l_bicPartyA); l_recno := l_recno + 1;
            end if;
        end if;

        -- Подсекция Б2: Продаваемая сумма
        --
        --    33B          валюта и сумма [USD10000,]
        --    56A          посредник      [/999999 XXXXXXXXXXX]
        --     или 56D     реквизиты      [/999999
        --                                 XXXXXXXXXXXXXXXXXXX
        --                                 XXXXXXXXXXXXXXXXXXX
        --                                 XXXXXXXXXXXXXXXXXXX
        --                                 XXXXXXXXXXXXXXXXXXX]
        --    57A          реквизиты      [/123456 XXXXXXXXXXX]
        --     или 57D     реквизиты      [/123456
        --                                 XXXXXXXXXXXXXXXXXXX
        --                                 XXXXXXXXXXXXXXXXXXX
        --                                 XXXXXXXXXXXXXXXXXXX
        --                                 XXXXXXXXXXXXXXXXXXX]
        --
        In_SwOperw(l_Ref, '33', 'B', l_recno, 'B', AmountToSWIFT(l_currAmountB, l_currCodeB, true, true)); l_recno := l_recno + 1;

        -- Подготавливаем строки 56, 57
        if (l_intermB is not null) then
            l_intermB := PrepStr(l_intermB);
        end if;

        if (l_altPartyB is not null) then
            l_altPartyB := PrepStr(l_altPartyB);
        end if;


        -- Поле 56[А,D] (если заполнено, после подготовки может уже и не быть)
        if (l_intermB is not null) then

            -- Проверяем какую опцию использовать
            if (is_valid_a_option(l_intermB)) then
                In_SwOperw(l_Ref, '56', 'B', l_recno, 'A', l_intermB); l_recno := l_recno + 1;
            else
                In_SwOperw(l_Ref, '56', 'B', l_recno, 'D', FormatFieldOption('56', 'D', l_intermB)); l_recno := l_recno + 1;
            end if;

        end if;

        -- Поле 57[A,D]
        if (l_accPartyB is not null and l_bicPartyB is not null) then
            In_SwOperw(l_Ref, '57', 'B', l_recno, 'A', '/' || l_accPartyB || chr(13) || chr(10) || l_bicPartyB);
        elsif (l_accPartyB is null and l_bicPartyB is not null) then
            In_SwOperw(l_Ref, '57', 'B', l_recno, 'A', l_bicPartyB);
        else
            if (l_altPartyB is not null) then
                In_SwOperw(l_Ref, '57', 'B', l_recno, 'D', FormatFieldOption('57', 'D', l_altPartyB));
            else
                if (l_accPartyA is null and l_bicPartyA is null) then
                    In_SwOperw(l_Ref, '57', 'B', l_recno, 'D', 'NONE');
                else
                    In_SwOperw(l_Ref, '57', 'B', l_recno, 'D', 'NET');
                end if;
            end if;
        end if;
        l_recno := l_recno + 1;


    --                                                             --
    -- ***            Конец блока создания сообщения           *** --
    -----------------------------------------------------------------

    -- Привязываем созданное сообщение к договору
    Link3xxMsg(300, l_Ref, p_dealRef, 'I');


END gen_mt300_message;


--**************************************************************--
function prepare_57str( p_src in varchar2) return varchar2
is
begin
    return rtrim(ltrim(rtrim(ltrim(p_src, chr(13) ||chr(10)),chr(13) ||chr(10))));
end;


--**************************************************************--
-- GEN_MT320_MESSAGE()
--
--     Процедура создания сообщения MT300
--
--     Описание параметров:
--
--        p_dealRef        Референс сделки (FX_DEAL)
--        p_msgFlag        Дополнительная опция
--                           MATU - отмена сделки
--
--
-- DG
--**************************************************************--
PROCEDURE gen_mt320_message(
     p_dealRef   in  number,
     p_msgFlag   in  varchar2,
     p_msgOption in  varchar2 default null )
IS

l_swmsg t_swmsg;
l_ref   number;         -- Реф. создаваемого сообщения
l_rnk   number;

BEGIN

    -- Получаем из договора необходимые реквизиты
    -- !!! Сумма договора и процентов сохраняется в единицах /100
    begin
        select b.bic                receiver_bic,
               d.sdate              trade_date,
               a.bdate              value_date,
               d.wdate              maturity_date,
               decode(v.tipd, 1,
                          'L', 'B') fld17,
               a.s*100              principal_amount,
               a.kv                 principal_currency,
               r.ir                 interest_rate,
               a.int_amount*100     interest_amount,
               n.basey              basey_code,
               b.num_nd             agreement_num,
               b.dat_nd             agreement_date,
               a.swi_ref            inbound_msg,
               a.swi_bic            partya_bic,
               a.swi_acc            partya_acc,
               a.swo_ref            outbound_msg,
               a.swo_bic            partyb_bic,
               a.swo_acc            partyb_acc,
               a.alt_partyb         alt_partyb,
               a.interm_b           partyb_interm,
               a.int_partya         interest_partya,
               a.int_interma        interest_intermediary_a,
               a.int_partyb         interest_partyb,
               a.int_intermb        interest_intermediary_b,
               d.rnk                rnk
          into l_swmsg.bicReceiver,
               l_swmsg.tradeDate,
               l_swmsg.valueDate,
               l_swmsg.maturDate,
               l_swmsg.fld17,
               l_swmsg.prcCurrAmount,
               l_swmsg.prcCurrCode,
               l_swmsg.intRate,
               l_swmsg.intAmount,
               l_swmsg.baseyCode,
               l_swmsg.agreementNum,
               l_swmsg.agreementDate,
               l_swmsg.swiRef,
               l_swmsg.bicPartyA,
               l_swmsg.accPartyA,
               l_swmsg.prevSwRef,
               l_swmsg.bicPartyB,
               l_swmsg.accPartyB,
               l_swmsg.altPartyB,
               l_swmsg.intermB,
               l_swmsg.intPartyA,
               l_swmsg.intIntermA,
               l_swmsg.intPartyB,
               l_swmsg.intIntermB,
               l_rnk
          from cc_deal d, cc_add a, custbank b, cc_vidd v, int_ratn r, int_accn n, customer c
         where d.nd    = p_dealRef
           and d.nd    = a.nd
           and a.adds  = 0
           and d.rnk   = b.rnk
           and a.accs  = r.acc
           --  and a.bdate = r.bdat
           and r.bdat  = (select max(bdat)
                            from int_ratn
                           where acc  = a.accs
                             and bdat <= a.bdate)
           and r.id    = decode(v.tipd, 1, 0, 1)
           and d.vidd  = v.vidd
           and a.accs  = n.acc
           and n.id    = decode(v.tipd, 1, 0, 1)
           and d.rnk   = c.rnk;
    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\110 Договор или параметры договора с реф. ' || to_char(p_dealRef) || ' не найдены (CC_DEAL)');
    end;

    if (l_swmsg.prevSwRef is not null and p_msgOption is null) then
        raise_application_error(-20780, '\027 К договору уже привязано исходящее сообщение MT320 с реф. ' || to_char(l_swmsg.prevSwRef));
    end if;

    --
    -- Сообщение на отмену формируется только если было сформировано предыдущее
    --
    if (p_msgOption = 'MATU' and l_swmsg.prevSwRef is null) then
        return;
    end if;

    begin
        select substr(value,1,20) into l_swmsg.agreementNum from customerw where rnk=l_rnk and tag = 'BGD';
    exception when no_data_found then
       null;
    end;

    begin
        select to_date(value, 'dd/mm/yyyy') into l_swmsg.agreementDate from customerw where rnk=l_rnk and tag = 'DGD';
    exception when no_data_found then
        null;
    end;


    -- формирование сообщения
    igen_mt320_message(l_swmsg, p_msgFlag, p_msgOption, l_ref);

    -- Привязываем созданное сообщение к договору
    -- Link3xxMsg(320, l_Ref, p_dealRef, 'I');
    --
    update cc_add
       set swo_ref = l_Ref
     where nd = p_dealref
       and adds = 0;

END gen_mt320_message;


--**************************************************************--
-- GEN3XXMSG()
--
--     Процедура создания сообщения MT300/320 по договору
--
--     Описание параметров:
--
--        p_mt             Тип сообщения.
--                         Допустимый значения: 300, 320
--
--        p_dealRef        Референс сделки
--
--
-- DG
--**************************************************************--
PROCEDURE Gen3xxMsg(
    p_mt        in  number,
    p_dealRef   in  number )
IS
BEGIN


    if (p_mt = '300')  then gen_mt300_message(p_dealRef, 'L');
    elsif (p_mt = 320) then gen_mt320_message(p_dealRef, 'L');
    else
       raise_application_error(-20780, '\017 Тип сообщения MT' || to_char(p_mt) || ' не поддерживается');
    end if;


END Gen3xxMsg;

--**************************************************************--
-- LINK3XXMSG()
--
--     Процедура привязки сообщения MT300/600/320 к договору
--
--     Описание параметров:
--
--        p_mt             Тип сообщения.
--                         Допустимый значения: 300, 320
--
--        p_swRef          Референс Swift сообщения
--
--        p_dealRef        Референс сделки
--
--        p_io             Направление Swift сообщения
--                         ("O"- входящее, "I"- исходящее)
--                          !! Внимательно с буквами
--
-- DG
--**************************************************************--
PROCEDURE Link3xxMsg(
    p_mt        in  number,
    p_swRef     in  number,
    p_dealRef   in  number,
    p_io        in  char  )
IS


l_inRef            number;
l_outRef           number;
l_dummy            number;

l_dealPartnerBic   varchar2(11);
l_dealCurrencyA    fx_deal.kva%type;
l_dealAmountA      fx_deal.suma%type;
l_dealCurrencyB    fx_deal.kvb%type;
l_dealAmountB      fx_deal.sumb%type;

l_swSender         varchar2(11);
l_swReceiver       varchar2(11);
l_swDealDate       date;
l_swValueDate      date;
l_swCurrencyA      number;
l_swAmountA        number;
l_swCurrencyB      number;
l_swAmountB        number;
l_swAccA           varchar2(35);
l_swBicA           varchar2(11);
l_swAccB           varchar2(35);
l_swBicB           varchar2(11);
l_swFld57          varchar2(250);
l_swFldA56         varchar2(250);
l_swFldB56         varchar2(250);
l_swAgrNum         varchar2(10);
l_swAgrDate        date;


BEGIN


    --
    -- Проверяем существует ли
    -- сообщение с указанным реф.
    --
     begin
         select swref
           into l_dummy
           from sw_journal
          where swref = p_swRef
            and mt    = p_mt;
     exception
         when NO_DATA_FOUND then
             raise_application_error(-20780,'\018 Не найдено сообщение MT' || to_char(p_mt) || ' с референсом ' || to_char(p_swRef));
     end;


    if (p_mt = 300 or p_mt = 600) then

        --
        -- Получаем реф. сообщений,
        -- привязанных к сделке
        --
        begin
            select swi_ref, swo_ref, bicb, kva, suma, kvb, sumb
              into l_inRef, l_outRef, l_dealPartnerBic, l_dealCurrencyA, l_dealAmountA, l_dealCurrencyB, l_dealAmountB
              from fx_deal
             where deal_tag = p_dealref;
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20780,'\020 Не найдена сделка c референсом ' || to_char(p_dealRef) || ' (FX_DEAL)');
        end;

        --
        -- Получаем реквизиты сообщения
        --
        if (p_mt = 300) then
           get_mt300_fields(
               p_swRef     => p_swRef,
               p_sender    => l_swSender,
               p_receiver  => l_swReceiver,
               p_dealDate  => l_swDealDate,
               p_valueDate => l_swValueDate,
               p_currencyA => l_swCurrencyA,
               p_sumA      => l_swAmountA,
               p_currencyB => l_swCurrencyB,
               p_sumB      => l_swAmountB,
               p_swaccA    => l_swAccA,
               p_swbicA    => l_swBicA,
               p_swaccB    => l_swAccB,
               p_swbicB    => l_swBicB,
               p_swFld57   => l_swFld57,
               p_swFldA56  => l_swFldA56,
               p_swFldB56  => l_swFldB56,
               p_swAgrNum  => l_swAgrNum,
               p_swAgrDate => l_swAgrDate );
        else
           get_mt600_fields(
               p_swRef     => p_swRef,
               p_sender    => l_swSender,
               p_receiver  => l_swReceiver,
               p_dealDate  => l_swDealDate,
--               p_valueDate => l_swValueDate,
               p_currencyA => l_swCurrencyA,
               p_sumA      => l_swAmountA,
               p_currencyB => l_swCurrencyB,
               p_sumB      => l_swAmountB );
--               p_swaccA    => l_swAccA,
--               p_swbicA    => l_swBicA,
--               p_swaccB    => l_swAccB,
--               p_swbicB    => l_swBicB,
--               p_swFld57   => l_swFld57,
--               p_swFldA56  => l_swFldA56,
--               p_swFldB56  => l_swFldB56,
--               p_swAgrNum  => l_swAgrNum,
--               p_swAgrDate => l_swAgrDate );
         end if;

        --
        -- Сравниваем основные реквизиты сделки и сообщения
        -- Основными реквизитами считаем:
        --   BIC-код партнера, валюту и сумму по стороне А,
        --   валюту и сумму по стороне Б
        --
        if (   l_dealPartnerBic != l_swReceiver and p_io = 'I'
            or l_dealPartnerBic != l_swSender   and p_io = 'O') then

            raise_application_error(-20780, '\023 Не совпадают основные реквизиты сделки и сообщения (код партнера)');
        end if;


        if p_mt = 300 and
           (   l_dealCurrencyA != l_swCurrencyA
            or l_dealAmountA   != l_swAmountA
            or l_dealCurrencyB != l_swCurrencyB
            or l_dealAmountB   != l_swAmountB   ) then

            raise_application_error(-20780, '\023 Не совпадают основные реквизиты сделки и сообщения (сумма А/Б)');
        end if;


        if p_mt = 600 and
           (   (l_swCurrencyA != 959 and l_dealCurrencyA != l_swCurrencyA)
            or l_dealAmountA  != l_swAmountA
            or (l_swCurrencyB != 959 and l_dealCurrencyB != l_swCurrencyB)
            or l_dealAmountB  != l_swAmountB   ) then

            raise_application_error(-20780, '\023 Не совпадают основные реквизиты сделки и сообщения (сумма А/Б)');
        end if;


        if (p_io = 'O') then

            if (l_inRef is not null) then
                raise_application_error(-20780, '\021 К договору уже привязано входящее сообщение MT' || to_char(p_mt)|| ' с реф. ' || to_char(l_inRef));
            end if;

            update fx_deal
               set swi_ref = p_swref
             where deal_tag = p_dealref;

        elsif (p_io = 'I') then

            if (l_outRef is not null) then
                raise_application_error(-20780, '\022 К договору уже привязано исходящее сообщение MT' || to_char(p_mt)|| ' с реф. ' || to_char(l_outRef));
            end if;

            update fx_deal
               set swo_ref = p_swref
             where deal_tag = p_dealref;

        else
            raise_application_error(-20780, '\019 Неверно указано направление (вх./исх.)');
        end if;

     elsif (p_mt=320) then

        --
        -- Получаем реф. сообщений,
        -- привязанных к сделке
        --
        begin
           select swi_ref, swo_ref
             into l_inRef, l_outRef
             from cc_add
            where nd   = p_dealref
              and adds = 0;
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20780,'\025 Не найдена сделка c референсом ' || to_char(p_dealRef) || ' (CC_ADD)');
        end;

        if (p_io = 'O') then

            if (l_inRef is not null) then
                raise_application_error(-20780, '\026 К договору уже привязано входящее сообщение MT320 с реф. ' || to_char(l_inRef));
            end if;

            update cc_add
               set swi_ref = p_swref
             where nd = p_dealref
               and adds = 0;

        elsif (p_io = 'I') then

            if (l_outRef is not null) then
                raise_application_error(-20780, '\027 К договору уже привязано исходящее сообщение MT320 с реф. ' || to_char(l_outRef));
            end if;

            update cc_add
               set swo_ref = p_swref
             where nd = p_dealref
               and adds = 0;

        else
            raise_application_error(-20780, '\019 Неверно указано направление (вх./исх.)');
        end if;

    else
        raise_application_error(-20780, '\017 Тип сообщения MT' || to_char(p_mt) || ' не поддерживается');
    end if;


END Link3xxMsg;


--**************************************************************--
-- UNLINK3XXMSG()
--
--     Процедура отвязки сообщения MT300/320 от договора
--
--     Описание параметров:
--
--        p_mt             Тип сообщения.
--                         Допустимый значения: 300, 320
--
--        p_swRef          Референс Swift сообщения
--                         (в данной версии не используется)
--
--        p_dealRef        Референс сделки
--
--        p_io             Направление Swift сообщения
--                         ("O"- входящее, "I"- исходящее)
--                          !! Внимательно с буквами
--
-- DG
--**************************************************************--
PROCEDURE Unlink3xxMsg(
    p_mt        in  number,
    p_swRef     in  number,
    p_dealRef   in  number,
    p_io        in  char  )
IS


l_inRef       number;
l_outRef      number;


BEGIN


    if (p_mt = 300) then

        --
        -- Получаем реф. сообщений,
        -- привязанных к сделке
        --
        begin
            select swi_ref, swo_ref
              into l_inRef, l_outRef
              from fx_deal
             where deal_tag = p_dealref;
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20780,'\020 Не найдена сделка c референсом ' || to_char(p_dealRef) || ' (FX_DEAL)');
        end;

        if (p_io = 'O') then

            if (l_inRef is null) then
                raise_application_error(-20780, '\030 К договору с реф. ' || to_char(p_dealRef) || ' не привязано входящее сообщение');
            end if;

            update fx_deal
               set swi_ref = null
             where deal_tag = p_dealref;

        elsif (p_io = 'I') then

            if (l_outRef is null) then
                raise_application_error(-20780, '\031 К договору с реф. ' || to_char(p_dealRef) || ' не привязано исходящее сообщение');
            end if;

            update fx_deal
               set swo_ref = null
             where deal_tag = p_dealref;

        else
            raise_application_error(-20780, '\019 Неверно указано направление (вх./исх.)');
        end if;

     elsif (p_mt=320) then

        --
        -- Получаем реф. сообщений,
        -- привязанных к сделке
        --
        begin
           select swi_ref, swo_ref
             into l_inRef, l_outRef
             from cc_add
            where nd   = p_dealref
              and adds = 0;
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20780,'\025 Не найдена сделка c референсом ' || to_char(p_dealRef) || ' (CC_ADD)');
        end;


        if (p_io = 'O') then

            if (l_inRef is null) then
                raise_application_error(-20780, '\030 К договору с реф. ' || to_char(p_dealRef) || ' не привязано входящее сообщение');
            end if;

            update cc_add
               set swi_ref = null
             where nd = p_dealref
               and adds = 0;

        elsif (p_io = 'I') then

            if (l_outRef is null) then
                raise_application_error(-20780, '\031 К договору с реф. ' || to_char(p_dealRef) || ' не привязано исходящее сообщение');
            end if;

            update cc_add
               set swo_ref = null
             where nd = p_dealref
               and adds = 0;

        else
            raise_application_error(-20780, '\019 Неверно указано направление (вх./исх.)');
        end if;

     else
        raise_application_error(-20780, '\017 Тип сообщения MT' || to_char(p_mt) || ' не поддерживается');
     end if;


END Unlink3xxMsg;


procedure get_field_value(
    p_srcField in  varchar2,
    p_fldBic   out varchar2,
    p_fldAcc   out varchar2)
is

l_accPos   number;
l_acc      varchar2(34);
l_bic      char(11);

begin

    -- Сразу определяем какая опция заполнения
    if (substr(p_srcField, 1, 1) = '/') then

        -- Определим где же разделитель счета и BICa
        l_accPos := instrc(p_srcField, chr(13));

        -- Для виндовых переводов строки тестим смещение
        if (l_accPos is not null and l_accPos !=0 and substr(p_srcField, l_accPos+1, 1) = chr(10)) then
            l_accPos := l_accPos + 1;
        end if;

        -- Если не нашли, то может быть еще юниксовый перевод строки
        if (l_accPos is null or l_accPos = 0) then
            l_accPos := instrc(p_srcField, chr(10));
        end if;

        -- В самом крайнем случае может быть удосужились хоть пробелом разделить
        if (l_accPos is null or l_accPos = 0) then
            l_accPos := instrc(p_srcField, ' ');
        end if;

        if (l_accPos is null or l_accPos = 0) then

            -- Ну вообще ..... просто бъем первые 34 символа в счет, далее в BIC
            l_acc := substr(p_srcField, 2, 34);
            l_bic := substr(p_srcField, 36, 11);

        else

            -- Ограничиваем 34 и 11 символами
            l_acc := substr(rtrim(ltrim((replace(replace(substr(p_srcField, 2, l_accPos-1), chr(13), ''), chr(10), '')))), 1, 34);
            l_bic := substr(replace(replace(replace(substr(p_srcField, l_accPos+1), chr(13), ''), chr(10), ''), ' ', ''), 1, 11);

        end if;

        p_fldAcc := l_acc;
        p_fldBic := l_bic;

    else
        p_fldAcc := null;   -- ничего разбирать не придется
        p_fldBic := null;
    end if;

end get_field_value;




--**************************************************************--
-- GET_MT300_FIELDS()
--
--     Процедура получения основных реквизитов сообщения MT320
--
-- DG
--**************************************************************--

PROCEDURE get_mt300_fields(
    p_swRef      in  number,
    p_sender     out varchar2,
    p_receiver   out varchar2,
    p_dealDate   out date,
    p_valueDate  out date,
    p_currencyA  out number,
    p_sumA       out number,
    p_currencyB  out number,
    p_sumB       out number,
    p_swaccA     out varchar2,
    p_swbicA     out varchar2,
    p_swaccB     out varchar2,
    p_swbicB     out varchar2,
    p_swFld57    out varchar2,
    p_swFldA56   out varchar2,
    p_swFldB56   out varchar2,
    p_swAgrNum   out varchar2,
    p_swAgrDate  out date     )
IS


l_first57  boolean := true;
l_accPos   number;
l_acc      varchar2(100);
l_bic      char(100);
l_io       sw_journal.io_ind%type;
l_tmp      sw_journal.sender%type;





BEGIN


    select sender, receiver, io_ind
      into p_sender, p_receiver, l_io
      from sw_journal
     where swref = p_swRef
       and mt = 300;

    --
    -- Если сообщение входящее, то нужно поменять местами
    -- отправителя и получателя. Т.к. по результатам работы
    -- функции нужно заполнить еще и форму ввода
    --
    if (l_io = 'O') then
        l_tmp      := p_sender;
        p_sender   := p_receiver;
        p_receiver := l_tmp;

    end if;

    for i in (select tag || opt field, value
                from sw_operw
               where swref = p_swRef
              order by n)
    loop

        if (i.field = '30T') then
            p_dealDate := to_date(i.value, 'YYYYMMDD');

        elsif (i.field = '30V') then
        p_valueDate := to_date(i.value, 'YYYYMMDD');

        elsif (i.field = '32B') then

            if (l_io = 'O') then
             SwiftToAmount(i.value, p_currencyB, p_sumB);
            else
             SwiftToAmount(i.value, p_currencyA, p_sumA);
            end if;

        elsif (i.field = '33B') then

            if (l_io = 'O') then
                 SwiftToAmount(i.value, p_currencyA, p_sumA);
            else
                 SwiftToAmount(i.value, p_currencyB, p_sumB);
            end if;

        elsif (i.field in ('57A', '57D', '57J')) then

            if (i.field = '57A') then

                if (l_io = 'O') then

                    if (l_first57) then
                        get_field_value(i.value, p_swBicB, p_swAccB);
                    else
                        get_field_value(i.value, p_swBicA, p_swAccA);
                    end if;

                else

                    if (l_first57) then
                        get_field_value(i.value, p_swBicA, p_swAccA);
                    else
                        get_field_value(i.value, p_swBicB, p_swAccB);
                    end if;

                end if;

            else                          -- Здесь все другие опции

                if (l_first57) then

                    if (l_io = 'O') then
                        p_swFld57 := i.value;
                    else
                        -- нас заполнили по опции не A
                        -- разбираем только если опция D
                        get_field_value(i.value, p_swBicA, p_swAccA);

                    end if;

                else

                    if (l_io = 'O') then
                        -- нас заполнили по опции не A
                        get_field_value(i.value, p_swBicA, p_swAccA);
                    else
                        p_swFld57 := i.value;
                    end if;

                end if;


            end if;

            -- Устанавливаем признак
            l_first57 := false;

        elsif (i.field in ('56A', '56D', '56J')) then

            --
            -- Здесь все просто, не важно какая опция - все в одно поле
            --
            if (l_io = 'O') then

                if (l_first57) then
                    p_swFldB56 := i.value;
                else
                    p_swFldA56 := i.value;
                end if;

            else

                if (l_first57) then
                    p_swFldA56 := i.value;
                else
                    p_swFldB56 := i.value;
                end if;
            end if;   -- l_io

        elsif (i.field = '77D') then

            begin
                p_swAgrDate := to_date(substr(i.value, -6), 'yymmdd');
            exception
                when OTHERS then null;
            end;

            begin
                p_swAgrNum := substr(substr(i.value, -17, 10), instr(substr(i.value, -17, 10), ' '));
            exception
                when OTHERS then null;
            end;

        end if;

    end loop;



END get_mt300_fields;


--**************************************************************--
-- GET_MT600_FIELDS()
--
--     Процедура получения основных реквизитов сообщения MT600
--
--**************************************************************--

PROCEDURE get_mt600_fields(
    p_swRef      in  number,
    p_sender     out varchar2,
    p_receiver   out varchar2,
    p_dealDate   out date,
--    p_valueDate  out date,
    p_currencyA  out number,
    p_sumA       out number,
    p_currencyB  out number,
    p_sumB       out number
--    p_swaccA     out varchar2,
--    p_swbicA     out varchar2,
--    p_swaccB     out varchar2,
--    p_swbicB     out varchar2,
--    p_swFld57    out varchar2,
--    p_swFldA56   out varchar2,
--    p_swFldB56   out varchar2,
--    p_swAgrNum   out varchar2,
--    p_swAgrDate  out date
)
IS


l_first57  boolean := true;
l_accPos   number;
l_acc      varchar2(100);
l_bic      char(100);
l_io       sw_journal.io_ind%type;
l_tmp      sw_journal.sender%type;


BEGIN


    select sender, receiver, io_ind
      into p_sender, p_receiver, l_io
      from sw_journal
     where swref = p_swRef
       and mt = 600;

    --
    -- Если сообщение входящее, то нужно поменять местами
    -- отправителя и получателя. Т.к. по результатам работы
    -- функции нужно заполнить еще и форму ввода
    --
    if (l_io = 'O') then
        l_tmp      := p_sender;
        p_sender   := p_receiver;
        p_receiver := l_tmp;

    end if;

    for i in (select tag || opt field, value, seq
                from sw_operw
               where swref = p_swRef
              order by n)
    loop

        if (i.field = '30') then
            p_dealDate := to_date(i.value, 'YYMMDD');

        elsif (i.field = '32F' and i.seq = 'B') then

            if (l_io = 'O') then
             SwiftToAmount('XAU'||substr(i.value,4), p_currencyB, p_sumB);
            else
             SwiftToAmount('XAU'||substr(i.value,4), p_currencyA, p_sumA);
            end if;

        elsif (i.field = '34P' and i.seq = 'B') then

            if (l_io = 'O') then
             SwiftToAmount(substr(i.value,7), p_currencyA, p_sumA);
            else
             SwiftToAmount(substr(i.value,7), p_currencyB, p_sumB);
            end if;

        elsif (i.field = '32F' and i.seq = 'C') then

            if (l_io = 'O') then
             SwiftToAmount('XAU'||substr(i.value,4), p_currencyA, p_sumA);
            else
             SwiftToAmount('XAU'||substr(i.value,4), p_currencyB, p_sumB);
            end if;

        elsif (i.field = '34R' and i.seq = 'C') then

            if (l_io = 'O') then
             SwiftToAmount(substr(i.value,7), p_currencyB, p_sumB);
            else
             SwiftToAmount(substr(i.value,7), p_currencyA, p_sumA);
            end if;

        end if;

    end loop;


END get_mt600_fields;


--**************************************************************--
-- GET_MT320_FIELDS()
--
--     Процедура получения основных реквизитов сообщения MT320
--
-- DG
--**************************************************************--
PROCEDURE get_mt320_fields(
    p_swRef       in  number,
    p_sender      out varchar2,
    p_receiver    out varchar2,
    p_tradeDate   out date,
    p_valueDate   out date,
    p_maturDate   out date,
    p_dealType    out varchar2,
    p_currency    out number,
    p_amount      out number,
    p_intCurrency out number,
    p_intAmount   out number,
    p_intRate     out number,
    p_intMethod   out varchar2,
    p_swaccA      out varchar2,
    p_swbicA      out varchar2,
    p_swaccB      out varchar2,
    p_swbicB      out varchar2,
    p_swFld57     out varchar2,
    p_swFldA56    out varchar2,
    p_swFldB56    out varchar2 )
IS


l_first57  boolean := true;
l_accPos   number;
l_acc      varchar2(100);
l_bic      char(100);
l_seq      varchar2(1);       -- текущая последовательность


BEGIN


    select sender, receiver
      into p_sender, p_receiver
      from sw_journal
     where swref = p_swRef
       and mt = 320;

    for i in (select tag || opt field, value
                from sw_operw
               where swref = p_swRef
              order by n)
    loop

        if (substr(i.field, 1, 2) = '15') then
            l_seq := substr(i.field, 3, 1);

        elsif (i.field = '17R') then
            p_dealType := substr(rtrim(ltrim(i.value)), 1, 1);

        elsif (i.field = '30T') then
            p_tradeDate := to_date(ltrim(rtrim(i.value)), 'YYYYMMDD');

        elsif (i.field = '30V') then
            p_valueDate := to_date(ltrim(rtrim(i.value)), 'YYYYMMDD');

        elsif (i.field = '30P') then
            p_maturDate := to_date(ltrim(rtrim(i.value)), 'YYYYMMDD');

        elsif (i.field = '32B') then

            SwiftToAmount(i.value, p_currency, p_amount);

        elsif (i.field = '30P') then
            p_maturDate := to_date(ltrim(rtrim(i.value)), 'YYYYMMDD');

        elsif (i.field = '34E') then

             SwiftToAmount(i.value, p_intCurrency, p_intAmount);

        elsif (i.field = '37G') then

            p_intRate := to_number(replace(i.value, ',', '.'));

        elsif (i.field = '14D') then

            p_intMethod := to_char(SwiftToDayFraction(i.value));


        elsif (i.field = '57A') then


            l_accPos := instrc(i.value, chr(13));
        if (l_accPos is null or l_accPos = 0) then
            l_accPos := instrc(i.value, chr(10));
        end if;

        if (l_accPos is null or l_accPos = 0) then
            l_accPos := instrc(i.value, ' ');
        end if;

            -- Проверяем на заполнение поля по option D
            -- В этом случае вместо BIC кода будет свободный текст
        if (length(substr(i.value, l_accPos))-2 <= 11) then

                l_acc := substr(i.value, 2, l_accPos-2);
                l_bic := substr(i.value, l_accPos+1);

                if (l_seq = 'C') then
                    p_swAccA := substr(ltrim(rtrim(l_acc)), 1, 35);
                    p_swBicA := substr(ltrim(rtrim(l_bic)), 1, 11);
                elsif (l_seq = 'D') then
                    p_swAccB := substr(ltrim(rtrim(l_acc)), 1, 35);
                    p_swBicB := substr(ltrim(rtrim(l_bic)), 1, 11);
                end if;

            else

                if (l_seq = 'C') then
                    p_swAccA := substr(ltrim(rtrim(substr(i.value, 2, l_accPos-2))), 1, 35);
                    p_swBicA := substr(ltrim(rtrim(l_bic)), 1, 11);
                elsif (l_seq = 'D') then
                    p_swFld57 := substr(i.value, 1, 200);
                end if;

            end if;

        elsif (i.field = '56A') then

            if (l_seq = 'D') then
                p_swFldB56 := substr(i.value, 1, 200);
            end if;

        end if;

    end loop;


END get_mt320_fields;

--**************************************************************--
-- Convert Day Fraction code from Swift format to local
--
-- DG
--**************************************************************--

FUNCTION SwiftToDayFraction(
    p_swiftCode      IN VARCHAR2 ) RETURN NUMBER
IS

 l_localCode    number;

BEGIN

    if    (p_swiftCode = 'ACT/365') then l_localCode := 1;
    elsif (p_swiftCode = 'AFI/365') then l_localCode := 0;
    elsif (p_swiftCode = 'ACT/360') then l_localCode := 3;
    elsif (p_swiftCode = '360/360') then l_localCode := 2;
    elsif (p_swiftCode = '30E/360') then l_localCode := 2;
    else
        raise_application_error(-20780, '\109 Неизвестный код периода');
    end if;

    return l_localCode;

END SwiftToDayFraction;

--**************************************************************--
-- Convert Day Fraction code from local format to Swift format
--
-- DG
--**************************************************************--

FUNCTION DayFractionToSwift(
    p_localCode      IN NUMBER ) RETURN VARCHAR2
IS

 l_swiftCode    varchar2(10);

BEGIN

    select name_mb
      into l_swiftCode
      from basey
     where basey = p_localCode;

/*
    if    (p_localCode = 1) then l_swiftCode := 'ACT/365';
    elsif (p_localCode = 0) then l_swiftCode := 'AFI/365';
    elsif (p_localCode = 3) then l_swiftCode := 'ACT/360';
    elsif (p_localCode = 2) then l_swiftCode := '360/360';
    else
        raise_application_error(-20780, '\109 Неизвестный код периода');
    end if;
*/

    return l_swiftCode;

exception
    when NO_DATA_FOUND then
        raise_application_error(-20780, '\109 Неизвестный код периода');
END DayFractionToSwift;





    -----------------------------------------------------------------
    -- IEXPMSG_DELETE_MESSAGE()
    --
    --     Функция удаления сообщения и документа, которые находятся
    --     на этапе ожидания экспорта
    --
    --     Параметры:
    --
    --         p_swRef     Референс сообщения
    --
    --         p_retOpt    Опция для возврата
    --                        0 - только сообщение     (MSGRET_MSG_ONLY)
    --                        1 - сообщение и документ (MSGRET_MSG_DOC )
    --
    procedure iexpmsg_delete_message(
                  p_swRef          in sw_journal.swref%type,
                  p_retOpt         in number                 )
    is

    l_sos          sw_journal.sos%type;         /*                        статус сообщения */
    l_flags        sw_journal.flags%type;       /*                флаг состояния сообщения */
    l_dateOut      sw_journal.date_out%type;    /*                 дата отправки сообщения */

    l_docRef       oper.ref%type;               /*               Реф. связанного документа */
    l_backErrCode  number;                      /*   Код ошибки процедуры возврата (неисп) */
    l_backErrMsg   varchar2(2000);              /* Текст ошибки процедуры возврата (неисп) */

    begin

        --
        -- Обработка сообщения
        --
        begin

            select sos, flags, date_out
              into l_sos, l_flags, l_dateOut
              from sw_journal
             where swref = p_swRef;

            if (l_sos = -2) then
                delete from sw_procque where swref = p_swRef;
                raise_application_error(-20780, '\301 Сообщение с реф. ' || to_char(p_swRef) || ' умеет статус "Удалено"');
            end if;

            if (l_dateOut != to_date('01014000', 'ddmmyyyy')) then
                raise_application_error(-20780, '\302 Сообщение с реф. ' || to_char(p_swRef) || ' не является заблокированным');
            end if;

            update sw_journal
               set sos   = -2,
                   flags = null
             where swref = p_swref;

            bars_audit.write_message(bars_audit.fin_msg, bankdate(), 'Снято из очереди на отправку (удалено) SWIFT сообщение с реф. ' || p_swRef);

        exception
            when NO_DATA_FOUND then
                raise_application_error(-20780, '\300 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено');
        end;

        --
        -- Обработка документа
        --
        if (p_retOpt = MSGRET_MSG_DOC) then

            bars_audit.trace('Deleting related with document...');

            -- Удаляем документ
            begin

                select ref into l_docRef
                  from sw_oper
                 where swref = p_swRef;

            exception
                when TOO_MANY_ROWS then
                    raise_application_error(-20780, '\301 К сообщению с реф. ' || to_char(p_swRef) || ' привязано несколько документов');
                when NO_DATA_FOUND then null;
            end;

            bars_audit.trace('Message related document Ref=%s', to_char(l_docRef));

            -- Выполняем удаление
            if (l_docRef is not null) then
                p_back_dok(l_docRef, 5, -1, l_backErrCode, l_backErrMsg);
            end if;

        end if;

    end iexpmsg_delete_message;


    -----------------------------------------------------------------
    -- EXPMSG_DELETE_MESSAGE()
    --
    --     Функция удаления сообщения, ожидающего экспорт
    --
    --     Параметры:
    --
    --         p_swRef     Референс сообщения
    --
    --         p_retOpt    Опция для возврата
    --                        NULL - умолчательное
    --                        0    - только сообщение     (MSGRET_MSG_ONLY)
    --                        1    - сообщение и документ (MSGRET_MSG_DOC )
    --
    procedure expmsg_delete_message(
                  p_swRef          in sw_journal.swref%type,
                  p_retOpt         in number  default null    )
    is

    l_retOpt   number;   /* Опция для удаления */

    begin

        if (p_retOpt is null) then

            if (get_param_value(MODPAR_MSGDELDOC) = MODVAL_MSGDELDOC_TRUE) then
                l_retOpt := MSGRET_MSG_DOC;
            else
                l_retOpt := MSGRET_MSG_ONLY;
            end if;

        else
            l_retOpt := p_retOpt;
        end if;

        iexpmsg_delete_message(p_swRef, l_retOpt);

    end expmsg_delete_message;




--**************************************************************--
-- DELETE_MESSAGE()
--
--     Устанавливает состояние "Удалено" для указанного сообщения
--     Для установки данного состояния сообщение должно быть еще
--     не отправленным и содержать флаг L (locked)
--
-- DG
--**************************************************************--
procedure delete_message(
    p_swRef          in number )
is

l_sos          sw_journal.sos%type;
l_flags        sw_journal.flags%type;
l_dateOut      sw_journal.date_out%type;

l_docRef       oper.ref%type;               /*               Реф. связанного документа */
l_backErrCode  number;                      /*   Код ошибки процедуры возврата (неисп) */
l_backErrMsg   varchar2(2000);              /* Текст ошибки процедуры возврата (неисп) */

begin

    --
    -- Обработка сообщения
    --
    begin

        select sos, flags, date_out
          into l_sos, l_flags, l_dateOut
          from sw_journal
         where swref = p_swRef;

        if (l_sos = -2) then
            delete from sw_procque where swref = p_swRef;
            raise_application_error(-20780, '\301 Сообщение с реф. ' || to_char(p_swRef) || ' умеет статус "Удалено"');
        end if;

        if (l_dateOut != to_date('01014000', 'ddmmyyyy')) then
            raise_application_error(-20780, '\302 Сообщение с реф. ' || to_char(p_swRef) || ' не является заблокированным');
        end if;

        update sw_journal
           set sos   = -2,
               flags = null
         where swref = p_swref;

        -- delete from sw_procque
        --  where swref = p_swref;

        bars_audit.write_message(bars_audit.fin_msg, bankdate(), 'Снято из очереди на отправку (удалено) SWIFT сообщение с реф. ' || p_swRef);






    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\300 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено');
    end;

    --
    -- Обработка документа
    --
    if (get_param_value(MODPAR_MSGDELDOC) = MODVAL_MSGDELDOC_TRUE) then

        bars_audit.trace('Deleting related with document...');

        -- Удаляем документ
        begin

            select ref into l_docRef
              from sw_oper
             where swref = p_swRef;

        exception
            when TOO_MANY_ROWS then
                raise_application_error(-20780, '\301 К сообщению с реф. ' || to_char(p_swRef) || ' привязано несколько документов');
            when NO_DATA_FOUND then null;
        end;

        bars_audit.trace('Message related document Ref=%s', to_char(l_docRef));

        -- Выполняем удаление
        if (l_docRef is not null) then
            p_back_dok(l_docRef, 5, -1, l_backErrCode, l_backErrMsg);
        end if;

    end if;

end delete_message;










    -------------------------------------------------------------------
    -- GET_FIELDVALUE_TRANSFORMED()
    --
    --    Процедура получения опции поля и его значения по исходному
    --    сообщению с использованием справочника трансформаций
    --
    --    Параметры:
    --
    --        p_transMode       Тип трансформации
    --
    --        p_msgTgtMt        Тип целевого сообщения
    --
    --        p_msgTgtNum       Номер поля в модели целевого сообщения
    --
    --        p_msgTgtRpNum     Порядковый номер для повторяющегося
    --                          поля сообщения
    --
    --        p_msgSrcMt        Тип исходного сообщения
    --
    --        p_msgTgtOpt       Опция поля для целевого сообщения
    --                          (полученная по исходному)
    --
    --        p_msgTgtValue     Значение поля для целевого сообщения
    --
    --
    -- TODO: Реализовать настоящий поиск по справочнику трансформаций
    --
    procedure get_fieldvalue_transformed(
                  p_transMode     in  varchar2,
                  p_msgTgtMt      in  sw_model.mt%type,
                  p_msgTgtNum     in  sw_model.num%type,
                  p_msgTgtRpNum   in  number,
                  p_msgSrcMt      in  sw_model.mt%type,
                  p_msgTgtOpt     out sw_opt.opt%type,
                  p_msgTgtValue   out sw_operw.value%type )
    is

    l_modelTag   sw_model.tag%type;
    l_modelOpt   sw_model.opt%type;

    begin

        --
        -- Вместо справочника трансформаций используем прямое
        -- совпадение полей сообщений
        --
        select tag, nvl(opt, '-') into l_modelTag, l_modelOpt
          from sw_model
         where mt  = p_msgTgtMt
           and num = p_msgTgtNum;

        if (l_modelOpt != 'a') then

            begin
                select nvl(opt, '-'), value into p_msgTgtOpt, p_msgTgtValue
                  from tmp_sw_message_source
                 where tag = l_modelTag
                   and nvl(opt, '-') = l_modelOpt;
            exception
                when NO_DATA_FOUND then null;
                when TOO_MANY_ROWS then null;
            end;

        else

            begin
                select nvl(opt, '-'), value into p_msgTgtOpt, p_msgTgtValue
                  from tmp_sw_message_source
                 where tag = l_modelTag
                   and (opt = 'a' or
                        nvl(opt, '-') in (select opt
                                            from sw_model_opt
                                           where mt  = p_msgTgtMt
                                             and num = p_msgTgtNum ));

            exception
                when NO_DATA_FOUND then null;
                when TOO_MANY_ROWS then null;
            end;

        end if;

    end get_fieldvalue_transformed;



    -------------------------------------------------------------------
    -- GEN_FULL_NEWMESSAGE()
    --
    --    Процедура формирует макет сообщения указанного типа на
    --    основе существующего сообщения, используя заданную
    --    трансформацию между типами сообщений
    --
    --    Параметры:
    --
    --        p_mt      Тип нового сообщения, макет которого
    --                  необходимо сформировать
    --
    --        p_swRef   Референс существующего сообщения
    --
    --
    procedure gen_full_newmessage(
                  p_mt        in  sw_mt.mt%type,
                  p_swRef     in  sw_journal.swref%type )
    is

    cursor cursModel(p_mt in number)
    is
    select num, seq, subseq, tag, opt, status, empty, seqstat, rpblk, editval
      from sw_model
     where mt = p_mt
    order by num;


    l_recModel    cursModel%rowtype;    /*          строка модели сообщения */
    l_recno       number;               /*          счетчик номер записи    */

    l_msgSrcMt    sw_mt.mt%type;        /*          тип исходного сообщения */
    l_msgTgtOpt   sw_opt.opt%type;      /*    Опция поля целевого сообщения */
    l_msgTgtValue sw_operw.value%type;  /* Значение поля целевого сообщения */


    l_rpnum       number;               /*  Счетчик для повторяющихся полей */


    begin

        bars_audit.trace('Generating new message type %s from message SwRef=%s...', to_char(p_mt), to_char(p_swRef));

        --
        -- Алгоритм работы:
        --
        --     1. Формируем макет исходного сообщения
        --     2. По модели нового сообщения формируем его
        --        получая значения полей функцией на основе описанной
        --        трансформации
        --

        bars_audit.trace('check capability of transforming between message types...');
        bars_audit.trace('implementation restriction, check skipped.');

        bars_audit.trace('generating model of source message SwRef=%s...', to_char(p_swRef));
        gen_full_message(p_swRef, null);

        bars_audit.trace('transferring model to source container...');
        delete from tmp_sw_message_source where swref=p_swRef and userid=user_id;

        insert into tmp_sw_message_source
        select * from tmp_sw_message;

        delete from tmp_sw_message;
        bars_audit.trace('source message model transferred and stage cleaned.');

        bars_audit.trace('Generating new message model (type %s)...', to_char(p_mt));

        select mt into l_msgSrcMt
          from sw_journal
         where swref = p_swRef;

        bars_audit.trace('Source message type is %s', to_char(l_msgSrcMt));

        open cursModel(p_mt);
        l_recno := 1;

        loop

            fetch cursModel into l_recModel;
            exit when cursModel%notfound;

            bars_audit.trace('trying to get value for tag=%s opt=%s...', l_recModel.tag, l_recModel.opt);

            if (l_recModel.rpblk = 'RI') then

                --
                -- Пытаемся получить повторяющееся поле, до
                -- тех пор, пока будут значения. Но одна строка
                -- макете обязательна
                --
                l_rpnum := 1;

                loop

                    get_fieldvalue_transformed(
                        p_transMode   => 'E',
                        p_msgTgtMt    => p_mt,
                        p_msgTgtNum   => l_recModel.num,
                        p_msgTgtRpNum => l_rpnum,
                        p_msgSrcMt    => l_msgSrcMt,
                        p_msgTgtOpt   => l_msgTgtOpt,
                        p_msgTgtValue => l_msgTgtValue );

                    if (l_rpnum = 1 or l_msgTgtValue is not null) then

                        if (l_msgTgtOpt is null) then
                            l_msgTgtOpt := l_recModel.opt;
                        else
                            if (l_msgTgtOpt = '-') then
                                l_msgTgtOpt := null;
                            end if;
                        end if;


                        insert into tmp_sw_message(num, seq, subseq, tag, opt,
                                                   status, empty, seqstat, value, optmodel, editval)
                        values (l_recno, l_recModel.seq, l_recModel.subseq,
                                l_recModel.tag, l_msgTgtOpt,
                                l_recModel.status,
                                l_recModel.empty, l_recModel.seqstat, l_msgTgtValue,
                                l_recModel.opt, l_recModel.editval);
                        l_recno := l_recno + 1;

                    end if;

                    if (l_msgTgtValue is null) then exit;
                    end if;

                    l_rpnum := l_rpnum + 1;

                end loop;

            else

                --
                -- Просто пытаемся получить значение через функцию трансформации
                --
                get_fieldvalue_transformed(
                    p_transMode   => 'E',
                    p_msgTgtMt    => p_mt,
                    p_msgTgtNum   => l_recModel.num,
                    p_msgTgtRpNum => null,
                    p_msgSrcMt    => l_msgSrcMt,
                    p_msgTgtOpt   => l_msgTgtOpt,
                    p_msgTgtValue => l_msgTgtValue );

                if (l_msgTgtOpt is null) then
                    l_msgTgtOpt := l_recModel.opt;
                else
                    if (l_msgTgtOpt = '-') then
                        l_msgTgtOpt := null;
                    end if;
                end if;

                --
                -- Вставляем в макет
                --
                insert into tmp_sw_message(num, seq, subseq, tag, opt,
                                           status, empty, seqstat, value, optmodel, editval)
                values (l_recno, l_recModel.seq, l_recModel.subseq,
                        l_recModel.tag, l_msgTgtOpt,
                        l_recModel.status,
                        l_recModel.empty, l_recModel.seqstat, l_msgTgtValue,
                        l_recModel.opt, l_recModel.editval);
                l_recno := l_recno + 1;

            end if;

        end loop;

        close cursModel;

        bars_audit.trace('New message type %s generated from message SwRef=%s.', to_char(p_mt), to_char(p_swRef));

    end gen_full_newmessage;


--**************************************************************--
-- GEN_FULL_MESSAGE()
--
--     Процедура формирует макет сообщения, которое содержит все
--     возможные для данного типа сообщения поля, на базе
--     указанного существующего сообщения
--
--     Внимание! Данная версия не поддерживает повторяющиеся поля
--     и повторяющиеся блоки
--
-- DG
--**************************************************************--
procedure gen_full_message(
    p_swRef          in sw_journal.swref%type,
    p_mt             in sw_mt.mt%type           )
is

ora_lock  exception;
pragma exception_init(ora_lock, -54);

cursor cursModel(p_mt in number)
is
select num, seq, subseq, tag, opt, status, empty, seqstat, rpblk, editval
  from sw_model
 where mt = p_mt
order by num;


cursor cursMsg(p_ref in number)
is
select tag, opt, value
  from sw_operw
 where swref = p_ref
order by n;


l_mt    sw_journal.mt%type;

l_recModel  cursModel%rowtype;
l_recMsg    cursMsg%rowtype;

l_msgEnd    boolean := false;
l_recno     number  := 1;

begin

    begin
        select mt into l_mt from sw_journal where swref = p_swRef for update nowait;
    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\300 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено');
        when ORA_LOCK then
            raise_application_error(-20780, 'Сообщение реф. ' || to_char(p_swRef) || ' редактируется другим пользователем');
    end;

    --
    -- Если тип сообщения не задан, то получаем его
    -- Может быть ситуация когда меняют тип сообщения при
    -- редактировании, тогда второй параметр - это тот
    -- тип сообщения, на который меняют
    --
    if (p_mt is not null and l_mt != p_mt) then
        gen_full_newmessage(p_mt, p_swRef);
        return;
    end if;

    delete from tmp_sw_message where swref=p_swRef and userid=user_id;

    open cursModel(l_mt);
    open cursMsg(p_swRef);
    fetch cursMsg into l_recMsg;

    loop

        fetch cursModel into l_recModel;
        exit when cursModel%notfound;

        if (not l_msgEnd) then

            if (    l_recModel.tag = l_recMsg.tag
                and (nvl(l_recModel.opt, ' ') = nvl(l_recMsg.opt, ' ')
                     or lower(l_recModel.opt) = l_recModel.opt)) then               -- нижний регистр не проверяем совпадение

                --
                -- Если это повторяющийся элемент, то проходим циклом
                --
                if (l_recModel.rpblk = 'RI') then

                    loop

                        insert into tmp_sw_message(num, seq, subseq, tag, opt,
                                                   status, empty, seqstat, value, optmodel, editval, swref, userid)
                        values (l_recno, l_recModel.seq, l_recModel.subseq,
                                l_recModel.tag, l_recMsg.opt, l_recModel.status,
                                l_recModel.empty, l_recModel.seqstat, l_recMsg.value, l_recModel.opt, l_recModel.editval, p_swRef, user_id);
                        l_recno := l_recno + 1;

                        fetch cursMsg into l_recMsg;

                        if cursMsg%notfound then
                            l_msgEnd := true;
                            exit;
                        end if;

                        -- проверяем на повторяющийся тэг
                        if (l_recModel.tag = l_recMsg.tag and (nvl(l_recModel.opt, ' ') = nvl(l_recMsg.opt, ' ')
                                                                or lower(l_recModel.opt) = l_recModel.opt)) then
                            null;
                        else
                            exit;
                        end if;

                    end loop;

                else

                    insert into tmp_sw_message(num, seq, subseq, tag, opt,
                                               status, empty, seqstat, value, optmodel, editval, swref, userid)
                    values (l_recno, l_recModel.seq, l_recModel.subseq,
                            l_recModel.tag, l_recMsg.opt, l_recModel.status,
                            l_recModel.empty, l_recModel.seqstat, l_recMsg.value, l_recModel.opt, l_recModel.editval, p_swRef, user_id);
                    l_recno := l_recno + 1;

                    fetch cursMsg into l_recMsg;

                    if cursMsg%notfound then
                        l_msgEnd := true;
                    end if;
               end if;

            else

                insert into tmp_sw_message(num, seq, subseq, tag, opt,
                                           status, empty, seqstat, optmodel, editval, swref, userid)
                values (l_recno, l_recModel.seq, l_recModel.subseq,
                        l_recModel.tag, l_recModel.opt, l_recModel.status,
                        l_recModel.empty, l_recModel.seqstat, l_recModel.opt, l_recModel.editval, p_swRef, user_id);
                l_recno := l_recno + 1;


            end if;

        else

                insert into tmp_sw_message(num, seq, subseq, tag, opt,
                                           status, empty, seqstat, swref, userid)
                values (l_recno, l_recModel.seq, l_recModel.subseq,
                        l_recModel.tag, l_recModel.opt, l_recModel.status,
                        l_recModel.empty, l_recModel.seqstat, p_swRef, user_id);
                l_recno := l_recno + 1;

        end if;

    end loop;

    close cursModel;
    close cursMsg;

end gen_full_message;



--**************************************************************--
-- UPDATE_MESSAGE()
--
--     Процедура сохраняет сообщение из временной таблицы, куда
--     его помещает программа ввода/редактирования. В процессе
--     переноса незаполненные поля исключаются
--
--     Внимание! Данная версия не поддерживает повторяющиеся поля
--     и повторяющиеся блоки
--
-- DG
--**************************************************************--
procedure update_message(
    p_swRef          in  sw_journal.swref%type,
    p_mt             in  sw_mt.mt%type         )
is

CRLF   constant char(2) := chr(13) || chr(10);

cursor cursMsg
is
select num, seq, subseq, tag, opt,
       status, empty, seqstat, rtrim(ltrim(value, CRLF), CRLF) value
  from tmp_sw_message where swref=p_swRef and userid=user_id()
order by num;


l_mt        sw_journal.mt%type;
l_oldMt     sw_journal.mt%type;
l_flags     sw_journal.flags%type;
l_dateOut   sw_journal.date_out%type;
l_trn       sw_journal.trn%type;
l_trn2      sw_journal.trn%type  := null;

l_vdate     sw_journal.vdate%type;
l_vdate2    sw_journal.vdate%type  := null;

l_ins       boolean;
l_recno     number;

l_recMsg    cursMsg%rowtype;
l_recMsgDef cursMsg%rowtype;

l_docRef    oper.ref%type;                 /*     Реф. исходного документа (NOS) */
l_docVDate  oper.vdat%type;                /* Дата валютирования документа (NOS) */

begin

    begin
        select mt, flags, date_out, trn, vdate
          into l_oldMt, l_flags, l_dateOut, l_trn, l_vdate
          from sw_journal
         where swref = p_swRef;

        -- Отслеживаем изменение типа сообщения
        if (p_mt is not null and p_mt != l_oldMt) then
            l_mt := p_mt;
        else
            l_mt := l_oldMt;
        end if;

        --
        -- Проверяем заблокировано ли сообщение,
        -- и на всякий случай не отправляли ли мы уже его
        --
        if (l_flags != 'L' or l_dateOut != to_date('01014000', 'ddmmyyyy')) then
            raise_application_error(-20780, '\302 Сообщение с реф. ' || to_char(p_swRef) || ' не является заблокированным');
        end if;

        --
        -- Проверяем не наложена ли виза на данное сообщение
        --
        if (msgchk_geteditstatus(p_swRef) != 1) then
            raise_application_error(-20781, '\422 На сообщение наложена виза, редактирование запрещено SwRef=' || to_char(p_swRef));
        end if;


    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\300 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено');
    end;

    --
    -- Здесь было бы неплохо проверить корректность ввода
    -- сообщения
    --
    -- DG (06/05/2006): Добавил проверку внизу
    --
    -- validate_message(l_mt, p_swRef);
    --

    --
    -- Удаляем существующие инф. строки сообщения
    --
    delete from sw_operw where swref = p_swRef;

    l_ins           := false;
    l_recMsgDef.num := null;
    l_recno         := 1;

    open cursMsg;

    loop
        fetch cursMsg into l_recMsg;
        exit when cursMsg%notfound;

        --
        -- Здесь нужно понять нужно ли вставлять данную строку
        -- в сообщение. Несколько правил:
        --  1. Если значение не пустое, то однозначно нужно вставлять
        --  2. Если поле пустое, тэг обязательный и блок обязательный -
        --     вставляем. Это заведемо проблема, но ее должна решать
        --     процедура проверки
        --  3. Если поле пустое, но и должно быть пустым, оно
        --     является обязательным, а блок опциональным, то
        --     вставку такого поля нужно отложить до вставки
        --     любого поля блока

        if (l_recMsg.value is not null) then l_ins := true;
        elsif (    l_recMsg.status = 'M'
               and l_recMsg.seqstat = 'M') then l_ins := true;
        elsif (    l_recMsg.empty   = 'Y'
               and l_recMsg.status  = 'M'
               and l_recMsg.seqstat = 'O') then

             l_recMsgDef := l_recMsg;
             l_ins       := false;
        else
             l_ins       := false;
        end if;

        if (l_ins) then

            --
            -- Если это поле 20, то необходимо проверить не был ли изменен
            -- референс сообщения
            --
            if (l_recMsg.tag = '20' and l_recMsg.opt is null)  then

                if (l_recMsg.value != l_trn) then
                    l_trn2 := l_recMsg.value;
                end if;

            end if;

            --
            -- Если это поле 32A, то необходимо проверить не была ли изменена
            -- дата валютирования
            --
            if (l_recMsg.tag = '32' and l_recMsg.opt = 'A')  then

                if (substr(l_recMsg.value, 1, 6) != to_char(l_vdate, 'yymmdd')) then
                    l_vdate2 := to_date(substr(l_recMsg.value, 1, 6), 'yymmdd');
                end if;

            end if;


            --
            -- Если нужно вставлять, то проверяем отложенную
            -- запись. Если она существует и блок совпадает,
            -- то вставляем сначало ее, потом текущую запись
            --
            if (l_recMsgDef.num is not null) then
                if (l_recMsg.seq = l_recMsgDef.seq) then

                    In_SwOperw(p_swRef, l_recMsgDef.tag, l_recMsgDef.seq, l_recno, l_recMsgDef.opt, l_recMsgDef.value);
                    l_recno := l_recno + 1;

                end if;
            end if;

            --
            -- Перед самой вставкой проверяем опцию. Если данный тэг
            -- может быть использован с несколькими опциями, то в модели
            -- опция представлена прописной буквой, выбранная опция всегда
            -- представлена заглавной буквой.
            --
            if (l_recMsg.opt = lower(l_recMsg.opt) and l_recMsg.opt is not null and l_recMsg.opt != ' ') then
                raise_application_error(-20780, '\302 Не выбрана опция Seq=' || l_recMsg.seq || ' Tag=' || l_recMsg.tag);
            end if;

            -- Вставляем запись
            In_SwOperw(p_swRef, l_recMsg.tag, l_recMsg.seq, l_recno, ltrim(l_recMsg.opt), l_recMsg.value);
            l_recno := l_recno + 1;

        end if;

    end loop;

    close cursMsg;

    --
    -- Если изменялось поле 20, то обновляем заголовок
    --
    if (l_trn2 is not null) then
        update sw_journal
           set trn = l_trn2
         where swref = p_swRef;
    end if;

    if (l_mt != l_oldMt) then
        update sw_journal
           set mt = l_mt
         where swref = p_swRef;
    end if;

    bars_audit.trace('Updated message successfully stored, validating...');
    genmsg_message_validate(p_swRef);
    bars_audit.trace('Updated message successfully validated.');

    --
    -- Отслеживаем изменение даты валютирования
    --
    if (l_vdate2 is not null) then

        begin
            select o.ref, o.vdat into l_docRef, l_docVDate
              from sw_oper l, oper o
             where l.swref = p_swRef
               and l.ref   = o.ref;

             if (l_docVDate = l_vdate2) then
                 bars_audit.trace('Document value date = new message value date.');
             else
                 update oper
                    set vdat = l_vdate2
                  where ref = l_docRef;

                 bars_audit.financial('Изменена плановая дата валютирования документа NOS (Реф. '|| to_char(l_docRef) || ' ) по дате валютирования сообщения.');
             end if;

        exception
            when NO_DATA_FOUND then
                bars_audit.trace('Source document not found, skip value date updating');
            when TOO_MANY_ROWS then
                bars_audit.trace('Many source documents found, skip value date updating');
        end;

    end if;

    bars_audit.write_message(bars_audit.fin_msg, bankdate(), 'Выполнено ручная коррекция SWIFT сообщения с реф. ' || p_swRef);

end update_message;
--**************************************************************--
-- PREPSTR2()
--
--     Функция перекодирует русские символы в строке в латинские
--     возвращаемое значение не содержит перевода строки
--
-- DG
--**************************************************************--
function PrepStr2(
           p_srcStr in varchar2 ) return varchar2
is
begin
    return replace(PrepStr(p_srcStr), chr(13) || chr(10), ' ');
end PrepStr2;





function get_swtag(
              p_swref   in sw_operw.swref%type,
              p_seq     in sw_operw.seq%type,
              p_tag     in sw_operw.tag%type,
              p_opt     in sw_operw.opt%type   ) return sw_operw.value%type
is

l_result   sw_operw.value%type;

begin

    if (p_opt is null) then

        select value into l_result
          from sw_operw
         where swref = p_swref
           and seq   = p_seq
           and tag   = p_tag
           and opt is null;
    else

        select value into l_result
          from sw_operw
         where swref = p_swref
           and seq   = p_seq
           and tag   = p_tag
           and opt   = p_opt;

    end if;

    return l_result;

exception
    when NO_DATA_FOUND then return null;
end get_swtag;

function get_swtaglist(
              p_swref   in sw_operw.swref%type,
              p_seq     in sw_operw.seq%type,
              p_tag     in sw_operw.tag%type,
              p_opt     in sw_operw.opt%type   ) return t_strlist
is

l_list     t_strlist := t_strlist();

l_value    sw_operw.value%type;
l_num      sw_operw.n%type;
l_cnt      number                := 1;

begin

    begin

        select n, value
          into l_num, l_value
          from (select *
                  from sw_operw
                 where swref         = p_swref
                   and seq           = p_seq
                   and tag           = p_tag
                   and nvl(opt, '-') = nvl(p_opt, '-')
                order by n)
         where rownum < 2;


        l_list.extend;
        l_list(l_cnt) := l_value;
        l_cnt := l_cnt + 1;

    exception
        when NO_DATA_FOUND then return l_list;
    end;

    -- продолжаем получать значения
    loop

        begin

            select n, value
              into l_num, l_value
              from sw_operw
             where swref         = p_swref
               and seq           = p_seq
               and tag           = p_tag
               and nvl(opt, '-') = nvl(p_opt, '-')
               and n             = l_num + 1;

            l_list.extend;
            l_list(l_cnt) := l_value;
            l_cnt := l_cnt + 1;

        exception
            when NO_DATA_FOUND then return l_list;
        end;

    end loop;

    return l_list;

end get_swtaglist;



procedure get_swtag(
              p_swRef   in  sw_operw.swref%type,
              p_seq     in  sw_operw.seq%type,
              p_tag     in  sw_operw.tag%type,
              p_opt     out sw_operw.opt%type,
              p_value   out sw_operw.value%type )
is
begin

    select opt, value into p_opt, p_value
      from sw_operw
     where swref = p_swref
       and seq   = p_seq
       and tag   = p_tag
       and rownum=1;

exception
    when NO_DATA_FOUND then null;
end get_swtag;

    -----------------------------------------------------------------
    -- GET_VALUE_LIST()
    --
    --     Функция получения списка значений из строки. Значения в
    --     переданной строке должны быть разделены символами CRLF
    --
    --     Параметры:
    --
    --         p_value  Строка содержащаю список значений,
    --                  разделенных символами CRLF
    --
    --
    function get_value_list(
                 p_value   in   sw_operw.value%type ) return t_strlist
    is

    l_list   t_strlist := t_strlist();   /*      список значений */
    l_value  sw_operw.value%type;        /*   строка для разбора */
    l_tmp    sw_operw.value%type;        /*   буфер для значения */
    l_pos    number;                     /*  позиция разделителя */
    l_cnt    number  := 1;               /*      кол-во значений */

    begin

        bars_audit.trace('generating list of values...');

        if (p_value is not null) then

            l_value := p_value;

            while (l_value is not null)
            loop

                l_pos := instr(l_value, CRLF);

                if (l_pos != 0) then
                    l_tmp   := rtrim(ltrim(substr(l_value, 1, l_pos-1)));
                    l_value := substr(l_value, l_pos+2);
                else
                    l_tmp   := l_value;
                    l_value := null;
                end if;

                if (l_tmp is not null) then
                    l_list.extend;
                    l_list(l_cnt) := l_tmp;
                    l_cnt := l_cnt + 1;
                end if;

            end loop;

        end if;

        bars_audit.trace('value list created, items count=>%s', to_char(l_list.count));
        return l_list;

    end get_value_list;



procedure validate_bic(
    p_tag      in sw_tag.tag%type,
    p_bic      in sw_banks.bic%type )
is

l_cnt number;

begin

    if (length(p_bic) not in (8, 11) or p_bic is null) then
        raise_application_error(-20782, '\905 Некорректная длина BIC-кода поле ' || p_tag);
    end if;

    if (length(p_bic) = 11) then

        select count(*) into l_cnt
          from sw_banks
         where bic = p_bic;

    else

        select count(*) into l_cnt
          from sw_banks
         where bic like p_bic || '%';

    end if;

    if (l_cnt = 0) then
        raise_application_error(-20782, '\906 BIC-код не найден в справочнике участников поле ' || p_tag);
    end if;

end validate_bic;

procedure validate_acc(
    p_tag      in sw_tag.tag%type,
    p_opt      in sw_opt.opt%type,
    p_value    in sw_operw.value%type )
is

ERR     constant number := -20782;

l_symb  varchar2(1);

begin

    -- bars_trace();

    -- Первый символ - "/"
    if (substr(p_value, 1, 1) != '/') then
        raise_application_error(ERR, '\907 Первый символ счета должен быть символом "/"');
    end if;

    -- минимальная длина 1 символ
    if (length(p_value) < 2) then
        raise_application_error(ERR, '\908 Минимальная длина счета 1 символ в поле ' || p_tag || p_opt);
    end if;

    -- максимальная длина счета 34 символа
    if (length(p_value) > 35) then
        raise_application_error(ERR, '\908 Максимальная длина счета 34 символа в поле ' || p_tag || p_opt);
    end if;

    -- В счете могут быть только цифры и большие буквы (латинские)
    for i in 2..length(p_value)
    loop

        l_symb := substr(p_value, i, 1);

        if ((l_symb >= '0' and l_symb <= '9') or
            (l_symb >= 'A' and l_symb <= 'Z') or
            (l_symb >= 'a' and l_symb <= 'z') or
            (l_symb in ('/', '-', '?', ':', '(', ')', '.', ',','''', '+', '{', '}', ' '))) then null;
        else
            raise_application_error(ERR, '\909 недопустимый символ в номере счета в поле ' || p_tag || p_opt);
        end if;

    end loop;

end validate_acc;

------------------------
-- VALIDATE_SWCHRSET()
--
--     Проверка на вхождение всех полей в установленных
--     набор символов SWIFT (X Charset, Y Charset, Z Charset)
--
-- TODO: нормальное отображение ошибки вместе с полем
--

procedure validate_swchrset(
              p_tag      in  sw_tag.tag%type,
              p_opt      in  sw_opt.opt%type,
              p_value    in  varchar2,
              p_swchrset in  varchar2        )
is
begin

    LoadTransTable('TRANS');

    if (p_swchrset = 'X') then

        if (p_value != strverify(p_value, 'TRANS')) then
            raise_application_error(-20782, 'TXX: Недопустимый символ в поле ' || p_tag || p_opt);
        end if;

    end if;

end validate_swchrset;


-----------------------------------------------------------
-- VALIDATE_FIELD_ROWS()
--
--    Проверка на наличие недопустимых символов в строках поля
--
--
procedure validate_field_rows(
    p_tag      in  sw_tag.tag%type,
    p_value    in  varchar2 )
is

l_crln   char(2) := chr(13) || chr(10);

l_pos    number;
l_value  sw_operw.value%type;
l_row    sw_operw.value%type;

begin

    if (nvl(length(p_value), 0) < 1) then
        raise_application_error(-20782, '\910 Длина поля не может быть меньше 1 символа (поле ' || p_tag || ')');
    end if;

    if (p_tag = '86') then
        -- не допускается пустая строка в конце поля
        if (substr(p_value,-2) = l_crln) or (substr(p_value,-1) = chr(10)) then
            raise_application_error(-20782, '\906 Не допускается пустая строка (поле '|| p_tag || ')');
        end if;
    end if;

    l_value := p_value;
    l_pos   := 1;

    while (l_pos != 0 and l_value is not null)
    loop

        -- выделяем отдельную строку
        l_pos   := instr(l_value, l_crln);

        if (l_pos != 0) then
            l_row   := substr(l_value, 1, l_pos-1);
            l_value := substr(l_value, l_pos+2);
        else
            l_row   := l_value;
            l_value := null;
        end if;

        -- проверка каждой строки
        if (p_tag = '86') then
            -- не допускается первый символ точка ('.') - перенос суммы или даты на другую строку
            if (substr(l_row,1,1) = '.') then
                raise_application_error(-20782, '\907 Недопустимый первый символ строки - ''.'' (поле '|| p_tag || ')');
            end if;
        end if;

    end loop;

end validate_field_rows;

-----------------------------------------------------------
-- VALIDATE_FIELD_CHAR()
--
--    Проверка на наличие недопустимых символов в поле
--    Выполняется по всей таблице перекодировки
--
--
procedure validate_field_char(
              p_tag      in  sw_tag.tag%type,
              p_opt      in  sw_opt.opt%type,
              p_value    in  varchar2         )
is
--
type t_swchars is table of varchar2(1);
--
l_swchars    t_swchars;
l_char       varchar2(1);
l_isallowed  boolean;
--
begin

    -- Загружаем список допустимых символов (по всем таблицам)
    select distinct rtrim(ltrim(sw_char))
    bulk collect into l_swchars
      from sw_volap
     where length(rtrim(ltrim(sw_char))) = 1
       and sw_char is not null;


    -- Проверяем допустимость каждого символа строки
    for i in 1..nvl(length(p_value), 0)
    loop

        -- получаем символ
        l_char := substr(p_value, i, 1);

        -- устанавливаем флаг
        l_isallowed := false;

        if (l_char not in (' ', chr(13), chr(10) )) then

            -- Ищем в таблице перекодировки данный символ
            for i in 1..l_swchars.count
            loop
              if (l_char = l_swchars(i)) then l_isallowed := true;
              end if;
            end loop;

        else l_isallowed := true;
        end if;

        if (not l_isallowed) then
            raise_application_error(-20782, '\902 Недопустимый символ в поле ' || p_tag || p_opt);
        end if;

    end loop;

end validate_field_char;






procedure validate_field(
    p_tag      in  sw_tag.tag%type,
    p_opt      in  sw_opt.opt%type,
    p_value    in  varchar2,
    p_mode     in  number,
    p_chkchar  in  number  default 1 )
is

l_crln   char(2) := chr(13) || chr(10);

l_pos      number;
l_lpos     number;
l_value    sw_operw.value%type;
l_line     sw_operw.value%type;

l_tmp_date date;                    -- Временный буфер для даты
l_cnt      number;                  -- Счетчик общий
l_list     t_strlist := t_strlist();

begin

--    if (p_value is null) then return;
--    end if;

    if (p_opt = 'D' and p_tag = '14') then

        if (p_value not in ('ACT/365', 'AFI/365', 'ACT/360', '360/360', '30E/360')) then
            raise_application_error(-20782, 'T36: неверно указан код в поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt in ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H') and p_tag = '15') then

        if (p_value is not null) then
            raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
        end if;

    elsif (p_opt is null and p_tag in ('20', '21')) then

        if (substr(p_value, 1, 1) = '/' or substr(p_value, -1, 1) = '/' or instr(p_value, '//') != 0) then
            raise_application_error(-20782, 'T26: неверно заполнено поле ' || p_tag);
        end if;

        validate_swchrset(p_tag, p_opt, p_value, 'X');

    elsif (p_opt = 'C' and p_tag = '13') then

        if (substr(p_value, 1, 9) not in ('/CLSTIME/', '/RNCTIME/', '/SNDTIME/')) then
            raise_application_error(-20782, 'TXX: неверно указан код в поле ' || p_tag || p_opt);
        end if;

        if (substr(p_value, 14, 1) not in ('+' ,'-')) then
            raise_application_error(-20782, 'T15: допускается только +/- в поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt = 'A' and p_tag = '16') then

        if (length(p_value) > 5) then
            raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
        end if;

        begin
            l_cnt := to_number(p_value);
        exception
            when INVALID_NUMBER then
                raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
        end;

    elsif (p_opt in ('A', 'T', 'U') and p_tag = '17') then

        if (p_value not in ('Y', 'N')) then
            raise_application_error(-20782, 'T36: недопустимый код в поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt = 'R' and p_tag = '17') then

        if (p_value not in ('B', 'L')) then
            raise_application_error(-20782, 'T67: недопустимый код в поле ' || p_tag || p_opt);
        end if;

    elsif ((p_opt = 'H' and p_tag = '26') or
           (p_opt in ('G', 'N') and p_tag = '21') ) then

        validate_text_field(p_tag, p_value, 1, 16);


    elsif (p_opt = 'A' and p_tag = '22') then

        if (p_value not in ('AMND', 'CANC', 'DUPL', 'EXOP', 'NEWT')) then
            raise_application_error(-20782, 'T36: недопустимый код в поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt = 'B' and p_tag = '22') then

        if (p_value not in ('CONF', 'MATU', 'ROLL')) then
            raise_application_error(-20782, 'T36: неверный код в  поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt = 'C' and p_tag = '22') then

        if (length(p_value) != 16) then
            raise_application_error(-20782, '\902 неверный формат поля ' || p_tag || p_opt);
        end if;


    elsif (p_opt = 'B' and p_tag = '23') then

        if (p_value not in ('CRED', 'CRTS', 'SPAY', 'SPRI', 'SSTD')) then
            raise_application_error(-20782, 'T36: недопустимый код в поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt = 'E' and p_tag = '23') then

        if (p_mode = 1) then
            l_list := get_value_list(p_value);
        else
            l_list.extend;
            l_list(1) := p_value;
        end if;

        for i in 1..l_list.count
        loop

            if (substr(l_list(i), 1, 4) not in ('SDVA', 'INTC', 'CORT', 'HOLD', 'CHQB', 'PHOB',
                                                'TELB', 'PHON', 'TELE', 'PHOI', 'TELI', 'REPA' )) then
                raise_application_error(-20782, 'T47: недопустимый код в поле ' || p_tag || p_opt);
            end if;

            if (substr(l_list(i), 1, 4) not in ('PHON', 'PHOB', 'PHOI', 'TELE', 'TELB', 'TELI', 'HOLD', 'REPA')
                and length(l_list(i)) != 4) then
                raise_application_error(-20782, 'D97: дополнительная информация не разрешена для кода ' || substr(l_list(i), 1, 4) || ' в поле ' || p_tag || p_opt);
            end if;

        end loop;

        l_list.delete;

    elsif (p_opt = 'D' and p_tag = '24') then

        -- 1. Код
        if (substr(p_value, 1, 4) not in ('BROK', 'ELEC', 'FAXT', 'PHON', 'TELX')) then
            raise_application_error(-20782, 'T36: недопустимый код в поле ' || p_tag || p_opt);
        end if;

        -- Номер
        if (length(p_value) > 4) then

            -- 2.1  Разделитель
            if (substr(p_value, 5, 1) != '/') then
                raise_application_error(-20782, '\902 неверный формат поля ' || p_tag || p_opt);
            end if;

            -- 2.2 Максимальная длина
            validate_text_field(p_tag, substr(p_value, 6), 1, 35);

        end if;

    elsif (p_opt is null and p_tag = '25') then

        validate_text_field(p_tag, p_value, 1, 35);

    elsif (p_opt = 'C' and p_tag = '26') then

        if ((substr(p_value, instr(p_value,'/',-1)+1, 5) not in ('ALLOC', 'UNALL')) or
            (substr(p_value, instr(p_value,'/',-1)+6, 4) not in ('GOLD', 'SILV', 'PLAT', 'PALL', 'RHOD', 'RUTH', 'OSMI', 'IRID'))) then
            raise_application_error(-20782, 'TXX: неверно заполнено поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt = 'T' and p_tag = '26') then

        if (p_value not in ('S01', 'S02', 'S03', 'S04', 'S05', 'S06', 'S07', 'S08') or p_value is null) then
            raise_application_error(-20782, 'TXX: неверно заполнено поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt = 'C' and p_tag = '28') then

        if (instr(p_value, '/') = 0) then

            -- одно число
            begin
                l_cnt := to_number(p_value);
            exception
                when INVALID_NUMBER then
                    raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
            end;
        else

            -- два числа разделенные символом "/"
            begin
                l_cnt := to_number(substr(p_value, 1, instr(p_value, '/') - 1));
                l_cnt := to_number(substr(p_value, instr(p_value, '/') + 1));
            exception
                when INVALID_NUMBER then
                    raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
            end;


        end if;

    elsif (p_opt = 'A' and p_tag = '29') then

        validate_text_field(p_tag, p_value, 4, 35);


    elsif (p_opt in ('F', 'P', 'T', 'V', 'X') and p_tag = '30') then

        -- 1. Формат даты
        begin
            l_tmp_date := to_date(p_value, 'YYYYMMDD');
        exception
            when OTHERS then
                raise_application_error(-20782, 'T50: Неверный формат даты в поле ' || p_tag || p_opt);
        end;


    elsif (p_opt is null and p_tag = '30') then

        -- 1. Формат даты
        begin
            l_tmp_date := to_date(p_value, 'YYMMDD');
        exception
            when OTHERS then
                raise_application_error(-20782, 'T50: Неверный формат даты в поле ' || p_tag || p_opt);
        end;


    elsif ((p_opt = 'A' and p_tag = '32') or
           (p_opt in ('P', 'R') and p_tag = '34')) then

        -- 1. Формат даты
        begin
            l_tmp_date := to_date(substr(p_value, 1, 6), 'YYMMDD');
        exception
            when OTHERS then
                raise_application_error(-20782, 'T50: Неверный формат даты в поле ' || p_tag || p_opt);
        end;

        -- 2. Код валюты
        select count(*) into l_cnt
          from tabval
         where lcv = substr(p_value, 7, 3);

        if (l_cnt = 0) then
            raise_application_error(-20782, 'T52: Неверно задан код валюты в поле ' || p_tag || p_opt);
        end if;

        -- 3. Первый символ является цифрой
        if (translate(substr(p_value, 10,1), '0123456789', '9999999999') != '9') then
            raise_application_error(-20782, 'C03: Сумма должна начинаться с цифры в поле ' || p_tag || p_opt);
        end if;

        -- 4. Наличие запятой обязательно
        if (instr(substr(p_value, 10), ',') = 0) then
            raise_application_error(-20782, 'T40: Наличие запятой в сумме обязательно в поле ' || p_tag || p_opt);
        end if;

        -- 5. Максимальная длина суммы
        if (length(substr(p_value, 10)) > 15) then
            raise_application_error(-20782, 'T43: Превышен максимальная длина суммы в поле ' || p_tag || p_opt);
        end if;

    elsif ((p_opt in ('B', 'F') and p_tag = '32') or
           (p_opt in ('B', 'E', 'G') and p_tag = '33') or
           (p_opt = 'G' and p_tag = '71')) then

        -- 1. Код валюты
        if (p_opt = 'F' and p_tag = '32') then
            if substr(p_value, 1, 3) not in ('FOZ', 'GOZ', 'GRM', 'KLO', 'LOT') then
                l_cnt := 0;
            else
                l_cnt := 1;
            end if;
        else
            select count(*) into l_cnt
              from tabval
             where lcv = substr(p_value, 1, 3);
        end if;

        if (l_cnt = 0) then
            raise_application_error(-20782, 'T52: Неверно задан код валюты в поле ' || p_tag || p_opt);
        end if;

        -- 2. Первый символ является цифрой
        if (substr(translate(substr(p_value, 4, 1), '0123456789', '9999999999'), 1, 1) != '9') then
            raise_application_error(-20782, 'C03: Сумма должна начинаться с цифры в поле '|| p_tag || p_opt);
        end if;

        -- 3. Наличие запятой обязательно
        if (instr(substr(p_value, 4), ',') = 0) then
            raise_application_error(-20782, 'T40: Наличие запятой в сумме обязательно в поле '|| p_tag || p_opt);
        end if;

        -- 4. Максимальная длина суммы
        if (p_opt = 'G' and p_tag = '33') then
            if substr(p_value,-5) = 'SEE72' then
                l_value := substr(p_value, 4, length(p_value)-3-5);
            else
                l_value := substr(p_value, 4);
            end if;
        else
            l_value := substr(p_value, 4);
        end if;
        if (length(l_value) > 15) then
            raise_application_error(-20782, 'T43: Превышен максимальная длина суммы в поле '|| p_tag || p_opt);
        end if;

    elsif ((p_opt = 'H' and p_tag = '32') or
           (p_opt = 'E' and p_tag = '34')) then

        if (substr(p_value, 1, 1) = 'N') then
            l_value := substr(p_value, 2);
        else
            l_value := p_value;
        end if;

        -- 1. Код валюты
        select count(*) into l_cnt
          from tabval
         where lcv = substr(l_value, 1, 3);

        if (l_cnt = 0) then
            raise_application_error(-20782, 'T52: Неверно задан код валюты в поле ' || p_tag || p_opt);
        end if;

        -- 2. Первый символ является цифрой
        if (substr(translate(substr(l_value, 4, 1), '0123456789', '9999999999'), 1, 1) != '9') then
            raise_application_error(-20782, 'C03: Сумма должна начинаться с цифры в поле '|| p_tag || p_opt);
        end if;

        -- 3. Наличие запятой обязательно
        if (instr(substr(l_value, 4), ',') = 0) then
            raise_application_error(-20782, 'T40: Наличие запятой в сумме обязательно в поле '|| p_tag || p_opt);
        end if;

        -- 4. Максимальная длина суммы
        if (length(substr(l_value, 4)) > 15) then
            raise_application_error(-20782, 'T43: Превышен максимальная длина суммы в поле '|| p_tag || p_opt);
        end if;


    elsif (p_opt = 'F' and p_tag = '71') then

        if (p_mode = 1) then
            l_list := get_value_list(p_value);
        else
            l_list.extend;
            l_list(1) := p_value;
        end if;

        for i in 1..l_list.count
        loop

            -- 1. Код валюты
            select count(*) into l_cnt
              from tabval
             where lcv = substr(l_list(i), 1, 3);

            if (l_cnt = 0) then
                raise_application_error(-20782, 'T52: Неверно задан код валюты в поле ' || p_tag || p_opt);
            end if;

            -- 2. Первый символ является цифрой
            if (substr(translate(substr(l_list(i), 4, 1), '0123456789', '9999999999'), 1, 1) != '9') then
                raise_application_error(-20782, 'C03: Сумма должна начинаться с цифры в поле '|| p_tag || p_opt);
            end if;

            -- 3. Наличие запятой обязательно
            if (instr(substr(l_list(i), 4), ',') = 0) then
                raise_application_error(-20782, 'T40: Наличие запятой в сумме обязательно в поле '|| p_tag || p_opt);
            end if;

            -- 4. Максимальная длина суммы
            if (length(substr(l_list(i), 4)) > 15) then
                raise_application_error(-20782, 'T43: Превышен максимальная длина суммы в поле '|| p_tag || p_opt);
            end if;

        end loop;

        l_list.delete;

    elsif ((p_opt is null and p_tag = '36') or
           (p_opt = 'L' and p_tag = '37') ) then

        -- 1. Первый символ является цифрой
        if (substr(translate(p_value, '0123456789', '9999999999'), 1, 1) != '9') then
            raise_application_error(-20782, 'C03: Сумма должна начинаться с цифры в поле 36');
        end if;

        -- 2. Наличие запятой обязательно
        if (instr(p_value, ',') = 0) then
            raise_application_error(-20782, 'T40: Наличие запятой в сумме обязательно в поле 36');
        end if;

        -- 3. Максимальная длина суммы
        if (length(p_value) > 12) then
            raise_application_error(-20782, 'T43: Превышен максимальная длина суммы в поле 36');
        end if;

    elsif ((p_opt = 'G' and p_tag = '37')) then

        if (substr(p_value, 1, 1) ='N') then
            l_value := substr(p_value, 2);
        else
            l_value := p_value;
        end if;

        -- 1. Первый символ является цифрой
        if (substr(translate(l_value, '0123456789', '9999999999'), 1, 1) != '9') then
            raise_application_error(-20782, 'C03: Сумма должна начинаться с цифры в поле ' || p_tag || p_opt);
        end if;

        -- 2. Наличие запятой обязательно
        if (instr(l_value, ',') = 0) then
            raise_application_error(-20782, 'T40: Наличие запятой в сумме обязательно в поле ' || p_tag || p_opt);
        end if;

        -- 3. Максимальная длина суммы
        if (length(l_value) > 12) then
            raise_application_error(-20782, 'T43: Превышен максимальная длина суммы в поле ' || p_tag || p_opt);
        end if;

    elsif ((p_opt = 'J' and p_tag = '38')) then

        if (substr(p_value, 1, 1) not in ('D', 'M')) then
            raise_application_error(-20782, 'T61: Неверно задан код в поле ' || p_tag || p_opt);
        end if;

        if (length(substr(p_value, 2)) > 3) then
                raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
        end if;

        -- одно число
        begin
            l_cnt := to_number(substr(p_value, 2));
        exception
            when INVALID_NUMBER then
                raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
        end;

    elsif ((p_opt = 'K' and p_tag = '50') or
           (p_opt is null and p_tag = '59') ) then

        --
        -- Format: [/34x]
        --         4x35X
        --
        if (substr(p_value, 1, 1) = '/') then

            l_pos := instr(p_value, l_crln);

            if (l_pos !=0) then
                l_value := substr(p_value, 1, l_pos-1);
            else
                l_value := p_value;
            end if;

            validate_acc(p_tag, p_opt, l_value);
/*
            if (length(l_value) > 35) then
                raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
            end if;
*/
            if (l_pos != 0) then
                validate_text_field(p_tag, substr(p_value, l_pos+2), 4, 35);
            end if;

        else
            validate_text_field(p_tag, p_value, 4, 35);
        end if;

    elsif (p_opt = 'A' and p_tag in ('50', '59')) then

        --
        -- Format: [/34x]
        --         BIC
        --

        if (substr(p_value, 1, 1) = '/') then

            l_pos := instr(p_value, l_crln);

            if (l_pos = 0) then
                raise_application_error(-20782, '\902 Неверный формат поля, не найден BIC. Поле '|| p_tag || p_opt);
            end if;

            l_value := substr(p_value, 1, l_pos-1);


            validate_acc(p_tag, p_opt, l_value);
/*
            if (length(l_value) > 35) then
                raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
            end if;
*/
            validate_bic(p_tag, substr(p_value, l_pos+2));

        else
            validate_bic(p_tag, p_value);
        end if;

    elsif (p_opt = 'F' and p_tag = '50') then

        -- Формат поля:
        -- 35x
        -- 4*35x

        -- Должно быть два подполя
        l_pos := instr(p_value, l_crln);

        if (l_pos = 0) then
            raise_application_error(-20782, '\902 Неверный формат поля, подполе 2 не найдено. Поле '|| p_tag || p_opt);
        end if;

        --
        -- Подполе 1
        --
        l_value := substr(p_value, 1, l_pos-1);

        if (substr(l_value, 1, 1) = '/') then
            -- Формат 1 (subfield 1 line format 1)
            validate_acc(p_tag, p_opt, l_value);
        else
            -- Формат 2 (subfield 1 line format 2)
            if (substr(l_value, 1, 4) not in ('ARNU', 'CCPT', 'CUST', 'DRLC', 'EMPL', 'IBEI', 'NIDN', 'SOSE', 'TXID')
                or substr(l_value, 5, 1) != '/'                                                      ) then
                raise_application_error(-20782, 'T55: В подполе 1 должен быть представлен один из кодов ARNU, CCPT, CUST, DRLC, EMPL, IBEI, NIDN. Поле '|| p_tag || p_opt);
            end if;

            if (length(l_value) > 35) then
                raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
            end if;

            if (substr(l_value, 1, 4) in ('ARNU', 'CCPT', 'CUST', 'DRLC', 'EMPL', 'NIDN', 'SOSE', 'TXID')) then
                -- после кода /<код страны (2 симв.)>/ (TODO: проверка кода страны - пока нет справочника)
                if (substr(l_value, 8, 1) != '/') then
                    raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
                end if;
            end if;

        end if;

        --
        -- Подполе 2
        --
        l_value := substr(p_value, l_pos+2);

        -- Проверяем соблюдение длины и кол-ва строк
        validate_text_field(p_tag, l_value, 4, 35);

        -- Формат кода n/
        l_list := get_value_list(l_value);
        l_line := null;

        for i in 1..l_list.count
        loop

            if (substr(l_list(i), 2, 1) != '/') then
                raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt || ' (нет кода строки)');
            end if;

            if (substr(l_list(i), 1, 1) not in ('1', '2', '3', '4', '5', '6', '7', '8')) then
                raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt || ' (неизв. код строки)');
            end if;

            if (l_line is not null) then
                if (to_number(l_line) > to_number(substr(l_list(i), 1, 1))) then
                    raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt || ' (нарушена послед. кодов)');
                end if;
            end if;

            l_line := substr(l_list(i), 1, 1);

            -- Если встретился код 2, значит должен быть код 3
            if (substr(l_list(i), 1, 1) = '2') then
                l_cnt := 0;
                for j in 1..l_list.count
                loop
                    if (substr(l_list(j), 1, 1) = '3') then l_cnt := 1;
                    end if;
                end loop;

                if (l_cnt = 0) then
                    raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt || ' (нет обяз. кода 3)');
                end if;

            end if;

            -- Если встретился код 3, значит должен быть код 2
            if (substr(l_list(i), 1, 1) = '3') then
                l_cnt := 0;
                for j in 1..l_list.count
                loop
                    if (substr(l_list(j), 1, 1) = '2') then l_cnt := 1;
                    end if;
                end loop;

                if (l_cnt = 0) then
                    raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt || ' (нет обяз. кода 2)');
                end if;

            end if;

            -- Если встретился код 4, значит должен быть код 5
            if (substr(l_list(i), 1, 1) = '4') then
                l_cnt := 0;
                for j in 1..l_list.count
                loop
                    if (substr(l_list(j), 1, 1) = '5') then l_cnt := 1;
                    end if;
                end loop;

                if (l_cnt = 0) then
                    raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt || ' (нет обяз. кода 5)');
                end if;

            end if;

            -- Если встретился код 5, значит должен быть код 4
            if (substr(l_list(i), 1, 1) = '5') then
                l_cnt := 0;
                for j in 1..l_list.count
                loop
                    if (substr(l_list(j), 1, 1) = '4') then l_cnt := 1;
                    end if;
                end loop;

                if (l_cnt = 0) then
                    raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt || ' (нет обяз. кода 4)');
                end if;

            end if;

        end loop;

        l_list.delete;

    elsif (p_opt = 'D' and p_tag in ('52', '53', '54', '55', '56', '57', '58', '82', '83', '84', '85', '86', '87', '88')) then

        --
        -- Format: [/1a!][/34x]
        --         4x35X
        --
        if (substr(p_value, 1, 1) = '/') then

            l_pos := instr(p_value, l_crln);

            if (l_pos !=0) then
                l_value := substr(p_value, 1, l_pos-1);
            else
                l_value := p_value;
            end if;

            if (substr(l_value, 3, 1) = '/') then
                 if (length(l_value) > 37) then
                     raise_application_error(-20782, '\902 Неверный формат поля ' || p_tag || p_opt);
                 end if;

                 validate_acc(p_tag, p_opt, substr(l_value, 3));
            else
                validate_acc(p_tag, p_opt, l_value);
            end if;

            if (l_pos != 0) then
                validate_text_field(p_tag, substr(p_value, l_pos+2), 4, 35);
            end if;

        else
            validate_text_field(p_tag, p_value, 4, 35);
        end if;

    elsif (p_opt = 'C' and p_tag in ('56', '57')) then

        --
        -- Format: /34x
        --
        validate_acc(p_tag, p_opt, p_value);

    elsif (p_opt = 'B' and p_tag in ('53', '54', '55', '57', '84', '85')) then

        --
        -- Format: [/1a!][/34x]
        --         35X
        --
        if (substr(p_value, 1, 1) = '/') then

            l_pos := instr(p_value, l_crln);

            if (l_pos !=0) then
                l_value := substr(p_value, 1, l_pos-1);
            else
                l_value := p_value;
            end if;

            if (substr(l_value, 3, 1) = '/') then
                -- I dont validate letter in second position
                validate_acc(p_tag, p_opt, substr(l_value, 3));
            else
                 validate_acc(p_tag, p_opt, l_value);
            end if;

            if (l_pos != 0) then
                validate_text_field(p_tag, substr(p_value, l_pos+2), 1, 35);
            end if;

        else
            validate_text_field(p_tag, p_value, 1, 35);
        end if;

    elsif (p_opt = 'A' and p_tag in ('51', '52', '53', '54', '55', '56', '57', '58', '82', '83', '84', '85', '86', '87', '88')) then

        if (substr(p_value, 1, 1) = '/') then

            l_pos := instr(p_value, l_crln);

            if (l_pos = 0) then
                raise_application_error(-20782, '\902 Неверный формат поля, не найден BIC. Поле '|| p_tag || p_opt);
            end if;

            l_value := substr(p_value, 1, l_pos-1);

            if (substr(l_value, 3, 1) = '/') then
                 validate_acc(p_tag, p_opt, substr(l_value, 3));
            else
                validate_acc(p_tag, p_opt, l_value);
            end if;

            if (substr(p_value, l_pos+2) is null or substr(p_value, l_pos+2) = l_crln) then
                raise_application_error(-20782, '\902 Неверный формат поля, не найден BIC. Поле '|| p_tag || p_opt);
            end if;

            validate_bic(p_tag, substr(p_value, l_pos+2));

        else
            validate_bic(p_tag, p_value);
        end if;

    elsif ((p_opt in ('F', 'M') and p_tag in ('60', '62'))
           or (p_opt is null and p_tag in ('64', '65'))    ) then

        -- 1. Признак D/C
        if (substr(p_value, 1, 1) not in ('D', 'C')) then
            raise_application_error(-20782, 'T51: Недопустимый код в поле ' || p_tag || p_opt);
        end if;

        -- 2. Формат даты
        begin
            l_tmp_date := to_date(substr(p_value, 2, 6), 'YYMMDD');
        exception
            when OTHERS then
                raise_application_error(-20782, 'T50: Неверный формат даты в поле 32A');
        end;

        -- 3. Код валюты
        select count(*) into l_cnt
          from tabval
         where lcv = substr(p_value, 8, 3);

        if (l_cnt = 0) then
            raise_application_error(-20782, 'T52: Неверно задан код валюты в поле ' || p_tag || p_opt);
        end if;

        -- 4. Первый символ является цифрой
        if (substr(translate(substr(p_value, 11, 1), '0123456789', '9999999999'), 1, 1) != '9') then
            raise_application_error(-20782, 'C03: Сумма должна начинаться с цифры в поле ' || p_tag || p_opt);
        end if;

        -- 4. Наличие запятой обязательно
        if (instr(substr(p_value, 11), ',') = 0) then
            raise_application_error(-20782, 'T40: Наличие запятой в сумме обязательно в поле '|| p_tag || p_opt);
        end if;

        -- 5. Максимальная длина суммы
        if (length(substr(p_value, 11)) > 15) then
            raise_application_error(-20782, 'T43: Превышен максимальная длина суммы в поле ' || p_tag || p_opt);
        end if;

    elsif (p_opt is null and p_tag in ('61')) then

        null; -- пока не проверяю

    elsif (p_opt is null and p_tag = '70') then

        validate_text_field('70', p_value, 4, 35);

    elsif (p_opt = 'A' and p_tag = '71') then

        if (p_value not in ('BEN', 'OUR', 'SHA')) then
            raise_application_error(-20782, 'T08: Недопустимый код в поле 71A');
        end if;

    elsif (p_opt is null and p_tag = '72') then

        validate_text_field('72', p_value, 6, 35);

    elsif (p_opt = 'B' and p_tag = '77') then

        validate_text_field('72', p_value, 3, 35);

    elsif (p_opt = 'D' and p_tag = '77') then

        validate_text_field(p_tag, p_value, 6, 35);

    elsif (p_opt = 'T' and p_tag = '77') then null;

    elsif (p_opt is null and p_tag = '79') then

        validate_text_field('79', p_value, 35, 50);

    elsif (p_opt = 'J' and p_tag in ('53', '56', '57', '58', '82', '83', '84', '85', '86', '87', '88')) then

        validate_text_field(p_tag, p_value, 5, 40);

    elsif (p_opt is null and p_tag = '86') then

        validate_text_field('86', p_value, 6, 65);
        validate_field_rows('86', p_value);

    elsif (p_opt = 'A' and p_tag = '94') then

        if (p_value not in ('AGNT', 'BILA', 'BROK')) then
            raise_application_error(-20782, 'T36: Неверный код в поле ' || p_tag || p_opt);
        end if;
    elsif (p_tag  in('KOD_G')) then
        null;
    else
        raise_application_error(-20999, 'implementation restriction - cannot validate ' || p_tag || p_opt);
    end if;

    -- Проверка на допустимые символы
    if (p_chkchar = 1) then
        validate_field_char(p_tag, p_opt, p_value);
    end if;

end validate_field;



procedure validate_text_field(
    p_tag      in  sw_tag.tag%type,
    p_value    in  varchar2,
    p_rows     in  number,
    p_rowlen   in  number )
is

l_crln   char(2) := chr(13) || chr(10);

l_pos    number;
l_value  sw_operw.value%type;
l_row    sw_operw.value%type;

l_rowcnt number                := 0;

begin

    if (nvl(length(p_value), 0) < 1) then
        raise_application_error(-20782, '\910 Длина поля не может быть меньше 1 символа (поле ' || p_tag || ')');
    end if;

    l_value := p_value;
    l_pos   := 1;

    while (l_pos != 0 and l_value is not null)
    loop

        -- выделяем отдельную строку
        l_pos   := instr(l_value, l_crln);

        if (l_pos != 0) then
            l_row   := substr(l_value, 1, l_pos-1);
            l_value := substr(l_value, l_pos+2);
        else
            l_row   := l_value;
            l_value := null;
        end if;

        dbms_output.put_line(length(l_row));

        l_rowcnt:= l_rowcnt + 1;

        -- проверяем длину строки
        if (length(l_row) > p_rowlen) then
            raise_application_error(-20782, '\904 Длина строки больше максимального значения (поле ' || p_tag || ')');
        end if;

    end loop;

    if (l_rowcnt > p_rows) then
        raise_application_error(-20782, '\905 Количество строк в поле больше максимального значения (поле '|| p_tag || ')');
    end if;

end validate_text_field;


--**********************************************************************
-- VALIDATE_MSGFORMAT()
--
--      Процедура проверки сообщения на соответствие формату
--
--      Замечания: множество ограничений на повторяющиеся поля
--
--**********************************************************************

procedure validate_msgformat(
              p_swRef    in  number )
is

cursor cursModel(p_mt in number)
is
select num, seq, subseq, tag, opt, status, status2, empty, seqstat, rpblk
  from sw_model
 where mt = p_mt
order by num;


l_recModel cursModel%rowtype;       -- Строка модели сообщения

l_mt       sw_journal.mt%type;      -- Тип сообщения для проверки
l_opt      sw_opt.opt%type;         -- Установленная опция в сообщении
l_value    sw_operw.value%type;     -- Значение поля
l_list     t_strlist := t_strlist();               -- Список значения для повторяющегося поля

l_cnt      number;

begin

    -- Получаем тип сообщения
    select mt into l_mt
      from sw_journal
     where swref = p_swRef;

    open cursModel(l_mt);

    loop
        fetch cursModel into l_recModel;
        exit when cursModel%notfound;

        -- Получаем строку сообщения
        if (lower(l_recModel.opt) = l_recModel.opt) then

            -- Возможны различные опции для этого поля
            get_swtag(p_swRef, l_recModel.seq, l_recModel.tag, l_opt, l_value);

            -- Проверяем допустима ли опция
            if (l_value is not null) then
                select count(*) into l_cnt
                  from sw_model_opt
                 where mt = l_mt
                   and num = l_recModel.num
                   and opt = nvl(l_opt, '-');

                if (l_cnt = 0) then
                    raise_application_error(-20782, '\903 Опция ' || l_opt || ' недопустима для поля ' || l_recModel.tag);
                end if;
            end if;

        else
            -- Есть только одна опция, получаем значение
            if (l_recModel.rpblk is null) then

                l_value := get_swtag(p_swRef, l_recModel.seq, l_recModel.tag, l_recModel.opt);
                l_opt   := l_recModel.opt;

            elsif (l_recModel.rpblk = 'RI') then

                -- Получаем список
                l_list := get_swtaglist(p_swRef, l_recModel.seq, l_recModel.tag, l_recModel.opt);
                l_opt  := l_recModel.opt;

            else
                raise_application_error(-20999, 'implementation restriction - cannot validate repeated tag');
            end if;

        end if;

        if (l_recModel.rpblk is null)  then

            if (l_value is not null) then

                -- Просто проверяем формат
                validate_field(l_recModel.tag, l_opt, l_value, 0, 0);

            else

                -- Проверяем обязательность данного поля
                if (l_recModel.status = 'M' and (l_recModel.status2 is null or l_recModel.status2 = 'M')) then
                    raise_application_error(-20782, '\902 Поле ' || l_recModel.tag || l_recModel.opt || ' является обязательным в сообщении');
                end if;
            end if;

        elsif (l_recModel.rpblk = 'RI') then

           for i in 1..l_list.count
           loop
               validate_field(l_recModel.tag, l_opt, l_list(i), 0, 0);
           end loop;

        else
            raise_application_error(-20999, 'implementation restriction - cannot validate repeated tag');
        end if;

    end loop;

end validate_msgformat;



procedure validate_mt103_message(
    p_swRef    in number )
is

l_fld71a  varchar2(200);
l_fld32b  varchar2(200);
l_fld33b  varchar2(200);
l_fld36   sw_operw.value%type;
l_fld59   sw_operw.value%type;

l_fld56   sw_operw.value%type;
l_fld57   sw_operw.value%type;
l_fld70   sw_operw.value%type;
l_fld77t  sw_operw.value%type;

l_fld71f  sw_operw.value%type;
l_fld71g  sw_operw.value%type;

l_tmp32   number;
l_tmp32b  number;
l_tmp33b  number;
l_tmp36   number;
l_tmp71f  number;
l_tmp71g  number;
l_currCode number;

l_cnt     number;

begin

    -- Проверка 1: Сообщение просто есть
    select count(*) into l_cnt
      from sw_journal
     where swref = p_swref;

    if (l_cnt = 0) then
        raise_application_error(-20782, '\901 Сообщение не найдено. SwRef=' || to_char(p_swRef));
    end if;

    -- Проверка 2: Форматы полей сообщения
    validate_msgformat(p_swRef);

    --
    -- Проверка 1: проверка заполнения поля 36
    --             поле 36 должно присутствовать в сообщении, если заполнено поле
    --             33B и валюта в полях 32 и 33 отличаются
    --

    begin
        select rtrim(ltrim(value))
          into l_fld32b
          from sw_operw
         where swref = p_swref
           and tag = '32'
           and opt = 'A';
    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\427 В сообщении нет обязательного поля 32A Ref='  || to_char(p_swRef));
    end;

    begin

        select rtrim(ltrim(value))
          into l_fld33b
          from sw_operw
         where swref = p_swref
           and tag = '33'
           and opt = 'B';

    exception
        when NO_DATA_FOUND then l_fld33b := null;
    end;

    begin

        select rtrim(ltrim(value))
          into l_fld36
          from sw_operw
         where swref = p_swref
           and tag = '36'
           and opt is null;

    exception
        when NO_DATA_FOUND then l_fld36 := null;
    end;


    if (l_fld33b is not null and substr(l_fld32b, 7, 3) != substr(l_fld33b, 1, 3)) then

        if (l_fld36 is null) then
            raise_application_error(-20780, '\414 Поле 36 должно быть заполнено для этого сообщения Ref=' || to_char(p_swRef));
        end if;

    else
        if (l_fld36 is not null) then
            raise_application_error(-20780, '\413 Поле 36 не должно быть заполнено для этого сообщения Ref=' || to_char(p_swRef));
        end if;
    end if;

    --
    -- Проверка 2: проверка заполнения полей 56 и 57
    --             Если поле 56 заполнено, то обязательно заполнение поля 57
    --
    --
    begin

        select rtrim(ltrim(value))
          into l_fld56
          from sw_operw
         where swref = p_swref
           and tag = '56'
           and opt in ('A', 'C', 'D');

    exception
        when NO_DATA_FOUND then l_fld56 := null;
    end;

    begin

        select rtrim(ltrim(value))
          into l_fld57
          from sw_operw
         where swref = p_swref
           and tag = '57'
           and opt in ('A', 'B', 'C', 'D');

    exception
        when NO_DATA_FOUND then l_fld57 := null;
    end;


    if (l_fld56 is not null and l_fld57 is null) then
        raise_application_error(-20780, '\415 Поле 57 должно быть заполнено при наличии заполненного поля 56 Ref=' || to_char(p_swRef));
    end if;

    --
    -- Проверка 3: проверка заполнения полей 70 и 77T
    --             Два взаимоисключающих поля
    --
    begin

        select rtrim(ltrim(value))
          into l_fld70
          from sw_operw
         where swref = p_swref
           and tag = '70'
           and opt is null;

    exception
        when NO_DATA_FOUND then l_fld70 := null;
    end;

    begin

        select rtrim(ltrim(value))
          into l_fld77t
          from sw_operw
         where swref = p_swref
           and tag = '77'
           and opt = 'T';

    exception
        when NO_DATA_FOUND then l_fld77t := null;
    end;

    if (l_fld70 is not null and l_fld77t is not null) then
        raise_application_error(-20780, '\416 Поле 77T не должно быть заполнено Ref=' || to_char(p_swRef));
    end if;


    --
    -- Проверка 4: проверка заполнения полей 71F при 71A=OUR
    --
    --

    select rtrim(ltrim(value))
      into l_fld71a
      from sw_operw
     where swref = p_swref
       and tag = '71'
       and opt = 'A';

    begin

        select rtrim(ltrim(value))
          into l_fld71f
          from sw_operw
         where swref = p_swref
           and tag = '71'
           and opt = 'F';

    exception
        when NO_DATA_FOUND then l_fld71f := null;
    end;

    begin

        select rtrim(ltrim(value))
          into l_fld71g
          from sw_operw
         where swref = p_swref
           and tag = '71'
           and opt = 'G';

    exception
        when NO_DATA_FOUND then l_fld71g := null;
    end;


    if (l_fld71a = 'OUR') then

        if (l_fld71f is not null) then
            raise_application_error(-20780, '\417 Поле 71F не должно быть заполнено (71A=OUR) Ref=' || to_char(p_swRef));
        end if;

        if (l_fld71g is not null and substr(l_fld71g, 1, 3) != substr(l_fld32b, 7, 3)) then
            raise_application_error(-20780, '\418 Поле 71G заполнено с кодом валюты не совпадающим с полем 32B (71A=OUR) Ref=' || to_char(p_swRef));
        end if;

        if ((l_fld71f is not null or l_fld71g is not null) and l_fld33b is null) then
            raise_application_error(-20780, '\423 Поле 33B обязательно к заполнению (71A=OUR) Ref=' || to_char(p_swRef));
        end if;


    end if;


    --
    -- Проверка 5: проверка заполнения полей 71G при 71A=BEN
    --
    --
    if (l_fld71a = 'BEN') then

        if (l_fld71g is not null) then
            raise_application_error(-20780, '\419 Поле 71G не должно быть заполнено (71A=BEN) Ref=' || to_char(p_swRef));
        end if;

        if (l_fld71f is null) then
            raise_application_error(-20780, '\420 Поле 71F не заполнено (71A=BEN) Ref=' || to_char(p_swRef));
        end if;

        if ((l_fld71f is not null or l_fld71g is not null) and l_fld33b is null) then
            raise_application_error(-20780, '\424 Поле 33B обязательно к заполнению (71A=BEN) Ref=' || to_char(p_swRef));
        end if;

    end if;


    --
    -- Проверка 6: проверка заполнения полей 71F при 71A=SHA
    --
    --
    if (l_fld71a = 'SHA') then

        if (l_fld71g is not null) then
            raise_application_error(-20780, '\421 Поле 71G не должно быть заполнено (71A=SHA) Ref=' || to_char(p_swRef));
        end if;

        -- Поле опциональное
        --if (l_fld71f is null) then
        --    raise_application_error(-20780, '\422 Поле 71F не заполенно (71A=SHA) Ref=' || to_char(p_swRef));
        --end if;

        if ((l_fld71f is not null or l_fld71g is not null) and l_fld33b is null) then
            raise_application_error(-20780, '\425 Поле 33B обязательно к заполнению (71A=BEN) Ref=' || to_char(p_swRef));
        end if;

    end if;


    --
    -- Проверка 7: проверка заполнения значения поля 32А
    --
    --
    if (l_fld33b is not null and (l_fld71g is not null or l_fld71f is not null)) then

        SwiftToAmount(substr(l_fld32b, 7), l_currCode, l_tmp32b);
        SwiftToAmount(l_fld33b, l_currCode, l_tmp33b);

        if (l_fld36 is not null) then
            l_tmp36 := to_number(replace(l_fld36, ',', '.'));
        else
            l_tmp36 := 1;
        end if;

        if (l_fld71g is not null) then
           SwiftToAmount(l_fld71g, l_currCode, l_tmp71g);
        else
           l_tmp71g := 0;
        end if;

        if (l_fld71f is not null) then
           SwiftToAmount(l_fld71f, l_currCode, l_tmp71f);
        else
           l_tmp71f := 0;
        end if;

        l_tmp32 := l_tmp33b * l_tmp36 + l_tmp71g - l_tmp71f;


        if (abs(l_tmp32b - l_tmp32) > 1/100) then
            raise_application_error(-20780, '\426 Неверно заполнено значение одного из полей 33B, 36, 71G, 71F. 32A=' || to_char(l_tmp32b) || ' рассчитанное=' || to_char(l_tmp32) || ' Ref=' || to_char(p_swRef));
        end if;

    end if;

    --
    -- Проверка 8: Заполнено ли поле 59А/59
    --
    begin

        select rtrim(ltrim(value))
          into l_fld59
          from sw_operw
         where swref = p_swref
           and tag = '59'
           and (opt = 'A' or opt is null);

    exception
        when NO_DATA_FOUND then l_fld59 := null;
    end;

    if (l_fld59 is null) then
            raise_application_error(-20780, '\427 Не заполнено поле 59А/59  Ref=' || to_char(p_swRef));
    end if;


end validate_mt103_message;


procedure validate_mt202_message(
    p_swRef    in number )
is

l_cnt        number;

begin

    -- Проверка 1: Сообщение просто есть
    select count(*) into l_cnt
      from sw_journal
     where swref = p_swref;

    if (l_cnt = 0) then
        raise_application_error(-20782, '\901 Сообщение не найдено. SwRef=' || to_char(p_swRef));
    end if;

    -- Проверка 2: Форматы полей сообщения
    validate_msgformat(p_swRef);

    -- Проверка 3: Если указано поле 56, то должно быть указано поле 57
    select count(*) into l_cnt
      from sw_operw
     where swref = p_swref
       and tag   = '56'
       and opt in ('A', 'D');

    if (l_cnt != 0) then

        select count(*) into l_cnt
          from sw_operw
         where swref = p_swref
           and tag   = '57'
           and opt  in ('A', 'B', 'D');

        if (l_cnt = 0) then
            raise_application_error(-20782, 'C81: Поле 56 заполнено, должно быть заполнено поле 57');
        end if;

    end if;

end validate_mt202_message;


--**************************************************************--
-- UNLOCK_MESSAGE()
--
--     Разблокирует указанное блокированное сообщение
--
-- DG
--**************************************************************--
procedure unlock_message(
    p_swRef          in number )
is

l_mt        sw_journal.mt%type;
l_sos       sw_journal.sos%type;
l_flags     sw_journal.flags%type;
l_dateOut   sw_journal.date_out%type;

l_sndrBic   sw_journal.sender%type;
l_rcvrBic   sw_journal.receiver%type;
l_bankName  sw_banks.name%type;

l_docUserID oper.userid%type;           /* Ид. пользователя, который вып. подбор корсчета */
l_absUserID staff.id%type;              /*            Ид. текущего пользователя комплекса */

begin

    begin
        select mt, sender, receiver, sos, flags, date_out
          into l_mt, l_sndrBic, l_rcvrBic, l_sos, l_flags, l_dateOut
          from sw_journal
         where swref = p_swRef;
    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\300 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено');
    end;

    if (l_sos = -2) then
        raise_application_error(-20780, '\301 Сообщение с реф. ' || to_char(p_swRef) || ' умеет статус "Удалено"');
    end if;

    if (l_dateOut != to_date('01014000', 'ddmmyyyy')) then
        raise_application_error(-20780, '\302 Сообщение с реф. ' || to_char(p_swRef) || ' не является заблокированным');
    end if;

    -- Проверка на не псевдо-BIC
    select upper(name)
      into l_bankName
      from sw_banks
     where bic = l_sndrBic;

    if (instr(l_bankName, 'FALSE') != 0 and instr(l_bankName, 'FALSE') is not null) then
        raise_application_error(-20780, '\301 Сообщение с реф. ' || to_char(p_swRef) || ' содержит псевдо-BIC в поле отправителя');
    end if;

    select upper(name)
      into l_bankName
      from sw_banks
     where bic = l_rcvrBic;

    if (instr(l_bankName, 'FALSE') != 0 and instr(l_bankName, 'FALSE') is not null) then
        raise_application_error(-20780, '\301 Сообщение с реф. ' || to_char(p_swRef) || ' содержит псевдо-BIC в поле получателя');
    end if;

    --
    -- При установке повышенной безопасности проверяем документ
    -- на то,   что подбор корсчета и соответственно порождение
    -- документа (тип NOS) было проведено этим же пользователем
    -- комплекса.  В  этом  случае разблокировку не выполняем и
    -- заносим этот факт к журнал безопасности.
    --

    if (nvl(get_param_value(MODPAR_MSGLCKSEC), MODVAL_MSGLCKSEC_FALSE) = MODVAL_MSGLCKSEC_TRUE) then

        if (msgchk_getexpstatus(p_swRef) = 0) then
            bars_audit.security('Выполнена попытка разблокировки сообщения без наложения виз. SwRef=' || to_char(p_swRef));
            raise_application_error(-20780, '\303 Разблокировка сообщения без наложения виз!');
        end if;

    end if;

    -- Выполняем проверку сообщения
    genmsg_message_validate(p_swRef);

    -- Обновляем
    update sw_journal
       set date_out = null,
           flags    = replace(l_flags, 'L', '')
     where swref = p_swref;

    delete from sw_procque
     where swref = p_swref;

    bars_audit.write_message(bars_audit.fin_msg, bankdate(), 'Разблокировано SWIFT сообщение с реф. ' || p_swRef);

end unlock_message;

--**********************************************************************
-- GET_DOCUMENT_REF()
--
--      Функция для получения референса документа, связанного с
--      сообщением Swift. Если с сообщением связано несколько
--      документов, то будет выбрано первый найденный документ
--
--
--**********************************************************************

function get_document_ref(
              p_swRef    in  number ) return sw_oper.ref%type
is

l_value   sw_oper.ref%type;

begin

    select ref   into l_value
      from sw_oper
     where swref  = p_swRef
       and rownum = 1;

    return l_value;

exception
     when NO_DATA_FOUND then return null;
end get_document_ref;


--**************************************************************--
-- GET_AUTH_FLAG()
--
--     Функция возвращает значение флага обработки сообщения
--     на основании  флага  проверки  кода аутентификации  и
--     состояния настроек
--
--     Описание параметров:
--
--        p_lauflag     Результат проверки кода LAU
--
--
-- DG
--**************************************************************--
function get_auth_flag(
              p_lauflag  in sw_journal.lau_flag%type ) return sw_journal.lau_act%type
is
begin
    return null;
end get_auth_flag;

--**************************************************************--
-- GEN_MESSAGE()
--
--     Процедура создания сообщения из платежного документа
--
--
--     Описание параметров:
--
--        p_ref        Референс документа
--
--
-- DG
--**************************************************************--
procedure gen_message(
              p_ref      in  oper.ref%type )
is
begin
    bars_swift_msg.docmsg_process_document(p_ref, null);
end gen_message;

--**********************************************************************
-- IMPMSG_SET_STAFF()
--
--      Процедура выполняет распределение импортированного сообщения
--      для указанного пользователя
--
--
--
--**********************************************************************

procedure impmsg_set_staff(
              p_swRef    in  sw_journal.swref%type,
              p_staffID  in  staff.id%type          )
is
begin

    update sw_journal set id = p_staffID
     where swref = p_swRef;

    bars_audit.info('SWT: сообщение распределено в журнал ' || nvl(to_char(p_staffID), 'общий') || '.SwRef=' || to_char(p_swRef));

end impmsg_set_staff;

--**********************************************************************
-- IMPMSG_CHANGE_STAFF()
--
--      Процедура выполняет перераспределение всех распределенных на
--      пользователя сообщений на другого пользователя
--
--
--
--**********************************************************************

procedure impmsg_change_staff(
              p_swRef       in  sw_journal.swref%type,
              p_swStaffID   in  staff.id%type,
              p_staffID     in  staff.id%type         )
is
begin

   if (p_swRef is not null) then

       update sw_journal
          set id = p_staffID
        where swref = p_swRef
          and id    = p_swStaffID;

       bars_audit.info('SWT: сообщение перераспределено в журнал ' || nvl(to_char(p_staffID), 'общий') || '.SwRef=' || to_char(p_swRef));

   else

       update sw_journal
          set id = p_staffID
        where id    = p_swStaffID;

       bars_audit.info('SWT: все сообщения перераспределены в журнал ' || nvl(to_char(p_staffID), 'общий') || '.SwRef=' || to_char(p_swRef));
   end if;

end impmsg_change_staff;

--**********************************************************************
-- IMPMSG_DELETE_MESSAGE()
--
--      Процедура удаления импортированного сообщения
--
--
--
--
--**********************************************************************

procedure impmsg_delete_message(
              p_swRef    in  sw_journal.swref%type  )
is
begin

    delete from sw_journal where swref = p_swRef;

    bars_audit.info('SWT: Пользователь удалил сообщение SwRef=' || to_char(p_swRef));

end impmsg_delete_message;




    -----------------------------------------------------------------
    -- ISTMT_PARSE_STMT
    --
    --     Процедура разбора выписки
    --
    --     Параметры:
    --
    --         p_swref    Реф. сообщения
    --
    --
    procedure istmt_parse_stmt(
                  p_swref  in  sw_journal.swref%type)
    is

    l_pos          number;                  /*      позиция подполя в строке */
    l_pos2         number;                  /*                  доп. позиция */

    l_accNostro    accounts.acc%type;       /*              Ид. счета Nostro */
    l_dk           dk.dk%type;              /*          Признак Дебет/Кредит */
    l_stmt_dk      varchar2(2);             /*   Признак Дебет/Кредит выписки*/
    l_stmt_curl    tabval.lcv%type;         /*        ISO-код валюты выписки */

    l_stmt_num     sw_950.num%type;         /*        Номер страницы выписки */
    l_stmt_cur     sw_950.kv%type;          /*            Код валюты выписки */
    l_stmt_odat    sw_950.stmt_bdate%type;  /*        Начальная дата выписки */
    l_stmt_obal    sw_950.obal%type;        /*              Входящий остаток */
    l_stmt_cdat    sw_950.stmt_date%type;   /*         Конечная дата выписки */
    l_stmt_cbal    sw_950.cbal%type;        /*             Исходящий остаток */
    l_stmt_info    sw_950.add_info%type;    /*       Доп. информация выписки */
    l_stmt_date    sw_950a.fdat%type;       /*                  Дата остатка */
    l_stmt_bal     sw_950a.s%type;          /*               Остаток на дату */

    l_stmtl_vdate  sw_950d.vdate%type;      /*   Дата валютирования проводки */
    l_stmtl_edate  sw_950d.edate%type;      /*     Дата поступления проводки */
    l_stmtl_fcode  sw_950d.fund%type;       /*          Подполе 4: код фонда */
    l_stmtl_amount sw_950d.s%type;          /*              Сумма транзакции */
    l_stmtl_mt     sw_950d.mt%type;         /*       Тип исходного сообщения */
    l_stmtl_swtt   sw_950d.swtt%type;       /*       Тип исходной транзакции */
    l_stmtl_ref    sw_950d.their_ref%type;  /*          Референс влад. счета */
    l_stmtl_ref2   sw_950d.their2_ref%type; /*          Референс обсл. банка */
    l_stmtl_info   sw_950d.detail%type;     /* Доп. информация о транзакциии */


    begin

        bars_audit.trace('looking for unparsed statements...');

        --
        -- Отбираем все выписки, которые еще не разобраны
        --
        for k1 in (select j.swref, j.sender, j.accd acc, j.page, j.currency
                     from sw_journal j
                    where swref = p_swref )
        loop

            bars_audit.trace('Found unparsed statement SwRef=%s, parsing...', to_char(k1.swref));

            --
            -- Очистка переменных
            --
            l_accNostro := null;

            l_stmt_num  := null;
            l_stmt_cur  := null;
            l_stmt_odat := null;
            l_stmt_obal := null;
            l_stmt_cdat := null;
            l_stmt_cbal := null;
            l_stmt_info := null;

            -- Проходим по всем записям отобранного сообщения
            for k2 in (select n, tag, opt, value
                         from sw_operw
                        where swref = k1.swref
                       order by n                )
            loop

                bars_audit.trace('message field: tag=%s opt=%s value=%s', k2.tag, k2.opt, k2.value);

                if (k2.tag = '25' and k2.opt is null) then

                    --
                    -- Пытаемся подобрать корсчет, по которому
                    -- сформирована данная выписки
                    --
                    bars_audit.trace('looking for nostro account ...');

                    begin

                        select b.acc into l_accNostro
                          from bic_acc b, accounts a, tabval t
                         where b.bic = k1.sender
                           and b.their_acc = k2.value
                           and b.acc = a.acc
                           and a.kv = t.kv
                           and t.lcv = k1.currency;

                        bars_audit.trace('Found nostro account acc=%s', to_char(l_accNostro));

                    exception
                        when NO_DATA_FOUND then

                            bars_audit.trace('Nostro account not found on account number, try found on sender...');

                            begin

                                select b.acc  into l_accNostro
                                  from bic_acc b, accounts a, tabval t
                                 where b.bic = k1.sender
                                   and b.acc = a.acc
                                   and a.kv = t.kv
                                   and t.lcv = k1.currency;

                                bars_audit.trace('Found nostro account acc=%s (retry 2)', to_char(l_accNostro));

                            exception
                                when NO_DATA_FOUND then
                                    bars_audit.trace('Nostro account not found!');
                                when TOO_MANY_ROWS then
                                    bars_audit.trace('Nostro account not found!');
                            end;
                    end;

                elsif (k2.tag = '28' and k2.opt = 'C') then

                    l_stmt_num := k2.value;
                    bars_audit.trace('Statement number/sequence is %s', l_stmt_num);

                elsif (k2.tag = '60' and k2.opt in ('F', 'M')) then

                    if (substr(k2.value, 1, 1) = 'D') then
                        l_dk   := -1;
                    else
                        l_dk   := 1;
                    end if;

                    l_stmt_odat := to_date(substr(k2.value, 2, 6), 'yymmdd');
                    l_stmt_curl := substr(k2.value, 8, 3);

                    SwiftToAmount(substr(k2.value, 8), l_stmt_cur, l_stmt_obal);
                    l_stmt_obal := l_stmt_obal * l_dk;

                    bars_audit.trace('Statement begin date is %s', to_char(l_stmt_odat, 'dd.mm.yyyy'));
                    bars_audit.trace('Statement opening balance is %s currency %s', to_char(l_stmt_obal), to_char(l_stmt_cur));

                    -- Создаем заголовок выписки
                    insert into sw_950 (swref, nostro_acc, num, kv, stmt_bdate, stmt_date, obal, cbal)
                    values (k1.swref, l_accNostro, l_stmt_num, l_stmt_cur, l_stmt_odat, l_stmt_odat, l_stmt_obal, 0);

                elsif (k2.tag = '61' and k2.opt is null) then

                    --
                    -- Подполе 1: "Value date"
                    --
                    l_stmtl_vdate := to_date(substr(k2.value, 1, 6), 'yymmdd');
                    bars_audit.trace('Statement line: value date is %s', to_char(l_stmtl_vdate, 'dd.mm.yyyy'));

                    --
                    -- Подполе 2: "Entry date"
                    --
                    if (substr(k2.value, 7, 1) not in ('R', 'C', 'D')) then
                        l_stmtl_edate := to_date(substr(k2.value, 7, 4), 'mmdd');
                        l_pos         := 11;
                        bars_audit.trace('Statement line: entry date is %s', to_char(l_stmtl_edate, 'dd.mm.yyyy'));
                    else
                        l_stmtl_edate := null;
                        l_pos         := 7;
                        bars_audit.trace('Statement line: entry date skipped.');
                    end if;

                    --
                    -- Подполе 3: "Debit/Credit"
                    --
                    if (substr(k2.value, l_pos, 1) = 'R') then

                        if (substr(k2.value, l_pos, 2) = 'RC') then
                            l_dk := -1;
                            l_stmt_dk:='RC';
                        else
                            l_dk := 1;
                            l_stmt_dk:='RD';
                        end if;

                        l_pos := l_pos + 2;

                    else

                        if (substr(k2.value, l_pos, 1) = 'D') then
                            l_dk := -1;
                            l_stmt_dk:='D';
                        else
                            l_dk := 1;
                            l_stmt_dk:='C';
                        end if;

                        l_pos := l_pos + 1;

                    end if;

                    bars_audit.trace('Statement line: D/C is %s, position is %s', to_char(l_dk), to_char(l_pos));

                    --
                    -- Подполе 4: "Funds Code"
                    --
                    if (instr('0123456789', substr(k2.value, l_pos, 1)) != 0) then
                        l_stmtl_fcode := null;
                        bars_audit.trace('Statement line: subfield 4 (funds code) not found.');
                    else
                        l_stmtl_fcode := substr(k2.value, l_pos, 1);
                        l_pos         := l_pos + 1;
                        bars_audit.trace('Statement line: funds code is %s', l_stmtl_fcode);
                    end if;

                    --
                    -- Подполе 5: "Amount"
                    --
                    l_pos2 := instr(substr(k2.value, l_pos), ',');

                    while (instr('0123456789', substr(k2.value, l_pos+l_pos2, 1)) > 0)
                    loop
                        l_pos2 := l_pos2 + 1;
                    end loop;

                    SwiftToAmount(l_stmt_curl || substr(k2.value, l_pos, l_pos2), l_stmt_cur, l_stmtl_amount);
                    l_stmtl_amount := l_stmtl_amount * l_dk;
                    l_pos          := l_pos + l_pos2;

                    --
                    -- Подполе 6: "Transaction type"
                    --
                    bars_audit.trace('Statement line: subfield 6 position is %s', to_char(l_pos));

                    if (substr(k2.value, l_pos, 1) = 'S') then
                        l_stmtl_mt   := to_number(substr(k2.value, l_pos + 1, 3));
                        l_stmtl_swtt := null;
                        l_pos        := l_pos + 4;
                    else
                        l_stmtl_mt   := null;
                        l_stmtl_swtt := substr(k2.value, l_pos + 1, 3);
                        l_pos        := l_pos + 4;
                    end if;

                    bars_audit.trace('Statement line: message type is %s, transaction type is %s', to_char(l_stmtl_mt), l_stmtl_swtt);

                    --
                    -- Подполе 7: "Reference for account owner" (their2_ref)
                    --
                    l_pos2 := instr(substr(k2.value, l_pos), '//');

                    if (l_pos2 != 0) then

                        bars_audit.trace('Statement line: subfield 7 position is %s, subfield 8 rel position is %s', to_char(l_pos), to_char(l_pos2));
                        l_stmtl_ref := substr(k2.value, l_pos, l_pos2-1);

                    else

                        l_pos2 := instr(k2.value, CRLF);

                        bars_audit.trace('Statement line: subfield 7 position is %s, subfield 8 not found, CRLF position is %s', to_char(l_pos), to_char(l_pos2));

                        if (l_pos2 != 0) then
                            l_stmtl_ref := substr(k2.value, l_pos, l_pos2-l_pos);
                        else
                            l_stmtl_ref := substr(k2.value, l_pos);
                        end if;

                        --
                        -- Возвращаем значение l_pos2 для корректного
                        -- определения подполя 9
                        --
                        l_pos2 := 0;

                    end if;

                    bars_audit.trace('Statement line: subfield 7 is %s', l_stmtl_ref2);

                    --
                    -- Подполе 8: "Account servicing institutions reference"
                    --
                    if (l_pos2 != 0) then

                        l_pos  := l_pos + l_pos2 + 1;
                        l_pos2 := instr(k2.value, CRLF);
                        bars_audit.trace('Statement line: subfield 8 begin position is %s, end position is %s', to_char(l_pos), to_char(l_pos2));

                        if (l_pos2 != 0) then
                            l_stmtl_ref2 := substr(k2.value, l_pos, l_pos2-l_pos);
                        else
                            l_stmtl_ref2 := substr(k2.value, l_pos);
                        end if;

                    else
                        l_stmtl_ref2 := null;
                    end if;

                    bars_audit.trace('Statement line: subfield 8 is %s', l_stmtl_ref);

                    --
                    -- DG (17/03/2006): Пока не понимаю,  но Петрокоммерц утверждает
                    --                  что искать нужно сначало по подполю 7, потом
                    --                  по подполю 8
                    --
                    -- if (l_stmtl_ref is null and l_stmtl_ref2 is not null) then
                    --    l_stmtl_ref := l_stmtl_ref2;
                    --    bars_audit.trace('Statement line: reassign their_ref to subfield 7 = %s', l_stmtl_ref);
                    -- end if;
                    --

                    --
                    -- Подполе 9: "Details"
                    --
                    l_pos := instr(k2.value, CRLF);

                    if (l_pos != 0) then
                        l_stmtl_info := substr(k2.value, l_pos + 2);
                    else
                        l_stmtl_info := null;
                    end if;

                    bars_audit.trace('Statement line: subfield 9 is %s', l_stmtl_info);

                    -- Вставка строки выписки
                    insert into sw_950d (swref, n, vdate, edate, fund, s, mt, swtt, their_ref, their2_ref, detail, stmt_dk)
                    values (k1.swref, k2.n, l_stmtl_vdate, l_stmtl_edate, l_stmtl_fcode, l_stmtl_amount,
                            l_stmtl_mt, l_stmtl_swtt, l_stmtl_ref, l_stmtl_ref2, l_stmtl_info, l_stmt_dk);

                elsif (k2.tag = '62' and k2.opt in ('F', 'M')) then

                    if (substr(k2.value, 1, 1) = 'D') then
                        l_dk   := -1;
                    else
                        l_dk   := 1;
                    end if;

                    l_stmt_cdat := to_date(substr(k2.value, 2, 6), 'yymmdd');

                    SwiftToAmount(substr(k2.value, 8), l_stmt_cur, l_stmt_cbal);
                    l_stmt_cbal := l_stmt_cbal * l_dk;

                    bars_audit.trace('Statement end date is %s', to_char(l_stmt_cdat, 'dd.mm.yyyy'));
                    bars_audit.trace('Statement closing balance is %s currency %s', to_char(l_stmt_cbal), to_char(l_stmt_cur));

                elsif (k2.tag in ('64', '65') and k2.opt is null) then

                    --
                    -- Состояние (остаток) счета на дату
                    --

                    if (substr(k2.value, 1, 1) = 'D') then
                        l_dk   := -1;
                    else
                        l_dk   := 1;
                    end if;

                    l_stmt_date := to_date(substr(k2.value, 2, 6), 'yymmdd');

                    SwiftToAmount(substr(k2.value, 8), l_stmt_cur, l_stmt_bal);
                    l_stmt_bal := l_stmt_bal * l_dk;

                    bars_audit.trace('Statement balance date is %s', to_char(l_stmt_date, 'dd.mm.yyyy'));
                    bars_audit.trace('Statement balance is %s currency %s', to_char(l_stmt_bal), to_char(l_stmt_cur));

                    begin

                        insert into sw_950a (swref, fdat, kv, s)
                        values (k1.swref, l_stmt_date, l_stmt_cur, l_stmt_bal);

                    exception
                        when DUP_VAL_ON_INDEX then
                            bars_audit.trace('Duplicate record in sw_950a detected, ignoring ...');
                    end;

                elsif (k2.tag = '86' and k2.opt is null) then

                    --
                    -- Дополнительная информация
                    --
                    l_stmt_info := k2.value;
                    bars_audit.trace('Information to account owner: %s', l_stmt_info);

                else
                    bars_audit.trace('Tag %s opt %s is ignored.', k2.tag, k2.opt);
                end if;

            end loop;

            -- Обновляем заголовок
            update sw_950
               set stmt_date = l_stmt_cdat,
                   cbal      = l_stmt_cbal,
                   add_info  = l_stmt_info
             where swref = k1.swref;

            bars_audit.trace('Statement parsed SwRef=%', to_char(k1.swref));

        end loop;

     end istmt_parse_stmt;


    -----------------------------------------------------------------
    -- ISTMT_PARSE_ERROR
    --
    --     Процедура регистрации/очистки информации об ошибке
    --     при разборе выписки
    --
    --     Параметры:
    --
    --         p_swref    Реф. выписки
    --
    --         p_mode     Режим: регистрация/очистка
    --
    --         p_errmsg   Сообщение об ошибке (только для регистр.)
    --
    --
    procedure istmt_parse_error(
                  p_swref  in  sw_journal.swref%type,
                  p_mode   in  number,
                  p_errmsg in  varchar2 )
    is
    p         constant varchar2(100) := 'swt.stmtparseerr';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s, par[1]=>%, par[2]=>%s', p,
                         to_char(p_swref), to_char(p_mode), p_errmsg            );

        if    (p_mode = STMT_PARSEERROR_CLEAR) then

            bars_audit.trace('%s: clearing error for stmt %s...', p, to_char(p_swref));
            delete from sw_stmt_errs
             where stmt_swref = p_swref;
            bars_audit.trace('%s: error cleared for stmt %s...', p, to_char(p_swref));

        elsif (p_mode = STMT_PARSEERROR_SET  ) then

            bars_audit.trace('%s: add error for stmt %s...', p, to_char(p_swref));
            begin
                insert into sw_stmt_errs (stmt_swref, stmt_ptime, stmt_errmsg)
                values (p_swref, sysdate, p_errmsg);
                bars_audit.trace('%s: error added for stmt %s', p, to_char(p_swref));
            exception
                when DUP_VAL_ON_INDEX then
                    update sw_stmt_errs
                       set stmt_ptime  = sysdate,
                           stmt_errmsg = p_errmsg
                     where stmt_swref = p_swref;
                    bars_audit.trace('%s: error changed for stmt %s', p, to_char(p_swref));
            end;

        else
            bars_error.raise_nerror(MODCODE, 'INVALID_PARSEERROR_MODE', to_char(p_mode));
        end if;

        bars_audit.trace('%s: succ end.');
    end istmt_parse_error;



     ----------------------------------------------------------------
     -- ISTMT_CREATE_INFDOC()
     --
     --      Процедура создания информационного документа для
     --      отправки в филиал (по исходному документу и сообщению)
     --
     --      Параметры:
     --
     --          p_swRef        Референс сообщения
     --
     --          p_srcRec       Референс исх. документа
     --
     procedure istmt_create_infdoc(
                   p_swRef  in  sw_journal.swref%type,
                   p_srcRef in  oper.ref%type          )
     is

     l_ref       oper.ref%type;            /*  референс созданного документа */
     l_tt        oper.tt%type;             /*  тип операция  (инф. документ) */
     l_vob       oper.vob%type;            /*  вид документа (инф. документ) */

     l_mt        sw_journal.mt%type;       /*                  тип сообщения */
     l_sender    sw_journal.sender%type;   /*            BIC-код отправителя */
     l_receiver  sw_journal.receiver%type; /*             BIC-код получателя */

     l_vdat      oper.vdat%type;           /*       реквизиты исх. документа */
     l_kv        oper.kv%type;
     l_amnt      oper.s%type;
     l_nama      oper.nam_a%type;
     l_nlsa      oper.nlsa%type;
     l_mfoa      oper.mfoa%type;
     l_namb      oper.nam_b%type;
     l_nlsb      oper.nlsb%type;
     l_desc      oper.nazn%type;
     l_ida       oper.id_a%type;
     l_idb       oper.id_b%type;
     l_refa      oper.ref_a%type;


     begin

         bars_audit.trace('swt.stmcrinfdoc: entry point par[0]=>%s par[1]=>%s', to_char(p_swRef), to_char(p_srcRef));

         --
         -- Получаем тип операции и вид документа
         --
         l_tt  := substr(get_param_value('SWTSTMTT'), 1, 3);
         l_vob := nvl(to_number(get_param_value('SWTSTMVB')), 1);

         --
         -- Получаем реквизиты заголовка сообщения
         --
         select mt, sender, receiver
           into l_mt, l_sender, l_receiver
           from sw_journal
          where swref = p_swRef;

         --
         -- Получаем реквизиты исх. документа
         --
         select vdat, kv, s, nam_a, nlsa, mfoa, nam_b, nlsb, nazn, id_a, id_b, ref_a
           into l_vdat, l_kv, l_amnt, l_nama, l_nlsa, l_mfoa, l_namb, l_nlsb, l_desc, l_ida, l_idb, l_refa
           from oper
          where ref = p_srcRef;

         --
         -- Получаем референс документа
         --
         gl.ref (l_ref);

         gl.in_doc3(
               ref_    =>  l_ref,
               tt_     =>  l_tt,
               vob_    =>  l_vob,
               nd_     =>  substr(to_char(l_ref), 1, 10),
               pdat_   =>  sysdate,
               vdat_   =>  l_vdat,
               dk_     =>  2,
               kv_     =>  l_kv,
               s_      =>  l_amnt,
               kv2_    =>  l_kv,
               s2_     =>  l_amnt,
               sk_     =>  null,
               data_   =>  trunc(sysdate),
               datp_   =>  trunc(sysdate),
               nam_a_  =>  l_namb,
               nlsa_   =>  l_nlsb,
               mfoa_   =>  gl.aMFO,
               nam_b_  =>  l_nama,
               nlsb_   =>  l_nlsa,
               mfob_   =>  l_mfoa,
               nazn_   =>  l_desc,
               d_rec_  =>  '#fMT' || to_char(l_mt),
               id_a_   =>  l_idb,
               id_b_   =>  l_ida,
               id_o_   =>  null,
               sign_   =>  null,
               sos_    =>  0,
               prty_   =>  0);


         --
         -- Заполняем доп. реквизиты из заголовка сообщения
         --

         insert into operw (ref, tag, value) values (l_ref, 'SWSND', l_sender);
         insert into operw (ref, tag, value) values (l_ref, 'SWRCV', l_receiver);
         insert into operw (ref, tag, value) values (l_ref, 'f', 'MT '|| to_char(l_mt));

         insert into operw (ref, tag, value) values (l_ref, 'SWREF', l_refa);

         --
         -- Вставляем доп.реквизиты из сообщения в документ
         --
         impmsg_document_storetag(l_ref, p_swRef, null);

         bars_audit.trace('swt.stmcrinfdoc: created document ref=%s', to_char(l_ref));

         bars_audit.trace('swt.stmcrinfdoc: succ end');

     end istmt_create_infdoc;


     ----------------------------------------------------------------
     -- STMT_GEN_INFDOC()
     --
     --      Функция формирования информационных документов для
     --      филиалов (уведомлений по проведенным платежам)
     --
     --      Параметры:
     --
     --          p_stmtRef        Референс выписки
     --
     --      Функция возвращает количество сформированных документов
     --
     function stmt_gen_infdoc(
                   p_stmtRef  in  sw_950.swref%type ) return number
     is

     l_ourBic   sw_banks.bic%type;  /*                        наш BIC-код */

     l_srcRef   oper.ref%type;      /*            референс исх. документа */
     l_srcMfo   oper.mfoa%type;     /* код МФО отправителя исх. документа */
     l_nosRef   oper.ref%type;      /*             референс документа NOS */

     l_doccnt   number;             /*   кол-во сформированных документов */

     begin

         bars_audit.trace('swt.stmgeninfdoc: entry point par[0]=>%s', to_char(p_stmtRef));

         l_ourBic := get_ourbank_bic;
         l_doccnt := 0;
         bars_audit.trace('swt.stmgeninfdoc: our BIC is %s', l_ourBic);

         --
         -- Проходим по всем строкам выписки, кот. удовл. условиям:
         --
         --   - к строке выписки привязано исх. сообщение
         --   - отправитель сообщения - наш BIC
         --
         for c in (select j.swref
                     from sw_950d s, sw_journal j
                    where s.swref       = p_stmtRef
                      and s.src_swref is not null
                      and s.checked_ind = 'Y'
                      and s.src_swref   = j.swref
                      and j.sender      = l_ourBic   )
         loop

             bars_audit.trace('swt.stmgeninfdoc: trying message swref=%s...', to_char(c.swref));

             --
             -- Получаем реквизиты исходного документа
             --
             -- SWT --SW_OPER-- DOC<NOS> ---OPER.REFL--- DOC<SRC>
             --

             begin

                 select o.ref, o.mfoa, l.ref
                   into l_srcRef, l_srcMfo, l_nosRef
                   from oper o, sw_oper l
                  where l.swref = c.swref
                    and o.refl  = l.ref
                    and exists (select 1
                                  from v_uchrrp_ext
                                 where mfo != gl.kf
                                   and mfo  = o.mfoa
                                   and kodn = 6     );

                 bars_audit.trace('swt.stmgeninfdoc: srcref=%s, srcmfo=%s, nosref=%s', to_char(l_srcRef), l_srcMfo, to_char(l_nosRef));

                 --
                 -- Создаем по исх. документу информационный
                 --
                 istmt_create_infdoc(c.swref, l_srcRef);
                 l_doccnt := l_doccnt + 1;

             exception
                 when NO_DATA_FOUND then bars_audit.trace('swt.stmgeninfdoc: no rel doc found.');
                 when TOO_MANY_ROWS then bars_audit.trace('swt.stmgeninfdoc: many rel doc found!');
             end;

             bars_audit.trace('swt.stmgeninfdoc: message swref=%s processed.', to_char(c.swref));

         end loop;

         bars_audit.trace('swt.stmgeninfdoc: succ end.');

         return l_doccnt;

     end stmt_gen_infdoc;


     ----------------------------------------------------------------
     -- STMT_GEN_INFDOC2()
     --
     --      Процедура формирования информационных документов для
     --      филиалов (уведомлений по проведенным платежам)
     --
     --      Параметры:
     --
     --          p_stmtRef        Референс выписки
     --
     --          p_docCnt         Кол-во сформир. документов
     --
     procedure stmt_gen_infdoc2(
                   p_stmtRef  in  sw_950.swref%type,
                   p_docCnt   out number             )
     is
     begin
         p_doccnt := stmt_gen_infdoc(p_stmtRef);
     end stmt_gen_infdoc2;



     ----------------------------------------------------------------
     -- GET_INFDOC_BIS2REC()
     --
     --     Получение массива записей из БИС инф. документа
     --
     --      Параметры:
     --
     --          p_rec     Ид. строки первой записи
     --
     --
     --
     function get_infdoc_bis2rec(
                  p_rec  in  arc_rrp.rec%type ) return t_sw_dtmtab
     pipelined
     is
     p         constant varchar2(100) := 'swt.getinfdb2r';
     l_buf     varchar2(250);
     l_pos     number;
     l_spos    number;
     l_rec     t_sw_dtmrec    := t_sw_dtmrec(null, null);
     l_tag     char(5)        := null;
     l_value   varchar2(1024) := null;
     begin
         for c in (select nazn, d_rec
                     from arc_rrp
                    where bis > 1
                      and rec in (select rec
                                    from rec_que
                                   where rec_g = p_rec
                                     and rec_g is not null)
                   order by bis)
         loop
             l_buf := rtrim(ltrim(c.nazn||c.d_rec));

             loop

                 l_pos := nvl(instr(l_buf, '#F'), 0);
                 exit when (l_pos <= 0);

                 l_buf := substr(l_buf, l_pos + 2);
                 l_pos := instr(l_buf, '#');

                 if (l_pos > 0) then
                     l_spos  := instr(l_buf, ':');
                     l_tag   := ltrim(rtrim(substr(l_buf, 1, l_spos - 1)));
                     l_value := ltrim(rtrim(substr(l_buf, l_spos + 1, l_pos - l_spos - 1)));
                 end if;

                 if (l_tag is not null) then

                     if    (l_rec.dtmtag is null) then
                         l_rec.dtmtag := l_tag;
                         l_rec.value  := l_value;
                     elsif (l_rec.dtmtag = l_tag) then
                         l_rec.value := l_rec.value || CRLF || l_value;
                     else
                         pipe row (l_rec);
                         l_rec.dtmtag := l_tag;
                         l_rec.value  := l_value;
                     end if;

                     l_tag   := null;
                     l_value := null;

                 end if;
             end loop;
         end loop;

         if (l_rec.dtmtag is not null) then
             pipe row (l_rec);
         end if;

         return;

     end get_infdoc_bis2rec;


     ----------------------------------------------------------------
     -- STMT_PROCESS_REGINFDOC()
     --
     --      Регистрация инф. документа в очереди для обработки
     --      в филиале и формирование текст сообщения SWIFT
     --
     --      Параметры:
     --
     --          p_rec        Ид. записи
     --
     --
     --
     procedure stmt_process_reginfdoc(
                   p_rec  in  arc_rrp.rec%type )
     is
     begin

         --
         -- Сохраняем реф. в очереди
         --
         g_curinfrec := p_rec;
         --
     end stmt_process_reginfdoc;


     ----------------------------------------------------------------
     -- STMT_PROCESS_INFDOC()
     --
     --      Процедура обработки входящих информационных документов
     --      в филиале и формирование текст сообщения SWIFT
     --
     --
     --
     procedure stmt_process_infdoc(
                   p_rec  in  arc_rrp.rec%type )
     is

     l_ourBic   sw_banks.bic%type;  /*                        наш BIC-код */

     l_srcRef   oper.ref%type;      /*            референс исх. документа */
     l_srcMfo   oper.mfoa%type;     /* код МФО отправителя исх. документа */
     l_nosRef   oper.ref%type;      /*             референс документа NOS */
     l_refa     oper.ref%type;      /*           Реф. исходного документа */


     l_dk       arc_rrp.dk%type;
     l_mfoa     arc_rrp.mfoa%type;
     l_mfob     arc_rrp.mfob%type;
     l_addinf   arc_rrp.d_rec%type;

     l_result   number;
     l_swref    sw_journal.swref%type;
     l_mt       sw_journal.mt%type;
     l_trn      sw_journal.trn%type;
     l_sender   sw_journal.sender%type;
     l_receiver sw_journal.receiver%type;
     l_curr     sw_journal.currency%type;
     l_amount   sw_journal.amount%type;

     l_recno    number;
     l_rec      arc_rrp.rec%type;
            l_guid varchar2(36);


     begin
         bars_audit.trace('swt.stmprcinfdoc: entry point par[0]=>%s', to_char(g_curinfrec));

         l_rec       := g_curinfrec;
         g_curinfrec := null;

         if (l_rec is null) then
             bars_audit.trace('swt.stmprcinfdoc: rec=null, exit');
             return;
         end if;

         select a.dk, a.mfoa, a.mfob, a.s, a.d_rec, t.lcv
           into l_dk, l_mfoa, l_mfob, l_amount, l_addinf, l_curr
           from arc_rrp a, tabval t
          where a.rec = l_rec
            and a.kv  = t.kv;


         --
         -- Выполняем проверку документа:
         --   - информационные дебет
         --   - МФО(А) != МФО(Б)
         --   - МФО(Б) равен нашему
         --
         if (l_dk != 2 or l_mfob != gl.kf or l_mfob = l_mfoa) then
             bars_audit.trace('swt.stmprcinfdoc: infdoc verify failed, skip');
             return;
         else
             bars_audit.trace('swt.stmprcinfdoc: infdoc verify succ');
         end if;

         -- Получаем реквизиты
         for c in (select dtmtag, value
                     from table(bars_swift.get_infdoc_bis2rec(l_rec))
                    where dtmtag in ('SWREF', 'SWSND', 'SWRCV', '20   '))
         loop
             case
                 when (c.dtmtag = 'SWREF') then l_refa     := to_number(c.value);
                 when (c.dtmtag = 'SWSND') then l_sender   := c.value;
                 when (c.dtmtag = 'SWRCV') then l_receiver := c.value;
                 when (c.dtmtag = '20   ') then l_trn      := c.value;
             end case;
         end loop;

         bars_audit.trace('swt.stmprcinfdoc: swref=%s swsnd=%s swrcv=%s trn=%s',
                                   to_char(l_refa), l_sender, l_receiver, l_trn );

         -- Ищем исх. документ
         begin
             select ref into l_refa
               from oper
              where ref = l_refa;
             bars_audit.trace('swt.stmprcinfdoc: infdoc src ref=%s found.', to_char(l_refa));
         exception
             when NO_DATA_FOUND then
                 bars_audit.trace('swt.stmprcinfdoc: infdoc src ref not found, skip document');
                 return;
         end;

         -- Получаем тип сообщения
         l_mt := to_number(substr(l_addinf, instr(l_addinf, '#f')+4,3));
         bars_audit.trace('swt.stmprcinfdoc: mt=%s', to_char(l_mt));


         l_guid :=bars_swift.generate_uetr;
         -- Создаем заголовок сообщения SWIFT
         in_swjournal(
             ret_      => l_result,
             swref_    => l_swref,
             mt_       => l_mt,
             mid_      => l_trn,
             page_     => null,
             io_       => 'I',
             sender_   => l_sender,
             receiver_ => l_receiver,
             transit_  => null,
             payer_    => null,
             payee_    => null,
             ccy_      => l_curr,
             amount_   => l_amount,
             accd_     => null,
             acck_     => null,
             vdat_     => null,
             idat_     => to_char(sysdate, 'YYYY-MM-DD HH24:MI'),
             sti_      =>'001',
             uetr_     =>lower(l_guid));

         bars_audit.trace('swt.stmprcinfdoc: message header swref=%s created.', to_char(l_swref));

         l_recno := 1;
         --
         -- По доп. реквизитам создаем тело сообщения
         --
         for c in (select md.num, md.seq, md.tag, md.opt, w.value
                     from (select m.num, m.seq, m.tag, m.opt,  rpad(m.dtmtag, 5, ' ') dtmtag
                             from sw_model m
                            where mt = l_mt
                              and (opt != 'a' or opt is null)
                           union all
                           select m.num, m.seq, m.tag, decode(o.opt, '-', null, o.opt),
                                  rpad(substr(m.dtmtag, 1, 2) || decode(o.opt, '-', null, o.opt), 5, ' ') dtmtag
                             from sw_model m, sw_model_opt o
                            where m.mt = l_mt
                              and m.opt = 'a'
                              and m.mt  = o.mt
                              and m.num = o.num) md,
                          (select dtmtag, value
                             from table(bars_swift.get_infdoc_bis2rec(l_rec))) w
                    where w.dtmtag = md.dtmtag
                   order by md.num                )
         loop
             In_SwOperW(l_swref, c.tag, c.seq, l_recno, c.opt, c.value);
             l_recno := l_recno + 1;
         end loop;

         bars_audit.trace('swt.stmprcinfdoc: message swref=%s created.', to_char(l_swref));


         --
         -- Создаем связку документа и сообщения
         --
         delete from sw_oper
          where ref = l_refa;

         insert into sw_oper (ref, swref)
         values (l_refa, l_swref);

         delete from tzapros
          where rec = l_rec;

         bars_audit.trace('swt.stmprcinfdoc: src doc ref=%s and message swref=%s linked.', to_char(l_refa), to_char(l_swref));
         bars_audit.trace('swt.stmprcinfdoc: succ end');

     end stmt_process_infdoc;




    -----------------------------------------------------------------
    -- STMT_GET_STATE()
    --
    --     Функция возвращает состояние выписки.  Возможно  два
    --     состояние выписки: "Выписка обработана" и   "Выписка
    --     не обработана" (1 или 0 соответственно).
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --
    function stmt_get_state(
                 p_stmtRef  in  sw_950.swref%type) return number
    is

    l_stmtState  sw_950.done%type;      /* состояние выписки */

    begin

        bars_audit.trace('Looking for state of statement SwRef=%s...', to_char(p_stmtRef));

        select nvl(done, 0) into l_stmtState
          from sw_950
         where swref = p_stmtRef;

        bars_audit.trace('Statement SwRef=%s state is %s', to_char(p_stmtRef), to_char(l_stmtState));

        return l_stmtState;

    exception
        when NO_DATA_FOUND then
            bars_audit.error('Выписка с реф. SwRef=' || to_char(p_stmtRef) || ' не найдена.');
            raise_application_error(-20781, '\308 Выписка с реф. SwRef=' || to_char(p_stmtRef) || ' не найдена');
    end stmt_get_state;


    -----------------------------------------------------------------
    -- STMT_SET_STATE()
    --
    --     Процедура устанавливает состояние выписки.    Возможно
    --     два состояние выписки: "Выписка обработана" и "Выписка
    --     не обработана". В обработанной выписке каждая из строк
    --     должна иметь ссылку на документ,   который  отображает
    --     транзакцию по корсчету
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtState      Новое состояние выписки
    --
    procedure stmt_set_state(
                  p_stmtRef   in  sw_950.swref%type,
                  p_stmtState in  sw_950.done%type  )
    is
    begin
        stmt_set_state2(p_stmtRef, p_stmtState, 0);
    end stmt_set_state;


    -----------------------------------------------------------------
    -- STMT_SET_STATE2()
    --
    --     Расширенная процедура установки состояния выписки.
    --     Работа процедуры аналогична процедуре  STMT_SET_STATE()
    --     с возможностью отключения проверки на полноту обработки
    --     строк выписки
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtState      Новое состояние выписки
    --
    --          p_stmtFlag       Признак принудительной установки
    --
    procedure stmt_set_state2(
                 p_stmtRef   in  sw_950.swref%type,
                 p_stmtState in  sw_950.done%type,
                 p_stmtFlag  in  number  default 0  )
    is

    l_stmtState  sw_950.done%type;      /* состояние выписки */
    l_cnt        number;                /*           счетчик */
    l_infdocc    number;                /* кол-во сформ. док.*/

    begin

        bars_audit.trace('Trying to set state %s for statement SwRef=%s ...', to_char(p_stmtState), to_char(p_stmtRef));

        if (p_stmtState not in (0, 1) or p_stmtState is null) then
            raise_application_error(-20781, '\309 Неизвестное состояние ' || to_char(l_stmtState) || ' выписки');
        end if;

        -- savepoint sp_beforeLockStmt;

        --
        -- Блокируем выписку (разобранную и журнал)
        --
        select nvl(done, 0) into l_stmtState
          from sw_950
         where swref = p_stmtRef
        for update nowait;

        select 1 into l_cnt
          from sw_journal
         where swref = p_stmtRef
        for update nowait;


        bars_audit.trace('Current state of statement SwRef=%s is %s', to_char(p_stmtRef), to_char(l_stmtState));

        if (p_stmtState = 0) then

            update sw_950
               set done = null
             where swref = p_stmtRef;

            update sw_journal
               set date_pay = null
             where swref = p_stmtRef;

        else

            bars_audit.trace('Looking for unprocessed statement rows...');

            if (p_stmtFlag != 1) then

                -- Проверяем привязку документов к строкам выписки
                select count(*) into l_cnt
                  from sw_950d
                 where swref = p_stmtRef
                   and (checked_ind is null or checked_ind != 'Y');

                if (l_cnt != 0) then
                    -- rollback to sp_beforeLockStmt;
                    bars_audit.error('В выписке SwRef=' || to_char(p_stmtRef) || ' найдены необработанные строки');
                    raise_application_error(-20781, '\310 В выписке SwRef=' || to_char(p_stmtRef) || ' найдены необработанные строки');
                end if;

            end if;

            update sw_950
               set done = 1
             where swref = p_stmtRef;

            -- После перевода состояния выписки нужно
            -- проставить ей дату оплаты в журнале
            update sw_journal
               set date_pay = sysdate
             where swref = p_stmtRef;

            --
            -- Выполняем отсылку инф. документов филиалам
            --
            if (get_param_value(MODPAR_STMINFDOC) = MODPAR_STMINFDOC_TRUE) then

                bars_audit.trace('Statement info to branches...');
                l_infdocc := stmt_gen_infdoc(p_stmtRef);
                bars_audit.trace('Statement info to branches completed.');

            else
                bars_audit.trace('Statement info to branches skipped by configuration settings.');
            end if;

        end if;

        bars_audit.trace('State of statement SwRef=%s changed to %s.', to_char(p_stmtRef), to_char(p_stmtState));

    end stmt_set_state2;


    -----------------------------------------------------------------
    -- STMT_SET_NOSTROACC()
    --
    --     Процедура устанавливает счет выписки. Данная процедура
    --     используется в том случае, когда счет выписки  не  был
    --     установлен в момент ее приема и разбора.
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtNosAcc     Идентификатор счета
    --
    procedure stmt_set_nostroacc(
                  p_stmtRef    in  sw_950.swref%type,
                  p_stmtNosAcc in  sw_950.nostro_acc%type  )
    is

    l_swRef     sw_950.swref%type;  /* референс выписки */
    begin

        bars_audit.trace('Trying to set nostro account=%s to statement SwRef=%s...', to_char(p_stmtNosAcc), to_char(p_stmtRef));

        select swref into l_swRef
          from sw_950
         where swref = p_stmtRef
           and nostro_acc is null
        for update nowait;

        update sw_950
           set nostro_acc = p_stmtNosAcc
         where swref = p_stmtRef;

        bars_audit.trace('Nostro account is set.');
        bars_audit.info('Установлен счет выписки (Ид. счета= ' || to_char(p_stmtNosAcc) || ' Ид. выписки=' || to_char(p_stmtRef) || ')');

    end stmt_set_nostroacc;


























    -----------------------------------------------------------------
    -- STMT_SRCMSG_GETRELMSG()
    --
    --     Процедура получения референса и типа начального сообщения
    --     по цепочке связанных сообщения для строки выписки
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtRow        Номер строки выписки
    --
    --          p_msgSwRef       Референс сообщения (выходной)
    --
    --          p_msgMt          Тип сообщения      (выходной)
    --
    --
    procedure stmt_srcmsg_getrelmsg(
                  p_stmtRef  in  sw_950.swref%type,
                  p_stmtRow  in  sw_950d.n%type,
                  p_msgSwRef out sw_journal.swref%type,
                  p_msgMt    out sw_journal.mt%type     )
    is

    l_swRef  sw_950d.src_swref%type;  /* реф. прикрепленного сообщения к выписке */

    begin

        bars_audit.trace('Trying to get related message for statement SwRef=%s row=%s...', to_char(p_stmtRef), to_char(p_stmtRow));

        select src_swref into l_swRef
          from sw_950d
         where swref = p_stmtRef
           and n     = p_stmtRow;

        bars_audit.trace('Statement row source message SwRef=%s', to_char(l_swRef));

        if (l_swRef is null) then
            bars_audit.trace('Source message is empty, return statement as message, message type is 950.');
            p_msgSwRef := p_stmtRef;
            p_msgMt    := 950;
        else
            bars_audit.trace('Trying to get related message for message SwRef=%s...', to_char(l_swRef));
            impmsg_message_getrelmsg(l_swRef, p_msgSwRef, p_msgMt);
            bars_audit.trace('Related message is SwRef=%s, message type is %s', to_char(p_msgSwRef), to_char(p_msgMt));
        end if;

        bars_audit.trace('Related message procedure successfully completed.');

    end stmt_srcmsg_getrelmsg;


    -----------------------------------------------------------------
    -- MSGI_GET_MT()
    --
    --     Функция получения тип сообщения. Если сообщения референсом
    --     указанным в вызове нет, то будет сгенерирована ошибка
    --
    --
    --      Параметры:
    --
    --          p_SwRef        Референс сообщения
    --
    --
    function msgi_get_mt(
                  p_swRef     in  sw_journal.swref%type ) return sw_mt.mt%type
    is

    l_mt   sw_mt.mt%type;   /* Тип сообщения */

    begin

        select mt   into l_mt
          from sw_journal
         where swref = p_swRef;

        return l_mt;

    end msgi_get_mt;





    -----------------------------------------------------------------
    -- IMPMSGI_DOCUMENT_LINK()
    --
    --     Процедура привязки документа к импортированному сообщению
    --     Привязываемый документ не должен быть привязан  к  такому
    --     же типу сообщения (кроме выписок).
    --
    --
    --
    --
    --      Параметры:
    --
    --          p_listref      Список документов для привязки
    --
    --          p_SwRef        Референс сообщения
    --
    --
    --
    procedure impmsgi_document_link(
                  p_listref   in  t_listref,
                  p_swRef     in  sw_journal.swref%type )
    is

    type         t_listref is table of number;

    l_listref    t_listref;                /* Список привязанных документов */

    l_mt         sw_mt.mt%type;            /*                Тип сообщения */
    l_stmtRef    sw_950.swref%type;        /*             Референс выписки */

    l_msgPayDate sw_journal.date_pay%type; /*        Дата оплаты сообщения */
    l_msgValueDate sw_journal.vdate%type;  /* Дата валютирования сообщения */
    l_docValueDate oper.vdat%type;         /* Дата валютирования документа */
    l_cnt        number;                   /*                      счетчик */

    l_docDateMni   number;                 /* Отклонения даты вал. документа (минус) */
    l_docDateMax   number;                 /* Отклонения даты вал. документа (плюс)  */
    l_docexists    boolean;                /* Признак одинаковых списоков документов */


    begin

        bars_audit.trace('Linking document Ref=%s with message SwRef=%s ...', '<list>', to_char(p_swRef));

        -- Получаем тип сообщения к которому привязываем документ
        l_mt := msgi_get_mt(p_swRef);

        --
        -- Получаем дату валютирования документа
        --
        select vdat  into l_docValueDate
          from oper
         where ref = p_listref(1);

        bars_audit.trace('Document value date is %s', to_char(l_docValueDate, 'dd.mm.yyyy'));

        --
        -- Блокируем сообщение
        --
        savepoint sp_beforeLockMsg;

        select vdate, date_pay into l_msgValueDate, l_msgPayDate
          from sw_journal
         where swref = p_swRef
        for update nowait;

        bars_audit.trace('Message value date is %s', to_char(l_msgValueDate, 'dd.mm.yyyy'));
        bars_audit.trace('Message pay date is %s', to_char(l_msgPayDate, 'dd.mm.yyyy'));


        if (l_msgPayDate is not null) then

            -- Проверяем совпадает ли список документов
            select ref bulk collect into l_listref
              from sw_oper
             where swref = p_swref
               and swrnum is null;

            l_docexists := true;
            if (l_listref.count = p_listref.count) then

                for i in 1..p_listref.count
                loop
                    l_docexists := false;
                    for j in 1..l_listref.count
                    loop
                        if (l_listref(j) = p_listref(i)) then l_docexists := true;
                        end if;
                    end loop;
                    if (not l_docexists) then
                        rollback to sp_beforeLockMsg;
                        bars_audit.error('Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
                        raise_application_error(-20781, '\319 Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
                    end if;
                end loop;
            else
                rollback to sp_beforeLockMsg;
                bars_audit.error('Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
                raise_application_error(-20781, '\319 Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
            end if;

            return;

        end if;

        --
        -- Получаем минимальное и максимальное отклонения даты валютирования
        -- документа от даты валютирования сообщения
        --
        l_docDateMni := nvl(to_number(get_param_value(MODPAR_DOCVDTMNI)), MODPAR_DOCVDTMNI_DEFAULT);
        l_docDateMax := nvl(to_number(get_param_value(MODPAR_DOCVDTMAX)), MODPAR_DOCVDTMAX_DEFAULT);

        bars_audit.trace('Document value date diff is -%s to +%s.', to_char(l_docDateMni), to_char(l_docDateMax));

        if (l_msgValueDate not between l_docValueDate - l_docDateMni and l_docValueDate + l_docDateMax) then
            rollback to sp_beforeLockMsg;
            bars_audit.error('Дата валютирования документа меньше даты валютирования сообщения');
            raise_application_error(-20781, '\313 Дата валютирования сообщения '||to_char(l_msgValueDate, 'dd.mm.yyyy')||' не попадает в диапазон дат '||to_char(l_docValueDate - l_docDateMni, 'dd.mm.yyyy')||' і '||to_char(l_docValueDate + l_docDateMax, 'dd.mm.yyyy'));
        end if;

        forall i in 1..p_listref.count
            insert into sw_oper (ref, swref) values (p_listref(i), p_swRef);
        bars_audit.trace('Document linked with message.');

        if (l_msgPayDate is null) then

            update sw_journal
               set date_pay = sysdate
             where swref = p_swRef;

            bars_audit.trace('Message pay date is set now.');

        end if;

/*
        bars_audit.trace('Looking for statements with this source message ...');
        for i in (select *
                    from sw_950d
                   where src_swref =  p_swRef
                     and vdate     >= l_msgValueDate)
        loop
            --stmti_document_link(i.swref, i.n, t_listref(p_docRef));
            null;
        end loop;
*/

        bars_audit.trace('Statement(s) with this source message processed.');
        bars_audit.trace('Document Ref=%s successfully linked with message SwRef=%s.', '<list>', to_char(p_swRef));

    end impmsgi_document_link;


    -----------------------------------------------------------------
    -- IMPMSGI_DOCUMENT_LINK()
    --
    --     Процедура привязки документа к импортированному сообщению
    --     Привязываемый документ не должен быть привязан  к  такому
    --     же типу сообщения (кроме выписок).
    --
    --
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_SwRef        Референс сообщения
    --
    --
    --
    procedure impmsgi_document_link(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type )
    is
    type         t_listref is table of number;

    l_listref    t_listref;                /* Список документов */

    l_mt         sw_mt.mt%type;            /*                Тип сообщения */
    l_stmtRef    sw_950.swref%type;        /*             Референс выписки */

    l_msgPayDate sw_journal.date_pay%type; /*        Дата оплаты сообщения */
    l_msgValueDate sw_journal.vdate%type;  /* Дата валютирования сообщения */
    l_docValueDate oper.vdat%type;         /* Дата валютирования документа */
    l_cnt        number;                   /*                      счетчик */

    l_docDateMni   number;                 /* Отклонения даты вал. документа (минус) */
    l_docDateMax   number;                 /* Отклонения даты вал. документа (плюс)  */
    l_docexists    boolean;

    begin

        bars_audit.trace('Linking document Ref=%s with message SwRef=%s ...', to_char(p_docRef), to_char(p_swRef));

        -- Получаем тип сообщения к которому привязываем документ
        l_mt := msgi_get_mt(p_swRef);

        --
        -- Проверяем привязку на дубликат по типу сообщения
        --
        -- dg (04/05/2006): отключил по просьбе Сбербанка
        --
        -- select count(*) into l_cnt
        --   from sw_oper o, sw_journal j
        --  where o.ref   = p_docRef
        --    and o.swref = j.swref
        --    and j.mt    = l_mt;
        --
        -- if (l_cnt != 0) then
        --     bars_audit.error('Документ Ref=' || to_char(p_docRef) || ' уже привязан к другому сообщению данного типа');
        --     raise_application_error(-20781, '\311 Документ уже привязан к другому сообщению данного типа');
        -- end if;
        --
        -- bars_audit.trace('Check to duplicate link (on message type) passed.');
        --

        --
        -- DG (11/08/2006): удалил проверку из-за того, что при формировании МТ202 оно
        --                  проходит по двум корсчетам и соответственно попадает в две
        --                  выписки, а сообщение отображается как один документ
        --
        -- Проверяем отсутствие привязки документа к выписке
        --
        -- begin
        --     select o.swref   into l_stmtRef
        --       from sw_oper o, sw_journal j
        --      where o.ref   = p_docRef
        --        and o.swref = j.swref
        --        and j.mt in (select mt from sw_stmt)
        --        and rownum <= 1;
        --
        --     bars_audit.error('Документ Ref=' || to_char(p_docRef) || ' привязан к выписке SwRef=' || to_char(l_stmtRef));
        --     raise_application_error(-20781, '\312 Документ Ref=' || to_char(p_docRef) || ' привязан к выписке SwRef=' || to_char(l_stmtRef));
        --
        -- exception
        --     when NO_DATA_FOUND then
        --         bars_audit.trace('Check to statement link passed.');
        -- end;

        --
        -- Получаем дату валютирования документа
        --
        select vdat  into l_docValueDate
          from oper
         where ref = p_docRef;

        bars_audit.trace('Document value date is %s', to_char(l_docValueDate, 'dd.mm.yyyy'));

        --
        -- Блокируем сообщение
        --
        savepoint sp_beforeLockMsg;

        select vdate, date_pay into l_msgValueDate, l_msgPayDate
          from sw_journal
         where swref = p_swRef
        for update nowait;

        bars_audit.trace('Message value date is %s', to_char(l_msgValueDate, 'dd.mm.yyyy'));
        bars_audit.trace('Message pay date is %s', to_char(l_msgPayDate, 'dd.mm.yyyy'));

        if (l_msgPayDate is not null) then

            -- Проверяем совпадает ли список документов
            select ref bulk collect into l_listref
              from sw_oper
             where swref = p_swref
               and swrnum is null;

            if (l_listref.count != 1) then
                rollback to sp_beforeLockMsg;
                bars_audit.error('Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
                raise_application_error(-20781, '\319 Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
            end if;

            if (l_listref(1) != p_docref) then
                rollback to sp_beforeLockMsg;
                bars_audit.error('Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
                raise_application_error(-20781, '\319 Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
            end if;

            return;

        end if;

        --
        -- Получаем минимальное и максимальное отклонения даты валютирования
        -- документа от даты валютирования сообщения
        --
        l_docDateMni := nvl(to_number(get_param_value(MODPAR_DOCVDTMNI)), MODPAR_DOCVDTMNI_DEFAULT);
        l_docDateMax := nvl(to_number(get_param_value(MODPAR_DOCVDTMAX)), MODPAR_DOCVDTMAX_DEFAULT);

        bars_audit.trace('Document value date diff is -%s to +%s.', to_char(l_docDateMni), to_char(l_docDateMax));

        if (l_msgValueDate not between l_docValueDate - l_docDateMni and l_docValueDate + l_docDateMax) then
            rollback to sp_beforeLockMsg;
            bars_audit.error('Дата валютирования документа меньше даты валютирования сообщения');
            raise_application_error(-20781, '\313 Дата валютирования сообщения '||to_char(l_msgValueDate, 'dd.mm.yyyy')||' не попадает в диапазон дат '||to_char(l_docValueDate - l_docDateMni, 'dd.mm.yyyy')||' і '||to_char(l_docValueDate + l_docDateMax, 'dd.mm.yyyy'));
        end if;

        insert into sw_oper (ref, swref) values (p_docRef, p_swRef);
        bars_audit.trace('Document linked with message.');


        if (l_msgPayDate is null) then

            update sw_journal
               set date_pay = sysdate
             where swref = p_swRef;

            bars_audit.trace('Message pay date is set now.');

        end if;

/*
        bars_audit.trace('Looking for statements with this source message ...');
        for i in (select *
                    from sw_950d
                   where src_swref =  p_swRef
                     and vdate     >= l_msgValueDate)
        loop
            --stmti_document_link(i.swref, i.n, t_listref(p_docRef));
            null;
        end loop;
*/

        bars_audit.trace('Statement(s) with this source message processed.');
        bars_audit.trace('Document Ref=%s successfully linked with message SwRef=%s.', to_char(p_docRef), to_char(p_swRef));

    end impmsgi_document_link;


    -----------------------------------------------------------------
    -- IMPMSGI_DOCUMENT_LINK_ALL()
    --
    --     Процедура привязки документа к импортированному сообщению
    --     Привязываемый документ не должен быть привязан  к  такому
    --     же типу сообщения (кроме выписок).
    --
    --
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_SwRef        Референс сообщения
    --
    --
    --
    procedure impmsgi_document_link_all(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type )
    is
    type         t_listref is table of number;

    l_listref    t_listref;                /* Список документов */

    l_mt         sw_mt.mt%type;            /*                Тип сообщения */
    l_stmtRef    sw_950.swref%type;        /*             Референс выписки */

    l_msgPayDate sw_journal.date_pay%type; /*        Дата оплаты сообщения */
    l_msgValueDate sw_journal.vdate%type;  /* Дата валютирования сообщения */
    l_docValueDate oper.vdat%type;         /* Дата валютирования документа */
    l_cnt        number;                   /*                      счетчик */

    l_docDateMni   number;                 /* Отклонения даты вал. документа (минус) */
    l_docDateMax   number;                 /* Отклонения даты вал. документа (плюс)  */
    l_docexists    boolean;

    begin

        bars_audit.trace('Linking document Ref=%s with message SwRef=%s ...', to_char(p_docRef), to_char(p_swRef));

        -- Получаем тип сообщения к которому привязываем документ
        l_mt := msgi_get_mt(p_swRef);

        --
        -- Проверяем привязку на дубликат по типу сообщения
        --
        -- dg (04/05/2006): отключил по просьбе Сбербанка
        --
        -- select count(*) into l_cnt
        --   from sw_oper o, sw_journal j
        --  where o.ref   = p_docRef
        --    and o.swref = j.swref
        --    and j.mt    = l_mt;
        --
        -- if (l_cnt != 0) then
        --     bars_audit.error('Документ Ref=' || to_char(p_docRef) || ' уже привязан к другому сообщению данного типа');
        --     raise_application_error(-20781, '\311 Документ уже привязан к другому сообщению данного типа');
        -- end if;
        --
        -- bars_audit.trace('Check to duplicate link (on message type) passed.');
        --

        --
        -- DG (11/08/2006): удалил проверку из-за того, что при формировании МТ202 оно
        --                  проходит по двум корсчетам и соответственно попадает в две
        --                  выписки, а сообщение отображается как один документ
        --
        -- Проверяем отсутствие привязки документа к выписке
        --
        -- begin
        --     select o.swref   into l_stmtRef
        --       from sw_oper o, sw_journal j
        --      where o.ref   = p_docRef
        --        and o.swref = j.swref
        --        and j.mt in (select mt from sw_stmt)
        --        and rownum <= 1;
        --
        --     bars_audit.error('Документ Ref=' || to_char(p_docRef) || ' привязан к выписке SwRef=' || to_char(l_stmtRef));
        --     raise_application_error(-20781, '\312 Документ Ref=' || to_char(p_docRef) || ' привязан к выписке SwRef=' || to_char(l_stmtRef));
        --
        -- exception
        --     when NO_DATA_FOUND then
        --         bars_audit.trace('Check to statement link passed.');
        -- end;

        --
        -- Получаем дату валютирования документа
        --
        select vdat  into l_docValueDate
          from oper
         where ref = p_docRef;

        bars_audit.trace('Document value date is %s', to_char(l_docValueDate, 'dd.mm.yyyy'));

        --
        -- Блокируем сообщение
        --
        savepoint sp_beforeLockMsg;

        select vdate, date_pay into l_msgValueDate, l_msgPayDate
          from sw_journal
         where swref = p_swRef
        for update nowait;

        bars_audit.trace('Message value date is %s', to_char(l_msgValueDate, 'dd.mm.yyyy'));
        bars_audit.trace('Message pay date is %s', to_char(l_msgPayDate, 'dd.mm.yyyy'));

        if (l_msgPayDate is not null) then

            -- Проверяем совпадает ли список документов
            select ref bulk collect into l_listref
              from sw_oper
             where swref = p_swref
               and swrnum is null;

            if (l_listref.count != 1) then
                rollback to sp_beforeLockMsg;
                bars_audit.error('Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
                raise_application_error(-20781, '\319 Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
            end if;

            if (l_listref(1) != p_docref) then
                rollback to sp_beforeLockMsg;
                bars_audit.error('Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
                raise_application_error(-20781, '\319 Сообщение SwRef='|| to_char(p_swRef) || ' уже обработано');
            end if;

            return;

        end if;

        --
        -- Получаем минимальное и максимальное отклонения даты валютирования
        -- документа от даты валютирования сообщения
        --
        l_docDateMni := nvl(to_number(get_param_value(MODPAR_DOCVDTMNI)), MODPAR_DOCVDTMNI_DEFAULT);
        l_docDateMax := nvl(to_number(get_param_value(MODPAR_DOCVDTMAX)), MODPAR_DOCVDTMAX_DEFAULT);

        bars_audit.trace('Document value date diff is -%s to +%s.', to_char(l_docDateMni), to_char(l_docDateMax));

      /*  if (l_msgValueDate not between l_docValueDate - l_docDateMni and l_docValueDate + l_docDateMax) then
            rollback to sp_beforeLockMsg;
            bars_audit.error('Дата валютирования документа меньше даты валютирования сообщения');
            raise_application_error(-20781, '\313 Дата валютирования сообщения '||to_char(l_msgValueDate, 'dd.mm.yyyy')||' не попадает в диапазон дат '||to_char(l_docValueDate - l_docDateMni, 'dd.mm.yyyy')||' і '||to_char(l_docValueDate + l_docDateMax, 'dd.mm.yyyy'));
        end if;*/

        insert into sw_oper (ref, swref) values (p_docRef, p_swRef);
        bars_audit.trace('Document linked with message.');


        if (l_msgPayDate is null) then

            update sw_journal
               set date_pay = sysdate
             where swref = p_swRef;

            bars_audit.trace('Message pay date is set now.');

        end if;

/*
        bars_audit.trace('Looking for statements with this source message ...');
        for i in (select *
                    from sw_950d
                   where src_swref =  p_swRef
                     and vdate     >= l_msgValueDate)
        loop
            --stmti_document_link(i.swref, i.n, t_listref(p_docRef));
            null;
        end loop;
*/

        bars_audit.trace('Statement(s) with this source message processed.');
        bars_audit.trace('Document Ref=%s successfully linked with message SwRef=%s.', to_char(p_docRef), to_char(p_swRef));

    end impmsgi_document_link_all;


    -----------------------------------------------------------------
    -- IMPMSGI_DOCUMENT_LINKREL()
    --
    --     Процедура привязки документа к связанным сообщениям
    --
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа, для которого
    --                         выполняется привязки
    --
    --          p_SwRef        Референс сообщения,  к  которому
    --                         была   инициирована привязка
    --
    --          p_stepNum      Номер шага, который будет выполняться
    --                         Параметр указывается при рекурсивных
    --
    --
    procedure impmsgi_document_linkrel(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type,
                  p_stepNum   in  number default 0       )
    is

    l_msgMt          sw_journal.mt%type;       /*                       тип сообщения */
    l_msgValueDate   sw_journal.vdate%type;    /*        дата валютирования сообщения */
    l_msgTrn         sw_journal.trn%type;      /*            SWIFT-референс сообщения */
    l_msgRelRef      sw_operw.value%type;      /*  связанный SWIFT-референс сообщения */
    l_relSwRef       sw_journal.swref%type;    /*           реф. связанного сообщения */
    l_relDatePay     sw_journal.date_pay%type; /* признак оплаты связанного сообщения */

    begin

         bars_audit.trace('Creating link to document Ref=%s from related messages Swref=%s (step %s)...', to_char(p_docRef), to_char(p_swRef), to_char(p_stepNum));

         select mt, trn, vdate into l_msgMt, l_msgTrn, l_msgValueDate
           from sw_journal
          where swref = p_swRef;

         bars_audit.trace('Message type is %s, trn is %s, value date is %s', to_char(l_msgMt), l_msgTrn, to_char(l_msgValueDate, 'dd.mm.yyyy'));

         --
         -- Шаг 1. По связанному референсу (поле 21) находит и привязываем
         --        связанные по этому референсу сообщения (с вложениями вниз)
         --
         if (p_stepNum in (0, 1)) then

             bars_audit.trace('Looking for related message (field 21) on source message SwRef=%s...', to_char(p_swRef));

             begin

                 select value into l_msgRelRef
                   from sw_operw
                  where swref = p_swRef
                    and tag   = '21'
                    and opt is null;

                 bars_audit.trace('Message related reference is %s', l_msgRelRef);
                 bars_audit.trace('Looking for message: trn=%s value date=%s', l_msgRelRef, to_char(l_msgValueDate, 'dd.mm.yyyy'));

                 begin

                     select swref, date_pay  into l_relSwRef, l_relDatePay
                       from sw_journal
                      where vdate between l_msgValueDate - 30 and l_msgValueDate
                        and trn  = l_msgRelRef
                        and substr(mt, 1, 1)  != substr(l_msgMt, 1, 1);

                     bars_audit.trace('Related message SwRef=%s found.', to_char(l_relSwRef));

                     if (l_relDatePay is null) then

                         --
                         -- Привязываем данное сообщение к документу и пытаемся пройти
                         -- по этому шагу от найденного сообщения
                         --
                         impmsgi_document_link(p_docRef, l_relSwRef);
                         impmsgi_document_linkrel(p_docRef, l_relSwRef, 1);

                     else
                         bars_audit.trace('Related message already payed, skip this step (possible error).');
                     end if;

                 exception
                     when NO_DATA_FOUND then
                         bars_audit.trace('Message on related reference not found.');
                     when TOO_MANY_ROWS then
                         bars_audit.trace('Found many messages on related reference!');
                 end;
             exception
                 when NO_DATA_FOUND then
                     bars_audit.trace('Related reference not found in source message SwRef=%s.', to_char(p_swRef));
             end;

         end if;

         --
         -- Шаг 2. Ищем сообщения, у которых в качестве связанного сообщения
         --        (поле 21), установлено наше сообщение и привязываем их
         --
         if (p_stepNum in (0, 2)) then

             bars_audit.trace('Looking for message with this message SwRef=%s reference in field 21...', to_char(p_swRef));

             begin

                 select j.swref, j.date_pay into l_relSwRef, l_relDatePay
                   from sw_journal j, sw_operw w
                  where substr(j.mt, 1, 1) != substr(l_msgMt, 1, 1)
                    and j.vdate >= l_msgValueDate
                    and j.swref  = w.swref
                    and w.tag    = '21'
                    and w.opt is null
                    and w.value  = l_msgTrn;

                 bars_audit.trace('Message SwRef=%s with this message as related found.', to_char(l_relSwRef));

                 if (l_relDatePay is null) then

                     --
                     -- Привязываем данное сообщение к документу и пытаемся пройти
                     -- по этому шагу от найденного сообщения
                     --
                     impmsgi_document_link(p_docRef, l_relSwRef);
                     impmsgi_document_linkrel(p_docRef, l_relSwRef, 2);

                 else
                     bars_audit.trace('Message with this message as related message already payed, skip this step (possible error).');
                 end if;

             exception
                 when NO_DATA_FOUND then
                     bars_audit.trace('Message with this message as related not found.');
                 when TOO_MANY_ROWS then
                     bars_audit.trace('Found many messages with this message as related!');
             end;

         end if;

         bars_audit.trace('All related messages successfully processed.');

    end impmsgi_document_linkrel;


    -----------------------------------------------------------------
    -- IMPMSGI_MESSAGE_LINKREL()
    --
    --     Процедура поиска и привязки сообщения к документу,
    --     который был порожден для связанного сообщения
    --
    --
    --      Параметры:
    --
    --          p_SwRef        Референс сообщения
    --
    --
    procedure impmsgi_message_linkrel(
                  p_swRef     in  sw_journal.swref%type  )
    is

    l_msgMt          sw_journal.mt%type;       /*                       тип сообщения */
    l_msgValueDate   sw_journal.vdate%type;    /*        дата валютирования сообщения */
    l_msgTrn         sw_journal.trn%type;      /*            SWIFT-референс сообщения */
    l_msgRelRef      sw_operw.value%type;      /*  связанный SWIFT-референс сообщения */
    l_relSwRef       sw_journal.swref%type;    /*           реф. связанного сообщения */
    l_relDatePay     sw_journal.date_pay%type; /* признак оплаты связанного сообщения */
    l_docRef         oper.ref%type;            /*       референс связанного документа */
    l_isPayed        boolean;                  /*    признак оплаты данного сообщения */

    begin

         bars_audit.trace('Linking message SwRef=%s to related message document...', to_char(p_swRef));

         select mt, trn, vdate into l_msgMt, l_msgTrn, l_msgValueDate
           from sw_journal
          where swref = p_swRef;

         bars_audit.trace('Message type is %s, trn is %s, value date is %s', to_char(l_msgMt), l_msgTrn, to_char(l_msgValueDate, 'dd.mm.yyyy'));

         --
         -- Для сообщений, которые включают множество единичных сообщений
         -- эта привязка не выполняется
         --
         if (l_msgMt in (102, 450)) then
             return;
         end if;


         l_isPayed := false;

         --
         -- Шаг 1. По связанному референсу (поле 21) находит и привязываем
         --        связанные по этому референсу сообщения (с вложениями вниз)
         --

         bars_audit.trace('Looking for related message (field 21) on source message SwRef=%s...', to_char(p_swRef));

         begin

             select value into l_msgRelRef
               from sw_operw
              where swref = p_swRef
                and tag   = '21'
                and opt is null;

             bars_audit.trace('Message related reference is %s', l_msgRelRef);
             bars_audit.trace('Looking for message: trn=%s value date=%s', l_msgRelRef, to_char(l_msgValueDate, 'dd.mm.yyyy'));

             begin

                 select swref, date_pay  into l_relSwRef, l_relDatePay
                   from sw_journal
                  where vdate between l_msgValueDate - 30 and l_msgValueDate
                    and trn  = l_msgRelRef
                    and substr(mt, 1, 1)  != substr(l_msgMt, 1, 1);

                 bars_audit.trace('Related message SwRef=%s found.', to_char(l_relSwRef));

                 if (l_relDatePay is not null) then

                     --
                     -- Привязываем данное сообщение к документу, который
                     -- привязан к связанному сообщению
                     --
                     begin

                         select ref into l_docRef
                           from sw_oper
                          where swref = l_relSwRef;

                         bars_audit.trace('Document Ref=%s linked with message SwRef=%s', to_char(l_docRef), to_char(l_relSwRef));

                         --
                         -- Рекурсивные вызовы не нужны, т.к. в момент привязки документа
                         -- к сообщению, процедура рекурсивно привязывает  все  сообщения,
                         -- которые на тот момент были доступны
                         --
                         impmsgi_document_link(l_docRef, p_swRef);

                         --
                         -- Нужно попытаться привязать к найденному документу те сообщения,
                         -- которые ссылаются на текущее сообщение. Это нужно в том случае,
                         -- когда из-за этого сообщения была разорвана цепочка и сейчас ее
                         -- можно восстановить
                         --
                         impmsgi_document_linkrel(l_docRef, p_swRef, 2);

                         l_isPayed := true;

                     exception
                         when NO_DATA_FOUND then
                             bars_audit.trace('Linked with message SwRef=%s document not found (possible error)!', to_char(l_relSwRef));
                         when TOO_MANY_ROWS then
                             bars_audit.trace('Many documents linked with message SwRef=%s (possible error)!', to_char(l_relSwRef));
                     end;

                 else
                     bars_audit.trace('Related message not processed (payed).');
                 end if;

             exception
                 when NO_DATA_FOUND then
                     bars_audit.trace('Message on related reference not found.');
                 when TOO_MANY_ROWS then
                     bars_audit.trace('Found many messages on related reference!');
             end;
         exception
             when NO_DATA_FOUND then
                 bars_audit.trace('Related reference not found in source message SwRef=%s.', to_char(p_swRef));
         end;

         --
         -- Шаг 2. Ищем сообщения, у которых в качестве связанного сообщения
         --        (поле 21), установлено наше сообщение и привязываем их
         --
         if (not l_isPayed) then

             bars_audit.trace('Looking for message with this message SwRef=%s reference in field 21...', to_char(p_swRef));

             begin

                 select j.swref, j.date_pay into l_relSwRef, l_relDatePay
                   from sw_journal j, sw_operw w
                  where substr(j.mt, 1, 1) != substr(l_msgMt, 1, 1)
                    and j.vdate >= l_msgValueDate
                    and j.swref  = w.swref
                    and w.tag    = '21'
                    and w.opt is null
                    and w.value  = l_msgTrn;

                 bars_audit.trace('Message SwRef=%s with this message as related found.', to_char(l_relSwRef));

                 if (l_relDatePay is not null) then

                     --
                     -- Привязываем данное сообщение к документу, который
                     -- привязан к сообщению, которое связано с нашим
                     --
                     begin

                         select ref into l_docRef
                           from sw_oper
                          where swref = l_relSwRef;

                         bars_audit.trace('Document Ref=%s linked with message SwRef=%s', to_char(l_docRef), to_char(l_relSwRef));

                         --
                         -- Рекурсивные вызовы не нужны, т.к. в момент привязки документа
                         -- к сообщению, процедура рекурсивно привязывает  все  сообщения,
                         -- которые на тот момент были доступны
                         --
                         impmsgi_document_link(l_docRef, p_swRef);

                         --
                         -- Нужно попытаться привязать к найденному документу те сообщения,
                         -- которые ссылаются на текущее сообщение. Это нужно в том случае,
                         -- когда из-за этого сообщения была разорвана цепочка и сейчас ее
                         -- можно восстановить
                         --
                         impmsgi_document_linkrel(l_docRef, p_swRef, 1);

                         l_isPayed := true;

                     exception
                         when NO_DATA_FOUND then
                             bars_audit.trace('Linked with message SwRef=%s document not found (possible error)!', to_char(l_relSwRef));
                         when TOO_MANY_ROWS then
                             bars_audit.trace('Many documents linked with message SwRef=%s (possible error)!', to_char(l_relSwRef));
                     end;

                 else
                     bars_audit.trace('Message with this message as related message not payed.');
                 end if;

             exception
                 when NO_DATA_FOUND then
                     bars_audit.trace('Message with this message as related not found.');
                 when TOO_MANY_ROWS then
                     bars_audit.trace('Found many messages with this message as related!');
             end;

         end if;

         bars_audit.trace('All related messages successfully processed.');

    end impmsgi_message_linkrel;




    -----------------------------------------------------------------
    -- IMPMSGI_DOCUMENT_UNLINK()
    --
    --     Процедура  удаления привязки документа к импортированному
    --     сообщению
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_SwRef        Референс сообщения
    --
    --
    --
    procedure impmsgi_document_unlink(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type )
    is

    l_cnt    number;   /* счетчик */

    l_stmtRef      sw_950.swref%type;        /* Референс выписки */
    l_stmtRow      sw_950d.n%type;           /* Номер строки выписки */
    l_stmtDocRef   oper.ref%type;            /* Референс документа в привязках выписки */
    l_msgValueDate sw_journal.vdate%type;    /* Дата валютирования сообщения */
    l_msgPayDate   sw_journal.date_pay%type; /* Дата оплаты документа */


    begin

        bars_audit.trace('Deleting Link document Ref=%s with message SwRef=%s ...', to_char(p_docRef), to_char(p_swRef));





        --
        -- Проверяем есть ли привязка
        --
        select count(*) into l_cnt
          from sw_oper
         where swref = p_swRef
           and ref   = p_docRef;

        if (l_cnt = 0) then
            bars_audit.error('Документ Ref=' || to_char(p_docRef) || ' не привязан к сообщению SwRef=' || to_char(p_swRef));
            raise_application_error(-20781, '\315 Документ Ref=' || to_char(p_docRef) || ' не привязан к сообщению SwRef=' || to_char(p_swRef));
        end if;

        --
        -- Получаем дату валютирования сообщения
        --
        -- DG: Временно закоментарил для попытки вызова процедуры из триггера
        -- savepoint sp_beforeLockMsg;

        select date_pay, vdate into l_msgPayDate, l_msgValueDate
          from sw_journal
         where swref = p_swRef
        for update nowait;

        bars_audit.trace('Message value date is %s', to_char(l_msgValueDate, 'dd.mm.yyyy'));

        --
        -- Находим привязку сообщения к выписке (и документу)
        --
        begin
            select swref, n, our_ref into l_stmtRef, l_stmtRow, l_stmtDocRef
              from sw_950d
             where vdate     >= l_msgValueDate
               and src_swref = p_swRef
            for update nowait;

            bars_audit.trace('Statement row found: StmtRef=%s Ref=%s', to_char(l_stmtRef), to_char(l_stmtDocRef));

            if (l_stmtDocRef != p_docRef) then
                -- rollback to sp_beforeLockMsg;
                bars_audit.error('Внутренняя ошибка: конфликт реквизитов привязки сообщения и выписки');
                raise_application_error(-20781, '\999 Внутренняя ошибка: конфликт реквизитов привязки сообщения и выписки');
            end if;

            stmt_set_state(l_stmtRef, 0);

            update sw_950d
               set our_ref      = null,
                    checked_ind = 'N'
             where swref = l_stmtRef
               and n     = l_stmtRow;

            bars_audit.trace('Document Ref=%s unlinked from statement SwRef=%s row=%s', to_char(p_docRef), to_char(l_stmtRef), to_char(l_stmtRow));

        exception
            when NO_DATA_FOUND then
                bars_audit.trace('Message SwRef=%s not linked with statement.', p_swRef);
        end;

        --
        -- Отвязываем документ от сообщения
        --
        update sw_journal
           set date_pay = null
         where swref = p_swRef;

        delete from sw_oper
         where swref = p_swRef
           and ref   = p_docRef;

        bars_audit.trace('Document Ref=%s successfully unlinked from message SwRef=%s.', to_char(p_docRef), to_char(p_swRef));

    end impmsgi_document_unlink;



    -----------------------------------------------------------------
    -- IMPMSGI_DOCUMENT_UNLINKREL()
    --
    --     Процедура удаления привязки документа в связанных
    --     сообщениях
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа, для которого
    --                         выполняется  удаление   привязки
    --
    --          p_SwRef        Референс сообщения,  от которого
    --                         было   инициировано     удаление
    --                         привязки
    --
    --
    --
    procedure impmsgi_document_unlinkrel(
                  p_docref    in  oper.ref%type,
                  p_swref     in  sw_journal.swref%type )
    is
    begin

         bars_audit.trace('Updating link to document Ref=%s from related messages Swref=%s...', to_char(p_docRef), to_char(p_swRef));

         --
         -- На данный момент связанные сообщения ищем по документу,
         -- к которому они все должны быть привязаны,  и     списку
         -- типов сообщений (103, 202, 900, 910)
         --
         for i in (select l.swref
                     from sw_oper l, sw_journal j
                    where l.ref   = p_docRef
                      and l.swref = j.swref
                      and j.mt in (103, 202, 900, 910))
         loop

             bars_audit.trace('Processing related message SwRef=%s...', to_char(i.swref));
             impmsgi_document_unlink(p_docRef, i.swref);
             bars_audit.trace('Related message SwRef=%s successfully processed.', to_char(i.swref));

         end loop;

         bars_audit.trace('All related messages successfully updated.');

    end impmsgi_document_unlinkrel;


    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_UNLINK()
    --
    --     Процедура  удаления привязки документа к сообщению
    --
    --
    --      Параметры:
    --
    --          p_docref       Референс документа
    --
    --          p_swref        Референс сообщения
    --
    --
    procedure impmsg_document_unlink(
                  p_docref    in  oper.ref%type,
                  p_swref     in  sw_journal.swref%type )
    is
    p       constant  varchar2(100) := 'swt.impmsgdocunlink';

    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, to_char(p_docref), to_char(p_swref));

        -- TODO: Переписать более компактно
        if (p_docref is null) then
            for i in (select ref from sw_oper where swref = p_swref)
            loop
                -- Удаляем привязку к указанному документу
                impmsgi_document_unlink(i.ref, p_swref);
                bars_audit.trace('%s: document ref=%s unlinked.', p, to_char(i.ref));

                -- Обрабатываем связанные сообщения
                if (get_param_value(MODPAR_MSGRL) = MODVAL_MSGRL_TRUE) then
                    impmsgi_document_unlinkrel(i.ref, p_swref);
                    bars_audit.trace('%s: related messages processed.', p);
                else
                    bars_audit.trace('%s: related messages update skipped, mode unset.', p);
                end if;

            end loop;

        else
            -- Удаляем привязку к указанному документу
            impmsgi_document_unlink(p_docref, p_swref);
            bars_audit.trace('%s: document ref=%s unlinked.', p, to_char(p_docref));

            -- Обрабатываем связанные сообщения
            if (get_param_value(MODPAR_MSGRL) = MODVAL_MSGRL_TRUE) then
                impmsgi_document_unlinkrel(p_docref, p_swref);
                bars_audit.trace('%s: related messages processed.', p);
            else
                bars_audit.trace('%s: related messages update skipped, mode unset.', p);
            end if;
        end if;
        bars_audit.trace('%s: succ end', p);

    end impmsg_document_unlink;

    -----------------------------------------------------------------
    -- IMPMSG_MESSAGE_CHANGEUSER()
    --
    --     Процедура распределяет/перераспределяет сообщение  на
    --     указанного пользователя или в группу нераспределенных
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс сообщения
    --
    --          p_srcUserID    Идентификатор пользователя, на  которого
    --                         распределено(ы) сообщение(я)
    --
    --          p_tgtUserID    Идентификатор пользователя, на  которого
    --                         необходимо распределить/перераспределить
    --                         сообщение(я)
    --
    procedure impmsg_message_changeuser(
                  p_swRef     in  sw_journal.swref%type,
                  p_srcUserID in  staff.id%type,
                  p_tgtUserID in  staff.id%type          )
    is

    l_msgUserID   staff.id%type;   /* Идентификатор пользователя, на кот. распределено */

    begin

        bars_audit.trace('Changing user id on message(s) SwRef=%s...(SrcUserID=%s TgtUserID=%s)', to_char(p_swRef), to_char(p_srcUserID), to_char(p_tgtUserID));

        --
        -- Распределяем/Перераспределяем сообщения
        --

        if (p_swRef is not null) then

            begin

                select id  into l_msgUserID
                  from sw_journal
                 where swref = p_swRef
                   and date_pay is null
                for update nowait;

                update sw_journal
                   set id = p_tgtUserID
                 where swref = p_swRef;

                bars_audit.trace('UserID on message SwRef=%s successfully changed from %s to %s.', to_char(p_swRef), to_char(p_srcUserID), to_char(p_tgtUserID));
                bars_audit.info('Сообщение с реф. ' || to_char(p_swRef) || ' распределено/перераспределено.');

            exception
                when NO_DATA_FOUND then
                    bars_audit.error('SWT:\400 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено или обработано');
                    raise_application_error(-20781, '\400 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено или обработано');
            end;


        else

            update sw_journal
               set id = p_tgtUserID
             where decode(date_pay, null, 1, null) = 1
               and nvl(id, 0) = nvl(p_srcUserID, 0);

            bars_audit.trace('All messages from userid=%s changed to userid=%s, messages count is %s.', to_char(p_srcUserID), to_char(p_tgtUserID), to_char(sql%rowcount));
            bars_audit.info('Сообщения с пользователя Ид=' || to_char(p_srcUserID) || ' перераспределены на пользователя Ид=' || to_char(p_tgtUSerID));

        end if;

    end impmsg_message_changeuser;

    -----------------------------------------------------------------
    -- IMPMSG_MESSAGE_DELETE()
    --
    --     Процедура удаляет импортированное сообщение
    --
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс сообщения
    --
    --
    procedure impmsg_message_delete(
                  p_swRef    in  sw_journal.swref%type  )
    is

    l_swRef  sw_journal.swref%type;   /* Референс удаляемого сообщения */

    begin

        bars_audit.trace('Deleting imported message SwRef=%s...', to_char(p_swRef));

        select swref  into l_swRef
          from sw_journal
         where swref = p_swRef
           and imported = 'Y'
           and date_pay is null
        for update nowait;

        -- Удаляем
        delete from sw_operw    where swref = p_swRef;
        delete from sw_messages where swref = p_swRef;
        delete from sw_journal  where swref = p_swRef;

        bars_audit.info('SWT: Импортированное сообщение с реф. ' || to_char(p_swRef) || ' удалено пользователем.');

    exception
        when NO_DATA_FOUND then
            bars_audit.error('Сообщение с реф. ' || to_char(p_swRef) || ' не найдено или обработано');
            raise_application_error(-20781, '\400 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено или обработано');
    end impmsg_message_delete;


    -----------------------------------------------------------------
    -- IMPMSG_MESSAGE_GETACCB()
    --
    --     Функция получения счета из сообщения
    --
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс сообщения
    --
    --
    function impmsg_message_getaccb(
                 p_swRef    in  sw_journal.swref%type  ) return accounts.acc%type
    is

    l_msgAcc   accounts.acc%type;   /* Идентификатор счета */

    begin

        bars_audit.trace('Trying to get accounts from imported message SwRef=%s...', to_char(p_swRef));

        select acck  into l_msgAcc
          from sw_journal
         where swref = p_swRef
           and imported = 'Y';

        bars_audit.trace('Message account is %s', to_char(l_msgAcc));

        return l_msgAcc;

    exception
        when NO_DATA_FOUND then
            bars_audit.error('Сообщение с реф. ' || to_char(p_swRef) || ' не найдено или обработано');
            raise_application_error(-20781, '\400 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено или обработано');
    end impmsg_message_getaccb;


--**********************************************************************
-- IMPMSG_AFTER()
--
--      Процедура, выполняющаяся после импорта сообщения с помощью
--      программы файлового процессинга (SWTOSS)
--
--
--
--**********************************************************************

procedure impmsg_after(
              p_swRef    in  sw_journal.swref%type )
is

l_prcStatus  sw_journal.lau_act%type;

begin

    update sw_journal
       set date_out = decode(date_out, null, date_in, date_out),
           imported = 'Y'
     where swref = p_swRef;

    --
    -- На этот момент в сообщении уже установлен признак обработки
    --
    if (sql%rowcount != 0) then

        select lau_act into l_prcStatus
          from sw_journal
         where swref = p_swRef;

        if (l_prcStatus = 1) then

            -- Только если включен параметр
            if (get_param_value(MODPAR_MSGRL) = MODVAL_MSGRL_TRUE) then
                impmsgi_message_linkrel(p_swRef);
            end if;
        end if;

    end if;

end impmsg_after;

--**********************************************************************
-- PROCESS_AUTH_MESSAGE()
--
--      Процедура удаления сообщения, которое не прошло проверку
--      аутентификации с помощью кода LAU
--
--
--
--**********************************************************************

procedure process_auth_message(
              p_swRef    in  sw_journal.swref%type,
              p_action   in  number                )
is

l_cnt number;

begin

    -- обработке подлежат только импортированные сообщения
    -- без аутентификации
    select count(*) into l_cnt
      from sw_journal
     where swref = p_swref
       and imported = 'Y'
       and nvl(lau_flag, 0) = 0
       and lau_act = 0;

    if (l_cnt = 0) then
        raise_application_error(-20999, 'Невозможно удалить сообщение (IMP+LAU)');
    end if;


    if (p_action = 1) then

        update sw_journal
           set lau_act = 1,
               lau_uid = (select id
                            from staff
                           where logname = sys_context('USERENV', 'SESSION_USER'))
         where swref = p_swref;

        impmsgi_message_linkrel(p_swRef);

    elsif (p_action = 0) then

        delete from sw_messages where swref = p_swref;
        delete from sw_operw    where swref = p_swref;
        delete from sw_journal  where swref = p_swref;

    else
        raise_application_error(-20999, 'Неверно указано действие');
    end if;

end process_auth_message;






    -----------------------------------------------------------------
    -- IMPMSGI_MESSAGE_GETRELMSG()
    --
    --     Процедура получения референса и типа начального сообщения
    --     по цепочке связанных сообщения для указанного сообщения
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс выписки
    --
    --          p_msgSwRef       Референс сообщения (выходной)
    --
    --



    procedure impmsgi_message_getrelmsg(
                  p_swRef    in  sw_journal.swref%type,
                  p_msgSwRef out sw_journal.swref%type  )
    is

    l_msgRelRef    sw_operw.value%type;      /*     реф. связанного сообщения */
    l_msgMt        sw_journal.mt%type;       /*                 тип сообщения */
    l_msgValueDate sw_journal.vdate%type;    /*  дата валютирования сообщения */
    l_relSwRef     sw_journal.swref%type;    /*     реф. связанного сообщения */
    l_relDatePay   sw_journal.date_pay%type; /*         дата оплаты сообщения */

    begin

        if (g_currelmsgrl >= MAX_RELMSG_RECURSION) then
            p_msgSwRef := null;
            return;
        end if;

        select mt, vdate into l_msgMt, l_msgValueDate
          from sw_journal
         where swref = p_swRef;

        --
        -- По связанному референсу (поле 21) находит связанное
        -- сообщение
        --
        bars_audit.trace('Looking for related message (field 21) on source message SwRef=%s...', to_char(p_swRef));

        begin

            select value into l_msgRelRef
              from sw_operw
             where swref = p_swRef
               and tag   = '21'
               and opt is null;

             bars_audit.trace('Message related reference is %s', l_msgRelRef);
             bars_audit.trace('Looking for message: trn=%s value date=%s', l_msgRelRef, to_char(l_msgValueDate, 'dd.mm.yyyy'));

             begin

                 select swref, date_pay  into l_relSwRef, l_relDatePay
                   from sw_journal
                  where vdate between l_msgValueDate - 30 and l_msgValueDate
                    and trn  = l_msgRelRef
                    and substr(mt, 1, 1) != substr(l_msgMt, 1, 1);

                 bars_audit.trace('Related message SwRef=%s found.', to_char(l_relSwRef));

                 if (l_relDatePay is not null) then

                     --
                     -- Сообщение уже оплачено по какой-то  причине,
                     -- его показывать не можем. Возвращаем референс
                     -- исходного сообщения
                     --
                     p_msgSwRef := p_swRef;
                     bars_audit.trace('Founded message already payed, skip it...');

                 else
                     --
                     -- Для найденного сообщения пытаемся найти связанное
                     --
                     g_currelmsgrl := g_currelmsgrl + 1;
                     impmsgi_message_getrelmsg(l_relSwRef, p_msgSwRef);
                     bars_audit.trace('recursive call result: %s', to_char(p_msgSwRef));

                 end if;

             exception
                 when NO_DATA_FOUND then
                     bars_audit.trace('Message on related reference not found.');
                     p_msgSwRef := p_swRef;

                 when TOO_MANY_ROWS then
                     bars_audit.trace('Found many messages on related reference!');
                     p_msgSwRef := p_swRef;

             end;
         exception
             when NO_DATA_FOUND then
                 bars_audit.trace('Related reference not found in source message SwRef=%s.', to_char(p_swRef));
                 p_msgSwRef := p_swRef;
         end;

        bars_audit.trace('Related reference for message SwRef=%s is SwRef=%s.', to_char(p_swRef), to_char(p_msgSwRef));

    end impmsgi_message_getrelmsg;


    -----------------------------------------------------------------
    -- IMPMSG_MESSAGE_GETRELMSG()
    --
    --     Процедура получения референса и типа начального сообщения
    --     по цепочке связанных сообщения для указанного сообщения
    --
    --
    --      Параметры:
    --
    --          p_swRef        Референс выписки
    --
    --          p_msgSwRef       Референс сообщения (выходной)
    --
    --          p_msgMt          Тип сообщения      (выходной)
    --
    --
    procedure impmsg_message_getrelmsg(
                  p_swRef    in  sw_journal.swref%type,
                  p_msgSwRef out sw_journal.swref%type,
                  p_msgMt    out sw_journal.mt%type     )
    is
    begin

        bars_audit.trace('Looking for related message for message SwRef=%s...', to_char(p_swRef));

        if (get_param_value(MODPAR_MSGRL) = MODVAL_MSGRL_TRUE) then

            --
            -- Всегда пытаемся идти вниз, т.е. по полю 21
            --
            g_currelmsgrl := 0;
            impmsgi_message_getrelmsg(p_swRef, p_msgSwRef);

            select mt into p_msgMt
              from sw_journal
             where swref = p_msgSwRef;

            bars_audit.trace('Related reference is SwRef=%s, message type is %s.', to_char(p_msgSwRef), to_char(p_msgMt));

        else

            bars_audit.trace('Related messages disabled, return our reference and message type.');

            select swref, mt  into p_msgSwRef, p_msgMt
              from sw_journal
             where swref = p_swRef;

        end if;

        bars_audit.trace('Related message is SwRef=%s, message type is %s.', to_char(p_msgSwRef), to_char(p_msgMt));

    end impmsg_message_getrelmsg;


    -----------------------------------------------------------------
    -- GET_MESSAGE_FIELDNAME()
    --
    --     Функция получения имени поля по метаописанию
    --
    --
    --      Параметры:
    --
    --          p_msgMt        Тип сообщения
    --
    --          p_msgSeq       Фрагмент сообщения
    --
    --          p_msgTag       Поле сообщения
    --
    --          p_msgOpt       Опция поля
    --
    --
    function get_message_fieldname(
                  p_msgMt    in  sw_mt.mt%type,
                  p_msgSeq   in  sw_seq.seq%type,
                  p_msgTag   in  sw_tag.tag%type,
                  p_msgOpt   in  sw_opt.opt%type   ) return varchar2
    is

    l_fldNum      sw_model.num%type;          /* позиция поля в модели */
    l_fldName     sw_model.name%type;         /*     наименование поля */
    l_fldSubName  sw_model_opt.subname%type;  /*    наименование опции */

    begin

        bars_audit.trace('get name of field tag=%s opt=%s message type=%s...', to_char(p_msgTag), to_char(p_msgOpt), to_char(p_msgMt));

        begin
            select num, name into l_fldNum, l_fldName
              from sw_model
             where mt            = p_msgMt
               and seq           = p_msgSeq
               and tag           = p_msgTag
               and nvl(opt, '-') = nvl(p_msgOpt, '-');

            bars_audit.trace('field number in model=%s name=%s.', to_char(l_fldNum), to_char(l_fldName));

        exception
            when NO_DATA_FOUND then

                bars_audit.trace('field not found, trying to get field with variable option...');

                begin
                    select num, name into l_fldNum, l_fldName
                      from (select num, name
                              from sw_model
                             where mt            = p_msgMt
                               and seq           = p_msgSeq
                               and tag           = p_msgTag
                               and opt           = 'a'
                            order by num)
                     where rownum <= 1;

                     bars_audit.trace('field number is %s, name is %s. Trying to get subname...', to_char(l_fldNum), l_fldName);

                     begin
                         select subname into l_fldSubName
                           from sw_model_opt
                          where mt            = p_msgMt
                            and num           = l_fldNum
                            and nvl(opt, '-') = nvl(p_msgOpt, '-');

                         bars_audit.trace('Subname is %s', l_fldSubName);
                     exception
                         when NO_DATA_FOUND then
                             l_fldSubName := null;
                             bars_audit.trace('Option not found, possible error!');
                     end;

                exception
                    when NO_DATA_FOUND then
                        l_fldName := null;
                        bars_audit.trace('field with variable option not found!');
                end;


            when TOO_MANY_ROWS then

                bars_audit.trace('found many rows, trying to get first...');

                select num, name into l_fldNum, l_fldName
                  from (select num, name
                          from sw_model
                         where mt            = p_msgMt
                           and seq           = p_msgSeq
                           and tag           = p_msgTag
                           and nvl(opt, '-') = nvl(p_msgOpt, '-')
                        order by num)
                 where rownum <= 1;

                bars_audit.trace('field number in model=%s name=%s.', to_char(l_fldNum), to_char(l_fldName));
        end;

        if (l_fldName is not null) then
            if (l_fldSubName is not null) then
                l_fldName := substr(l_fldName || ' ' || l_fldSubName, 1, 70);
            end if;
        end if;

        return l_fldName;

    end get_message_fieldname;

    -----------------------------------------------------------------
    -- GET_MESSAGE_FIELDVALUE()
    --
    --     Функция получения полного значения поля
    --     Функция возвращает значение поля и наименование участника
    --     если данное поле содержит BIC
    --
    --      Параметры:
    --
    --          p_msgMt        Тип сообщения
    --
    --          p_msgSeq       Фрагмент сообщения
    --
    --          p_msgTag       Поле сообщения
    --
    --          p_msgOpt       Опция поля
    --
    --
    function get_message_fieldvalue(
                  p_msgMt    in  sw_mt.mt%type,
                  p_msgSeq   in  sw_seq.seq%type,
                  p_msgTag   in  sw_tag.tag%type,
                  p_msgOpt   in  sw_opt.opt%type,
                  p_msgValue in  sw_operw.value%type  ) return varchar2
    is

    l_CrLn   char(2) := chr(13) || chr(10);

    l_pos      number;                /* позиция перевода строки */
    l_bic      sw_banks.bic%type;     /*                 BIC-код */
    l_name     sw_banks.name%type;    /*  Наименование участника */
    l_city     sw_banks.city%type;    /*         Город участника */
    l_country  sw_banks.country%type; /*        Страна участника */
    l_value    sw_operw.value%type;   /*           Значение поля */

    begin

        l_value := p_msgValue;

        if (p_msgOpt = 'A' and p_msgTag in ('51', '52', '53', '54', '55', '56', '57', '58', '82', '83', '84', '85', '86', '87', '88')) then

            --
            -- исключаем счет
            --
            if (substr(l_value, 1, 1) = '/') then

                l_pos := instr(l_value, l_CrLn);

                if (l_pos = 0) then
                    -- ошибка формата, не дополняем его
                    return l_value;
                end if;

                l_bic := substr(l_value, l_pos+2);

            else
                l_bic := l_value;
            end if;

            -- Выполняем поиск кода в справочнике
            begin

                select name, city, country into l_name, l_city, l_country
                  from sw_banks
                 where bic = l_bic;

                if (l_name is not null) then

                    -- В новой строке добавляем наименование
                    if (substr(l_value, -2) != l_CrLn ) then
                        l_value := l_value || l_CrLn;
                    end if;

                    l_value := l_value || l_name;

                    if (l_city is not null) then

                        l_value := l_value || l_CrLn || l_city;

                    end if;

                    if (l_country is not null) then

                        l_value := l_value || l_CrLn || l_country;

                    end if;


                end if;

            exception
                when NO_DATA_FOUND then null;
                when TOO_MANY_ROWS then null;
            end;


        end if;

        return l_value;

    end get_message_fieldvalue;



    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_SWIFT ' || g_headerVersion || chr(10) ||
               'package header definition(s):' || chr(10) || g_headerDefs;
    end header_version;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_SWIFT ' || g_bodyVersion || chr(10) ||
               'package body definition(s):' || chr(10) || g_bodyDefs;
    end body_version;






    -----------------------------------------------------------------
    -- MSGCHK_PUT_CHECKSTAMP()
    --
    --     Процедура наложения специальной визы на документ, которая
    --     определяется как виза сообщения SWIFT,   порожденного  по
    --     данному документу
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_swRef        Референс порожденного сообщения
    --
    --          p_chkGrp       Код группы визирования
    --
    --          p_chkAct       Тип действия (наложение визы/отказ)
    --
    --          p_chkOpt       Опции
    --
    procedure msgchk_put_checkstamp(
                  p_docRef   in  oper.ref%type,
                  p_swRef    in  sw_journal.swref%type,
                  p_chkGrp   in  sw_chklist.idchk%type,
                  p_chkAct   in  number,
                  p_chkOpt   in  number                )
    is

    l_dummy       number;
    l_isPay       number;
    l_isSign      number;
    l_tt          oper.tt%type;
    l_locDate     date;

    l_backErrCode number;
    l_backErrMsg  varchar2(2000);

    l_docChk      oper.chk%type;
    l_userId      number;
    l_mt          number;
    l_unlockgrp   number;

    begin

        if (p_chkAct is null or p_chkAct not in (0, 1)) then
            bars_audit.error('Неверно задан параметр CheckAction');
            raise_application_error(-20999, 'Неверно задан параметр CheckAction');
        end if;

        --
        -- Группа визирования должна быть определена для сообщений
        --
        begin
            select 1 into l_dummy
              from sw_chklist
             where idchk = p_chkGrp;
        exception
            when NO_DATA_FOUND then
                bars_audit.error('\420 Группа визирования ChkId=' || to_char(p_chkGrp) || ' не разрешена для сообщений');
                raise_application_error(-20781, '\420 Группа визирования ChkId=' || to_char(p_chkGrp) || ' не разрешена для сообщений');
        end;

        bars_audit.trace('Check group is valid.');

        --
        -- Проверяем связку сообщения и документа
        --
        begin
            select j.mt into l_mt
              from sw_journal j, sw_oper o, oper p
             where j.swref = p_swRef
               and p.ref   = p_docRef
               and j.swref = o.swref
               and p.ref   = o.ref;
        exception
            when NO_DATA_FOUND then
                bars_audit.error('\421 Отсутствует связь между сообщением SwRef=' || to_char(p_swRef) || ' и документом Ref=' || to_char(p_docRef));
                raise_application_error(-20781, '\421 Отсутствует связь между сообщением SwRef=' || to_char(p_swRef) || ' и документом Ref=' || to_char(p_docRef));
        end;

        bars_audit.trace('document Ref=%s and message SwRef=%s is linked.', to_char(p_docRef), to_char(p_swRef));

        if (p_chkAct = 1) then

            -- До наложения визы "на сообщение" необходимо его проверить
            genmsg_message_validate(p_swRef);

            bars_audit.trace('Attempt to put checkstamp to document Ref=%s...', to_char(p_docRef));

            -- Пытаемся наложить визу на документ
            select tt into l_tt
              from oper
             where ref = p_docRef;

            savepoint sp_beforeDocChk;
            begin

                -- Блокируем документ
                chk.lock_doc(p_docRef, p_chkGrp, l_isPay, l_isSign);
                bars_audit.trace('Document locked.');

                -- Ставим визу
                chk.put_visa(p_docRef, l_tt, p_chkGrp, l_isPay+1, null, null, null);
                bars_audit.trace('Call chk.put_visa() successfully completed.');
                bars_audit.info('Установлена виза на документ Ref=' || to_char(p_docRef));

                bars_audit.info('Выполнено визирование документа Ref=' || to_char(p_docRef));

                if (l_isPay = 1) then

                    bars_audit.trace('trying to pay document...');
                    gl.pay(2, p_docRef, l_locDate);
                    bars_audit.trace('document pay call successfully complete.');

                end if;

            exception
                when OTHERS then
                    rollback to sp_beforeDocChk;
                    bars_audit.trace('Exception found, rollback and re-raise');
                    raise;
            end;


            -- Если включена автоматическая отправка, то разблокируем сообщение
            if ( get_param_value(MODPAR_MSGLCK) = MODVAL_MSGLCK_OFF) then

                -- Получаем группу, после которой можно разблокировать сообщение
                select chkgrp into l_unlockgrp
                  from sw_mt
                 where mt = l_mt;
                bars_audit.trace('unlock group %s', to_char(l_unlockgrp));

                if (l_unlockgrp = p_chkgrp) then
                    unlock_message(p_swref);
                    bars_audit.trace('message unlocked (auto)');
                end if;

            end if;

        else

            select id into l_userId
              from staff
             where logname = user;


            if (p_chkOpt = -1) then

                --
                -- Возврат на предыдущую визу
                --
                bars_audit.trace('back document to previous check group...');

                savepoint sp_beforeDocChk;
                begin

                    -- Блокируем документ
                    chk.lock_doc(p_docRef, p_chkGrp, l_isPay, l_isSign);
                    bars_audit.trace('Document locked.');

                    update oper
                       set chk = substr(chk, 1, length(rtrim(chk))-6)
                     where ref = p_docRef;

                    delete from oper_visa
                     where sqnc = (select max(sqnc)
                                     from oper_visa
                                    where ref = p_docRef);

                    insert into oper_visa (ref, dat, userid, groupid, status, passive)
                    values (p_docRef, sysdate, l_userId, p_chkGrp, 0, 1);

                    bars_audit.info('Выполнен возврат на предыдущую визу для документа Ref=' || to_char(p_docRef));

                exception
                    when OTHERS then
                        rollback to sp_beforeDocChk;
                        bars_audit.trace('Exception found, rollback and re-raise');
                        raise;
                end;

            else

                --
                -- Сторнирование документа
                --

                bars_audit.trace('full back document...');

                savepoint sp_beforeDocChk;
                begin

                    -- Блокируем документ
                    chk.lock_doc(p_docRef, p_chkGrp, l_isPay, l_isSign);
                    bars_audit.trace('Document locked.');

                    select chk into l_docChk
                      from oper
                     where ref = p_docRef;

                    p_back_dok(p_docRef, 5, p_chkOpt, l_backErrCode, l_backErrMsg);

                    update oper
                       set chk = rtrim(nvl(l_docChk,'')) || chk.put_stmp(p_chkGrp)
                     where ref = p_docRef;

                    insert into oper_visa (ref, dat, userid, groupid, status)
                    values (p_docRef, sysdate, l_userId, p_chkGrp, 3);

                    bars_audit.info('Выполнено сторнирование документа Ref=' || to_char(p_docRef));

                exception
                    when OTHERS then
                        rollback to sp_beforeDocChk;
                        bars_audit.trace('Exception found, rollback and re-raise');
                        raise;
                end;

            end if;

        end if;

    end msgchk_put_checkstamp;


    -----------------------------------------------------------------
    -- MSGCHK_GETEDITSTATUS()
    --
    --     Функция возвращает признак возможности редактирования
    --     сообщения. Сообщение можно редактировать если на него
    --     не была наложена ни одна виза
    --
    --      Параметры:
    --
    --          p_swRef        Референс порожденного сообщения
    --
    --
    function msgchk_geteditstatus(
                  p_swRef    in  sw_journal.swref%type ) return number
    is

    l_result   number;

    begin

        select decode(count(*), 0, 1, 0) into l_result
          from sw_oper l, oper_visa v, sw_chklist c
         where l.swref    = p_swRef
           and l.ref      = v.ref
           and v.groupid  = c.idchk
           and v.status   = 1
           and nvl(v.passive, 0) != 1;

        return l_result;

    end msgchk_geteditstatus;

    -----------------------------------------------------------------
    -- MSGCHK_GETEXPSTATUS()
    --
    --     Функция возвращает признак возможности экспорта сообщения
    --     из БД в транспортный файл.
    --
    --      Параметры:
    --
    --          p_swRef        Референс порожденного сообщения
    --
    --
    function msgchk_getexpstatus(
                  p_swRef    in  sw_journal.swref%type ) return number
    is

    l_chkGrp   sw_mt.chkgrp%type;   -- Код группы финальной визирования
    l_result   number;

    begin

        select m.chkgrp into l_chkGrp
          from sw_journal j, sw_mt m
         where j.swref = p_swRef
           and j.mt    = m.mt;

        --
        -- Код группы визирования не задан, экпортировать можно всегда
        --
        if (l_chkGrp is null) then
            return 1;
        end if;

        --
        -- Проверяем наложение указанной группы визирования на
        -- документ, который привязан к сообщению
        --
        select decode(count(*), 0, 0, 1) into l_result
          from sw_oper l, oper_visa v
         where l.swref   = p_swRef
           and l.ref     = v.ref
           and v.groupid = l_chkGrp
           and v.status  in (1, 2);

        return l_result;

    end msgchk_getexpstatus;


    -----------------------------------------------------------------
    -- GENMSG_MESSAGE_VLDMSG103()
    --
    --     Процедура проверки корректности сообщения SWIFT MT103
    --     (Network validation rules)
    --
    --     Параметры:
    --
    --         p_swref    Референс сообщения
    --
    --
    procedure genmsg_message_vldmsg103(
                  p_swRef     in  sw_journal.swref%type )
    is
    begin

        -- TODO: Перенести проверки сообщения (аналогично bars_swift_msg.docmsg_document_vldmt103)

        -- Старая процедура проверки
        validate_mt103_message(p_swRef);

    end genmsg_message_vldmsg103;




















    -----------------------------------------------------------------
    -- GENMSG_MESSAGE_VLDMSG202()
    --
    --     Процедура проверки корректности сообщения SWIFT MT202
    --     (Network validation rules)
    --
    --
    --
    --
    procedure genmsg_message_vldmsg202(
                  p_swRef     in  sw_journal.swref%type )
    is
    begin
        validate_mt202_message(p_swRef);
    end genmsg_message_vldmsg202;



    -----------------------------------------------------------------
    -- GENMSG_MESSAGE_VALIDATE()
    --
    --     Процедура проверки корректности сообщения SWIFT
    --
    --
    --
    --
    --
    procedure genmsg_message_validate(
                  p_swRef     in  sw_journal.swref%type )
    is

    ERR     constant number := -20782;

    l_mt    sw_mt.mt%type;        /* тип сообщения */
    l_tag   sw_tag.tag%type;      /* поле сообщения */
    l_opt   varchar2(1);          /* опция поля */
    l_value sw_operw.value%type;  /* значение поля */
    l_list  t_strlist;            /* список значений */

    begin

        bars_audit.trace('validating message SwRef=%s...', to_char(p_swRef));

        begin
            select mt into l_mt
              from sw_journal
             where swref = p_swRef;
        exception
            when NO_DATA_FOUND then
                bars_audit.error('Сообщение с SwRef=' || to_char(p_swRef) || ' не найдено.');
                raise_application_error(ERR, '\400 Сообщение с реф. %s не найдено или обработано');
        end;

        bars_audit.trace('message type is %s', to_char(l_mt));

        --
        -- Проверка сообщения:
        --
        --    Этап 1. Проверка наличия обязательных полей (только наличие)
        --    Этап 2. Проверка значений в полях (всех)
        --    Этап 3. Специфичные проверки в зависимости от типа сообщения
        --
        bars_audit.trace('message validation step 1...');

        if (l_mt < 300 and l_mt > 399) then

            begin

                select m.tag, m.opt into l_tag, l_opt
                  from sw_model m
                 where m.mt     = l_mt
                   and m.status = 'M'
                   and (m.opt = upper(m.opt) or m.opt is null)
                   and (m.tag != '15')
                   and not exists (select 1
                                     from sw_operw w
                                    where w.swref = p_swRef
                                      and w.tag   = m.tag
                                      and nvl(w.opt, '-') = nvl(m.opt, '-'))
                   and rownum <= 1;

                raise_application_error(ERR, '\930 Нет обязательного поля ' || l_tag || l_opt);

            exception
                when NO_DATA_FOUND then null;
            end;

            begin

                select m.tag, m.opt into l_tag, l_opt
                  from sw_model m
                 where m.mt     = l_mt
                   and m.status = 'M'
                   and (m.status2 is null or m.status2 = 'M')
                   and m.opt = lower(m.opt)
                   and not exists (select 1
                                     from sw_operw w, sw_model_opt o
                                    where w.swref = p_swRef
                                      and w.tag   = m.tag
                                      and nvl(w.opt, '-') = o.opt
                                      and o.mt    = m.mt
                                      and o.num   = m.num )
                   and rownum <= 1;

                raise_application_error(ERR, '\930 Нет обязательного поля ' || l_tag || 'a');

            exception
                when NO_DATA_FOUND then null;
            end;
        else
            bars_audit.trace('message validating step 1 skipped for message type 3xx');
        end if;

        bars_audit.trace('message validation step 1 complete.');

        bars_audit.trace('message validation step 2...');

        for i in (select *
                    from sw_operw
                   where swref  = p_swRef
                  order by n              )
        loop

            bars_audit.trace('tag=>%s, opt=>%s, value=>%s', i.tag, i.opt, i.value);
            validate_field(i.tag, i.opt, i.value, 1, 1);
            bars_audit.trace('field %s%s succesfully validated.', i.tag, i.opt);

        end loop;

        bars_audit.trace('message validation step 2 complete.');

        bars_audit.trace('message validation step 3...');

        -- Для каждого типа сообщения будет своя процедура проверки
        if    (l_mt = 103) then
            genmsg_message_vldmsg103(p_swRef=>p_swRef);
        elsif (l_mt = 200) then
            bars_audit.trace('Network validation rules not present for message type 200, skip this step.');
        elsif (l_mt = 202) then
            genmsg_message_vldmsg202(p_swRef=>p_swRef);
        else
            bars_audit.trace('Network validation rules not implemented for message type ' || to_char(l_mt) || ', skip this step.');
        end if;

        bars_audit.trace('message validation step 3 complete.');

        bars_audit.trace('message SwRef=%s successfully validated.', to_char(p_swRef));

    end genmsg_message_validate;


    -----------------------------------------------------------------
    -- IN_SWMSGFIELD()
    --
    --   Процедура сохраняет значения полей сообщения
    --
    --
    --
    --
    procedure in_swmsgfield(
                  p_swRef     in  sw_msgfield.swref%type,
                  p_recnum    in  sw_msgfield.recnum%type,
                  p_msgBlk    in  sw_msgfield.msgblk%type,
                  p_msgTag    in  sw_msgfield.msgtag%type,
                  p_value     in  sw_msgfield.value%type  )
    is
    begin

        -- Просто вставляем реквизиты
        insert into sw_msgfield(swref, recnum, msgblk, msgtag, value)
        values (p_swRef, p_recnum, p_msgBlk, p_msgTag, p_value);

    end in_swmsgfield;



    -----------------------------------------------------------------
    -- GET_MESSAGE_RELMSG()
    --
    --   Функция поиска связанного сообщения. Если связанное сообщение
    --   найдено, то функция возвращает его референс, иначе возвращает
    --   значение NULL
    --
    --
    --
    function get_message_relmsg(
                 p_swRef    in  sw_journal.swref%type ) return sw_journal.swref%type
    is

    l_msgValueDate  sw_journal.vdate%type;   /* Дата валютирования исходного сообщения */
    l_msgRelRef     sw_journal.trn%type;     /* SWIFT референс связанного сообщения */
    l_swRef         sw_journal.swref%type;   /* Референс связанного сообщения */

    begin

        select vdate into l_msgValueDate
          from sw_journal
         where swref = p_swRef;

        select substr(value, 1, 16) into l_msgRelRef
          from sw_operw
         where swref = p_swRef
           and tag   = '21'
           and opt is null;

         bars_audit.trace('Related message SWIFT reference is %s', l_msgRelRef);

         select swref into l_swRef
           from sw_journal
          where trn = l_msgRelRef
            and vdate between l_msgValueDate - 30 and l_msgValueDate;

         return l_swRef;

    exception
        when NO_DATA_FOUND then return null;
        when TOO_MANY_ROWS then return null;
    end get_message_relmsg;

    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_GETPARAMS()
    --
    --   Процедура получения реквизитов для формируемого документа
    --   по входящему (импортированному) сообщению
    --
    --
    --
    procedure impmsg_document_getparams(
                  p_swRef        in      sw_journal.swref%type,
                  p_docMfoB      in out  oper.mfob%type,
                  p_docCurCode   in out  oper.kv2%type,
                  p_docAccNum    in out  oper.nlsb%type,
                  p_docRcvrId    in out  oper.id_a%type,
                  p_docRcvrName  in out  oper.nam_b%type,
                  p_docAmount    in out  oper.s%type,
                  p_docValueDate in out  oper.vdat%type  )
    is

    l_mt        sw_journal.mt%type;      /* Тип сообщения SWIFT */
    l_swRef     sw_journal.swref%type;   /* */
    l_relSwRef  sw_journal.swref%type;   /* */
    l_docRef    oper.ref%type;           /* Референс документа */
    l_72        number;

    begin

        bars_audit.trace('Getting document parameters for SwRef=%s...', to_char(p_swRef));

        begin
            select mt into l_mt
              from sw_journal
             where swref = p_swRef;
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20780, '\300 Сообщение с реф. ' || to_char(p_swRef) || ' не найдено');
        end;

        bars_audit.trace('message type is %s', to_char(l_mt));

        --Для МТ900 перевірим чи це комісія
         if l_mt='900' then
            begin
                 select instr(value, 'VO80050') into l_72
                   from sw_operw
                  where swref=p_swRef
                    and tag='72'
                    and rownum=1;
            exception
                when NO_DATA_FOUND then
                    l_72:=0;
            end;
        end if;

        -- Сейчас обрабатываем только подстановку для информационных документов
        -- Олег М. Для МТ900 ( коммис.)
        if (substr(to_char(l_mt), 2, 1) = '9') or (to_char(l_mt) = '900' and l_72>0) then

            l_swRef := p_swRef;

            while (1=1)
            loop
                l_relSwRef := get_message_relmsg(l_swRef);

                if (l_relSwRef is not null and l_relSwRef != l_swRef) then

                    l_swRef := l_relSwRef;

                    select mt into l_mt
                      from sw_journal
                     where swref = l_swRef;

                    if (substr(to_char(l_mt), 2, 1) != '9') then exit;
                    end if;

                else
                    exit;
                end if;

            end loop;


            --
            -- Если нашли связанное не информационное сообщение,
            -- пытаемся найти документ
            --
            if (l_swRef != p_swRef) then

                begin

                    select p.ref, p.mfob, p.kv2, p.nlsb, p.id_a, p.nam_b, p.s
                      into l_docRef, p_docMfoB, p_docCurCode, p_docAccNum, p_docRcvrId,
                           p_docRcvrName, p_docAmount
                      from sw_oper o, oper p
                     where o.swref = l_swRef
                       and o.ref   = p.ref;

                    bars_audit.trace('Document ref is %s', to_char(l_docRef));

                exception
                    when NO_DATA_FOUND then null;
                end;

            end if;

        end if;

    end impmsg_document_getparams;


    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_STORETAG()
    --
    --     Процедура дополняет документ доп. реквизитами из полей
    --     указанного сообщения SWIFT
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_swRef        Референс сообщения
    --
    --
    procedure impmsg_document_storetag(
                 p_docRef   in  oper.ref%type,
                 p_swRef    in  sw_journal.swref%type,
                 p_swRowNum in  number                 )
    is

    l_mt    sw_journal.mt%type;  /* тип сообщения */
    l_value sw_operw.value%type; /* значение поля (для строки выписки) */

    begin

        bars_audit.trace('Inserting SWIFT message SwRef=%s tags into document Ref=%s...', to_char(p_swRef), to_char(p_docRef));

        select mt into l_mt
          from sw_journal
         where swref = p_swRef;

        bars_audit.trace('Message type is %s', to_char(l_mt));

        if (l_mt != 950) then

            --
            -- Первая версия реализации конвертации полей сообщения
            -- в поля документа. Пока мы только ограничились проверкой
            -- нужно ли данное поле заносить в доп. реквизиты
            --
            for i in (select w.tag, w.opt, w.value
                        from sw_operw w
                       where swref = p_swRef
                         and exists (select 1
                                       from sw_model
                                      where mt            = l_mt
                                        and tag           = w.tag
                                        and nvl(decode(opt, 'a', w.opt, opt), '-') = nvl(w.opt, '-')
                                        and mtdtag is not null             )
                      order by n )
            loop

                bars_audit.trace('Inserting value for tag=%s opt=%s...', i.tag, i.opt);

                update operw
                   set value = substr(value || chr(13) || chr(10) || i.value, 1, 200)
                 where ref = p_docRef
                   and tag = rpad(i.tag || i.opt, 5, ' ');

                if (sql%rowcount = 0) then

                    bars_audit.trace('Document Ref=%s tag=%s not found, trying insert...', to_char(p_docRef), i.tag || i.opt);

                    insert into operw(ref, tag, value)
                    values (p_docRef, i.tag || i.opt, substr(i.value, 1, 200));

                    bars_audit.trace('Document Ref=%s tag=%s inserted.', to_char(p_docRef), i.tag || i.opt);

                else
                    bars_audit.trace('Document Ref=%s tag=%s updated.', to_char(p_docRef), i.tag || i.opt);
                end if;


            end loop;

        else

            bars_audit.trace('Get value for line %s of message SwRef=%s...', to_char(p_swRowNum), to_char(p_swRef));

            -- вставляем только одну строку выписки
            select value into l_value
              from sw_operw
             where swref = p_swRef
               and n     = p_swRowNum;

            insert into operw(ref, tag, value)
            values (p_docRef, '61', substr(l_value, 1, 200));

            bars_audit.trace('Document Ref=%s tag=61 inserted.', to_char(p_docRef));

        end if;
        bars_audit.trace('Message tags successfully inserted into document');

    end impmsg_document_storetag;


    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_STORETAG2()
    --
    --     Процедура дополняет документ доп. реквизитами из полей
    --     исх. документа по указанному типу сообщения
    --
    --
    --      Параметры:
    --
    --          p_tgtDocRef    Референс цел. документа
    --
    --          p_srcDocRef    Референс исх. сообщения
    --
    --          p_swmt         Тип сообщения
    --
    --
    procedure impmsg_document_storetag2(
                 p_tgtdocref   in  t_docref,
                 p_srcdocref   in  t_docref,
                 p_swmt        in  t_swmt    )
    is
    p        constant varchar2(100) := PKG_CODE || 'impmsgdocstrtag2';
    --
    l_mt    sw_journal.mt%type;  /* тип сообщения */
    l_value sw_operw.value%type; /* значение поля (для строки выписки) */

    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s', to_char(p_tgtdocref), to_char(p_srcdocref), to_char(p_swmt));

        -- Проходим по модели сообщения определяя тэги для переноса
        for i in (select w.tag, w.value
                    from operw w,
                         (select mtdtag
                            from sw_model
                           where mt    = p_swmt
                             and (opt is null or opt != 'a')
                          union all
                          select substr(m.mtdtag, 1, 2) || decode(o.opt, '-', null, o.opt)
                            from sw_model m, sw_model_opt o
                           where m.mt = p_swmt
                             and m.opt is not null
                             and m.opt = 'a'
                             and m.mt = o.mt
                             and m.num = o.num ) m
                   where w.ref = p_srcdocref
                     and w.tag = m.mtdtag   )
        loop
            bars_audit.trace('%s: sync tag %s...', p, i.tag);
            insert into operw(ref, tag, value)
            values (p_tgtdocref, i.tag, i.value);
            bars_audit.trace('%s: tag %s stored in doc', p, i.tag);
        end loop;
        bars_audit.trace('%s: succ end', p);

    end impmsg_document_storetag2;



    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_SYNCTAG()
    --
    --     Процедура дополняет документ доп. реквизитами SWIFT,
    --     аналогичными доп. реквизитам в исходном документе
    --
    --
    --      Параметры:
    --
    --          p_docRefSrc    Референс исходного документа
    --
    --          p_docRefTgt    Референс целевого сообщения
    --
    --
    procedure impmsg_document_synctag(
                 p_docRefSrc   in  oper.ref%type,
                 p_docRefTgt   in  oper.ref%type )
    is

    l_pos      number;
    l_docState oper.sos%type;     /* Состояние целевого документа */
    l_msgType  operw.value%type;  /* Тип сообщения */
    l_msgMt    sw_mt.mt%type;     /* Тип сообщения */
    l_msgRef   sw_journal.swref%type; /* Референс сообщения */

    begin

        bars_audit.trace('sync tags from document Ref=%s to document Ref=%s...', to_char(p_docRefSrc), to_char(p_docRefTgt));

        begin
            select value   into l_msgtype
              from operw
             where ref = p_docRefSrc
               and tag = 'f    ';

        exception
            when NO_DATA_FOUND then

               select d_rec into l_msgtype
                 from oper
                where ref = p_docRefSrc;

               l_pos := instr(l_msgtype, '#f');

               if (l_msgtype is not null and l_pos != 0) then
                   l_msgtype := substr(l_msgtype, l_pos + 2, instr(substr(l_msgtype, l_pos + 2), '#') - 1);
               else
                   l_msgtype := null;
               end if;
        end;

        bars_audit.trace('source document msgtype is %s', l_msgtype);

        if (l_msgType is null) then
            bars_audit.trace('source document without parameter f, skip operation.');
            return;
        end if;

        -- Проверяем состояние целевого документа, если полностью оплачен,
        -- то копировать доп. реквизиты нельзя
        select sos into l_docState
          from oper
         where ref = p_docRefTgt;

        if (l_docState = 5) then
            bars_audit.error('\320 Документ Ref=' || to_char(p_docRefTgt) || ' уже оплачен');
            raise_application_error(-20781, '\320 Документ Ref=' || to_char(p_docRefTgt) || ' уже оплачен');
        end if;

        -- Получаем тип сообщения
        l_msgMt := to_number(substr(l_msgType, 4));

        bars_audit.trace('message type in source document is %s', to_char(l_msgMt));

        -- Ищем нужное сообщение и копируем
        begin
            select j.swref  into l_msgRef
              from sw_oper o, sw_journal j
             where o.ref   = p_docRefSrc
               and o.swref = j.swref
               and j.mt    = l_msgMt;
        exception
            when NO_DATA_FOUND then l_msgref := null;

        end;
        bars_audit.trace('source document linked message SwRef=%s, storing...', to_char(l_msgRef));

        if (l_msgref is not null) then
            impmsg_document_storetag(p_docRefTgt, l_msgRef, null);
        else
            impmsg_document_storetag2(p_docRefTgt, p_docRefSrc, l_msgMt);
        end if;

        bars_audit.trace('message tags stored in target document, looking for info messages...');

        -- Ищем информационные сообщения
        for i in (select j.swref
                    from sw_oper o, sw_journal j
                   where o.ref    = p_docRefSrc
                     and o.swref  = j.swref
                     and j.mt    != l_msgMt
                     and substr(to_char(mt), 2, 1) = '9')
        loop
            impmsg_document_storetag(p_docRefTgt, i.swref, null);
        end loop;

        bars_audit.trace('All message tags stored in target document Ref=%s.', to_char(p_docRefTgt));

    end impmsg_document_synctag;


    -----------------------------------------------------------------
    -- GET_MESSAGE_CONDITION()
    --
    --     Функция проверяет вхождение указанной подстроки в
    --     сообщение. Если подстрока найдена в сообщении, то
    --     функция возвращает значение 1, иначе 0
    --
    --      Параметры:
    --
    --          p_swRef   Референс сообщения
    --
    --          p_text    Текстовая подстрока
    --
    --
    function get_message_condition(
                 p_swRef   in  sw_journal.swref%type,
                 p_text    in  varchar2               ) return number
    is

    l_existFlag  boolean := false;

    begin

        if (p_text is null) then
            return 1;
        end if;

        for i in (select 1
                    from sw_operw
                   where swref = p_swRef
                     and tag || opt || ': ' || value like '%' || p_text || '%')
        loop
            l_existFlag := true;
            exit;
        end loop;

        if (l_existFlag) then
            return 1;
        else
            return 0;
        end if;

    end get_message_condition;


    -----------------------------------------------------------------
    -- GENMSG_DOCUMENT_CORACCSKIP()
    --
    --   Процедура выполняет снятие документа с подбора корсчета
    --
    --
    procedure genmsg_document_coraccskip(
                  p_ref   in oper.ref%type )
    is
    begin

        bars_audit.trace('genmsg_skip_coracc: entry');

        update operw
           set value = '-1'
         where ref = p_ref
           and tag = 'NOS_A';

        if (sql%rowcount = 0) then
            bars_audit.trace('genmsg_skip_coracc: NOS_A req not found!');
            bars_audit.error('SWT\430 Не найден доп. реквизит NOS_A документа Ref=' || to_char(p_ref));
            raise_application_error(-20781, '\430 Не найден доп. реквизит NOS_A документа Ref=' || to_char(p_ref));
        end if;

        bars_audit.financial('Документ снят с подбора корсчета. Ref=' || to_char(p_ref));
        bars_audit.trace('genmsg_skip_coracc: succ end');

    end genmsg_document_coraccskip;


    -----------------------------------------------------------------
    -- DOCUMENT_UNLINK()
    --
    --     Процедура удаления привязок всех сообщений и выписок к
    --     указанному документу
    --
    --      Параметры:
    --
    --          p_docRef  Референс документа
    --
    --
    procedure document_unlink(
                 p_docRef  in  oper.ref%type )
    is
    p         constant varchar2(100) := 'swt.docunlink';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_docRef));

        bars_audit.trace('%s: looking for linked messages...');
        for c in (select swref
                    from sw_oper
                   where ref = p_docref)
        loop
            bars_audit.trace('%s: unlinking document %s from message %s...');
            --
            -- Используем внутреннюю процедуру удаления привязки, т.к. все
            -- связанные сообщения определяем сами (по привязке документа)
            -- и не зависим от параметра работы со связанными сообщениями
            --
            impmsgi_document_unlink(p_docref, c.swref);
            bars_audit.trace('%s: relation with document %s and message %s removed.');
        end loop;
        bars_audit.trace('%s: messages unlinked.', p);

        bars_audit.financial(bars_msg.get_msg(MODCODE, 'DOCUMENT_UNLINK_COMPLETED', to_char(p_docRef)));
        bars_audit.trace('%s: succ end', p);

    end document_unlink;


    -----------------------------------------------------------------
    -- STMT_PARSE_QUEUE()
    --
    --     Процедура разбора принятых выписок
    --
    --
    --
    procedure stmt_parse_queue
    is

    p         constant varchar2(100) := 'swt.stmtparseque';

    l_errmsg  varchar2(4000);  /* сообщение об ошибке */

    begin
        bars_audit.trace('%s: entry point', p);
        bars_audit.info(bars_msg.get_msg(MODCODE, 'STMT_PARSE_QUEUE_START'));

        --
        -- Отбираем все выписки, которые еще не разобраны
        --
        for i in (select j.swref
                     from sw_journal j
                    where decode(date_pay, null, 1, null) = 1
                      and j.io_ind = DIRECTION_INPUT
                      and j.mt    in (select mt from sw_stmt)
                      and not exists (select 1
                                        from sw_950
                                       where swref = j.swref)
                      and not exists (select 1
                                        from sw_950_arch
                                       where swref = j.swref)
                                       )
        loop
            begin
                istmt_parse_stmt(i.swref);
                istmt_parse_error(i.swref, STMT_PARSEERROR_CLEAR, l_errmsg);
                commit;
            exception
                when OTHERS then
                    l_errmsg := sqlerrm;
                    rollback;
                    bars_audit.error(bars_error.get_nerror_text(MODCODE, 'STMT_PARSE_ERROR', to_char(i.swref), l_errmsg));
                    bars_audit.warning(bars_msg.get_msg(MODCODE, 'STMT_PARSE_STMT_SKIP', to_char(i.swref)));
                    istmt_parse_error(i.swref, STMT_PARSEERROR_SET, l_errmsg);
            end;
        end loop;

        bars_audit.info(bars_msg.get_msg(MODCODE, 'STMT_PARSE_QUEUE_END'));
        bars_audit.trace('%s: succ end.', p);

    end stmt_parse_queue;

    -----------------------------------------------------------------
    -- PARSESTATEMENT()
    --
    --     Процедура разбора импортированных выписок
    --     ! Устарела, использовать STMT_PARSE_QUEUE()
    --
    --
    --
    procedure ParseStatement
    is
    begin
        stmt_parse_queue;
    end parsestatement;




    -----------------------------------------------------------------
    -- STMTI_LOCK()
    --
    --     Процедура блокировки выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --          p_stmtrow  Номер строки выписки
    --
    --
    procedure stmti_lock(
                 p_stmtref  in  t_stmtref,
                 p_stmtrow  in  t_stmtrnum )
    is
    p             constant varchar2(100) := MODCODE || '.stmtlck';

    ora_lock      exception;
    pragma        exception_init(ora_lock, -54);

    l_stmthdrrow  sw_950%rowtype;        /* строка заголовка выписки */
    l_stmtrow     sw_950d%rowtype;       /*           строка выписки */
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow));

        select * into l_stmthdrrow
          from sw_950
         where swref = p_stmtref
        for update nowait;
        bars_audit.trace('%s: stmt %s header locked', p, to_char(p_stmtref));

        select * into l_stmtrow
          from sw_950d
         where swref = p_stmtref
           and n     = p_stmtrow
        for update nowait;
        bars_audit.trace('%s: stmt %s row %s locked', p, to_char(p_stmtref), to_char(p_stmtrow));

        bars_audit.trace('%s: succ end', p);

    exception
        when NO_DATA_FOUND then
            bars_error.raise_nerror(MODCODE, 'STMT_ROW_NOTFOUND', to_char(p_stmtref), to_char(p_stmtrow));
        when ORA_LOCK      then
            bars_error.raise_nerror(MODCODE, 'STMT_ROW_LOCKED', to_char(p_stmtref), to_char(p_stmtrow));
    end stmti_lock;


    -----------------------------------------------------------------
    -- STMTI_STATE_REFRESH()
    --
    --     Процедура обновления состояния выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --
    procedure stmti_state_refresh(
                 p_stmtref  in  t_stmtref )
    is
    begin
        null;
    end stmti_state_refresh;



    -----------------------------------------------------------------
    -- STMTI_ROWSTATE_GET()
    --
    --     Процедура получения состояния строки выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --          p_stmtrow  Номер строки выписки
    --
    --      Возвращаемое значение:  Код состояния
    --
    --
    function stmti_rowstate_get(
                 p_stmtref  in  t_stmtref,
                 p_stmtrow  in  t_stmtrnum) return t_stmtstt
    is
    p            constant varchar2(100) := MODCODE || '.stmtirowstget';

    l_stmtstt   t_stmtstt;   /* код состояния строки */
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow));

        select checked_ind into l_stmtstt
          from sw_950d
         where swref = p_stmtref
           and n     = p_stmtrow;
        bars_audit.trace('%s: stmt row state %s',p, l_stmtstt);
        bars_audit.trace('%s: succ end', p);
        return l_stmtstt;

    end stmti_rowstate_get;



    -----------------------------------------------------------------
    -- STMTI_ROWSTATE_CHANGE()
    --
    --     Процедура установки состояния строки выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --          p_stmtrow  Номер строки выписки
    --
    --          p_stmtstt  Код состояния
    --
    --
    procedure stmti_rowstate_change(
                 p_stmtref  in  t_stmtref,
                 p_stmtrow  in  t_stmtrnum,
                 p_stmtstt  in  t_stmtstt  )
    is
    p         constant varchar2(100) := MODCODE || '.stmtrsttchg';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow), p_stmtstt);

        update sw_950d
           set checked_ind = p_stmtstt
         where swref = p_stmtref
           and n     = p_stmtrow;
        bars_audit.trace('%s: stmt row state changed to %s',p, p_stmtstt);
        bars_audit.trace('%s: succ end', p);

    end stmti_rowstate_change;


    -----------------------------------------------------------------
    -- STMTI_SRCMSG_GET()
    --
    --     Функция получения референса исходного сообщения для
    --     строки выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --          p_stmtrow  Номер строки выписки
    --
    --
    --
    function stmti_srcmsg_get(
                 p_stmtref  in  t_stmtref,
                 p_stmtrow  in  t_stmtrnum ) return t_swref
    is
    p         constant varchar2(100) := MODCODE || '.stmtisrcmsgget';
    l_srcmsg  t_swref;
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow));

        select src_swref into l_srcmsg
          from sw_950d
         where swref = p_stmtref
           and n     = p_stmtrow;
        bars_audit.trace('%s: stmt row srcmsg %s', p, to_char(l_srcmsg));
        bars_audit.trace('%s: succ end', p);
        return l_srcmsg;
    exception
        when NO_DATA_FOUND then
            bars_error.raise_nerror(MODCODE, 'STMT_ROW_NOTFOUND', to_char(p_stmtref), to_char(p_stmtrow));
    end stmti_srcmsg_get;



    -----------------------------------------------------------------
    -- STMTI_DOCUMENT_CHECK()
    --
    --     Процедура проверки соответствия документов и строки выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --          p_stmtrow  Номер строки выписки
    --
    --          p_listref  Список документов
    --
    --
    procedure stmti_document_check(
                 p_stmtref  in  t_stmtref,
                 p_stmtrow  in  t_stmtrnum,
                 p_listref  in  t_listref )
    is
    p         constant varchar2(100) := MODCODE || '.stmtidocchk';

    l_trndate sw_950d.vdate%type;   /*              дата транзакции */
    l_trncurr sw_950.kv%type;       /*        код валюты транзакции */
    l_trnamnt sw_950d.s%type;       /*             сумма транзакции */
    l_trnacc  accounts.acc%type;    /*              ид. корр. счета */

    l_docdtmni number;
    l_docdtmax number;

    l_docdate  oper.vdat%type;      /* дата валютирования документа */
    l_doccurr  oper.kv%type;        /*         код валюты документа */
    l_docamnt  oper.s%type;         /*              сумма документа */
    l_docsamnt oper.s%type  := 0;   /*       общая сумма документов */
    l_docacc   accounts.acc%type;    /*             ид. корр. счета */

    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=><list>', p, to_char(p_stmtref), to_char(p_stmtrow));

        -- Получаем реквизиты строки выписки
        begin
            select h.nostro_acc, d.vdate, h.kv, abs(d.s) into l_trnacc, l_trndate, l_trncurr, l_trnamnt
             from sw_950 h, sw_950d d
            where d.swref = p_stmtref
              and d.n     = p_stmtrow
              and d.swref = h.swref;
            bars_audit.trace('%s: stmt row value date %s, currency %s, amount %s', p, to_char(l_trndate, 'dd.mm.yyyy'), to_char(l_trncurr), to_char(l_trnamnt));
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'STMT_ROW_NOTFOUND', to_char(p_stmtref), to_char(p_stmtrow));
        end;

        -- Получаем допустимый диапазон отклонения дат
        l_docdtmni := nvl(to_number(get_param_value(MODPAR_DOCVDTMNI)), MODPAR_DOCVDTMNI_DEFAULT);
        l_docdtmax := nvl(to_number(get_param_value(MODPAR_DOCVDTMAX)), MODPAR_DOCVDTMAX_DEFAULT);
        bars_audit.trace('%s: document value date diff is -%s to +%s.', to_char(l_docdtmni), to_char(l_docdtmax));

        -- Проходим по всем документам
        for i in 1..p_listref.count
        loop
            -- Получаем реквизиты документа
            if l_trnacc is not null then
               begin
                   select p.fdat, p.s into l_docdate, l_docamnt
                     from oper o, opldok p
                    where o.ref = p_listref(i)
                      and o.ref = p.ref
                      and p.acc = l_trnacc;
                   bars_audit.trace('%s: document ref=%s value date %s, currency %s, amount %s', p, to_char(p_listref(i)), to_char(l_docdate, 'dd.mm.yyyy'), to_char(l_doccurr), to_char(l_docamnt));
               exception
                   when NO_DATA_FOUND then
                       bars_error.raise_nerror(MODCODE, 'IMPMSG_DOCUMENT_NOTFOUND', to_char(p_listref(i)));
               end;
            else
               begin
                   select o.vdat, o.s into l_docdate, l_docamnt
                     from oper o
                    where o.ref = p_listref(i);
                   bars_audit.trace('%s: document ref=%s value date %s, currency %s, amount %s', p, to_char(p_listref(i)), to_char(l_docdate, 'dd.mm.yyyy'), to_char(l_doccurr), to_char(l_docamnt));
               exception
                   when NO_DATA_FOUND then
                       bars_error.raise_nerror(MODCODE, 'IMPMSG_DOCUMENT_NOTFOUND', to_char(p_listref(i)));
               end;
            end if;

            --
            -- Проверка кода валюты
            -- if (l_trncurr != l_doccurr) then
            --     bars_audit.trace('%s: error detected - currency is different %s!=%s ref=%s', p, to_char(l_trncurr), to_char(l_doccurr), to_char(p_listref(i)));
            --     bars_error.raise_nerror(MODCODE, 'CHK_DOCUMENT_DIFFCURRENCY', to_char(p_listref(i)), to_char(l_trncurr), to_char(l_doccurr));
            -- end if;
            --

            -- Проверка даты валютирования
            if (l_trndate not between l_docdate - l_docdtmni and l_docdate + l_docdtmax) then
                bars_audit.trace('%s: error detected - value date is different %s!=%s ref=%s', p, to_char(l_trndate, 'dd.mm.yyyy'), to_char(l_docdate, 'dd.mm.yyyy'), to_char(p_listref(i)));
                bars_error.raise_nerror(MODCODE, 'CHK_DOCUMENT_DIFFVDATE', to_char(p_listref(i)), to_char(l_trndate, 'dd.mm.yyyy'), to_char(l_docdate, 'dd.mm.yyyy'));
            end if;

            -- TODO: проверка наличия корсчета в бух модели документа


            -- Аккум. общую сумму
            l_docsamnt := l_docsamnt + nvl(l_docamnt, 0);
        end loop;
        bars_audit.trace('%s: per-document check completed.', p);

        if (l_trnamnt != l_docsamnt) then
            bars_audit.trace('%s: erorr detected - total amount is different %s!=%s', p, to_char(l_trnamnt), to_char(l_docsamnt));
            bars_error.raise_nerror(MODCODE, 'CHK_DOCUMENT_DIFFAMOUNT', to_char(l_trnamnt/100, '9999999990.90'), to_char(l_docsamnt/100, '9999999990.90'));
        end if;
        bars_audit.trace('%s: check completed.', p);
        bars_audit.trace('%s: succ end', p);
    end stmti_document_check;


    -----------------------------------------------------------------
    -- STMTI_DOCUMENT_PUTCHK()
    --
    --     Установка визы на документ при квитовке выписки
    --
    --
    --      Параметры:
    --
    --          p_listref        Список документов
    --
    --
    procedure stmti_document_putchk(
                  p_listref   t_listref )
    is
    p          constant varchar2(100) := 'swt.stmtidocputchk';

    l_chkgrp    number;                  /*                     группа визирования */
    l_chkgrpa   varchar2(2);             /* шестнадцатиричное представление группы */
    l_docref    oper.ref%type;           /*                     референс документа */
    l_doctt     oper.tt%type;            /*                          тип документа */
    l_docchkgrp oper.nextvisagrp%type;   /*           группа визирования документа */
    l_docstate  oper.sos%type;           /*                    состояние документа */

    l_locdate   date;                    /* локальная банковская дата пользователя */
    l_ispay     number;                  /*           признак необходимости оплаты */
    l_issign    number;                  /*          признак необходимости подписи */

    begin
        bars_audit.trace('%s: entry point par[0]=>...', p);

        l_chkgrp  := to_number(get_param_value('SWTNOSGR'));
        l_chkgrpa := lpad(nvl(chk.to_hex(l_chkgrp), 0), 2, '0');
        bars_audit.trace('%s: chkgrp for doc is %s', p, to_char(l_chkgrp));

        -- Выходим если группа не задана
        if (l_chkgrp is null) then
            bars_audit.trace('%s: chkgrp=null, skip chk put', p);
            return;
        end if;

        -- Проходим по списку документов
        for i in 1..p_listref.count
        loop
            l_docref := p_listref(i);
            bars_audit.trace('%s: processing document %s...', p, to_char(l_docref));

            -- Получаем реквизиты документа
            select tt, nextvisagrp, sos
              into l_doctt, l_docchkgrp, l_docstate
              from oper
             where ref = l_docref;
            bars_audit.trace('%s: doc tt=%s chkgrp=%s sos=%s', p, l_doctt, l_docchkgrp, to_char(l_docstate));

            if (l_docchkgrp = l_chkgrpa and l_docstate between 0 and 3) then

                l_locdate := bankdate();
                bars_audit.trace('%s: local user bankdate is %s', to_char(l_locdate, 'dd.mm.yyyy'));

                -- Блокируем документ
                chk.lock_doc(l_docref, l_chkgrp, l_ispay, l_issign);
                bars_audit.trace('%s: doc %s is locked.', p, to_char(l_docref));

                -- Ставим визу
                chk.put_visa(l_docref, l_doctt, l_chkgrp, l_ispay+1, null, null, null);
                bars_audit.trace('%s: call chk.put_visa(%s) succ completed.', p, to_char(l_docref));

                if (l_ispay = 1) then
                    bars_audit.trace('%s: trying to pay doc %s...', p, to_char(l_docref));
                    gl.pay(2, l_docref, l_locdate);
                    bars_audit.trace('%s: doc %s succ payed.', p, to_char(l_docref));
                end if;
            end if;
            bars_audit.trace('%s: document %s processed', p, to_char(l_docref));
        end loop;
        bars_audit.trace('%s: succ end', p);

    end stmti_document_putchk;



    -----------------------------------------------------------------
    -- STMT_DOCUMENT_BACKCHK()
    --
    --     Снятие визы с документов при отвязке от выписки
    --
    --
    --      Параметры:
    --
    --          p_listref      Список документов
    --
    procedure stmti_document_backchk(
                  p_listref   t_listref  )
    is
    p          constant varchar2(100) := 'swt.stmtidocbckchk';

    l_chkgrp     number;                  /*                     группа визирования */
    l_chkgrp2    varchar2(2);             /*           последняя группа визирования */
    l_chkgrpa    varchar2(2);             /* шестнадцатиричное представление группы */
    l_docref     oper.ref%type;           /*                     референс документа */
    l_doctt      oper.tt%type;            /*                          тип документа */
    l_docchkgrp  oper.nextvisagrp%type;   /*           группа визирования документа */
    l_docstate   oper.sos%type;           /*                    состояние документа */
    l_ispay      number;                  /*           признак необходимости оплаты */
    l_issign     number;                  /*          признак необходимости подписи */

    begin
        bars_audit.trace('%s: entry point par[0]=><list>', p);

        l_chkgrp := to_number(get_param_value('SWTNOSGR'));
        l_chkgrpa := lpad(nvl(chk.to_hex(l_chkgrp), 0), 2, '0');
        bars_audit.trace('%s: chkgrp for doc is %s', p, to_char(l_chkgrp));

        -- Выходим если группа не задана
        if (l_chkgrp is null) then
            bars_audit.trace('%s: chkgrp=null, skip chk put', p);
            return;
        end if;

        for i in 1..p_listref.count
        loop
            l_docref := p_listref(i);
            bars_audit.trace('%s: processing document %s...', p, to_char(l_docref));

            -- Получаем реквизиты документа
            select tt, currvisagrp, nextvisagrp, sos
              into l_doctt, l_docchkgrp, l_chkgrp2, l_docstate
              from oper
             where ref = l_docref;
            bars_audit.trace('%s: doc tt=%s chkgrp=%s sos=%s', p, l_doctt, l_docchkgrp, to_char(l_docstate));

            if (l_docchkgrp = l_chkgrpa and l_docstate between 0 and 3) then

                -- Возврат на предыдущую визу
                bars_audit.trace('%s: back document to prev chk...', p);

                -- Блокируем документ
                chk.lock_doc(l_docref, to_number(l_chkgrp2, 'XX'), l_ispay, l_issign);
                bars_audit.trace('%s: document locked.', p);

                update oper
                   set chk = substr(chk, 1, length(rtrim(chk))-6)
                 where ref = l_docref;

                delete from oper_visa
                 where sqnc = (select max(sqnc)
                                 from oper_visa
                                where ref = l_docref);

                insert into oper_visa (ref, dat, userid, groupid, status, passive)
                values (l_docref, sysdate, user_id, l_chkgrp, 0, 1);
            end if;
            bars_audit.trace('%s: document %s processed', p, to_char(l_docref));

        end loop;
        bars_audit.trace('%s: succ end', p);

    end stmti_document_backchk;























    -----------------------------------------------------------------
    -- STMTI_DOCUMENT_LINK()
    --
    --     Процедура привязки документов к строке выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --          p_stmtrow  Номер строки выписки
    --
    --          p_listref  Список документов
    --
    --
    procedure stmti_document_link(
                 p_stmtref  in  t_stmtref,
                 p_stmtrow  in  t_stmtrnum,
                 p_listref  in  t_listref )
    is
    p         constant varchar2(100) := MODCODE || '.stmtidoclink';
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=><list>', p, to_char(p_stmtref), to_char(p_stmtrow));

        -- Блокируем строку выписки (пока блокировка накладывается во внешней процедуре)
        -- stmti_lock(p_stmtref, p_stmtrow);
        -- bars_audit.trace('%s: stmt %s locked', p, to_char(p_stmtref));

        -- Проверяем состояние строки выписки
        if (stmti_rowstate_get(p_stmtref, p_stmtrow) = STMTROW_PROCESSED) then
            bars_audit.trace('%s: error - linked documents found', p);
            bars_error.raise_error(MODCODE, 'STMT_ROWDOC_ALREADY_LINKED', to_char(p_stmtrow), to_char(p_stmtref));
        end if;

        -- Привязываем документы
        forall i in 1..p_listref.count
            insert into sw_oper(swref, swrnum, ref)
            values (p_stmtref, p_stmtrow, p_listref(i));
        bars_audit.trace('%s: documents linked', p);

        -- Если необходимо, то устанавливаем визу на документы
        stmti_document_putchk(p_listref);
        bars_audit.trace('%s: document chk is set.', p);


        -- Устанавливаем статус обработанной строки
        stmti_rowstate_change(p_stmtref, p_stmtrow, STMTROW_PROCESSED);
        bars_audit.trace('%s: stmt row state changed to PROCESSED', p);
        bars_audit.financial(bars_msg.get_msg(MODCODE, 'STMT_ROWDOC_LINKED', to_char(p_stmtrow), to_char(p_stmtref)));

        -- Обновляем состояние выписки
        stmti_state_refresh(p_stmtref);
        bars_audit.trace('%s: stmt state refreshed', p);
        bars_audit.trace('%s: succ end', p);

    end stmti_document_link;


    -----------------------------------------------------------------
    -- STMTI_DOCUMENT_UNLINK()
    --
    --     Процедура отвязки документов от строки выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --          p_stmtrow  Номер строки выписки
    --
    --
    procedure stmti_document_unlink(
                 p_stmtref  in  t_stmtref,
                 p_stmtrow  in  t_stmtrnum )
    is
    p         constant varchar2(100) := MODCODE || '.stmtidoculnk';
    l_listref t_listref;
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow));

        -- Проверяем состояние строки выписки
        if (stmti_rowstate_get(p_stmtref, p_stmtrow) = STMTROW_UNPROCESSED) then
            bars_audit.trace('%s: error - linked documents found', p);
            bars_error.raise_error(MODCODE, 'STMT_ROWDOC_NOTLINKED', to_char(p_stmtrow), to_char(p_stmtref));
        end if;

        -- Получаем список документов
        select ref bulk collect into l_listref
          from sw_oper
         where swref  = p_stmtref
           and swrnum = p_stmtrow;
        bars_audit.trace('%s: stmt row doclist created', p);

        -- Удаляем привязку
        delete from sw_oper
         where swref  = p_stmtref
           and swrnum = p_stmtrow;
        bars_audit.trace('%s: stmt row documents unlinked', p);

        -- Удаляем визу с документов
        stmti_document_backchk(l_listref);
        bars_audit.trace('%s: stmt row documents chk backed', p);

        -- Устанавливаем статус обработанной строки
        stmti_rowstate_change(p_stmtref, p_stmtrow, STMTROW_UNPROCESSED);
        bars_audit.trace('%s: stmt row state changed to UNPROCESSED', p);
        bars_audit.financial(bars_msg.get_msg(MODCODE, 'STMT_ROWDOC_UNLINKED', to_char(p_stmtrow), to_char(p_stmtref)));

        -- Обновляем состояние выписки
        stmti_state_refresh(p_stmtref);
        bars_audit.trace('%s: stmt state refreshed', p);
        bars_audit.trace('%s: succ end', p);

    end stmti_document_unlink;



    -----------------------------------------------------------------
    -- STMTI_SRCMSG_CHECK()
    --
    --     Процедура проверки соответствия сообщения и строки выписки
    --
    --      Параметры:
    --
    --          p_stmtref  Референс выписки
    --
    --          p_stmtrow  Номер строки выписки
    --
    --          p_srcswref Референс сообщения
    --
    --
    procedure stmti_srcmsg_check(
                 p_stmtref  in  t_stmtref,
                 p_stmtrow  in  t_stmtrnum,
                 p_srcswref in  t_swref     )
    is
    p         constant varchar2(100) := MODCODE || '.stmtisrcmsgchk';

    l_trncurr sw_journal.currency%type; /*        код валюты транзакции */
    l_trndate sw_950d.vdate%type;       /*              дата транзакции */
    l_trnamnt sw_950d.s%type;           /*             сумма транзакции */

    l_msgcurr sw_journal.currency%type; /*         код валюты сообщения */
    l_msgdate sw_journal.vdate%type;    /*               дата сообщения */
    l_msgamnt sw_journal.amount%type;   /*              сумма сообщения */

    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow), to_char(p_srcswref));

        -- Получаем реквизиты строки выписки
        select h.currency, d.vdate, abs(d.s) into l_trncurr, l_trndate, l_trnamnt
          from sw_950d d, sw_journal h
         where d.swref = p_stmtref
           and d.n     = p_stmtrow
           and d.swref = h.swref;
        bars_audit.trace('%s: stmt req: currency %s, value date %s, amount %s', p, l_trncurr, to_char(l_trndate, 'dd.mm.yyyy'), to_char(l_trnamnt));

        -- Получаем реквизиты сообщения
        select h.currency, h.vdate, h.amount into l_msgcurr, l_msgdate, l_msgamnt
          from sw_950d d, sw_journal h
         where d.swref = p_stmtref
           and d.n     = p_stmtrow
           and d.swref = h.swref;
        bars_audit.trace('%s: srcmsg req: currency %s, value date %s, amount %s', p, l_msgcurr, to_char(l_msgdate, 'dd.mm.yyyy'), to_char(l_msgamnt));

        if (l_trncurr != l_msgcurr or l_trndate != l_msgdate or l_trnamnt != l_msgamnt) then
            bars_audit.trace('%s: error detected - srcmsg and stmt req is different');
            bars_error.raise_nerror(MODCODE, 'STMT_SRCMSG_REQDIFF', to_char(p_stmtref), to_char(p_stmtrow), to_char(p_srcswref));
        end if;
        bars_audit.trace('%s: check completed.', p);
        bars_audit.trace('%s: succ end', p);

    end stmti_srcmsg_check;


    -----------------------------------------------------------------
    -- STMTI_SRCMSG_LOOKUP()
    --
    --     Функция поиска сообщения,   соответствующих критериям
    --     строки выписки. Если сообщение не найдено или найдено
    --     более одного сообщения, то функция возвращает NULL.
    --
    --      Параметры:
    --
    --          p_trn       Референс транзакции SWIFT
    --
    --          p_vdate     Дата валютирования
    --
    --          p_amount    Сумма сообщения
    --
    function stmti_srcmsg_lookup(
                 p_trn    in  sw_journal.trn%type,
                 p_vdate  in  sw_journal.vdate%type,
                 p_amount in  sw_journal.amount%type ) return sw_journal.swref%type
    is
    p         constant   varchar2(100)  := 'swt.getstmtsrcmsg';
    l_swref   sw_journal.swref%type;       /*  ид. сообщения */
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s', p,
                          p_trn, to_char(p_vdate, 'dd.mm.yyyy'), to_char(p_amount));

        select swref into l_swref
          from sw_journal
         where trn    = p_trn
           and vdate  = p_vdate
           and amount = p_amount;

        bars_audit.trace('%s: succ end, return %s', p, to_char(l_swref));
        return l_swref;
    exception
        when NO_DATA_FOUND then
            bars_audit.trace('%s: src message not found', p);
            return null;
        when TOO_MANY_ROWS then
            bars_audit.trace('%s: many src messages found', p);
            return null;
    end stmti_srcmsg_lookup;











    -----------------------------------------------------------------
    -- STMT_DOCUMENT_LINK()
    --
    --     Процедура привязки документов АБС к строке выписки
    --
    --
    --      Параметры:
    --
    --          p_stmtref        Референс выписки
    --
    --          p_stmtrow        Номер строки выписки
    --
    --          p_listref        Список документов
    --
    --          p_force          Признак принудительной привязки,
    --                           без выполнения проверок
    --
    procedure stmt_document_link(
                  p_stmtref  in  t_stmtref,
                  p_stmtrow  in  t_stmtrnum,
                  p_listref  in  t_listref,
                  p_force    in  number     )
    is
    p              constant varchar2(100) := 'swt.stmtdoclnk';
    l_srcmsgref    t_swref;                 /* референс привязанного сообщения */
    begin
        bars_audit.trace('%s: entry point par[0]=> par[1]=>%s par[2]=>...', p, to_char(p_stmtref), to_char(p_stmtrow));

        -- Блокируем выписку
        stmti_lock(p_stmtref, p_stmtrow);
        bars_audit.trace('%s: stmt locked', p);

        -- Проверяем строку выписки и документы
        if (p_force = FLAG_FORCE) then
            bars_audit.trace('%s: document check skipped on FORCE flag', p);
        else
            stmti_document_check(p_stmtref, p_stmtrow, p_listref);
        end if;
        bars_audit.trace('%s: document check completed', p);

        l_srcmsgref := stmti_srcmsg_get(p_stmtref, p_stmtrow);
        bars_audit.trace('%s: stmt row source message %s',p, l_srcmsgref);

        stmti_document_link(p_stmtref, p_stmtrow, p_listref);
        bars_audit.trace('%s: stmt row documents linked', p);

        -- Если есть исходное сообщение, то выполняем привязку к сообщению
        if (l_srcmsgref is not null) then
            impmsgi_document_link(p_listref, l_srcmsgref);
        end if;

        bars_audit.trace('%s: succ end', p);

    end stmt_document_link;



    -----------------------------------------------------------------
    -- STMT_DOCUMENT_UNLINK()
    --
    --     Процедура удаляет привязку документов к строке выписки.
    --     Если  к  указанной  строке  выписки привязано исходное
    --     сообщение, то будет удалена привязка документа к этому
    --     сообщению.    Удаление  привязки  изменяет   состояние
    --     выписки на "Необработана"
    --
    --      Параметры:
    --
    --          p_stmtref        Референс выписки
    --
    --          p_stmtrow        Номер строки выписки
    --
    --
    procedure stmt_document_unlink(
                  p_stmtref  in  t_stmtref,
                  p_stmtrow  in  t_stmtrnum )
    is
    p              constant varchar2(100) := 'swt.stmtdoculnk';

    l_srcmsgref    t_swref;                 /* референс привязанного сообщения */

    l_docRef   oper.ref%type;           /* референс привязанного документа */
    l_srcSwRef sw_journal.swref%type;   /* референс привязанного сообщения */
    l_swRef    sw_journal.swref%type;   /*              референс сообщения */
    l_srcMt    sw_950d.mt%type;         /*         тип исходного сообщения */

    begin
        bars_audit.trace('%s: entry point par[0]=> par[1]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow));

        -- Блокируем выписку
        stmti_lock(p_stmtref, p_stmtrow);
        bars_audit.trace('%s: stmt locked', p);

        l_srcmsgref := stmti_srcmsg_get(p_stmtref, p_stmtrow);
        bars_audit.trace('%s: stmt row source message %s',p, l_srcmsgref);

        stmti_document_unlink(p_stmtref, p_stmtrow);
        bars_audit.trace('%s: stmt row documents unlinked', p);

        -- Если есть исходное сообщение, то выполняем отвязку от сообщения
        if (l_srcmsgref is not null) then
            impmsg_document_unlink(null, l_srcmsgref);
        end if;

        bars_audit.trace('%s: succ end', p);

    end stmt_document_unlink;





    -----------------------------------------------------------------
    -- STMT_SRCMSG_LINK()
    --
    --     Процедура привязки исходного сообщения  к строке выписки.
    --     Строка выписки, к которой выполняется привязка сообщения,
    --     должна иметь признак наличия сообщения,  а  также  должны
    --     совпадать референс, дата валютирования и сумма транзакции
    --
    --
    --      Параметры:
    --
    --          p_stmtref        Референс выписки
    --
    --          p_stmtrow        Номер строки выписки
    --
    --          p_srcswref       Референс исходного сообщения
    --
    --          p_force          Признак принудительной привязки,
    --                           без выполнения проверок
    --
    --
    procedure stmt_srcmsg_link(
                  p_stmtref  in  t_stmtref,
                  p_stmtrow  in  t_stmtrnum,
                  p_srcswref in  t_swref,
                  p_force    in  number     )
    is
    p               constant varchar2(100) := 'swt.stmtsrcmsglnk';

    l_stmtrow     sw_950d%rowtype;  /*                              строка выписки */
    l_msglistref  t_listref;        /*      список привязанных документов сообщения */
    l_trnlistref  t_listref;        /* список привязанных документов строки выписки */



    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s par[2]=>%s par[3]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow), to_char(p_srcswref), to_char(p_force));

        -- Блокируем выписку
        stmti_lock(p_stmtref, p_stmtrow);
        bars_audit.trace('%s: stmt locked', p);

        -- Получаем реквизиты строки
        select * into l_stmtrow
          from sw_950d
         where swref = p_stmtref
           and n     = p_stmtrow;
        bars_audit.trace('%s: stmt row got', p);

        -- Проверяем наличие привязанного сообщения
        if (l_stmtrow.src_swref is not null) then
            bars_audit.trace('%s: error detected - srcmsg already linked', p);
            bars_error.raise_nerror(MODCODE, 'STMT_SRCMSG_ALREADY_LINKED', to_char(p_stmtref), to_char(p_stmtrow));
        end if;

        -- Получаем список документов сообщения
        select ref bulk collect into l_msglistref
          from sw_oper
         where swref = p_srcswref;
        bars_audit.trace('%s: srcmsg document list created.', p);

        -- Получаем список документов строки выписки
        select ref bulk collect into l_trnlistref
          from sw_oper
         where swref  = p_stmtref
           and swrnum = p_stmtrow;
        bars_audit.trace('%s: stmt row document list created.', p);

        if (l_msglistref.count != 0 and l_trnlistref.count != 0) then
            bars_audit.trace('%s: error detected - documents on both sides', p);
            bars_error.raise_nerror(MODCODE, 'STMT_SRCMSG_NOTEQ_DOCLISTS', to_char(p_stmtref), to_char(p_stmtrow), to_char(p_srcswref));
        end if;
        bars_audit.trace('%s: doclists check completed.', p);

        -- Проверяем реквизиты сообщения и строки выписки
        if (p_force != FLAG_FORCE) then
            stmti_srcmsg_check(p_stmtref, p_stmtrow, p_srcswref);
        end if;
        bars_audit.trace('%s: srcmsg check completed', p);

        -- Привязываем сообщение
        update sw_950d
           set src_swref= p_srcswref
         where swref = p_stmtref
           and n     = p_stmtrow;
        bars_audit.trace('%s: srcmsg linked with stmt row', p);

        -- Привязываем документы сообщения к строке выписки
        if (l_stmtrow.checked_ind = STMTROW_UNPROCESSED and l_msglistref.count > 0) then
            stmti_document_link(p_stmtref, p_stmtrow, l_msglistref);
        end if;
        bars_audit.trace('%s: srcmsg documents linked with stmt row', p);

        if (l_stmtrow.checked_ind = STMTROW_PROCESSED   and l_msglistref.count = 0) then
            for i in 1..l_trnlistref.count
            loop
                impmsgi_document_link(l_trnlistref(i), p_srcswref);
            end loop;
        end if;
        bars_audit.trace('%s: stmt documents linked with srcmsg', p);

    end stmt_srcmsg_link;


    -----------------------------------------------------------------
    -- STMT_SRCMSG_UNLINK()
    --
    --     Процедура удаляет привязку исходного сообщения к строке
    --     выписки. Выписка при выполнении данной процедуры должна
    --     иметь статус "Не обработана"
    --

    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtRow        Номер строки выписки
    --
    --
    procedure stmt_srcmsg_unlink(
                  p_stmtref  in  t_stmtref,
                  p_stmtrow  in  t_stmtrnum  )
    is
    p              constant varchar2(100) := 'swt.stmtsrcmsgulnk';
    l_srcmsgref    t_swref;     /* референс привязанного сообщения */
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, to_char(p_stmtref), to_char(p_stmtrow));

        -- Блокируем выписку
        stmti_lock(p_stmtref, p_stmtrow);
        bars_audit.trace('%s: stmt locked', p);

        l_srcmsgref := stmti_srcmsg_get(p_stmtref, p_stmtrow);
        bars_audit.trace('%s: stmt row source message %s',p, l_srcmsgref);

        if (l_srcmsgref is not null) then

            -- Удаляем привязку сообщения
            update sw_950d
               set src_swref = null
             where swref = p_stmtref
               and n     = p_stmtrow;
            bars_audit.trace('%s: stmt row srcmsg unlinked', p);

            -- Удаляем привязку документов к строке
            stmti_document_unlink(p_stmtref, p_stmtrow);
        else
            bars_audit.trace('%s: error detected - srcmsg not linked', p);
            bars_error.raise_nerror(MODCODE, 'STMT_SRCMSG_NOTLINKED', to_char(p_stmtref), to_char(p_stmtrow));
        end if;
        bars_audit.trace('%s: succ end', p);

    end stmt_srcmsg_unlink;


    -----------------------------------------------------------------
    -- STMT_SRCMSG_AUTOLINK()
    --
    --     Процедура автоматической привязки исходных  сообщений  к
    --     строкам выписки, которые имеют признак наличия исходного
    --     сообщения.  Поиск исходного сообщения,  соответствующего
    --     строке  выписки  выполняется  по   референсу   сообщения
    --     (подполе 8 или подполе 7 выписки), дате валютирования  и
    --     сумме транзакции
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --
    --
    procedure stmt_srcmsg_autolink(
                  p_stmtref  in  t_stmtref )
    is

    p          constant varchar2(100) := 'swt.stmtsrcmsgalnk';

    type       t_liststmtrows is table of sw_950d%rowtype;

    ora_lock   exception;
    pragma     exception_init(ora_lock, -54);

    l_swref    sw_journal.swref%type;   /*           Референс исходного сообщения */
    l_cnt      number;                  /*                                счетчик */

    l_stmthdr  sw_950%rowtype;          /*               строка заголовка выписки */
    l_stmtrows t_liststmtrows;          /*               детальные строки выписки */

    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_stmtref));

        -- Проверяем нужно ли обрабатывать выписку
        select count(*) into l_cnt
          from sw_950d
         where swref = p_stmtref
           and src_swref is null;
        bars_audit.trace('%s: stmt unprocessed rows %s', p, to_char(l_cnt));

        -- Выходим если делать нечего
        if (l_cnt = 0) then return;
        end if;

        -- Блокируем заголовок и все строки выписки без исх. сообщения
        begin
            select * into l_stmthdr
              from sw_950
             where swref = p_stmtref
            for update nowait;
            bars_audit.trace('%s: stmt header locked', p);

            select * bulk collect into l_stmtrows
              from sw_950d
             where swref = p_stmtref
               and src_swref is null
            for update nowait;
            bars_audit.trace('%s: stmt rows locked', p);
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'STMT_ROW_NOTFOUND', to_char(p_stmtref), '<null>');
            when ORA_LOCK      then
                bars_error.raise_nerror(MODCODE, 'STMT_ROW_LOCKED', to_char(p_stmtref), '<null>');
        end;

        -- Проходим по отобранным строкам
        for i in 1..l_stmtrows.count
        loop
            bars_audit.trace('%s: stmt row %s processing...', p, to_char(l_stmtrows(i).n));

            -- Ищем исходное сообщение по THEIR_REF
            l_swref := stmti_srcmsg_lookup(l_stmtrows(i).their_ref, l_stmtrows(i).vdate, abs(l_stmtrows(i).s));
            bars_audit.trace('%s: (step1) found srcmsg %s', p, to_char(l_swref));

            -- Ищем исходное сообщение по THEIR2_REF
            if (l_swref is null) then
                l_swref := stmti_srcmsg_lookup(l_stmtrows(i).their2_ref, l_stmtrows(i).vdate, abs(l_stmtrows(i).s));
                bars_audit.trace('%s: (step2) found srcmsg %s', p, to_char(l_swref));
            end if;

            -- Привязываем сообщение к строке выписки
            if (l_swref is not null) then
                bars_audit.trace('%s: attempt to link srcmsg %s ...', p, to_char(l_swref));
                stmt_srcmsg_link(p_stmtref, l_stmtrows(i).n, l_swref, 1);
                bars_audit.trace('%s: srcmsg %s linked', p, to_char(l_swref));
            else
                bars_audit.trace('%s: srcmsg not found, link skipped', p);
            end if;
            bars_audit.trace('%s: stmt row %s processed.', p, to_char(l_stmtrows(i).n));

        end loop;
        bars_audit.trace('%s: stmt swref %s srcmsg linking complete.', p, to_char(p_stmtref));

    end stmt_srcmsg_autolink;




    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_LINK()
    --
    --     Процедура привязки документа к импортированному сообщению
    --     Привязываемый документ не должен быть привязан  к  такому
    --     же типу сообщения (кроме выписок).
    --
    --
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_SwRef        Референс сообщения
    --
    -- TODO: Привязка связанных сообщений
    --
    procedure impmsg_document_link(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type )
    is
    p    constant varchar2(100) := 'swt.impmsgdoclink';
    --
    l_stmtref   t_stmtref;
    l_stmtrow   t_stmtrnum;
    l_sw_journal      sw_journal%rowtype;
    --
    begin

        bars_audit.trace('Linking document Ref=%s with main message SwRef=%s ...', to_char(p_docRef), to_char(p_swRef));
        impmsgi_document_link(p_docRef, p_swRef);
        bars_audit.trace('Document Ref=%s successfully linked with main message SwRef=%s.', to_char(p_docRef), to_char(p_swRef));

         begin
            insert into sw_oper_queue (ref, swref,status) values (p_docRef, p_swRef,0);
         exception when dup_val_on_index then null;
         end;

         --читаемо uetr для передачі по ВПС
          begin
           select *
              into l_sw_journal
           from sw_journal
           where swref = p_swref;
          exception when no_data_found then l_sw_journal.uetr:=null;
          end;

          if (l_sw_journal.uetr is not null) then
            begin
                insert into operw(ref, tag, value)
                values(p_docRef, 'UETR', l_sw_journal.uetr);
            exception when dup_val_on_index then null;
            end;
          end if;
          
          if (l_sw_journal.mt='202' and l_sw_journal.cov='COV' and l_sw_journal.imported='Y') then 
            bars_swift_msg.genmsg_mt299(p_swref);
          end if;

        -- Смотрим есть ли строка выписки
        begin
            select swref, n into l_stmtref, l_stmtrow
              from sw_950d
             where src_swref = p_swref;
            bars_audit.trace('%s: found statement %s row %s', p, to_char(l_stmtref), to_char(l_stmtrow));
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: statement row not found', p);
        end;

        if (l_stmtref is not null) then
            stmti_document_link(l_stmtref, l_stmtrow, bars_swift.t_listref(p_docref));
            bars_audit.trace('%s: statement row linked', p);
        end if;

        --
        -- Обрабатываем связанные сообщения
        --
        if (get_param_value(MODPAR_MSGRL) = MODVAL_MSGRL_TRUE) then

            bars_audit.trace('call impmsg_document_linkrel(%s, %s)...', to_char(p_docRef), to_char(p_swRef));
            impmsgi_document_linkrel(p_docRef, p_swRef);
            bars_audit.trace('call impmsg_document_linkrel() successfully completed.');

        else
            bars_audit.trace('Related messages update skipped, mode unset.');
        end if;

        begin
            bars_swift.auto_create_swt(p_docRef, p_swRef);
        exception when others then
            bars_audit.trace(substr(('BARS_SWIFT.AUTO_CREATE_SWT. Ref='||to_char(p_docRef)||'SwRef='||to_char(p_swRef)||'. '||SQLERRM), 1, 4000));
        end;

    end impmsg_document_link;


    -----------------------------------------------------------------
    -- IMPMSG_DOCUMENT_LINK_ALL()
    --
    --     Процедура привязки документа к импортированному сообщению
    --     Привязываемый документ не должен быть привязан  к  такому
    --     же типу сообщения (кроме выписок).
    --     БЕЗ ОГРАНИЧЕНИЯ ДАТ
    --
    --
    --
    --      Параметры:
    --
    --          p_docRef       Референс документа
    --
    --          p_SwRef        Референс сообщения
    --
    -- TODO: Привязка связанных сообщений
    --
    procedure impmsg_document_link_all(
                  p_docRef    in  oper.ref%type,
                  p_swRef     in  sw_journal.swref%type )
    is
    p    constant varchar2(100) := 'swt.impmsgdoclink';
    --
    l_stmtref   t_stmtref;
    l_stmtrow   t_stmtrnum;
    --
    begin

        bars_audit.trace('Linking document Ref=%s with main message SwRef=%s ...', to_char(p_docRef), to_char(p_swRef));
        impmsgi_document_link_all(p_docRef, p_swRef);
        bars_audit.trace('Document Ref=%s successfully linked with main message SwRef=%s.', to_char(p_docRef), to_char(p_swRef));

        -- Смотрим есть ли строка выписки
        begin
            select swref, n into l_stmtref, l_stmtrow
              from sw_950d
             where src_swref = p_swref;
            bars_audit.trace('%s: found statement %s row %s', p, to_char(l_stmtref), to_char(l_stmtrow));
        exception
            when NO_DATA_FOUND then
                bars_audit.trace('%s: statement row not found', p);
        end;

        if (l_stmtref is not null) then
            stmti_document_link(l_stmtref, l_stmtrow, bars_swift.t_listref(p_docref));
            bars_audit.trace('%s: statement row linked', p);
        end if;

        --
        -- Обрабатываем связанные сообщения
        --
        if (get_param_value(MODPAR_MSGRL) = MODVAL_MSGRL_TRUE) then

            bars_audit.trace('call impmsg_document_linkrel(%s, %s)...', to_char(p_docRef), to_char(p_swRef));
            impmsgi_document_linkrel(p_docRef, p_swRef);
            bars_audit.trace('call impmsg_document_linkrel() successfully completed.');

        else
            bars_audit.trace('Related messages update skipped, mode unset.');
        end if;

        begin
            bars_swift.auto_create_swt(p_docRef, p_swRef);
        exception when others then
            bars_audit.trace(substr(('BARS_SWIFT.AUTO_CREATE_SWT. Ref='||to_char(p_docRef)||'SwRef='||to_char(p_swRef)||'. '||SQLERRM), 1, 4000));
        end;

    end impmsg_document_link_all;












    ----------------------------------------------------------------
    -- GENMSG_NOTIFY_CREATE()
    --
    --     Создание информационного документа для уведомления
    --
    --      Параметры:
    --
    --          p_srcref   Ид. начального документа
    --
    --          p_nosref   Ид. документа по корсчету
    --
    procedure genmsg_notify_create(
                   p_srcref      in  number,
                   p_nosref      in  number )
    is
    p            constant varchar2(100) := 'swt.genmsgntfcr';
    --
    INFDOC_DK         constant number        := 3;                                  -- информационный кредит
    INFDOC_DESCPREFIX constant varchar2(160) := '#E2;';                             -- префикс для назначения платежа
    INFDOC_RCVRNAME   constant varchar2(70)  := 'Транзитний рахунок';               -- имя счета получателя
    --
    l_seprec    number;
    l_seperr    number;



    l_fdat        date;             -- банковская дата проводки по корсчету
    l_nosacc      accounts.acc%type;-- ид. корсчета
    l_srcmfo      oper.mfoa%type;   -- код МФО отправителя начального документа

    l_infref      oper.ref%type;    -- инф. док:  референс
    l_inftt       oper.tt%type;     -- инф. док:  тип операции
    l_infvob      oper.vob%type;    -- инф. док:  вид документа
    l_infkv       oper.kv%type;     -- инф. док:  код валюты
    l_infamnt     oper.s%type;      -- инф. док:  сумма документа
    l_infnama     oper.nam_a%type;  -- инф. док:  наименование отправителя
    l_infnlsa     oper.nlsa%type;   -- инф. док:  номер счета отправителя (корсчет)
    l_infmfoa     oper.mfoa%type;   -- инф. док:  код МФО отправителя (ГБ)
    l_infmfob     oper.mfob%type;   -- инф. док:  код МФО получателя
    l_infnlsb     oper.nlsb%type;   -- инф. док:  счет получателя
    l_infdesc     oper.nazn%type;   -- инф. док:  назначение платежа
    l_infdesc2    oper.d_rec%type;  -- инф. док:  доп. реквизиты
    l_infrefa     oper.ref_a%type;  -- инф. док:  начальный реф. исходного документа
    l_infida      oper.id_a%type;   -- инф. док:  идент. код отправителя
    l_infidb      oper.id_b%type;   -- инф. док:  идент. код получателя
    l_flag_pay_tt varchar2(1);      -- флаг в настройке операции(1- оплата по факту)
    l_rec number;
    l_err number;
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, to_char(p_srcref), to_char(p_nosref));

        -- Получаем тип операции и вид документа
        l_inftt  := substr(get_param_value('SWTSTMTT'), 1, 3);
        l_infvob := nvl(to_number(get_param_value('SWTSTMVB')), 1);
        bars_audit.trace('%s: inf document tt=%s, vob=%s', p, l_inftt, to_char(l_infvob));

        if (l_inftt is null) then
            bars_error.raise_nerror(MODCODE, 'GENMSG_NOTIFY_TTNOTFOUND');
        end if;

        -- Получаем дату проводки по корсчету
        select max(fdat) into l_fdat
          from opldok
         where ref = p_nosref;
        bars_audit.trace('%s: nos document value date is %s', p, to_char(l_fdat, 'dd.mm.yyyy'));

        -- Получаем ид. корсчета
        select to_number(value) into l_nosacc
          from operw
         where ref = p_srcref
           and tag = 'NOS_A';
        bars_audit.trace('%s: nostro account# %s', p, to_char(l_nosacc));

        -- Получаем реквизиты
        select mfoa, kv, s, nazn, ref_a
          into l_srcmfo, l_infkv, l_infamnt, l_infdesc, l_infrefa
          from oper
         where ref = p_srcref;

        -- Дополняем назначение платежа
        l_infdesc := substr(INFDOC_DESCPREFIX || l_infdesc, 1, 160);

        -- Формируем доп. реквизиты
        l_infdesc2 := '#CREF:' || to_char(l_infrefa) || '#D' || to_char(l_fdat, 'YYMMDD') || '#';

        -- Получаем реквизиты счета отправителя (корсчет)
        select substr(a.nms, 1, 38), a.nls, nvl(c.okpo, '9999999999')
          into l_infnama, l_infnlsa, l_infida
          from accounts a, customer c
         where a.acc = l_nosacc
           and a.rnk = c.rnk;

        l_infmfoa := gl.aMfo;

        -- Получаем код МФО и счет куда необходимо отправлять инф. документы
        get_swtinfdoc_nls(l_srcmfo, l_infmfob, l_infnlsb, l_infidb);

        -- Создаем информационный документ
        gl.ref(l_infref);

        gl.in_doc3(
               ref_    =>  l_infref,
               tt_     =>  l_inftt,
               vob_    =>  l_infvob,
               nd_     =>  substr(to_char(l_infref), 1, 10),
               pdat_   =>  sysdate,
               vdat_   =>  l_fdat,
               dk_     =>  INFDOC_DK,
               kv_     =>  l_infkv,
               s_      =>  l_infamnt,
               kv2_    =>  l_infkv,
               s2_     =>  l_infamnt,
               sk_     =>  null,
               data_   =>  l_fdat,
               datp_   =>  l_fdat,
               nam_a_  =>  l_infnama,
               nlsa_   =>  l_infnlsa,
               mfoa_   =>  l_infmfoa,
               nam_b_  =>  INFDOC_RCVRNAME,
               nlsb_   =>  l_infnlsb,
               mfob_   =>  l_infmfob,
               nazn_   =>  l_infdesc,
               d_rec_  =>  l_infdesc2,
               id_a_   =>  l_infida,
               id_b_   =>  l_infidb,
               id_o_   =>  '******',
               sign_   =>  hextoraw('00'),
               sos_    =>  0,
               prty_   =>  0);
        bars_audit.trace('%s: inf document created, ref is %s', p, to_char(l_infref));

        -- Добавляем доп. реквизиты документа
        insert into operw(ref, tag, value)
        values (l_infref, 'C', 'REF:' || to_char(l_infrefa));

        insert into operw(ref, tag, value)
        values (l_infref, 'D', to_char(l_fdat, 'YYMMDD'));
        bars_audit.trace('%s: inf document ref %s params added.', p, to_char(l_infref));

        -- Добавляем документ в список инф. уведомлений
        insert into sw_mvps_infdocs(ref, infref, fdat, otm)
        values (p_srcref, l_infref, l_fdat, 1);
        bars_audit.trace('%s: succ end', p);

    end genmsg_notify_create;

    ----------------------------------------------------------------
    -- GENMSG_NOTIFY_INSEP()
    --
    --     Отправка информационных уведомлений
    --
    --
    procedure genmsg_notify_insep
    is
    p            constant varchar2(100) := 'swt.genmsgntfinsep';
    --
    l_seprec    number;
    l_seperr    number;
    l_docrec    oper%rowtype;
    --
    begin
        bars_audit.trace('%s: entry point', p);

        for c in (select ref, infref from sw_mvps_infdocs where otm is not null and otm = 1)
        loop
            bars_audit.trace('%s: processign document %s...', p, to_char(c.infref));
/*
TODO: owner="vitalii.kyrychok" category="Vega2" priority="1 - High" created="01.07.2016"
text="Использование SIGN"
*/
            select * into l_docrec
              from oper
             where ref = c.infref;

            -- Выполняем отправку в ВПС
            l_seperr := -1;
            l_seprec :=  0;

            sep.in_sep(
                    err_   => l_seperr,
                    rec_   => l_seprec,
                    mfoa_  => l_docrec.mfoa,
                    nlsa_  => l_docrec.nlsa,
                    mfob_  => l_docrec.mfob,
                    nlsb_  => l_docrec.nlsb,
                    dk_    => l_docrec.dk,
                    s_     => l_docrec.s,
                    vob_   => l_docrec.vob,
                    nd_    => substr(to_char(l_docrec.ref), 1, 10),
                    kv_    => l_docrec.kv,
                    data_  => l_docrec.datd,
                    datp_  => l_docrec.datp,
                    nam_a_ => l_docrec.nam_a,
                    nam_b_ => l_docrec.nam_b,
                    nazn_  => l_docrec.nazn,
                    naznk_ => null,
                    nazns_ => 11,
                    id_a_  => l_docrec.id_a,
                    id_b_  => l_docrec.id_b,
                    id_o_  => '******',
                    ref_a_ => l_docrec.ref_a,
                    bis_   => 0,
                    sign_  => l_docrec.sign,
                    fn_a_  => null,
                    rec_a_ => null,
                    dat_a_ => null,
                    d_rec_ => l_docrec.d_rec,
                    otm_i  => 0,
                    ref_i  => l_docrec.ref );
            bars_audit.trace('%s: in_sep for document ref %s completed, err %s', p, to_char(c.infref), to_char(l_seperr));

            if (l_seperr != 0) then
                bars_error.raise_nerror(MODCODE, 'GENMSG_NOTIFY_INSEPERR');
            end if;

            update oper set sos = 5 where ref = c.infref;
            update sw_mvps_infdocs set otm = null where ref = c.ref;
            commit;
            bars_audit.trace('%s: document %s processed.', p, to_char(c.infref));

        end loop;
        bars_audit.trace('%s: succ end', p);

    end genmsg_notify_insep;




    ----------------------------------------------------------------
    -- GENMSG_NOTIFY_LISTADD()
    --
    --     Добавление документа в список документов
    --     для формирования уведомлений
    --
    --      Параметры:
    --
    --          p_ref     Ид. документа
    --
    --
    --
    procedure genmsg_notify_listadd(
                   p_docref      in  number )
    is
    p    constant varchar2(100) := 'swt.genmsgntfadd';
    --
    l_isfound  boolean := false;
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s', p, to_char(p_docref));

        -- Проверяем наличие документа в списке
        for i in 1..g_notifylist.count
        loop
            if (g_notifylist(i) = p_docref) then l_isfound := true;
            end if;
        end loop;

        if (not l_isfound) then
            g_notifylist.extend;
            g_notifylist(g_notifylist.count) := p_docref;
            bars_audit.trace('%s: document %s added in list', p, to_char(p_docref));
        else
            bars_audit.trace('%s: document %s already in list', p, to_char(p_docref));
        end if;
        bars_audit.trace('%s: succ end', p);

    end genmsg_notify_listadd;


    ----------------------------------------------------------------
    -- GENMSG_NOTIFY_PROCESS()

    --
    --     Обработка список документов и формирование уведомлений
    --
    --
    --
    --
    procedure genmsg_notify_process
    is
    p    constant varchar2(100) := 'swt.genmsgntfprc';
    --
    l_srcref   number;            -- реф. начального документа
    l_srcmfo   oper.mfoa%type;    -- код МФО отправителя нач. документа
    l_srckv    oper.kv%type;      -- код валюты нач. документа
    l_isvps    number;            -- признак документа МВПС
    l_isntf    number;            -- признак сфомированного уведомления
    --
    begin
        bars_audit.trace('%s: entry point', p);

        if (g_notifylist.count = 0) then return;
        end if;

        -- Проходим по списку
        for i in 1..g_notifylist.count
        loop
            bars_audit.trace('%s: processing document ref=%s...', p, to_char(g_notifylist(i)));

            -- Находим его начальный документ
            begin
                select ref, mfoa, kv into l_srcref, l_srcmfo, l_srckv
                  from oper
                 where refl = g_notifylist(i);
                bars_audit.trace('%s: source document ref=%s, mfo=%s kv=%s', p, to_char(l_srcref), l_srcmfo, to_char(l_srckv));
            exception
                when NO_DATA_FOUND then
                    bars_audit.trace('%s: source document not found', p);
                    l_srcref := null;
                    l_srcmfo := null;
                    l_srckv  := null;
            end;

            -- Для формирования уведомления нужно, чтобы начальный документ
            -- был прислан по МВПС от отделения
            if (l_srcref is not null) then

                if   (l_srcmfo = gl.aMFO) then
                    bars_audit.trace('%s: source mfo is our, notify disallowed', p);
                else
                    -- Проверяем что это участник МВПС
                    select count(*) into l_isvps
                      from v_uchrrp_ext
                     where mfo  = l_srcmfo
                       and kv   = l_srckv
                       and kodn = 6;

                    if (l_isvps != 0) then
                        bars_audit.trace('%s: source document from VPS, check for notify', p);

                        -- Проверяем формировалось ли уже уведомление
                        select count(1) into l_isntf
                          from sw_mvps_infdocs
                         where ref = l_srcref;
                        bars_audit.trace('%s: notfication check result %s', p, to_char(l_isntf));

                        if (l_isntf = 0) then
                            genmsg_notify_create(l_srcref, g_notifylist(i));
                            bars_audit.trace('%s: notify document created', p);
                        else
                            bars_audit.trace('%s: notification for this document already created', p);
                        end if;

                    else
                        bars_audit.trace('%s: source document not from VPS', p);
                    end if;

                end if;

            end if;
            bars_audit.trace('%s: document ref=%s processed.', p, to_char(g_notifylist(i)));

        end loop;
        bars_audit.trace('%s: list of documents processed.', p);

        -- Очищаем очередь
        g_notifylist.delete;
        bars_audit.trace('%s: succ end', p);

    end genmsg_notify_process;



































    -----------------------------------------------------------------
    -- STMT_DOCUMENT_LINK()
    --
    --     Процедура привязки документа АБС к строке выписки.
    --     Строка выписки, к которой выполняется привязка сообщения,
    --     должна иметь признак наличия сообщения,  а  также  должны
    --     совпадать референс, дата валютирования и сумма транзакции
    --
    --
    --      Параметры:
    --
    --          p_stmtRef        Референс выписки
    --
    --          p_stmtRow        Номер строки выписки
    --
    --          p_docRef         Референс документа
    --
    --          p_force          Признак принудительной привязки,
    --                           без выполнения проверок
    --
    procedure stmt_document_link(
                  p_stmtRef  in  sw_950.swref%type,
                  p_stmtRow  in  sw_950d.n%type,
                  p_docRef   in  oper.ref%type,
                  p_force    in  number  default 0 )
    is
    begin
        stmt_document_link(p_stmtref, p_stmtrow, t_listref(p_docref), p_force);
    end stmt_document_link;


--**********************************************************************
-- STMT_LINK_DOC()
--
--      Процедура привязки документа АБС к строке выписки
--
--      Параметры:
--
--          p_stmtRef        Референс выписки
--
--          p_stmtRow        Номер строки выписки
--
--          p_docRef         Референс привязываемого документа
--
--**********************************************************************

procedure stmt_link_doc(
              p_stmtRef  in  sw_950.swref%type,
              p_stmtRow  in  sw_950d.n%type,
              p_docRef   in  oper.ref%type     )
is
begin
    stmt_document_link(p_stmtRef, p_stmtRow, p_docRef);
end stmt_link_doc;

--**********************************************************************
-- STMT_UNLINK_DOC()
--
--      Процедура отвязки документа АБС от строки выписки
--      При отвязке документ отвязывается и от исходного
--      сообщения, если он был привязан к исходному сообщению
--
--      Параметры:
--
--          p_stmtRef        Референс выписки
--
--          p_stmtRow        Номер строки выписки
--
--
--**********************************************************************

procedure stmt_unlink_doc(
              p_stmtRef  in  sw_950.swref%type,
              p_stmtRow  in  sw_950d.n%type    )
is
begin
    stmt_document_unlink(p_stmtRef, p_stmtRow);
end stmt_unlink_doc;

    -- GET_NAME_BANK
    -- ф-ция получения наименования банка
    -- по связаному NOS находим входящий документ из РУ
    --
    --
    --
    function get_name_bank(p_swref sw_journal.swref%type) return varchar2
    is
    l_nos_swref sw_journal.swref%type;
    l_result banks.nb%type;
    begin

     begin

        l_nos_swref:=bars_swift.get_message_relmsg(p_swref);

          if (l_nos_swref is not null) then
               begin
                  select nb into l_result from banks where mfo=(
                   select mfoa from oper where refl =(
                        select ref from sw_oper
                        where swref=l_nos_swref));
                  exception when no_data_found then  l_result:=null;
                 end;
          else
            l_result:=null;
           end if;
      end;
     RETURN l_result;
    end get_name_bank;

--**********************************************************************
-- PAY_190_STMT
--
-- Дополнительная бизнес-логика по обработке 190 сообщений.
-- Оплата и наложение визы на связанные документы
--**********************************************************************
procedure pay_190_stmt( p_docref number, p_swref number) is
   jj_190 sw_journal%rowtype ;
   ww_190 sw_operw%rowtype   ;
   jj_103 sw_journal%rowtype ;
   oo_103 sw_oper%rowtype    ;
begin

  begin
     select * into jj_190 from  sw_journal where swref = p_swref       and io_ind = 'o'  ;
     select * into ww_190 from  sw_operw   where swref = p_swref       and tag    = '21' ;
     select * into jj_103 from  sw_journal where trn   = ww_190.value  and io_ind = 'I'  ;
     select * into oo_103 from  sw_oper    where swref = jj_103.swref ;

     gl.pay (2,  oo_103.ref,  gl.bdate );
     gl.pay (2,  p_docRef  ,  gl.bdate );
  exception when no_data_found  then null  ;
  end;
  return ;
end pay_190_stmt;

procedure auto_create_swt(p_ref oper.ref%type, p_swref sw_journal.swref%type)
is
  l_sw_journal sw_journal%rowtype;
  l_oper oper%rowtype;
  l_swref_new sw_journal.swref%type;
  l_ret number;
  l_transit varchar2(11);
  l_guid varchar2(36);

begin
select s.* into l_sw_journal from sw_journal s where s.swref=p_swref;
select o.* into l_oper from oper o where o.ref=p_ref;

 if ((l_oper.dk=1 and substr(l_oper.nlsa,1,4)='1500' and substr(l_oper.nlsb,1,4)='1600' and l_oper.mfob=gl.aMFO)
 or (l_oper.dk=0 and substr(l_oper.nlsa,1,4)='1600' and l_oper.mfoa=gl.aMFO and substr(l_oper.nlsb,1,4)='1500')) then

        begin
            select trim(value) into l_transit from sw_operw
            where swref= p_swref
              and tag='57'
              and opt='A';
          exception when no_data_found then
            begin
                select bic into l_transit from sw_banks where name in
                    (select trim(upper(substr(s.value,1,instr(s.value, chr(13))-1))) vv from sw_operw s
                    where
                    s.swref=p_swref
                    and s.tag='57'
                    and s.opt='D')
                    and rownum=1;
             exception when no_data_found then
                if(l_sw_journal.mt='202') then
                    begin
                     select trim(value) into l_transit from sw_operw
                        where swref= p_swref
                          and tag='58'
                          and opt='A';
                     exception when no_data_found then
                     begin
                      select bic into l_transit from sw_banks where name in
                            (select trim(upper(substr(s.value,1,instr(s.value, chr(13))-1))) vv from sw_operw s
                            where
                            s.swref=p_swref
                            and s.tag='58'
                            and s.opt='D')
                            and rownum=1;
                      raise_application_error(-20000, 'Не вдалося знайти БАНК ОТРИМУВАЧ');
                       end;

                    end;

                else

                    if l_oper.nlsb  like '1600%' then
                        select b.bic into l_transit from accounts a, bic_acc b
                        where a.acc=b.acc and nls=l_oper.nlsb and kv=l_oper.kv2;
                    elsif  l_oper.nlsa  like '1600%' then
                        select b.bic into l_transit from accounts a, bic_acc b
                        where a.acc=b.acc and nls=l_oper.nlsa and kv=l_oper.kv;
                    else
                        raise_application_error(-20000, 'Не вдалося знайти БАНК ОТРИМУВАЧ');
                    end if;

                end if;
            end;
        end;



     --l_guid :=bars_swift.generate_uetr;

    BARS_SWIFT.In_SwJournalInt(ret_      => l_ret,
                        swref_    => l_swref_new,
                        mt_       => l_sw_journal.mt,
                        mid_      => to_char(p_ref),
                        page_     => null,
                        io_       => 'I',
                        sender_   => l_sw_journal.receiver,
                        receiver_ => rpad(l_transit,11,'X'),
                        transit_  => l_sw_journal.transit,
                        payer_    => null,
                        payee_    => l_sw_journal.payee,
                        ccy_      => l_sw_journal.currency,
                        amount_   => l_sw_journal.amount,
                        accd_     => l_sw_journal.accd,
                        acck_     => null,
                        vdat_     => null,
                        idat_     => to_char(sysdate,  'YYYY-MM-DD HH24:MI'),
                        flag_     => 'L',
                        sti_      => '001',
						uetr_     => l_sw_journal.uetr
                    --uetr_     => lower(l_guid)
                        );
 update sw_journal set date_pay = sysdate, date_out = null where swref=l_swref_new;

 insert into sw_operw(swref,
                      tag,
                      seq,
                      n,
                      opt,
                      value)
select  l_swref_new,
        tag,
        seq,
        n,
        opt,
        upper(value)
    from sw_operw where swref=p_swref;

if (l_sw_journal.mt in('103','202')) then
      update sw_operw
      set value = to_char(p_ref)
      where swref=l_swref_new
      and tag='20'
      and seq='A';
  end if;

  insert into sw_oper (ref, swref)
  values(p_ref, l_swref_new);
 end if;
end;

function generate_uetr
return varchar2
is
l_sources_guid varchar2(32); /* GUID*/
l_guid varchar2(36);
x varchar2(1);

begin

/*
xxxxxxxx-xxxx- 4xxx-yxxx-xxxxxxxxxxxx
x = any lowercase hexadecimal character y = one of 8,9,a or b
*/
    select CASE round(dbms_random.value(1,4))
            WHEN 1 THEN '8'
            WHEN 2 THEN '9'
            WHEN 3 THEN 'a'
            WHEN 4 THEN 'b'
       END into x
    FROM dual;

   l_sources_guid:=sys_guid();
   l_guid:=substr(l_sources_guid,1,8)||'-'||substr(l_sources_guid,9,4)||'-4'||substr(l_sources_guid,14,3)||'-'||x||substr(l_sources_guid,18,3)||'-'||substr(l_sources_guid,21) ;
   return lower(l_guid);
end;
--**********************************************************************
begin
    g_notifylist := t_doclist();
end bars_swift;
/