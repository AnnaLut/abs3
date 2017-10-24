
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/priocom_abs.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PRIOCOM_ABS is
/**
	Пакет priocom_abs содержит процедуры для работы в АБС БАРС c данными,
	полученными от Кредитной системы
*/

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 01/09/2006';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;

/**
 * proc_limit_on_deposit - установка/снятие лимита на депозит
 */
procedure proc_limit_on_deposit(p_limit_id in integer);

/**
 * remove_dpt_limit_query - удаляет запись из таблицы dpt_limit_query
 */
procedure remove_dpt_limit_query(p_limit_id in integer);

end priocom_abs;
/
CREATE OR REPLACE PACKAGE BODY BARS.PRIOCOM_ABS is
/**
	Пакет priocom_abs содержит процедуры для работы в АБС БАРС c данными,
	полученными от Кредитной системы
*/

G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.0 01/09/2006';

G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2 is
begin
  return 'Package header PRIOCOM_ABS '||G_HEADER_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_HEADER_DEFS;
end header_version;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2 is
begin
  return 'Package body PRIOCOM_ABS '||G_BODY_VERSION||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||G_AWK_BODY_DEFS;
end body_version;

/**
 * proc_limit_on_deposit - установка/снятие лимита на депозит
 */
procedure proc_limit_on_deposit(p_limit_id in integer) is
begin
    priocom_user.proc_limit_on_deposit(p_limit_id);
end proc_limit_on_deposit;

/**
 * remove_dpt_limit_query - удаляет запись из таблицы dpt_limit_query
 */
procedure remove_dpt_limit_query(p_limit_id in integer) is
begin
    priocom_user.remove_dpt_limit_query(p_limit_id);
end remove_dpt_limit_query;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/priocom_abs.sql =========*** End ***
 PROMPT ===================================================================================== 
 