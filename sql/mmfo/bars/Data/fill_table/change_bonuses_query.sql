PROMPT *** change bonuses query in dpt_bonuses ***

DECLARE
l_sql varchar2(4000);

BEGIN

execute immediate 'ALTER TRIGGER TBI_DPT_BONUSES ENABLE';

/* -- старые запросы для расчета бонусов. 
---===DPZP (bonus_id = 2):
SELECT NVL (MAX (CASE
                WHEN NVL (cnt, 0) = 0 THEN 0
                WHEN kv = 980 THEN 0.5
                WHEN kv IN (840, 978) THEN 0.25
                ELSE 0
             END),0)
  FROM (SELECT t2.cnt_acc cnt, t3.kv
          FROM dpt_deposit t3,
               (SELECT COUNT (t1.acc) cnt_acc
                  FROM accounts t1
                 WHERE     t1.rnk = SYS_CONTEXT ('bars_dpt_bonus', 'cust_id')
                       AND T1.NBS = 2625
                       AND T1.OB22 IN ('24', '27', '31')
                       AND T1.DAZS IS NULL) t2
         WHERE T3.DEPOSIT_ID = SYS_CONTEXT ('bars_dpt_bonus', 'dpt_id'))

version2 (Feb 2018):
select nvl(MAX (CASE WHEN NVL (cnt, 0) = 0 THEN 0 ELSE val END), 0)  
         from   (SELECT t2.cnt_acc cnt, dbs2.val
          FROM dpt_bonus_settings dbs2 ,
               dpt_vidd dv2,
               dpt_deposit dd2,
               (SELECT COUNT (a2.acc) cnt_acc
                  FROM accounts a2 
                 WHERE a2.rnk =  SYS_CONTEXT ('bars_dpt_bonus', 'cust_id') 
                       AND a2.NBS = 2625
                       AND a2.OB22 IN ('24', '27', '31')
                       AND a2.DAZS IS NULL) t2
         WHERE dd2.DEPOSIT_ID = SYS_CONTEXT ('bars_dpt_bonus', 'dpt_id') 
           and dv2.vidd = dd2.vidd
           and dbs2.dpt_type = dv2.type_id
           and dbs2.kv = dv2.kv
           and :pDat+1 between dbs2.dat_begin and nvl(dbs2.dat_end, to_date('31.12.4999','DD.MM.YYYY'))
           and dbs2.bonus_id = dpt_bonus.get_bonus_id('DPZP'))
           
---===DPWB (bonus_id = 3):
SELECT NVL (MAX (CASE WHEN NVL (cnt, 0) = 0 THEN 0 ELSE val END), 0)
  FROM (SELECT t.cnt, dbs.val
          FROM dpt_bonus_settings dbs,
               dpt_vidd dv,
               dpt_deposit d,
               (SELECT COUNT (wb) cnt
                  FROM dpt_deposit
                 WHERE deposit_id = SYS_CONTEXT ('bars_dpt_bonus', 'dpt_id') AND wb = 'Y') t
         WHERE     dv.vidd = d.vidd
               AND d.deposit_id = SYS_CONTEXT ('bars_dpt_bonus', 'dpt_id')
               AND dv.type_id = DBS.DPT_TYPE
               AND dbs.kv = dv.kv
               AND dbs.bonus_id = 3)

---===EXCL (bonus_id = 4):
SELECT NVL (MAX (CASE WHEN NVL (cnt, 0) = 0 THEN 0 ELSE val END), 0)
  FROM (WITH dv
             AS (SELECT *
                   FROM dpt_vidd
                  WHERE vidd =
                           (SELECT vidd
                              FROM dpt_deposit
                             WHERE deposit_id = SYS_CONTEXT ('bars_dpt_bonus','dpt_id'))),
             ext_t
             AS (SELECT ext_num,
                        NVL (LEAD (ext_num) OVER (ORDER BY ext_num), 999999)
                           ext_num_next,
                        dve.type_id
                   FROM dpt_vidd_extdesc dve, dv
                  WHERE     METHOD_ID IN (8, 9, 10)
                        AND extension_id = dve.type_id)
        SELECT fost (d.acc, gl.bd),
               dv.kv,
               d.cnt_dubl,
               ext_num,
               ext_num_next,
               DV.EXTENSION_ID,
               t.cnt,
               dbs.val,
               dbs.s s0,
               NVL (LEAD (dbs.s) OVER (ORDER BY dbs.s), 9999999999999999) - 1
                  s,
               GREATEST (fost (d.acc, gl.bd), d.LIMIT) lim
          FROM dpt_bonus_settings dbs,
               dv,
               dpt_deposit d,
               (SELECT COUNT (deposit_id) cnt
                  FROM dpt_deposit
                 WHERE deposit_id = SYS_CONTEXT ('bars_dpt_bonus', 'dpt_id')) t,
               ext_t
         WHERE     dv.vidd = d.vidd
               AND d.deposit_id = SYS_CONTEXT ('bars_dpt_bonus', 'dpt_id')
               AND dv.type_id = DBS.DPT_TYPE
               AND dbs.kv = dv.kv
               AND NVL (DBS.s, -1) != -1
               AND dbs.bonus_id = 4
               AND (   d.cnt_dubl+1 BETWEEN ext_num AND ext_num_next
                    OR NVL (d.cnt_dubl, 0) = 0)
               AND ext_t.TYPE_ID(+) = DV.EXTENSION_ID)
 WHERE lim BETWEEN s0 AND s

*/

