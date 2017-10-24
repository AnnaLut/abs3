

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DPT_SOC_DOS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DPT_SOC_DOS ***

  CREATE OR REPLACE PROCEDURE BARS.P_DPT_SOC_DOS (p_date date) is
 type t_turns_baserow is record (acc int, date1 date, s number);
 type t_turns_baseset is table of t_turns_baserow;
 l_turns_baseset t_turns_baseset;
 l_date date;
BEGIN
 if p_date is null
 then
    l_date :=  TO_DATE ('01/06/2015', 'dd/mm/yyyy');
 else
    l_date := p_date;
 end if;

        WITH refs
               AS (SELECT REF,
                          acc,
                          fdat
                     FROM opldok od
                    WHERE     EXISTS
                                 (SELECT 1
                                    FROM dpt_soc_turns
                                   WHERE od.acc = acc AND date1 = od.fdat)
                          AND od.fdat >= l_date
                          AND sos = 5)
          SELECT r.acc, ok.fdat date1, ok.s /*+parallel 5*/
          bulk collect into l_turns_baseset
            FROM refs r, opldok ok
           WHERE r.REF = ok.REF
                 AND oK.fdat = r.fdat
                 AND EXISTS
                        (SELECT 1
                           FROM accounts
                          WHERE     nbs = '2909'
                                AND ob22 IN ('22', '25', '63')
                                AND dazs IS NULL
                                AND acc = ok.acc);
    for k in 1 .. l_turns_baseset.count
    loop

      UPDATE dpt_soc_turns
         SET kos_social = l_turns_baseset(k).s
       WHERE acc = l_turns_baseset(k).acc
         AND date1 = l_turns_baseset(k).date1;


   END LOOP;

   update dpt_soc_turns
   set  kos_social = 0
   where  kos_social is null;
   commit;
END p_dpt_soc_dos;
/
show err;

PROMPT *** Create  grants  P_DPT_SOC_DOS ***
grant EXECUTE                                                                on P_DPT_SOC_DOS   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DPT_SOC_DOS.sql =========*** End
PROMPT ===================================================================================== 
