
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sec.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SEC IS
--***************************************************************--
--                   Управление доступом к счетам
--            (C) Unity-BARS 2000 - 2007
--***************************************************************--
G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'Version 2.10 06.09.2012';

G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := ''
  ||'ORA11 - под Oracle 11g'||chr(10)
;

g_call_counter              number := 0;

function get_call_counter return number;

procedure set_call_counter(p_call_counter number);

/**
 * header_version - возвращает версию заголовка пакета
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета
 */
function body_version return varchar2;


function set_smask_ex(p_schema varchar2, p_name varchar2) return varchar2;

function fit_smask_ex(p_sec             raw,
                      p_branch          accounts.tobo%type,
                      p_user_branch     accounts.tobo%type,
                      p_smask_global    raw,
                      p_smask_parent    raw,
                      p_smask           raw
                     )
return binary_integer
    result_cache
;

FUNCTION set_smask(p_schema VARCHAR2, p_name VARCHAR2) RETURN VARCHAR2;
FUNCTION set_dmask(p_schema VARCHAR2, p_name VARCHAR2) RETURN VARCHAR2;
FUNCTION set_kmask(p_schema VARCHAR2, p_name VARCHAR2) RETURN VARCHAR2;

FUNCTION fill_smask(p_schema VARCHAR2, p_name VARCHAR2) RETURN VARCHAR2;
FUNCTION fill_dmask(p_schema VARCHAR2, p_name VARCHAR2) RETURN VARCHAR2;
FUNCTION fill_kmask(p_schema VARCHAR2, p_name VARCHAR2) RETURN VARCHAR2;

FUNCTION fit_smask(sec_ RAW, p_branch accounts.tobo%type) RETURN BINARY_INTEGER;
FUNCTION fit_dmask(sec_ RAW, p_branch accounts.tobo%type) RETURN BINARY_INTEGER;
FUNCTION fit_kmask(sec_ RAW, p_branch accounts.tobo%type) RETURN BINARY_INTEGER;

FUNCTION fit_gmask(sec_ RAW,ida_ BINARY_INTEGER) RETURN BINARY_INTEGER;
FUNCTION fit_umask(sec_ RAW,idu_ BINARY_INTEGER) RETURN BINARY_INTEGER;
PROCEDURE getmask (id_    BINARY_INTEGER,
                   smask_ OUT RAW,
                   dmask_ OUT RAW,
                   kmask_ OUT RAW,
                   smask_global_ OUT RAW,
                   dmask_global_ OUT RAW,
                   kmask_global_ OUT RAW,
           smask_parent_ out raw,
                   dmask_parent_ out raw,
                   kmask_parent_ out raw);
----
-- call_getmask - вызывает getmask
--
procedure call_getmask;

PROCEDURE addUgrp (id_  NUMBER, idg_ NUMBER);
PROCEDURE delUgrp (id_  NUMBER, idg_ NUMBER);
PROCEDURE addAgrp (acc_ NUMBER, ida_ NUMBER);
PROCEDURE delAgrp (acc_ NUMBER, ida_ NUMBER);
PROCEDURE givUAgrp(idg_ NUMBER, ida_ NUMBER);
PROCEDURE revUAgrp(idg_ NUMBER, ida_ NUMBER);
FUNCTION getAgrp(acc_ NUMBER) RETURN agrp_list PIPELINED;

-- очищает контекст пользователя
PROCEDURE clear_client_context(p_user_id in number default NULL);
-- очищает весь глобальный контекст
PROCEDURE clear_global_context;

-- очищает весь глобальный контекст
PROCEDURE clear_session_context;

-- выполняет обновление глобального контекста масок пользователя
procedure update_sec_ctx(p_user_id in integer);

-- выполняет инициализацию пакета
procedure init;

-- выполняет переинициализацию пакета
procedure reinit;

procedure test;

----
-- enqueue_sec_update - помещает запись на обновление маски доступа к счетам в очередь
--
procedure enqueue_sec_update(p_userid in integer, p_date in date);

