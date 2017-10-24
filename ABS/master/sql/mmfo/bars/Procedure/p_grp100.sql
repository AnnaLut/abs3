

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_GRP100.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_GRP100 ***

  CREATE OR REPLACE PROCEDURE BARS.P_GRP100 
is
BEGIN

-- процедура раскидывает "Тимчасову робочу групу 100"
-- по нужным нам группам

   FOR i IN (SELECT acc
             FROM accounts
             WHERE (nbs in ('1312', '1322',
                            '1318', '1328') )
               AND ( grp <> 07 or grp is null ))
   LOOP
      UPDATE accounts SET GRP=07 where acc=i.acc;
   END LOOP;
   ----------------------------------------------------------
   FOR i IN (SELECT acc
             FROM accounts
             WHERE (nbs like '151%' or
                    nbs like '152%' or
                    nbs like '158%' or
                    nbs like '159%' or
                    nbs like '178%' or
                    nbs like '179%' ) and ( grp <> 10 or grp is null ))
   LOOP
      UPDATE accounts SET GRP=10 where acc=i.acc;
   END LOOP;
   ----------------------------------------------------------
   FOR i IN (SELECT acc
             FROM accounts
             WHERE ( nbs like '161%' or
                     nbs like '162%' ) and ( grp <> 12 or grp is null ))
   LOOP
      UPDATE accounts SET GRP=12 where acc=i.acc;
   END LOOP;
   ----------------------------------------------------------
   FOR i IN (SELECT acc
             FROM accounts
             WHERE ( nbs like '950%' or
                     nbs like '951%' or
                     nbs = 3409 ) and ( grp <> 46 or grp is null ))
   LOOP
      UPDATE accounts SET GRP=46 where acc=i.acc;
   END LOOP;
   ----------------------------------------------------------

   COMMIT;

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_GRP100.sql =========*** End *** 
PROMPT ===================================================================================== 
