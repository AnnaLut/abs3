
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fost_snp_day.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOST_SNP_DAY (p_acc integer,p_id_1 integer)
      return  decimal is
      nn_     decimal;
begin
  begin
    select  ost
      into nn_
      from ACCM_SNAP_BALANCES
     where caldt_id=p_id_1 and acc=p_acc;
    exception when no_data_found then  nn_:=0;
  end;
  return nn_;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fost_snp_day.sql =========*** End *
 PROMPT ===================================================================================== 
 