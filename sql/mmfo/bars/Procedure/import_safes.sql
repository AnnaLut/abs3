

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IMPORT_SAFES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IMPORT_SAFES ***

  CREATE OR REPLACE PROCEDURE BARS.IMPORT_SAFES 
IS
   l_error   VARCHAR2 (1000);
BEGIN
   FOR k IN (SELECT DISTINCT branch
               FROM skr_import_safes
              WHERE imported = 0)
   LOOP
      BEGIN
         bc.subst_branch (k.branch);
      EXCEPTION
         WHEN OTHERS
         THEN
            l_error := SUBSTR (SQLERRM, 1, 1000);

            UPDATE skr_import_safes
               SET error = l_error
             WHERE branch = k.branch;

            CONTINUE;
      END;

      FOR s IN (SELECT snum, o_sk
                  FROM skr_import_safes
                 WHERE branch = k.branch AND imported = 0)
      LOOP
         BEGIN
            SAFE_DEPOSIT.
             CREATE_SAFE (s.snum,
                          s.o_sk,
                          SUBSTR (f_newnls (1, 'SCRN', '2909'), 1, 14));

            UPDATE skr_import_safes
               SET error = 'Open successfully', imported = 1
             WHERE snum = s.snum AND branch = k.branch;

			 commit;

         EXCEPTION
            WHEN OTHERS
            THEN
               l_error := SUBSTR (SQLERRM, 1, 1000);

               UPDATE skr_import_safes
                  SET error = l_error
                WHERE snum = s.snum AND branch = k.branch;
         END;
      END LOOP;
   END LOOP;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IMPORT_SAFES.sql =========*** End 
PROMPT ===================================================================================== 
