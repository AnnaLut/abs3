
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/arcrrp_branch.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ARCRRP_BRANCH (REF_ NUMBER, MFO_ VARCHAR2) return number is
 fl_ int := 0 ;
begin

  begin
    select 1
    into fl_
    from dual
    where  EXISTS (SELECT 1
                   FROM OPER
                   WHERE  (   BRANCH LIKE '/______/'
                           OR BRANCH LIKE '/______/000000/%' )
                     AND   REF =REF_ and MFOA=MFO_ AND TT <>'KL2');
  exception when NO_DATA_FOUND then null;
  end;

  RETURN FL_;

end arcrrp_branch;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/arcrrp_branch.sql =========*** End 
 PROMPT ===================================================================================== 
 