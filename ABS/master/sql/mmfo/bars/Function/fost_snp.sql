
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fost_snp.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOST_SNP (p_acc integer,p_id_1 integer)
      return  decimal is
      nn_     decimal;
begin
  begin
    select  ost+dos-kos-cudos+cukos
      into nn_
      from ACCM_AGG_MONBALS
     where caldt_id=p_id_1 and acc=p_acc;
    exception when no_data_found then  nn_:=0;
  end;
  return nn_;
end fost_snp;
 
/
 show err;
 
PROMPT *** Create  grants  FOST_SNP ***
grant EXECUTE                                                                on FOST_SNP        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOST_SNP        to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fost_snp.sql =========*** End *** =
 PROMPT ===================================================================================== 
 