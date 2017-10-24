

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DELACCM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DELACCM ***

  CREATE OR REPLACE PROCEDURE BARS.DELACCM is
  n_   number;
  d_   date;
begin
  bars_audit.info('DELACCM: start');
  -- ничего не делаем, т.к. синхронизацию снимков баланса убрали(удалили задание/job/)
  -- во время импорта АСВО и последующего удаления счетов снимки баланса не пересчитываются
  -- в любом случае решением проблемы несуществующих счетов в снимках баланса будет пересоздание снимка
  bars_audit.info('DELACCM: done, delete '||n_||' rows');

--немножко чистим мусор (для КБ)

  tokf;
  for k in (select rowid,nfia
            from   klpoow
            where  instr(nfia,'.')=0
           )
  loop
    begin
      select 1
      into   n_
      from   oper
      where  ref=to_number(k.nfia) and
             trunc(pdat)<>gl.bd;
    exception when no_data_found then
      n_ := 0;
    end;
    if n_=1 then
      delete
      from   klpoow
      where  rowid=k.rowid and
             nfia=k.nfia;
    end if;
  end loop;
  toroot;
  commit;

exception when OTHERS then
  rollback;
  bars_audit.error('DELACCM: '||sqlerrm||' - '||dbms_utility.format_error_backtrace);
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DELACCM.sql =========*** End *** =
PROMPT ===================================================================================== 
