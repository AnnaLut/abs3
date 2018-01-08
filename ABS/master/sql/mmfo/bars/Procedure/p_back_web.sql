

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BACK_WEB.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BACK_WEB ***

  CREATE OR REPLACE PROCEDURE BARS.P_BACK_WEB (p_ref oper.ref%type, p_reason bp_reason.id%type, res_code out number, res_text out varchar2)
is
  l_n number;
  l_v varchar2(4000);
  l_sos oper.sos%type;
begin
    begin
      select sos into l_sos from oper
             where ref=p_ref
               and branch like sys_context('bars_context','user_branch_mask');
      exception when no_data_found then
         res_text:='Документ не знайдено!';
         res_code:=1;
         return;
      end;

      if l_sos<0 then
         res_text:='Документ вже було сторновано!'; res_code:=1; return;
         end if;

   begin
      p_back_dok(Ref_ => p_ref, Lev_ => 5, ReasonId_ => p_reason, Par2_ => l_n, Par3_ => l_v, FullBack_ =>0);

	  chk.put_visa(REF_    => p_ref,
				   TT_     => 'BAK',
				   GRP_    => 6,
				   STATUS_ => 3,
				   KEYID_  => null,
				   SIGN1_  => null,
				   SIGN2_  => null);


      exception when others then
        res_text:=case when substr(SQLERRM,1,3)='ORA' then ltrim(substr(SQLERRM,11)) else SQLERRM end;
        res_code:=1;
        return;
    end;

    res_text:='Документ сторновано!';
    res_code:=0;

  end p_back_web;
/
show err;

PROMPT *** Create  grants  P_BACK_WEB ***
grant EXECUTE                                                                on P_BACK_WEB      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BACK_WEB.sql =========*** End **
PROMPT ===================================================================================== 
