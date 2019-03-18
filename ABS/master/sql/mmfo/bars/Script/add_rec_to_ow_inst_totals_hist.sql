begin
    for j in (select kf from mv_kf) loop
        bc.go(j.kf);
        for i in (select chain_idt from (
                         select chain_idt,  
                                max(plan_num) KEEP (DENSE_RANK LAST ORDER BY plan_num) as by_pl_num, 
                                max(plan_num) KEEP (DENSE_RANK LAST ORDER BY ins_bd) as by_ins_bd 
                           from ow_inst_totals_hist group by chain_idt)
                          where by_pl_num <> by_ins_bd) loop
        bars_ow.int_move_to_hist(i.chain_idt);
        end loop;
    end loop;
bc.go('/');
exception when others then 
bc.go('/');
raise;
end;
/