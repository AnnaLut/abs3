
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostiq_snp.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTIQ_SNP (p_acc integer,p_id_1 integer)
      return  decimal is
      nn_     decimal;
begin
  begin
    select  ostq-crdosq+crkosq
      into nn_
      from ACCM_AGG_MONBALS
     where caldt_id=p_id_1 and acc=p_acc;
    exception when no_data_found then  nn_:=0;
  end;
  return nn_;
end fostiq_snp;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostiq_snp.sql =========*** End ***
 PROMPT ===================================================================================== 
 