----
-- proc_sec_update_queue - обрабатывает очередь на обновление маски доступа к счетам
--
procedure proc_sec_update_queue;

END;
/
CREATE OR REPLACE PACKAGE BODY BARS.SEC 
is

--------------------------------------------------------------------------------
-- Реализация доступа к счетам на Просмотр/Дебет/Кредит
--------------------------------------------------------------------------------

g_body_version  constant varchar2(64)  := 'version 2.10 05.09.2012';
g_awk_body_defs constant varchar2(512) := ''
  ||'ORA11 - под Oracle 11g'||chr(10)
;

--
-- константы
--
ctx_namespace               constant varchar2(30) := 'bars_sec';
-- локальные маски доступа
ctx_attr_smask              constant varchar2(30) := 'smask';
ctx_attr_dmask              constant varchar2(30) := 'dmask';
ctx_attr_kmask              constant varchar2(30) := 'kmask';
-- глобальные маски доступа
ctx_attr_smask_global       constant varchar2(30) := 'smask_global';
ctx_attr_dmask_global       constant varchar2(30) := 'dmask_global';
ctx_attr_kmask_global       constant varchar2(30) := 'kmask_global';
-- родительские маски доступа
ctx_attr_smask_parent       constant varchar2(30) := 'smask_parent';
ctx_attr_dmask_parent       constant varchar2(30) := 'dmask_parent';
ctx_attr_kmask_parent       constant varchar2(30) := 'kmask_parent';

--
-- внутренние переменные
--
id     binary_integer;  -- код пользователя
my_id  binary_integer;  -- мой код пользователя(которым залогинился)
--
smask  accounts.sec%type;         -- маска смотреть
dmask  accounts.sec%type;         -- маска дебетовать
kmask  accounts.sec%type;         -- маска кредитовать
smasku accounts.sec%type;         -- маска смотреть
dmasku accounts.sec%type;         -- маска дебетовать
kmasku accounts.sec%type;         -- маска кредитовать
--
smask_global  accounts.sec%type;         -- маска смотреть
dmask_global  accounts.sec%type;         -- маска дебетовать
kmask_global  accounts.sec%type;         -- маска кредитовать
smasku_global accounts.sec%type;         -- маска смотреть
dmasku_global accounts.sec%type;         -- маска дебетовать
kmasku_global accounts.sec%type;         -- маска кредитовать
--
smask_parent  accounts.sec%type;         -- маска смотреть
dmask_parent  accounts.sec%type;         -- маска дебетовать
kmask_parent  accounts.sec%type;         -- маска кредитовать
smasku_parent accounts.sec%type;         -- маска смотреть
dmasku_parent accounts.sec%type;         -- маска дебетовать
kmasku_parent accounts.sec%type;         -- маска кредитовать


g_user_branch          tobo.tobo%type;    -- отделение пользователя
g_user_branch_mask     tobo.tobo%type;    -- маска отделения пользователя
g_user_parent_branch   tobo.tobo%type;    -- код родительского отделения

g_sec_length    number; -- длина поля accounts.sec

function get_call_counter return number is
begin
    return g_call_counter;
end get_call_counter;

procedure set_call_counter(p_call_counter number) is
begin
    g_call_counter := p_call_counter;
end set_call_counter;

--
-- header_version - возвращает версию заголовка пакета
--
function header_version return varchar2 is
begin
  return 'Package header SEC '||G_HEADER_VERSION||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_HEADER_DEFS;
end header_version;

--
-- body_version - возвращает версию тела пакета
--
function body_version return varchar2 is
begin
  return 'Package body SEC '||G_BODY_VERSION||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||G_AWK_BODY_DEFS;
end body_version;

--
--  Установка политик для SALDO-SALDOD-SALDOK
--
function set_smask(p_schema varchar2, p_name varchar2)
return varchar2 is
begin
   return 'sec.fit_smask(sec,tobo)>0';
end;

function set_dmask(p_schema varchar2, p_name varchar2)
return varchar2 is
begin
   return 'sec.fit_dmask(sec,tobo)>0';
end;

function set_kmask(p_schema varchar2, p_name varchar2)
return varchar2 is
begin
   return 'sec.fit_kmask(sec,tobo)>0';
