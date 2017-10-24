
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/docsign.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DOCSIGN is
/**
  Пакет DOCSIGN содержит функции для работы с буферами документов,
  с визами и ЭЦП на визировании.

  Created: 31.05.2005  SERG

  Modification History:

  13.05.2006 SERG Добавлены функции header_version() и body_version()

*/

/*
    -- Без параметров
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.4 04/02/2010';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;

function UserId2DigitId(uid in number) return varchar2;

/**
* Возвращает тип ЭЦП (NBU, UNI, VEG, PRX, SL2, ...)
*/
function GetSignType return varchar2;

/**
* Возвращает длину буффера документа (зависит от типа ЭЦП)
*/
function get_SignLng return number deterministic;

/**
* Возвращает длину буфера документа (зависит от типа ЭЦП)
*/
function GetSignLength return number;

-- получение идент. ключа операциониста
function GetIdOper return varchar2;


-- допустимый VOB для отправки в СЕП
function get_sep_vob(p_vob in number) return number;

-- получение буфера СЭП по референсу и идент. ключа
-- если ключ не задан, берется из oper.id_o
procedure RetrieveSEPBuffer(pref in number, id_oper in varchar2 default null,
  buf out varchar2);

-- сохранение ЭЦП в таблице oper
procedure StoreSEPSign(pref in number, buf in varchar2, id_oper in varchar2, bsign in raw);


end docsign;
/
CREATE OR REPLACE PACKAGE BODY BARS.DOCSIGN wrapped
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
17e7 a17
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
HafFBcIPE0xDHxrCU5i7c5nfJyzy
/
 show err;
 
PROMPT *** Create  grants  DOCSIGN ***
grant EXECUTE                                                                on DOCSIGN         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DOCSIGN         to OW;
grant EXECUTE                                                                on DOCSIGN         to START1;
grant EXECUTE                                                                on DOCSIGN         to WR_ACRINT;
grant EXECUTE                                                                on DOCSIGN         to WR_ALL_RIGHTS;
grant EXECUTE                                                                on DOCSIGN         to WR_CHCKINNR_ALL;
grant EXECUTE                                                                on DOCSIGN         to WR_CHCKINNR_CASH;
grant EXECUTE                                                                on DOCSIGN         to WR_CHCKINNR_SELF;
grant EXECUTE                                                                on DOCSIGN         to WR_CHCKINNR_SUBTOBO;
grant EXECUTE                                                                on DOCSIGN         to WR_CHCKINNR_TOBO;
grant EXECUTE                                                                on DOCSIGN         to WR_DOCVIEW;
grant EXECUTE                                                                on DOCSIGN         to WR_DOC_INPUT;
grant EXECUTE                                                                on DOCSIGN         to WR_IMPEXP;
grant EXECUTE                                                                on DOCSIGN         to WR_VERIFDOC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/docsign.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 