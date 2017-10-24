
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_dptbonus.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_DPTBONUS (p_bonus_id  in int, p_dpt_id in dpt_deposit.deposit_id%type) return number is
l_bonusval number;
begin
 if p_bonus_id = 2
 then 
   SELECT NVL (MAX (CASE
                WHEN NVL (cnt, 0) = 0 THEN 0
                WHEN kv = 980 THEN 0.5
                WHEN kv IN (840, 978) THEN 0.25
                ELSE 0
             END),0)
  into l_bonusval
  FROM (SELECT t2.cnt_acc cnt, t3.kv
          FROM dpt_deposit t3,
               (SELECT COUNT (t1.acc) cnt_acc
                  FROM accounts t1
                 WHERE     t1.rnk = (select rnk from dpt_deposit where deposit_id = p_dpt_id)
                       AND T1.NBS = 2625
                       AND T1.OB22 IN ('24', '27', '31')
                       AND T1.DAZS IS NULL) t2
         WHERE T3.DEPOSIT_ID = p_dpt_id);
 elsif p_bonus_id = 4 then
    SELECT NVL (MAX (CASE WHEN NVL (cnt, 0) = 0 THEN 0 ELSE val END), 0)
      INTO l_bonusval
      FROM (WITH dv
                 AS (SELECT *
                       FROM dpt_vidd
                      WHERE vidd =
                               (SELECT vidd
                                  FROM dpt_deposit
                                 WHERE deposit_id =p_dpt_id)),
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
                     WHERE deposit_id = p_dpt_id) t,
                   ext_t
             WHERE     dv.vidd = d.vidd
                   AND d.deposit_id = p_dpt_id
                   AND dv.type_id = DBS.DPT_TYPE
                   AND dbs.kv = dv.kv
                   AND NVL (DBS.s, -1) != -1
                   AND dbs.bonus_id = 4
                   AND (   d.cnt_dubl+1 BETWEEN ext_num AND ext_num_next
                        OR NVL (d.cnt_dubl, 0) = 0)
                   AND ext_t.TYPE_ID(+) = DV.EXTENSION_ID)
     WHERE lim BETWEEN s0 AND s;
   end if;
return l_bonusval;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_DPTBONUS ***
grant EXECUTE                                                                on F_GET_DPTBONUS  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_dptbonus.sql =========*** End
 PROMPT ===================================================================================== 
 