end;

--
--  Дополнительные политики, срабатывающие 1 раз на запрос
--  для установки переменных пакета из контекста
function fill_smask(p_schema varchar2, p_name varchar2)
return varchar2 is
begin
   smask        := sys_context(sec.ctx_namespace,sec.ctx_attr_smask);
   smask_parent := sys_context(sec.ctx_namespace,sec.ctx_attr_smask_parent);
   smask_global := sys_context(sec.ctx_namespace,sec.ctx_attr_smask_global);
   if smask is null or smask_parent is null or smask_global is null then
      call_getmask;
   end if;
   return null;
end;

function fill_dmask(p_schema varchar2, p_name varchar2)
return varchar2 is
begin
   dmask        := sys_context(sec.ctx_namespace,sec.ctx_attr_dmask);
   dmask_parent := sys_context(sec.ctx_namespace,sec.ctx_attr_dmask_parent);
   dmask_global := sys_context(sec.ctx_namespace,sec.ctx_attr_dmask_global);
   if dmask is null or dmask_parent is null or dmask_global is null then
      call_getmask;
   end if;
   return null;
end;

function fill_kmask(p_schema varchar2, p_name varchar2)
return varchar2 is
begin
   kmask        := sys_context(sec.ctx_namespace,sec.ctx_attr_kmask);
   kmask_parent := sys_context(sec.ctx_namespace,sec.ctx_attr_kmask_parent);
   kmask_global := sys_context(sec.ctx_namespace,sec.ctx_attr_kmask_global);
   if kmask is null or kmask_parent is null or kmask_global is null then
      call_getmask;
   end if;
   return null;
end;


function set_smask_ex(p_schema varchar2, p_name varchar2)
return varchar2 is
begin
   return 'sec.fit_smask_ex(sec,tobo'
   ||',sys_context(''bars_context'',''user_branch'')'
   ||',sys_context(''bars_sec'',''smask_global'')'
   ||',sys_context(''bars_sec'',''smask_parent'')'
   ||',sys_context(''bars_sec'',''smask'')'
   ||')>0';
end set_smask_ex;

--
-- Проверяет доступ к счету на просмотр (расширенный вариант)
--
function fit_smask_ex(p_sec             raw,
                      p_branch          accounts.tobo%type,
                      p_user_branch     accounts.tobo%type,
                      p_smask_global    raw,
                      p_smask_parent    raw,
                      p_smask           raw
                     )
return binary_integer
    result_cache
is
   l_user_branch_mask       accounts.tobo%type;
   l_user_parent_branch     accounts.tobo%type;
begin
   g_call_counter := g_call_counter + 1;
   if p_sec is null then return 0; end if;
   l_user_branch_mask   := p_user_branch||'%';
   l_user_parent_branch := substr(p_user_branch, 1, instr(p_user_branch, '/', -2));
   return utl_raw.compare(
              utl_raw.bit_and(
                  utl_raw.overlay(p_sec, '0000',1,g_sec_length),
                  utl_raw.bit_or(
                      p_smask_global,
                      utl_raw.bit_or(
                          case when p_branch like l_user_branch_mask
                               then p_smask else hextoraw('00')
                          end,
                          case when p_branch like l_user_branch_mask or p_branch = l_user_parent_branch
                               then p_smask_parent else hextoraw('00')
                          end
                      )
                  )
              ),
              null
          );
end fit_smask_ex;

--
-- Проверяет доступ к счету на просмотр
--
function fit_smask(sec_ raw, p_branch accounts.tobo%type) return binary_integer is
   l_res       binary_integer;
begin
   if sec_ is null then return 0; end if;
   return utl_raw.compare(
              utl_raw.bit_and(
                  utl_raw.overlay(sec_, '0000',1,g_sec_length),
                  utl_raw.bit_or(
                      smask_global,
                      utl_raw.bit_or(
                          case when p_branch like g_user_branch_mask
                               then smask else hextoraw('00')
                          end,
                          case when p_branch like g_user_branch_mask or p_branch = g_user_parent_branch
                               then smask_parent else hextoraw('00')
                          end
                      )
                  )
              ),
              null
          );
