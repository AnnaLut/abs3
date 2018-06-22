PROMPT *** Run *** ====== ins_data_dpt_vidd_bonus.sql =======*** Run ***
begin
        for k in (
        SELECT vidd,
               5 BONUS_ID,
               NULL REC_CONDITION,
               nvl((SELECT MAX (REC_RANG) + 1
                  FROM dpt_vidd_bonuses
                 WHERE vidd = dv.vidd),1)
                  AS REC_RANG,
               'Y' REC_ACTIVITY,
               'N' REC_FINALLY
          FROM bars.dpt_vidd dv
         WHERE upper(type_name) like '%л╡и%' 
           and upper(type_name) not like '%опнцпея%' 
           and kv = 980)
        loop
         begin
            insert into bars.dpt_vidd_bonuses(VIDD, BONUS_ID, REC_CONDITION, REC_RANG, REC_ACTIVITY, REC_FINALLY)       
            values (k.VIDD, k.BONUS_ID, k.REC_CONDITION, k.REC_RANG, k.REC_ACTIVITY, k.REC_FINALLY);
         exception when dup_val_on_index then null;
         end;   
        end loop;                   
end;
/
commit;
/


PROMPT *** End *** ====== ins_data_dpt_vidd_bonus.sql =======*** End ***
