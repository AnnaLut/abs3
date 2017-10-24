
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/swift_sec.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SWIFT_SEC 
is
/*
	SWIFT_SEC - пакет содержит процедуры по безопасности
	для работы со SWIFTом

	Создан: 06.10.2005 SERG

	История изменений:
*/

/*
  GetLAUIFlag возвращает значение параметра SWTLAUI
  1 - Формировать LAU для сообщений от АБС на SWIFT-терминал, 0 - нет
*/
function GetLAUIFlag return number;
/*
  GetLAUOFlag возвращает значение параметра SWTLAUO
  1 - Проверять LAU для сообщений от SWIFT-терминала на АБС, 0 - нет
*/
function GetLAUOFlag return number;

/*
  GetSwtKey - возвращает ключ SWIFT-терминала
*/
function GetSwtKey(str_key in varchar2) return varchar2;
/*
  GetAbsKey - возвращает ключ АБС
*/
function GetAbsKey(str_key in varchar2) return varchar2;

/*
  StoreTag сохраняет значение тэгов безопасности для свифт-сообщения
*/
procedure StoreTag(pswref in number, tag in varchar2, val in varchar2);

end SWIFT_SEC;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.SWIFT_SEC is
/**
	SWIFT_SEC - пакет содержит процедуры по безопасности
	для работы со SWIFTом

	Создан: 06.10.2005 SERG

	История изменений:
*/

/*
  GetLAUIFlag возвращает значение параметра SWTLAUI
  1 - Формировать LAU для сообщений от АБС на SWIFT-терминал, 0 - нет
*/
function GetLAUIFlag return number is
  fl  number;
begin
  begin
    select to_number(val) into fl from params where par='SWTLAUI';
  exception when no_data_found then
    fl := 0;
  end;
  return fl;
end;
/*
  GetLAUOFlag возвращает значение параметра SWTLAUO
  1 - Проверять LAU для сообщений от SWIFT-терминала на АБС, 0 - нет
*/
function GetLAUOFlag return number is
  fl  number;
begin
  begin
    select to_number(val) into fl from params where par='SWTLAUO';
  exception when no_data_found then
    fl := 0;
  end;
  return fl;
end;

function DecryptStr(str_encrypted in varchar2, str_key in varchar2) return varchar2 is
  raw_encrypted		raw(16);
  raw_decrypted		raw(16);
  raw_key           raw(16);
  str_decrypted 	varchar2(32);
begin
  raw_encrypted := hextoraw(str_encrypted);
  raw_key       := utl_raw.cast_to_raw(str_key);
  raw_decrypted := dbms_obfuscation_toolkit.DES3Decrypt(
			input => raw_encrypted,
            key   => raw_key);
  str_decrypted := rawtohex(raw_decrypted);
  return str_decrypted;
end;

/*
  GetSwtKey - возвращает ключ SWIFT-терминала
*/
function GetSwtKey(str_key in varchar2) return varchar2 is
	erm  varchar2(80);
	ern  constant positive := 001;
	err  exception;
	vkey varchar2(32);
begin
  begin
    select substr(val,1,32) into vkey from params where par='SWT_KEY';
    return DecryptStr(vkey, str_key);
  exception when no_data_found then
    erm := '1 - Ключ SWIFT-терминала не найден.';
    raise err;
  end;
exception when err then
	raise_application_error(-(20000+ern),'\'||erm,TRUE);
end;

/*
  GetAbsKey - возвращает ключ АБС
*/
function GetAbsKey(str_key in varchar2) return varchar2 is
	erm  varchar2(80);
	ern  constant positive := 002;
	err  exception;
	vkey varchar2(32);
begin
  begin
    select substr(val,1,32) into vkey from params where par='ABS_KEY';
    return DecryptStr(vkey, str_key);
  exception when no_data_found then
    erm := '1 - Ключ АБС не найден.';
    raise err;
  end;
exception when err then
	raise_application_error(-(20000+ern),'\'||erm,TRUE);
end;

/*
  StoreTag сохраняет значение тэгов безопасности для свифт-сообщения
*/
procedure StoreTag(pswref in number, tag in varchar2, val in varchar2) is
	erm  varchar2(80);
	ern  constant positive := 003;
	err  exception;

begin
  -- проверка на допустимость значений для tag
  if tag not in ('LAU','LAU_FLAG')
  then
    erm := '1 - Недопустимое значение TAG='||tag;
    raise err;
  end if;
  if tag='LAU' then
    update sw_journal set lau=val where swref=pswref;
    if sql%rowcount=0 then
      erm := '2 - Не найден SWREF='||pswref;
	  raise err;
    end if;
    return;
  end if;
  if tag='LAU_FLAG' then
    update sw_journal set lau_flag=to_number(val) where swref=pswref;
    if sql%rowcount=0 then
      erm := '2 - Не найден SWREF='||pswref;
	  raise err;
    end if;
    return;
  end if;
exception when err then
	raise_application_error(-(20000+ern),'\'||erm,TRUE);
end;

end;
/
 show err;
 
PROMPT *** Create  grants  SWIFT_SEC ***
grant EXECUTE                                                                on SWIFT_SEC       to SWTOSS;
grant EXECUTE                                                                on SWIFT_SEC       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/swift_sec.sql =========*** End *** =
 PROMPT ===================================================================================== 
 