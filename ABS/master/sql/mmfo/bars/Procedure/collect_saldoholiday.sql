create or replace procedure COLLECT_SALDOHOLIDAY
is
  c_title     constant varchar2(64) := 'collect_salho';
  l_minacrdat date;
  l_kf        varchar2(6);
--                     exception;
--pragma exception_init( -00054);
begin
  
  bars_audit.trace( '%s: Entry.', c_title );

  l_kf := sys_context('bars_context','user_mfo');

  select min(ACR_DAT)
    into l_minacrdat
    from INT_ACCN    i
    join DPT_DEPOSIT d
      on ( d.KF = i.KF and d.ACC = i.ACC )
   where d.DAT_END >= GL.BD()
     and i.id = 1;

  BARS_AUDIT.INFO( c_title||': KF='||l_kf||', min(INT_ACCN.ACR_DAT)='||to_char(l_minacrdat,'dd.mm.yyyy') );

  l_minacrdat := greatest( l_minacrdat, ADD_MONTHS(trunc(GL.BD(),'MM')-1,-6) );

  -- Сбрасываем флаг работы по накопительной таблице
  ACRN.SET_COLLECT_SALHO(0);

  -- Очищаем таблицу
  if ( l_kf Is Null )
  then
    execute immediate 'truncate table SALDO_HOLIDAY';
  else
    begin
      execute immediate 'alter session SET DDL_LOCK_TIMEOUT=60';
      execute immediate 'alter table SALDO_HOLIDAY truncate partition P_'||l_kf;
--    exception
--      when
    end;
  end if;

  bars_audit.trace( '%s: table saldo_holiday cleared.', c_title );

  execute immediate 'alter session ENABLE PARALLEL DML';

  -- Наполняем таблицу
  execute immediate 'insert /*+ APPEND PARALLEL(24) */'
         ||chr(10)||'  into SALDO_HOLIDAY' || case when l_kf Is Null then '' else ' partition ( P_'||l_kf||' )' end
         ||chr(10)||'     ( KF, FDAT, CDAT, ACC, DOS, KOS )'
         ||chr(10)||'select /*+ ORDERED FULL( e ) FULL( t ) FULL( d ) */'
         ||chr(10)||'       t.KF, t.FDAT , trunc(e.PAY_CALDATE) as CDAT, t.ACC'
         ||chr(10)||'     , nvl(sum(decode(t.DK,0,t.S)),0) as DOS'
         ||chr(10)||'     , nvl(sum(decode(t.DK,1,t.S)),0) as KOS'
         ||chr(10)||'  from OPER_EXT e'
         ||chr(10)||'  join OPLDOK   t'
         ||chr(10)||'    on ( t.KF = e.KF and t.REF = e.REF )'
         ||chr(10)||'  join DPT_DEPOSIT d'
         ||chr(10)||'    on ( d.KF = t.KF and d.ACC = t.ACC )'
         ||chr(10)||' where e.PAY_BANKDATE > :l_minacrdat'
         ||chr(10)||'   and t.FDAT > :l_minacrdat'
         ||chr(10)||'   and t.SOS = 5'
         ||chr(10)||'   and t.FDAT > e.PAY_CALDATE'
         ||chr(10)||' group by  t.KF, t.FDAT, trunc(e.PAY_CALDATE), t.ACC' 
    using l_minacrdat, l_minacrdat;

  bars_audit.trace( '%s: %s rows created.', c_title, to_char(sql%rowcount) );

  commit;

  -- Устанавливаем флаг работы по накопительной таблице
  ACRN.SET_COLLECT_SALHO(1);

  bars_audit.trace( '%s: table saldo_holiday collected.', c_title );

end COLLECT_SALDOHOLIDAY;
/

show errors;