end fit_smask;

--
-- Проверяет доступ к счету на дебет
--
function fit_dmask(sec_ raw, p_branch accounts.tobo%type) return binary_integer is
begin
   if sec_ is null then return 0; end if;
   return utl_raw.compare(
              utl_raw.bit_and(
                  utl_raw.overlay(sec_, '0000',1,g_sec_length),
                  utl_raw.bit_or(
                      dmask_global,
                      utl_raw.bit_or(
                          case when p_branch like g_user_branch_mask
                               then dmask else hextoraw('00')
                          end,
                          case when p_branch like g_user_branch_mask or p_branch = g_user_parent_branch
                               then dmask_parent else hextoraw('00')
                          end
                      )
                  )
              ),
              null
          );
end fit_dmask;

--
-- Проверяет доступ к счету на кредит
--
function fit_kmask(sec_ raw, p_branch accounts.tobo%type) return binary_integer is
begin
   if sec_ is null then return 0; end if;
   return utl_raw.compare(
              utl_raw.bit_and(
                  utl_raw.overlay(sec_, '0000',1,g_sec_length),
                  utl_raw.bit_or(
                      kmask_global,
                      utl_raw.bit_or(
                          case when p_branch like g_user_branch_mask
                               then kmask else hextoraw('00')
                          end,
                          case when p_branch like g_user_branch_mask or p_branch = g_user_parent_branch
                               then kmask_parent else hextoraw('00')
                          end
                      )
                  )
              ),
              null
          );
end;

--
-- определяем вхождение счета с маской sec_ в группу счетов ida_
--
function fit_gmask(sec_ raw,ida_ binary_integer) return binary_integer is
mask_ accounts.sec%type;
begin
   if sec_ is null then return 0; end if;
   if ida_<16 then
      mask_:=utl_raw.substr(
             utl_raw.cast_from_binary_integer(power(2,16-mod(ida_,16)-1)),3,2);
   elsif ida_>=16 then
      mask_:=utl_raw.overlay(
             utl_raw.cast_from_binary_integer(power(2,16-mod(ida_,16)-1)),
            '0000',2*trunc(ida_/16)-1);
   else
      return 0;
   end if;

   return utl_raw.compare(utl_raw.bit_and(
                          utl_raw.overlay(sec_, '0000',1,g_sec_length),
                          utl_raw.overlay(mask_,'0000',1,g_sec_length)),null);
end;

--
-- определяем доступность счета с маской sec_ пользователю idu_
-- резултатом является 3-битовое число, где
-- 1-ый бит справа - доступ на кредит
-- 2-ой бит справа - доступ на дебет
-- 3-ый бит справа - доступ на просмотр
--
-- TODO: узнать как это используется в приложении(должно ли влиять местонахождение пользователя(branch) на результат ф-ции?)
--
function fit_umask(sec_ raw,idu_ binary_integer) return binary_integer is
begin
   if sec_ is null then return 0; end if;
   if idu_<>id then
      id:=idu_;
      getmask (idu_,smasku,dmasku,kmasku,
               smasku_global,dmasku_global,kmasku_global,
               smasku_parent,dmasku_parent,kmasku_parent);
   end if;



   return
      sign(utl_raw.compare(utl_raw.bit_and(
        utl_raw.overlay(sec_, '0000',1,g_sec_length),
        utl_raw.bit_or(utl_raw.bit_or(smasku,smasku_global),smasku_parent)),null))*4+
      sign(utl_raw.compare(utl_raw.bit_and(
        utl_raw.overlay(sec_, '0000',1,g_sec_length),
        utl_raw.bit_or(utl_raw.bit_or(dmasku,dmasku_global),dmasku_parent)),null))*2+
      sign(utl_raw.compare(utl_raw.bit_and(
        utl_raw.overlay(sec_, '0000',1,g_sec_length),
        utl_raw.bit_or(utl_raw.bit_or(kmasku,kmasku_global),kmasku_parent)),null));

