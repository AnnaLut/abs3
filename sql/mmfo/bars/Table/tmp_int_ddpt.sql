PROMPT ===================== *** drop table tmp_int_ddpt *** ===============================

begin
  begin
  execute immediate 'drop table tmp_int_ddpt';
  exception when others then null;
  end;
end;
/
PROMPT =============== *** create and fill table tmp_int_ddpt *** ==========================
BEGIN 

 begin
   execute immediate 'CREATE TABLE tmp_int_ddpt AS
(select d.deposit_id, d.dat_begin, d.vidd, d.acc, d.kv, d.rnk, d.kf, d.branch, d.cnt_dubl,
-999 open_zp_cnt,
d.wb,
ir.br,
ir.ir,
dt.type_code,
dv.extension_id ext_id,
-999 bonus,
''                                                                                                                                                                                                                 '' note
from bars.dpt_deposit d
inner join bars.accounts ac on ac.acc = d.acc and ac.kf = d.kf
inner join bars.int_ratn ir on ir.acc = d.acc and ir.br is not null
inner join bars.brates br on br.br_id = ir.br 
inner join bars.dpt_vidd dv on dv.vidd = d.vidd
inner join bars.dpt_types dt on dt.type_id = dv.type_id and dt.type_code <> ''AKC''
where d.dat_begin >= to_date(''28.02.2017'',''DD.MM.YYYY'')
and (d.dat_end is null or d.dat_end > trunc(sysdate))
and ir.bdat = (select max(bdat) from bars.int_ratn where acc = ir.acc)
and br.br_type = 1
and ac.nbs = ''2630'')';

exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table already exists.');
    else raise;
    end if;  
end;
END;
/

PROMPT ================= *** table tmp_int_ddpt created *** =============================
 
