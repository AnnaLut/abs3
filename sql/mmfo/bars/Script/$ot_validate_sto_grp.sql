prompt Скрипт валидации sto_grp - переходим к составному ключу вместо перекодировки, удаляем лишние группы, обновляем записи в договорах
begin
    bpa.disable_policies('STO_LST');
    for rec in (select kf from mv_kf)
    loop
--        bc.go(rec.kf);
            for grp in (select * from sto_grp where substr(idg, -2, 2) = bars_sqnc.get_ru(kf) and kf = rec.kf)
            loop
                insert /*+ ignore_row_on_dupkey_index(STO_GRP, PK_STOGRP)*/ into sto_grp(idg, name, otm, stmp, tobo, kf) 
                values (trunc(grp.idg/100), grp.name, null, sysdate, null, grp.kf);
                --dbms_output.put_line('insert: '||trunc(grp.idg/100)||' - '||grp.name);
                update sto_lst
                set idg = trunc(grp.idg/100)
                where kf = rec.kf and idg = grp.idg;
                delete from sto_grp where idg = grp.idg and kf = rec.kf;
            end loop;
    end loop;
--    bc.home;
    insert /*+ ignore_row_on_dupkey_index(STO_GRP, PK_STOGRP)*/ into sto_grp(idg, name, otm, stmp, tobo, kf) 
    select distinct r.idg, r.name, r.otm, sysdate, r.tobo, l.kf
    from sto_grp r
    join sto_lst l on r.idg = l.idg 
    where not exists (select 1 from sto_grp g where l.idg = g.idg and l.kf = g.kf);
    bpa.enable_policies('STO_LST');
exception
    when others then
        bpa.enable_policies('STO_LST');
        raise;
end;
/
insert /*+ ignore_row_on_dupkey_index(STO_GRP, PK_STOGRP)*/ into sto_grp(idg, name, otm, stmp, tobo, kf) 
select distinct r.idg, r.name, r.otm, sysdate, r.tobo, l.kf
from sto_grp r
join sto_lst l on r.idg = l.idg 
where not exists (select 1 from sto_grp g where l.idg = g.idg and l.kf = g.kf);

commit;
