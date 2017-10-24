
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/va_989.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VA_989 (P_OB22_ char, rnk_ int )
RETURN varchar2 IS

/*
  24-01-2011 Sta перевод ОБ22 в accounts
*/

  NBS1_ accounts.NBS%TYPE := substr(P_OB22_,1,4);
  NBS2_ accounts.NBS%TYPE ;
  OB22_ accounts.OB22%TYPE  ;
  NLS2_ accounts.NLS%TYPE := null;

begin

 begin
   select ob22_989 into ob22_ from VALUABLES  where OB22 = P_OB22_;
   If    NBS1_ = '9820' then NBS2_:='9890';
   elsIf NBS1_ = '9821' then NBS2_:='9892';
   Else                      NBS2_:='9898';
   end if;

   select a.nls  into NLS2_
   from  accounts a
   where a.kv  = gl.baseval   and a.nbs = NBS2_  and a.rnk  = RNK_
     and a.dazs is null       and a.ob22=OB22_   and rownum = 1;

  EXCEPTION  WHEN NO_DATA_FOUND THEN null;
  end;

  return NLS2_;

end VA_989;
/
 show err;
 
PROMPT *** Create  grants  VA_989 ***
grant EXECUTE                                                                on VA_989          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VA_989          to PYOD001;
grant EXECUTE                                                                on VA_989          to WR_ALL_RIGHTS;
grant EXECUTE                                                                on VA_989          to WR_DOC_INPUT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/va_989.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 