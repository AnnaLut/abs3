
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/FINMON/function/get_branch_id.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION FINMON.GET_BRANCH_ID 
   RETURN bank.id%TYPE
IS
   l_branch_id   bank.id%TYPE;
BEGIN
   SELECT   id
     INTO   l_branch_id
     FROM   bank
    WHERE   ust_mfo = (SELECT   val
                         FROM   params
                        WHERE   par = 'MFO');

   RETURN l_branch_id;
END get_branch_id;
/
 show err;
 
PROMPT *** Create  grants  GET_BRANCH_ID ***
grant EXECUTE                                                                on GET_BRANCH_ID   to BARS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/FINMON/function/get_branch_id.sql =========*** En
 PROMPT ===================================================================================== 
 