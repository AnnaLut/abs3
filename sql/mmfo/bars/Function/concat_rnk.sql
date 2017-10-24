
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/concat_rnk.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CONCAT_RNK (rnkA varchar2, rnkB varchar2)
return varchar2
as
begin
  --least and greatest to replicate previous logic
  return TO_CHAR(least(rnkA, rnkB))||'/'||TO_CHAR(greatest(rnkA, rnkB));
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/concat_rnk.sql =========*** End ***
 PROMPT ===================================================================================== 
 