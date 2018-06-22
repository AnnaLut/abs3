PROMPT *** Run *** ====== ins_data_dpt_bonuses.sql =======*** Run ***
declare
l_bonus_id number := 5;
l_sql      varchar2(4000);
begin
 
 l_sql := 
  'SELECT NVL (MAX (CASE WHEN NVL (cnt, 0) = 0 THEN 0 ELSE val END), 0)
   FROM ( 
   WITH bonusid AS (select bars.dpt_bonus.get_bonus_id(''EXTN'') b_id from dual)
   SELECT t.cnt, dbs.val 
   FROM   dpt_deposit d,
          dpt_bonus_settings dbs,
          dpt_vidd dv,
          bonusid bid,
          (SELECT COUNT (*) cnt
           FROM dpt_deposit
           WHERE deposit_id = SYS_CONTEXT (''bars_dpt_bonus'', ''dpt_id'')) t       
   WHERE d.deposit_id = SYS_CONTEXT (''bars_dpt_bonus'', ''dpt_id'')
     AND d.vidd = dv.vidd
     AND dv.type_id = dbs.dpt_type
     AND dv.kv = dbs.kv 
     AND nvl(d.cnt_dubl,0) >= 1
     AND :pDat between dbs.dat_begin and nvl(dbs.dat_end, to_date(''31.12.4999'',''DD.MM.YYYY''))
     AND dbs.bonus_id = bid.b_id)';

 begin
  
  insert into bars.dpt_bonuses 
   values (l_bonus_id , 'Бонус за пролонгацію', 'EXTN', 'Y', 'N', 'N', l_sql, date'2018-07-01', null, null);

 exception when dup_val_on_index then 
   null;
 end;   
                    
end;
/
commit;
/


PROMPT *** End *** ====== ins_data_dpt_bonuses.sql =======*** End ***