--== DPZP
l_sql := 'select nvl(MAX (CASE WHEN cnt = 0 THEN 0 ELSE val END), 0)  
          from (
          with cntrl_dat as (select :pDat pdat from dual)
          select dbs.val, dpt_bonus.get_MMFO_ZPcard_count(SYS_CONTEXT (''bars_dpt_bonus'', ''cust_id''), cd.pdat) cnt
          from dpt_deposit dd,
               dpt_vidd dv,
               dpt_bonus_settings dbs,
               cntrl_dat cd
          where dd.deposit_id = SYS_CONTEXT (''bars_dpt_bonus'', ''dpt_id'') 
          and dd.vidd = dv.vidd
          and dbs.dpt_type = dv.type_id
          and dbs.bonus_id = dpt_bonus.get_bonus_id(''DPZP'')
          and dbs.kv = dv.kv
          and cd.pdat between dbs.dat_begin and nvl(dbs.dat_end, to_date(''31.12.4999'',''DD.MM.YYYY'')))';
   
update bars.dpt_bonuses db set db.bonus_query = l_sql where db.bonus_code = 'DPZP';

--== DPWB
l_sql := 'SELECT NVL (MAX (CASE WHEN NVL (cnt, 0) = 0 THEN 0 ELSE val END), 0)
         FROM (SELECT t.cnt, dbs.val
          FROM dpt_bonus_settings dbs,
               dpt_vidd dv,
               dpt_deposit d,
               (SELECT COUNT (wb) cnt
                  FROM dpt_deposit
                 WHERE deposit_id = SYS_CONTEXT (''bars_dpt_bonus'', ''dpt_id'') AND wb = ''Y'') t
         WHERE     dv.vidd = d.vidd
               AND d.deposit_id = SYS_CONTEXT (''bars_dpt_bonus'', ''dpt_id'')
               AND dv.type_id = DBS.DPT_TYPE
               AND dbs.kv = dv.kv
               AND :pDat between dbs.dat_begin and nvl(dbs.dat_end, to_date(''31.12.4999'',''DD.MM.YYYY''))
               AND dbs.bonus_id = bars.dpt_bonus.get_bonus_id(''DPWB''))';

update bars.dpt_bonuses db set db.bonus_query = l_sql where db.bonus_code = 'DPWB';

--== EXCL
l_sql := 'SELECT NVL (MAX (CASE WHEN NVL (cnt, 0) = 0 THEN 0 ELSE val END), 0)
        FROM (WITH dv
             AS (SELECT *
                   FROM dpt_vidd
                  WHERE vidd =
                           (SELECT vidd
                              FROM dpt_deposit
                             WHERE deposit_id = SYS_CONTEXT (''bars_dpt_bonus'',''dpt_id''))),
             ext_t
             AS (SELECT ext_num,
                        NVL (LEAD (ext_num) OVER (ORDER BY ext_num), 999999)
                           ext_num_next,
                        dve.type_id
                   FROM dpt_vidd_extdesc dve, dv
                  WHERE     METHOD_ID IN (8, 9, 10)
                        AND extension_id = dve.type_id)
        SELECT fost (d.acc, gl.bd),
               dv.kv,
               d.cnt_dubl,
               ext_num,
               ext_num_next,
               DV.EXTENSION_ID,
               t.cnt,
               dbs.val,
               dbs.s s0,
               NVL (LEAD (dbs.s) OVER (ORDER BY dbs.s), 9999999999999999) - 1
                  s,
               GREATEST (fost (d.acc, gl.bd), d.LIMIT) lim
          FROM dpt_bonus_settings dbs,
               dv,
               dpt_deposit d,
               (SELECT COUNT (deposit_id) cnt
                  FROM dpt_deposit
                 WHERE deposit_id = SYS_CONTEXT (''bars_dpt_bonus'', ''dpt_id'')) t,
               ext_t
         WHERE     dv.vidd = d.vidd
               AND d.deposit_id = SYS_CONTEXT (''bars_dpt_bonus'', ''dpt_id'')
               AND dv.type_id = DBS.DPT_TYPE
               AND dbs.kv = dv.kv
               AND :pDat between dbs.dat_begin and nvl(dbs.dat_end, to_date(''31.12.4999'',''DD.MM.YYYY''))
               AND NVL (DBS.s, -1) != -1
               AND dbs.bonus_id = bars.dpt_bonus.get_bonus_id(''EXCL'')
               AND (   d.cnt_dubl+1 BETWEEN ext_num AND ext_num_next
                    OR NVL (d.cnt_dubl, 0) = 0)
               AND ext_t.TYPE_ID(+) = DV.EXTENSION_ID)
 WHERE lim BETWEEN s0 AND s';

update bars.dpt_bonuses db set db.bonus_query = l_sql where db.bonus_code = 'EXCL';

commit; 
END;
/
show errors