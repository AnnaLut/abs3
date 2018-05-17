PROMPT ===================== *** drop table tmp_repair_int260418 *** ===============================

begin
  begin
  execute immediate 'drop table tmp_repair_int260418';
  exception when others then null;
  end;
end;
/
PROMPT =============== *** create and fill table tmp_repair_int260418 *** ==========================
BEGIN 

 begin
   execute immediate 'CREATE TABLE tmp_repair_int260418 AS
(select d.deposit_id, d.dat_begin, d.vidd, d.acc, d.kv, d.rnk, d.kf, d.branch, nvl(d.cnt_dubl,0) cnt_dubl,
d.wb,
dt.type_code,
dv.extension_id ext_id,
irad.ir old_ir,
irad.br old_br,
irad.op old_op,
-999 new_ir,
-999 new_br,
-999 new_op,
''                                                                                                                                                                                                                 '' note
from 
   bars.dpt_deposit d,
   bars.accounts ac,
   bars.dpt_vidd dv,
   bars.dpt_types dt,
   bars.int_ratn_arc irad,
   bars.int_ratn_arc irai
where 1=1
      and ac.acc = d.acc 
      and ac.kf = d.kf 
      and ac.nbs = ''2630''
      and dv.vidd = d.vidd
      and dt.type_id = dv.type_id 
      and dt.type_code <> ''AKC''
      and d.dat_begin = to_date(''26.04.2018'',''DD.MM.YYYY'')
      and (d.dat_end is null or d.dat_end > trunc(sysdate))
      and d.cnt_dubl >= 1
      and not exists (select null from bars.int_ratn ir where ir.bdat = to_date(''26.04.2018'',''DD.MM.YYYY'') and ir.acc = ac.acc)
      and irad.acc = ac.acc
      and irad.id = 1
      and irad.idu = 1
      and trunc(irad.fdat) = to_date(''05.05.2018'',''DD.MM.YYYY'')
      and irad.br is not null
      and irai.acc = ac.acc
      and irai.id = 1
      and irai.idu <> 1
      and irai.bdat = to_date(''26.04.2018'',''DD.MM.YYYY'')
      and irai.fdat between to_date(''26.04.2018 23:00:00'',''DD.MM.YYYY HH24:MI:SS'') and to_date(''27.04.2018 07:59:59'', ''DD.MM.YYYY HH24:MI:SS'')
      and irai.br is not null
      and irad.ir = irai.ir
      and irad.br = irai.br)';

exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table already exists.');
    else raise;
    end if;  
end;

END;
/

PROMPT ================= *** table tmp_repair_int260418 created *** =============================
 
