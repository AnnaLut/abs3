
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/kfile_sync.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.KFILE_SYNC is

-- Author  : Alex.Iurchenko
-- Created : 31.12.1899 23:59:59
-- Purpose : package for sync data for k-files between RU and CA
-- ‚ерсґЯ пакету
g_header_version constant varchar2(64) := 'version 1.00 XX/XX/2015';

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;

-- get next id in recieved data table
function get_last_id(p_last_id in decimal)  return decimal;

-- get next id in recieved data table
function get_sync_id  return decimal;

-- get next id in recieved data table (delete old data for corporation)
function get_sync_id(p_MFO in decimal, p_CORPORATION_ID in varchar2, p_SYNC_DATE in varchar2, p_SYNC_TYPE in varchar2)  return decimal;

-- fill data on date(p_date format DDMMYYYY)
procedure fill_temporary_data(p_date in varchar2, p_corp_code varchar2);

-- fill data on bankdate
procedure fill_today_data;

procedure set_sync_id(p_sync_id decimal);

procedure SYNC_OB_CORPORATION(
   p_ID                 IN OB_CORPORATION.ID%TYPE,
   p_CORPORATION_CODE   IN OB_CORPORATION.CORPORATION_CODE%TYPE,
   p_CORPORATION_NAME   IN OB_CORPORATION.CORPORATION_NAME%TYPE,
   p_PARENT_ID          IN OB_CORPORATION.PARENT_ID%TYPE,
   p_STATE_ID           IN OB_CORPORATION.state_id%TYPE,
   p_EXTERNAL_ID        IN OB_CORPORATION.EXTERNAL_ID%TYPE);


end kfile_sync;
/
CREATE OR REPLACE PACKAGE BODY BARS.KFILE_SYNC is
-- ‚ерсґЯ пакету
g_body_version constant varchar2(64) := 'version 1.00 01/11/2015';
g_dbgcode constant varchar2(20)      := 'kfile_sync';


-- ora_lock    exception;
-- pragma exception_init(ora_lock, -54);


-- header_version - возвращает версию заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header ' || g_dbgcode || ' ' || g_header_version || '.';
end header_version;


-- body_version - возвращает версию тела пакета
function body_version return varchar2 is
begin
  return 'Package body ' || g_dbgcode || ' ' || g_body_version || '.';
end body_version;


procedure SYNC_OB_CORPORATION(
   p_ID                 IN OB_CORPORATION.ID%TYPE,
   p_CORPORATION_CODE   IN OB_CORPORATION.CORPORATION_CODE%TYPE,
   p_CORPORATION_NAME   IN OB_CORPORATION.CORPORATION_NAME%TYPE,
   p_PARENT_ID          IN OB_CORPORATION.PARENT_ID%TYPE,
   p_STATE_ID           IN OB_CORPORATION.state_id%TYPE,
   p_EXTERNAL_ID        IN OB_CORPORATION.EXTERNAL_ID%TYPE)
IS
   --l_corp_id OB_CORPORATION.ID%type;
   l_corp_name   OB_CORPORATION.CORPORATION_NAME%TYPE;
   l_corp_row    OB_CORPORATION%ROWTYPE;
BEGIN
   BEGIN
      SELECT t1.*
        INTO l_corp_row
        FROM OB_CORPORATION t1
       WHERE T1.ID = p_ID;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         --select S_OB_CORPORATION.nextval into l_corp_id from dual;
         INSERT INTO BARS.OB_CORPORATION t1 (T1.ID)
              VALUES (p_ID)
           RETURNING id
                INTO l_corp_row.id;
   END;

   DBMS_OUTPUT.PUT_LINE (l_corp_row.CORPORATION_NAME);

   IF (   p_CORPORATION_NAME <> l_corp_row.CORPORATION_NAME
       OR (    p_CORPORATION_NAME IS NULL
           AND l_corp_row.CORPORATION_NAME IS NOT NULL)
       OR (    p_CORPORATION_NAME IS NOT NULL
           AND l_corp_row.CORPORATION_NAME IS NULL))
   THEN
      BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                    'CORPORATION_NAME',
                                    p_CORPORATION_NAME);
   END IF;

   IF (   p_CORPORATION_CODE <> l_corp_row.CORPORATION_CODE
       OR (    p_CORPORATION_CODE IS NULL
           AND l_corp_row.CORPORATION_CODE IS NOT NULL)
       OR (    p_CORPORATION_CODE IS NOT NULL
           AND l_corp_row.CORPORATION_CODE IS NULL))
   THEN
      BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                    'CORPORATION_CODE',
                                    p_CORPORATION_CODE);
   END IF;

   IF (   p_PARENT_ID <> l_corp_row.PARENT_ID
       OR (p_PARENT_ID IS NULL AND l_corp_row.PARENT_ID IS NOT NULL)
       OR (p_PARENT_ID IS NOT NULL AND l_corp_row.PARENT_ID IS NULL))
   THEN
      BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                    'CORPORATION_PARENT_ID',
                                    p_PARENT_ID);
   END IF;

   IF (   p_STATE_ID <> l_corp_row.STATE_ID
       OR (p_STATE_ID IS NULL AND l_corp_row.STATE_ID IS NOT NULL)
       OR (p_STATE_ID IS NOT NULL AND l_corp_row.STATE_ID IS NULL))
   THEN
      BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                    'CORPORATION_STATE_ID',
                                    p_STATE_ID);
   END IF;

   IF (   p_EXTERNAL_ID <> l_corp_row.EXTERNAL_ID
       OR (p_EXTERNAL_ID IS NULL AND l_corp_row.EXTERNAL_ID IS NOT NULL)
       OR (p_EXTERNAL_ID IS NOT NULL AND l_corp_row.EXTERNAL_ID IS NULL))
   THEN
      BARS.ATTRIBUTE_UTL.SET_VALUE (l_corp_row.id,
                                    'CORPORATION_EXTERNAL_ID',
                                    p_EXTERNAL_ID);
   END IF;

