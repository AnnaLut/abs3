
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bm_pdv.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BM_PDV (NLS_ varchar2, mode_ int)
  RETURN number IS
/*
 новая SQL-функция для формулы счета (оп.TMP)
 и формулы суммы (оп.T2P)

  Mode_ =0 возвращает счет
  Mode_ =1 возвращает сумму ПДВ
*/

 nTmp_ int; S_ number := 0;
BEGIN

 begin

   select 1 into nTmp_    from operw
   where ref=gl.aRef and tag='PDV' and value ='1';

   If Mode_ =0 then
      s_:= to_number( nbs_ob22 ('3801','09') );
   else

      select s2 into S_ from oper where ref=gl.aRef;

      If Mode_ =1 then  S_:=      Round(S_/6,0) ;
      else              S_:= S_ - Round(S_/6,0) ;
      end if;

   end if;

 EXCEPTION WHEN NO_DATA_FOUND THEN s_:= to_number(NLS_);
 END;

 Return S_;

end;
/
 show err;
 
PROMPT *** Create  grants  BM_PDV ***
grant EXECUTE                                                                on BM_PDV          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bm_pdv.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 