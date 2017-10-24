

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Procedure/KL_DATE_VERIFY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KL_DATE_VERIFY ***

  CREATE OR REPLACE PROCEDURE FINMON.KL_DATE_VERIFY (kl_id_ varchar2, kl_date_ date)
IS
   KL_ID   varchar2 (15);
BEGIN
   BEGIN
      SELECT   KL_ID
        INTO   KL_ID
        FROM   finmon.oper
       WHERE       kl_id = kl_id_
               AND kl_date >= TRUNC (kl_date_, 'YEAR')
               AND kl_date <= TRUNC (ADD_MONTHS (kl_date_, 12), 'YEAR');

      raise_application_error (
         -20101,
            'С данным kl_id запись в этом году есть! kl_id = '
         || kl_id_
         || ', kl_date = '
         || kl_date_
      );
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;
END KL_DATE_VERIFY;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Procedure/KL_DATE_VERIFY.sql =========*** 
PROMPT ===================================================================================== 
