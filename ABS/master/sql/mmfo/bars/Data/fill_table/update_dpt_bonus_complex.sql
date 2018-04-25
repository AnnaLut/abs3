PROMPT **Update dpt_bonus_complex**

DECLARE
l_sql bars.dpt_bonus_complex.func_name%type;

BEGIN

/*
--====== Old value of field 'FUNC_NAME' --- для всех оно было одинаковым
-- назначение - исключить обнуление веб-банкингом меньших бонусов

update dpt_bonus_requests
           set bonus_value_fact = 0
         where (dpt_id, bonus_value_fact) in
             (select dpt_id, bonus_value_fact from (
              select t1.dpt_id, bonus_value_fact, count(*)cc, min(t1.bonus_id) b, max(bonus_value_fact) over (order by t1.dpt_id) max_bonus_value_fact
                 from dpt_bonus_requests t1, dpt_bonuses t2, DPT_REQUESTS t3
                where t1.dpt_id = :p_dptid
                  and :p_branch is not null
                  and T1.BONUS_ID = T2.BONUS_ID
                  and T3.DPT_ID = t1.dpt_id
                  and T1.REQ_ID = T3.REQ_ID
                  and t1.bonus_id != 3 -- веб-банкинг не должен обнулять остальные
                  and T3.REQTYPE_ID = 1 -- запит на бонусну ставку
                  and T2.BONUS_CONFIRM = 'N' -- не потребує додаткового підтвердження
                  and T1.REQUEST_STATE = 'ALLOW'
                group by t1.dpt_id,bonus_value_fact)
                where ( cc = 1 and bonus_value_fact < max_bonus_value_fact)
                   or ( cc != 1 and bonus_value_fact <= max_bonus_value_fact and b != bonus_id)) and BONUS_ID != 3  */                   

l_sql := 'update dpt_bonus_requests
           set bonus_value_fact = 0
         where (dpt_id, bonus_value_fact) in
             (select dpt_id, bonus_value_fact from (
              select t1.dpt_id, bonus_value_fact, count(*)cc, min(t1.bonus_id) b, max(bonus_value_fact) over (order by t1.dpt_id) max_bonus_value_fact
                 from dpt_bonus_requests t1, dpt_bonuses t2, DPT_REQUESTS t3
                where t1.dpt_id = :p_dptid
                  and :p_branch is not null
                  and T1.BONUS_ID = T2.BONUS_ID
                  and T3.DPT_ID = t1.dpt_id
                  and T1.REQ_ID = T3.REQ_ID
                  and t1.bonus_id != dpt_bonus.get_bonus_id(''DPWB'') -- веб-банкинг не должен обнулять остальные
                  and T3.REQTYPE_ID = 1 -- запит на бонусну ставку
                  and T2.BONUS_CONFIRM = ''N'' -- не потребує додаткового підтвердження
                  and T1.REQUEST_STATE = ''ALLOW''
                group by t1.dpt_id,bonus_value_fact)
                where ( cc = 1 and bonus_value_fact < max_bonus_value_fact)
                   or ( cc != 1 and bonus_value_fact <= max_bonus_value_fact and b != bonus_id)) and BONUS_ID != dpt_bonus.get_bonus_id(''DPWB'')';
update bars.dpt_bonus_complex set func_name = l_sql;
commit;

end;
/
show error