END SYNC_OB_CORPORATION;


function get_last_id(p_last_id in decimal) return decimal is
  l_last_id decimal;
begin
  select max(t1.id)
    into l_last_id
    from bars.attribute_history t1,
         bars.object_type       t2,
         bars.attribute_kind    t3,
         bars.ob_corporation    t4
   where t1.attribute_id = t3.id
     and t3.object_type_id = t2.id
     and t2.type_code = 'CORPORATIONS'
     and t4.id = t1.object_id
     and t1.id > p_last_id;
  if (l_last_id is null) then
    select max(t1.id)
      into l_last_id
      from bars.attribute_history t1,
           bars.object_type       t2,
           bars.attribute_kind    t3,
           bars.ob_corporation    t4
     where t1.attribute_id = t3.id
       and t3.object_type_id = t2.id
       and t2.type_code = 'CORPORATIONS'
       and t4.id = t1.object_id;
  end if;
  return l_last_id;
end;


function get_sync_id
  return decimal
  is
  l_sync_id decimal;
  begin
   select S_OB_CORPORATION_SESSION.nextval into l_sync_id from dual;
  insert into BARS.OB_CORPORATION_SESSION ( id, KF, FILE_DATE, state_id, sys_time, SYNC_TYPE)
  values(l_sync_id, BARS.F_OURMFO , sysdate, 0, sysdate, 'SYNC');
  return l_sync_id;
end ;

function get_sync_id(p_MFO in decimal, p_CORPORATION_ID in varchar2, p_SYNC_DATE in varchar2, p_SYNC_TYPE in varchar2)
  return decimal
  is
  l_sync_id decimal;
   l_corp_id number;
  begin

  if (p_CORPORATION_ID<>'%')
      then
          l_corp_id :=to_number(p_CORPORATION_ID);
  end if;

   select S_OB_CORPORATION_SESSION.nextval into l_sync_id from dual;
  insert into BARS.OB_CORPORATION_SESSION ( id, KF, FILE_DATE, state_id, sys_time, SYNC_TYPE, FILE_CORPORATION_ID)
  values(l_sync_id, p_MFO , to_date(p_SYNC_DATE,'DDMMYYYY'), 0, sysdate, p_SYNC_TYPE, l_corp_id);
  return l_sync_id;
end ;


procedure set_sync_id(p_sync_id decimal) is
begin
  suda;
  update web_barsconfig
     set val = p_sync_id
   where key = 'KFiles.ServiceSyncDictId';
  tuda;
end;


procedure fill_temporary_data(p_date in varchar2, p_corp_code varchar2) is
  l_corp_code varchar2(10);
begin
  if (p_corp_code is null) then
    l_corp_code := '%';
  else
    l_corp_code := p_corp_code;
  end if;
  BARS.P_LIC26_KFILE(to_date(p_date, 'DDMMYYYY'), l_corp_code);
end;


procedure fill_today_data is
  l_corp_code varchar2(10);
begin
  l_corp_code := '%';
  tuda;
  BARS.P_LIC26_KFILE(bankdate, l_corp_code);
end;


begin
-- Initialization
null;
end kfile_sync;
/
 show err;
 
PROMPT *** Create  grants  KFILE_SYNC ***
grant DEBUG,EXECUTE                                                          on KFILE_SYNC      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/kfile_sync.sql =========*** End *** 
 PROMPT ===================================================================================== 
 