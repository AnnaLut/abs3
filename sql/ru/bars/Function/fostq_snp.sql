
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostq_snp.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTQ_SNP (p_acc integer,p_id_1 integer)
      return  decimal is
      nn_     decimal;
begin
  begin
    select  ostq+dosq-kosq-cudosq+cukosq
      into nn_
      from ACCM_AGG_MONBALS
     where caldt_id=p_id_1 and acc=p_acc;
    exception when no_data_found then  nn_:=0;
  end;
  return nn_;
end fostq_snp;
/
 show err;
 
PROMPT *** Create  grants  FOSTQ_SNP ***
grant EXECUTE                                                                on FOSTQ_SNP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTQ_SNP       to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostq_snp.sql =========*** End *** 
 PROMPT ===================================================================================== 
 