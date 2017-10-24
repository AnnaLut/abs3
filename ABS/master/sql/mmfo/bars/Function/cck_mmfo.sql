
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cck_mmfo.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CCK_MMFO RETURN varchar2 IS
  acc_  int; MFOb_ varchar2(12);  KVB_  int;  NLSB_ varchar2(15);
begin

  begin
    select mfob,nvl(kv2,kv),nlsb into MFOB_,KVB_,NLSB_
    from oper where ref=gl.aREF;

    if MFOB_ = gl.aMFO then
       select acc into acc_ from accounts
       where kv=KVB_ and nls = NLSB_ and dazs is null;
       RETURN  NLSB_;
    end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end;
  Return tobopack.GetTOBOParam('CORRACC');
end CCK_MMFO;
 
/
 show err;
 
PROMPT *** Create  grants  CCK_MMFO ***
grant EXECUTE                                                                on CCK_MMFO        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_MMFO        to RCC_DEAL;
grant EXECUTE                                                                on CCK_MMFO        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cck_mmfo.sql =========*** End *** =
 PROMPT ===================================================================================== 
 