end;
--
-- Получить маски доступа к счетам
--
procedure getmask (id_    binary_integer,
                   smask_ out raw,
                   dmask_ out raw,
                   kmask_ out raw,
                   smask_global_ out raw,
                   dmask_global_ out raw,
                   kmask_global_ out raw,
                   smask_parent_ out raw,
                   dmask_parent_ out raw,
                   kmask_parent_ out raw) is
sec_             accounts.sec%type;
sec_global_      accounts.sec%type;
sec_parent_      accounts.sec%type;
j                integer;
full_calc        integer;        -- 0/1 - флаг необходимости полного вычисления маски
mask_name        varchar2(30);
mask_name_global varchar2(30);
mask_name_parent varchar2(30);
l_clientid       varchar2(64);   -- клиентский ид. сессии
--
begin

 for i in 0..2 loop
   full_calc := 0;

   if    i=0 then
     mask_name        := sec.ctx_attr_kmask;
     mask_name_global := sec.ctx_attr_kmask_global;
     mask_name_parent := sec.ctx_attr_kmask_parent;
   elsif i=1 then
     mask_name        := sec.ctx_attr_dmask;
     mask_name_global := sec.ctx_attr_dmask_global;
     mask_name_parent := sec.ctx_attr_dmask_parent;
   elsif i=2 then
     mask_name        := sec.ctx_attr_smask;
     mask_name_global := sec.ctx_attr_smask_global;
     mask_name_parent := sec.ctx_attr_smask_parent;
   end if;

   if id_<>my_id then
     full_calc := 1;
   else
     /*sec_        := sys_context(sec.ctx_namespace,mask_name);
     sec_global_ := sys_context(sec.ctx_namespace,mask_name_global);
     sec_parent_ := sys_context(sec.ctx_namespace,mask_name_parent);
     if sec_ is null or sec_global_ is null or sec_parent_ is null then
        full_calc := 1;
     end if;*/
     full_calc := 1;
   end if;

   if full_calc=1 then

       j:=power(2,i);
       sec_:='0000'; sec_global_:='0000'; sec_parent_:='0000';
       for c in (select b.ida, a.scope
                   from groups_acc a, groups_staff_acc b
                  where a.id=b.ida
                    and b.idg in (
                                 select g.idg
                                   from groups_staff g
                                  where nvl(g.approve,0)=1
                                    and date_is_valid( g.adate1,g.adate2,g.rdate1,g.rdate2 )=1
                                    and bitand(g.secg,j)=j
                                    and g.idu in (
                                                 select s2.id_whom
                                                   from staff_substitute s2
                                                  where s2.id_who = id_
                                                    and date_is_valid(s2.date_start,s2.date_finish,null,null)=1
                                                  union
                                                  select id_
                                                    from dual
                                                 )
                                 )
                )
       loop
          case
          when c.scope='LOCAL' then
              -- вычисления по глобальной маске
              if c.ida<16 then
                 sec_:=utl_raw.bit_or(nvl(sec_,'0000'),
                       utl_raw.substr(
                       utl_raw.cast_from_binary_integer(
                       power(2,16-mod(c.ida,16)-1)),3,2));
              else
                 sec_:=utl_raw.bit_or(nvl(sec_,'0000'),
                       utl_raw.overlay(
                       utl_raw.cast_from_binary_integer(
                       power(2,16-mod(c.ida,16)-1)),'0000',2*trunc(c.ida/16)-1));
              end if;
          when c.scope='GLOBAL' then
              -- вычисления по глобальной маске
              if c.ida<16 then
                 sec_global_:=utl_raw.bit_or(nvl(sec_global_,'0000'),
                       utl_raw.substr(
                       utl_raw.cast_from_binary_integer(
                       power(2,16-mod(c.ida,16)-1)),3,2));
              else
                 sec_global_:=utl_raw.bit_or(nvl(sec_global_,'0000'),
                       utl_raw.overlay(
                       utl_raw.cast_from_binary_integer(
                       power(2,16-mod(c.ida,16)-1)),'0000',2*trunc(c.ida/16)-1));
              end if;
          when c.scope='PARENT' then
              -- вычисления по родительской маске
              if c.ida<16 then
                 sec_parent_:=utl_raw.bit_or(nvl(sec_parent_,'0000'),
                       utl_raw.substr(
                       utl_raw.cast_from_binary_integer(
                       power(2,16-mod(c.ida,16)-1)),3,2));
              else
                 sec_parent_:=utl_raw.bit_or(nvl(sec_parent_,'0000'),
                       utl_raw.overlay(
                       utl_raw.cast_from_binary_integer(
                       power(2,16-mod(c.ida,16)-1)),'0000',2*trunc(c.ida/16)-1));
              end if;
          end case;
       end loop;

       sec_         := utl_raw.overlay(sec_, '0000',1,g_sec_length);
       sec_global_  := utl_raw.overlay(sec_global_, '0000',1,g_sec_length);
       sec_parent_  := utl_raw.overlay(sec_parent_, '0000',1,g_sec_length);
       l_clientid   := sys_context('userenv', 'client_identifier');


       -- заносим значение маски локальных групп в контекст
       sys.dbms_session.set_context(
         namespace => sec.ctx_namespace,
         attribute => mask_name,
         value        => sec_,
         username  => null,
         client_id => l_clientid);

       -- заносим значение маски глобальных групп в контекст
       sys.dbms_session.set_context(
         namespace => sec.ctx_namespace,
         attribute => mask_name_global,
         value        => sec_global_,
         username  => null,
         client_id => l_clientid);

       -- заносим значение маски родительских групп в контекст
       sys.dbms_session.set_context(
         namespace => sec.ctx_namespace,
         attribute => mask_name_parent,
         value        => sec_parent_,
         username  => null,
         client_id => l_clientid);

       bars_audit.trace('BARS.SEC: Выполнена первичная инициализация контекста маски '''||mask_name
       ||'''доступа к счетам. Пользователь ID='||id_);

   end if;

   if    i=0 then
     kmask_ := sec_;
     kmask_global_ := sec_global_;
     kmask_parent_ := sec_parent_;
   elsif i=1 then
     dmask_ := sec_;
     dmask_global_ := sec_global_;
     dmask_parent_ := sec_parent_;
   elsif i=2 then
     smask_ := sec_;
     smask_global_ := sec_global_;
     smask_parent_ := sec_parent_;
   end if;

 end loop;

end;
--
-- Добавить пользователя в группу пользователей
--
PROCEDURE addUgrp (id_ NUMBER, idg_ NUMBER) IS
BEGIN
   INSERT INTO groups_staff(idu,idg) VALUES(id_,idg_);
END;
--
-- Убрать пользователя из группы пользователей
--
PROCEDURE delUgrp (id_ NUMBER, idg_ NUMBER) IS
BEGIN
   DELETE FROM groups_staff WHERE idu=id_ AND idg=idg_;
END;
--
-- Добавить счет в группу счетов
--
PROCEDURE addAgrp (acc_ NUMBER, ida_ NUMBER) IS
BEGIN
IF ida_<16 THEN
  UPDATE accounts SET sec=UTL_RAW.BIT_OR(NVL(sec,'0000'),
     UTL_RAW.SUBSTR(
     UTL_RAW.CAST_FROM_BINARY_INTEGER(power(2,16-MOD(ida_,16)-1)),3,2))
   WHERE acc=acc_;
ELSIF ida_>=16 THEN
  UPDATE accounts SET sec=UTL_RAW.BIT_OR(NVL(sec,'0000'),
     UTL_RAW.OVERLAY(
     UTL_RAW.CAST_FROM_BINARY_INTEGER(power(2,16-MOD(ida_,16)-1)),'0000',
       2*TRUNC(ida_/16)-1))
   WHERE acc=acc_;
END IF;
END;
--
-- Убрать счет из группы счетов
--
PROCEDURE delAgrp (acc_ NUMBER, ida_ NUMBER) IS
sec_  accounts.sec%type;
pos_  BINARY_INTEGER;
BEGIN
   SELECT sec INTO sec_ FROM accounts WHERE acc=acc_;
   pos_:=2*TRUNC(ida_/16)+1;

   IF UTL_RAW.LENGTH(sec_)>pos_ THEN

      sec_:=UTL_RAW.OVERLAY(UTL_RAW.BIT_AND(
            UTL_RAW.SUBSTR(sec_,pos_,2),
            UTL_RAW.BIT_COMPLEMENT(UTL_RAW.SUBSTR(
            UTL_RAW.CAST_FROM_BINARY_INTEGER(power(2,16-MOD(ida_,16)-1)),3,2))),sec_,pos_);

      pos_:=UTL_RAW.COMPARE(UTL_RAW.REVERSE(sec_),NULL);
      IF pos_>0 THEN
         pos_:=TRUNC((pos_-1)/2)*2;

         UPDATE accounts
            SET sec=UTL_RAW.SUBSTR(sec_,1,UTL_RAW.LENGTH(sec_)-pos_)
          WHERE acc=acc_;
      ELSE
         UPDATE accounts SET sec=NULL WHERE acc=acc_;
      END IF;
   END IF;
END;
--
-- Разрешить доступ группы пользователей к группе счетов
--
PROCEDURE givUAgrp (idg_ NUMBER, ida_ NUMBER) IS
BEGIN
   INSERT INTO groups_staff_acc(idg,ida) VALUES (idg_,ida_);
END;
--
-- Запретить доступ группы пользователей к группе счетов
--
PROCEDURE revUAgrp (idg_ NUMBER, ida_ NUMBER) IS
BEGIN
   DELETE FROM groups_staff_acc WHERE idg=idg_ AND ida=ida_;
END;
--
-- Получить список групп для счета
--
FUNCTION getAgrp(acc_ NUMBER) RETURN agrp_list PIPELINED IS
k    BINARY_INTEGER;
sec_ accounts.sec%type;
BEGIN
   BEGIN
      SELECT sec INTO sec_ FROM accounts WHERE acc=acc_;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN RETURN;
   END;

   IF sec_ IS NULL THEN RETURN; END IF;

   FOR i IN 0..UTL_RAW.LENGTH(sec_)/2-1 LOOP
      k:=UTL_RAW.CAST_TO_BINARY_INTEGER(UTL_RAW.SUBSTR(sec_,2*i+1,2));

      FOR j IN 1..16 LOOP
         IF BITAND(POWER(2,16-j),k)>0 THEN
            PIPE ROW (i*16+j-1);
         END IF;
      END LOOP;

   END LOOP;
   RETURN;
END;

PROCEDURE clear_session_context
IS
BEGIN
    sys.dbms_session.clear_context(sec.ctx_namespace, bars_login.get_session_clientid);
END clear_session_context;



-- очищает глобальный контекст для всех пользователей !!! пользоваться осторожно!
PROCEDURE clear_global_context IS
BEGIN
  for u in (select client_id from user_login_sessions) loop
    sys.dbms_session.clear_context(sec.ctx_namespace, u.client_id);
  end loop;
  bars_audit.trace('BARS.SEC: Очищен контекст масок доступа к счетам по всем пользователям');
END clear_global_context;

-- очищает контекст пользователя
PROCEDURE clear_client_context(p_user_id in number default NULL)
IS
l_user_id    number;
l_client_id  varchar2(64);
BEGIN
  if p_user_id is null then
    l_user_id := user_id;
  else
    l_user_id := p_user_id;
  end if;
  for c in (select client_id from user_login_sessions where user_id = l_user_id)
  loop
      sys.dbms_session.clear_context(sec.ctx_namespace, c.client_id);
  end loop;
  bars_audit.trace('BARS.SEC: Очищен контекст масок доступа к счетам. Пользователь ID=' || to_char(l_user_id));
END clear_client_context;

-- выполняет обновление глобального контекста масок доступа к счетам
procedure update_sec_ctx(p_user_id in integer) is
begin
  bars_audit.trace('BARS.SEC: START: обновление глобального контекста масок доступа к счетам, USER_ID='||p_user_id);
  sec.clear_client_context(p_user_id);
  sec.getmask(p_user_id,smask,dmask,kmask,smask_global,dmask_global,kmask_global,smask_parent,dmask_parent,kmask_parent);
  bars_audit.trace('BARS.SEC: FINISH: обновление глобального контекста масок доступа к счетам, USER_ID='||p_user_id);
end update_sec_ctx;

-- выполняет переинициализацию пакета
procedure reinit is
begin
   id := user_id;
   my_id := id;

   g_user_branch        := tobopack.gettobo;
   g_user_branch_mask   := g_user_branch||'%';
   g_user_parent_branch := substr(g_user_branch, 1, instr(g_user_branch, '/', -2));
end reinit;

----
-- call_getmask - вызывает getmask
--
procedure call_getmask
is
begin
    id := user_id;
    my_id := id;
    --
    if smask is null or smask_parent is null or smask_global is null
    or dmask is null or dmask_parent is null or dmask_global is null
    or kmask is null or kmask_parent is null or kmask_global is null
    then
        getmask (id,smask,dmask,kmask,smask_global,dmask_global,kmask_global,smask_parent,dmask_parent,kmask_parent);
    end if;
    --
    id:=-1;
end call_getmask;

-- выполняет инициализацию пакета
procedure init is
begin
   -- получаем размер поля accounts.sec
   if g_sec_length is null
   then
       select data_length
         into g_sec_length
         from user_tab_columns
        where table_name='ACCOUNTS'
          and column_name='SEC';
   end if;
   --
   reinit;
   --
end init;

procedure test is
begin
    sys.dbms_session.set_context(
         namespace => sec.ctx_namespace,
         attribute => 'test',
         value        => 'This is '||user||' with id='||sys_context('userenv','client_identifier'),
         username  => NULL,
         client_id => sys_context('userenv','client_identifier'));
end test;

----
-- enqueue_sec_update - помещает запись на обновление маски доступа к счетам в очередь
--
procedure enqueue_sec_update(p_userid in integer, p_date in date)
is
begin
    insert
      into sec_update_queue(user_id, update_time)
    values (p_userid, p_date);
    logger.trace('insert into sec_update_queue(user_id, update_time) values('
    ||p_userid||', to_date('||to_char(p_date, 'DD.MM.YYYY HH24:MI:SS')||',''DD.MM.YYYY HH24:MI:SS''))');
exception
    when dup_val_on_index then
        logger.trace('dup_val_on_index on insert into sec_update_queue(user_id, update_time) values('
        ||p_userid||', to_date('||to_char(p_date, 'DD.MM.YYYY HH24:MI:SS')||',''DD.MM.YYYY HH24:MI:SS''))');
end enqueue_sec_update;

----
-- proc_sec_update_queue - обрабатывает очередь на обновление маски доступа к счетам
--
procedure proc_sec_update_queue
is
begin
    logger.trace('proc_sec_update_queue start');
    --
    for c in (select *
                from sec_update_queue
               where update_time<=sysdate
                 for update skip locked
               order by update_time)
    loop
        update_sec_ctx(c.user_id);
        --
        delete
          from sec_update_queue
         where update_time = c.update_time
           and user_id = c.user_id;
        --
    end loop;
    --
    logger.trace('proc_sec_update_queue finish');
    --
end proc_sec_update_queue;

BEGIN
  init;
END sec;
/
 show err;
 
PROMPT *** Create  grants  SEC ***
grant EXECUTE                                                                on SEC             to ABS_ADMIN;
grant EXECUTE                                                                on SEC             to BARS009;
grant EXECUTE                                                                on SEC             to BARSAQ;
grant EXECUTE                                                                on SEC             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SEC             to CUST001;
grant EXECUTE                                                                on SEC             to KLBX;
grant EXECUTE                                                                on SEC             to START1;
grant EXECUTE                                                                on SEC             to TECH005;
grant EXECUTE                                                                on SEC             to TEST_ROLE;
grant EXECUTE                                                                on SEC             to WR_ALL_RIGHTS;
grant EXECUTE                                                                on SEC             to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sec.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 