
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/alt_payments.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ALT_PAYMENTS 
is

G_HEADER_VERSION   constant varchar2(64)  := 'version 1.0 06.04.2009';
G_AWK_HEADER_DEFS  constant varchar2(512) := '';

-------------------------------------------------------------------
-- pay_documents()
--
--  Оплата документів поточного користувача
--  платяться лише ті, які можливо заплатити
procedure pay_documents;

--------------------------------------------------------
-- clean_up()
--
-- Видалення стрічок, по яких пройшла оплата
--
procedure clean_up;

--------------------------------------------------------
-- HEADER_VERSION()
--
--     Функция возвращает строку с версией заголовка пакета
--
function header_version return varchar2;

--------------------------------------------------------
-- BODY_VERSION()
--
--     Функция возвращает строку с версией тела пакета
--
function body_version return varchar2;

end alt_payments;
/
CREATE OR REPLACE PACKAGE BODY BARS.ALT_PAYMENTS 
is

G_BODY_VERSION   constant varchar2(64)  := 'version 1.0 06.04.2009';
G_AWK_BODY_DEFS  constant varchar2(512) := '';

-------------------------------------------------------------------
-- pay_documents()
--
--  Оплата документів поточного користувача
--  платяться лише ті, які можливо заплатити
procedure pay_documents
is
begin
	update vpay_alt set sos = 1;
end pay_documents;

--------------------------------------------------------
-- clean_up()
--
-- Видалення стрічок, по яких пройшла оплата
--
procedure clean_up
is
begin
	delete from vpay_alt
	where   ND is null and
			S is null and
			DOPR is null and
			NMSA is null and
			NLSA is null and
			NLSA_ALT  is null and
			NMSB is null and
			NLSB is null and
			NLSB_ALT is null and
			NAZN is null and
			S2 is null and
			SOS is null and
			DATD is null and
			SK_ZB is null;

end clean_up;

-----------------------------------------------------------------
-- HEADER_VERSION()
--
--     Функция возвращает строку с версией заголовка пакета
--
function header_version return varchar2
is
begin
    return 'package header WEB_UTL ' || G_HEADER_VERSION || chr(10) ||
           'package header definition(s):' || chr(10) || G_AWK_HEADER_DEFS;
end header_version;

-----------------------------------------------------------------
-- BODY_VERSION()
--
--     Функция возвращает строку с версией тела пакета
--
function body_version return varchar2
is
begin
    return 'package body WEB_UTL ' || G_BODY_VERSION || chr(10) ||
           'package body definition(s):' || chr(10) || G_AWK_BODY_DEFS;
end body_version;

end alt_payments;
/
 show err;
 
PROMPT *** Create  grants  ALT_PAYMENTS ***
grant EXECUTE                                                                on ALT_PAYMENTS    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ALT_PAYMENTS    to PYOD001;
grant EXECUTE                                                                on ALT_PAYMENTS    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/alt_payments.sql =========*** End **
 PROMPT ===================================================================================== 
 