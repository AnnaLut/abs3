
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/FINMON/function/isd_branch.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION FINMON.ISD_BRANCH 
   RETURN NUMBER
IS
   d_branch   varchar2 (200);
BEGIN
   BEGIN
      SELECT   UPPER (TRIM (val))
        INTO   d_branch
        FROM   params
       WHERE   par = 'D_BRANCH'
       and kf = finmon.fm_policies.get_mfo;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         d_branch := 'FALSE';
   END;

   IF (d_branch = 'TRUE')
   THEN
      RETURN 1;
   ELSE
      RETURN 0;
   END IF;
END isD_BRANCH;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/FINMON/function/isd_branch.sql =========*** End *
 PROMPT ===================================================================================== 
 