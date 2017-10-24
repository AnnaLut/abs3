begin
        for k in (
        SELECT vidd,
               3 BONUS_ID,
               NULL REC_CONDITION,
               nvl((SELECT MAX (REC_RANG) + 1
                  FROM dpt_vidd_bonuses
                 WHERE vidd = dv.vidd),1)
                  AS REC_RANG,
               'Y' REC_ACTIVITY,
               'N' REC_FINALLY
          FROM bars.dpt_vidd dv
         WHERE     type_id IN (SELECT type_id
                                 FROM bars.dpt_types
                                WHERE fl_webbanking = 1)
               AND NOT EXISTS
                      (SELECT 1
                         FROM dpt_vidd_bonuses
                        WHERE vidd = dv.vidd AND bonus_id = 3)
        )
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
