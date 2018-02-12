declare  ff SPARAM_LIST%rowtype;
--------------------------------
begin 

  begin Insert into SPARAM_CODES   (CODE, NAME, ORD) Values   ('OVRN', 'Овердрафт', 8);
  exception when dup_val_on_index then null;  
  end;

  ff.name := 'VALUE' ;  ff.TABNAME  := 'ACCOUNTSW' ;  ff.CODE := 'OVRN' ;  ff.INUSE := 1;  ff.BRANCH := '/300465/' ;
  
--for k in (select * from mv_kf)
--loop bc.go ( k.KF);
  -----------------------------------------------------------------------------------------------------------------------------------------------
  --2600
  ff.tag := 'DONOR'  ; ff.semantic  := 'ОВР:Учасник без права ОВР';  
  update SPARAM_LIST  set semantic   = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;

  --2600
  ff.tag := 'TERM_OVR'; ff.semantic := 'ОВР:Термін безперер.дії, кіл.днів';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;

  --2600
  ff.tag := 'NOT_DS'; ff.semantic := 'ОВР:Відсутнє договірне списання';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  --2600
  ff.tag := 'NEW_KL'; ff.semantic := 'ОВР:<<Новий>> клієнт';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  --8998
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'PCR_CHKO'; ff.semantic := 'ОВР:Розмір ліміту (% від ЧКО)';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------

  ff.tag := 'TERM_DAY'; ff.semantic := 'ОВР:Термін(день міс) для сплати %%';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'STOP_O'; ff.semantic := 'ОВР:<<СТОП>> ';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;

  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'DT_SOS'; ff.semantic := 'ОВР:Дата зміни статусу дог';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'D'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'TERM_LIM'; ff.semantic := 'ОВР:День міс.перегляду ліміту';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'NOT_ZAL'; ff.semantic := 'ОВР:Угода без забеспечення';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'DEL_LIM'; ff.semantic := 'ОВР:Max % відх.ново ліміту від поперед';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'EXIT_ZN'; ff.semantic := 'ОВР:Тільки Ручний вихід із "сірої"=1';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
--end loop;
-- suda;
end;
/
COMMIT;
---------------------------------
delete from PS_SPARAM where spid in (select spid from SPARAM_LIST where code ='OVRN');

insert into PS_SPARAM( NBS ,   SPID ) 
               select p.nbs, l.spid 
               from ps p, SPARAM_LIST l
               where p.nbs in ( '2600', '2650', '2602', '2603', '2604' )
                 and l.TABNAME ='ACCOUNTSW' and l.tag in ( 'DONOR', 'TERM_OVR', 'NOT_DS', 'NEW_KL' ) ;
commit;
