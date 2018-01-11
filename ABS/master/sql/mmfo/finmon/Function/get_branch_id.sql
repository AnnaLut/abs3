
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/FINMON/function/get_branch_id.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION FINMON.GET_BRANCH_ID 
   RETURN bank.id%TYPE
IS
   l_branch_id   bank.id%TYPE;
BEGIN
    if finmon.fm_policies.get_mfo is null then
        SELECT   id
        INTO   l_branch_id
        FROM   bank
        WHERE   ust_mfo = (SELECT   val
                                       FROM   params
                                       WHERE   par = 'MFO' and kf=fm_policies.get_mfo/*and kf='324805'*/
                                       );
    else
        SELECT   id
        INTO   l_branch_id
        FROM   bank
        WHERE   ust_mfo = finmon.fm_policies.get_mfo;
    end if;
   RETURN l_branch_id;
END get_branch_id;
/
 show err;
 
PROMPT *** Create  grants  GET_BRANCH_ID ***
grant EXECUTE                                                                on GET_BRANCH_ID   to BARS;
grant EXECUTE                                                                on GET_BRANCH_ID   to BARSREADER_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/FINMON/function/get_branch_id.sql =========*** En
 PROMPT ===================================================================================== 
 