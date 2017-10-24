
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dr.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DR IS

-- Copyryight : UNITY-BARS
-- Author     : SERG
-- Created    : ?
-- Purpose    : Реестр должников

-- global consts
G_HEADER_VERSION constant varchar2(64)  := 'version 2.01 03/08/2010';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''
;

----
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2;

----
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2;

---------
/**
  Население временной таблицы нашими должниками за дату
*/
PROCEDURE dr_new(DAT_ date);
---------
/*
 * PROCEDURE in_headers_proc - обработка заголовков
 * SERG: 01-DEC-2001
 * Код процедуры: 201
 * Возможные коды возвращаемых ошибок:
 */
PROCEDURE in_headers_proc(
            ret_         OUT NUMBER,   -- Код ошибки
            retAux_      OUT NUMBER,   -- Дополнительный код ошибки
            reqId_       OUT VARCHAR2, -- Идентификатор запроса
            fName_           VARCHAR2, -- Имя файла
            fDate_           DATE,     -- Дата и время создания файла
            ilCount_         NUMBER,   -- Количество ИС в файле
            sumDebit_        NUMBER,   -- Число 0
            sumCredit_       NUMBER,   -- Число 0
            fileSign_        RAW,      -- ЭЦП файла
            signKey_         VARCHAR2, -- Идентификатор ключа ЭЦП
            reserve_         VARCHAR2, -- Резерв
            headSign_        RAW,      -- ЭЦП строки заголовка файла
            kFName_          VARCHAR2, -- Имя квитированного файла
            kFDate_          DATE,     -- Дата и время создания квитированного файла
            kILCount_        NUMBER,   -- Количество ИС в квитированном файле
            kFErrorCode_     SMALLINT, -- Код ошибки по квитированному файлу
            kSumDebit_       NUMBER,   -- Число 0
            kSumCredit_      NUMBER,   -- Число 0
            kFileSign_       RAW,      -- ЭЦП квитированного файла
            kSignKey_        VARCHAR2, -- Идентификатор ключа ЭЦП квитированного файла
            fType_           CHAR,               -- Идентификатор фазы
            entryNo_         SMALLINT  -- Порядковый номер вызова процедуры
  );
---------
PROCEDURE pf_name;
---------
--* PROCEDURE item_kwt - квитовка(блокировка) записей в debreg
--* SERG: 01-DEC-2001
--* Код процедуры: 203
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE item_kwt(p_szFName     CHAR,
                   p_dtDATE      DATE,
                   p_nLineNum    SMALLINT,
                   p_nErrorCode  SMALLINT);

---------
--/**
--* PROCEDURE file_kwt - квитовка файлов
--* SERG: 01-DEC-2001
--* Код процедуры: 204
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE file_kwt(p_szFName     CHAR,
                   p_dtDATE      DATE,
                   p_nLineNum    SMALLINT,
                   p_nErrorCode  SMALLINT,
                   p_nTicLines   SMALLINT);

---------
--/**
--* PROCEDURE find_request - поиск запроса
--* SERG: 11-DEC-2001
--* Код процедуры: 205
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE find_request(p_szReqId     OUT VARCHAR2,
                       p_szFName         CHAR,
                       p_dtDATE          DATE,
                       p_nLineNum        NUMBER);

---------
--/**
--* PROCEDURE update_request - квитовка запроса
--* SERG: 11-DEC-2001
--* Код процедуры: 206
--* Возможные коды возвращаемых ошибок:
--*/
PROCEDURE update_request( p_szReqId     VARCHAR2,
                          p_nSOS        NUMBER,
                          p_nErrorCode  NUMBER);

PROCEDURE refresh_debreg
  (acc_        NUMBER,
   adr_        VARCHAR2,
   crdagrnum_  VARCHAR2,
   crddate_    DATE,
   custtype_   NUMBER,
   kv_         NUMBER,
   nmk_        VARCHAR2,
   okpo_       VARCHAR2,
   prinsider_  NUMBER,
   summ_       NUMBER,
   rezid_      NUMBER,
   debdate_    DATE,
   osn_        VARCHAR2);

---------
END dr;
-----
/
CREATE OR REPLACE PACKAGE BODY BARS.DR wrapped
a000000
ab
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
504e 1814
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
NQC0TYeGC33Aarf5qcfkrrUdASBfRg==
/
 show err;
 
PROMPT *** Create  grants  DR ***
grant EXECUTE                                                                on DR              to DEB_REG;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dr.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 