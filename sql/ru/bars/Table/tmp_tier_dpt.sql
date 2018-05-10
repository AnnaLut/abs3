begin
  begin
  execute immediate 'drop table tmp_tier_dpt';
  exception when others then null;
  end;
end;
/  
 begin
   execute immediate 'CREATE TABLE tmp_tier_dpt AS
(select d.deposit_id, d.acc, d.kv, d.kf, d.branch,  ir.br, 8.25000000 base_rate, ir.ir old_ir, ir.ir count_ir, ir.ir new_ir,
 sysdate chng_dat,
 ''                                                                                                                                                                                                                 '' note
from bars.dpt_deposit d
inner join bars.int_ratn ir on ir.acc = d.acc
inner join bars.dpt_vidd dv on dv.vidd = d.vidd
inner join bars.dpt_types dt on dt.type_id = dv.type_id 
where 1 = 0)';

exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table already exists.');
    else raise;
    end if;  
end;

/
