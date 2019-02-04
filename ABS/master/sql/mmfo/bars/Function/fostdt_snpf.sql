
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========= Scripts /Sql/BARS/function/fostdt_snpf.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTDT_SNPF (p_acc integer,p_dat date)
      return  decimal is
      nn_     decimal;
begin
  begin
    select  ost-crdos+crkos
      into nn_
      from AGG_MONBALS
     where fdat=p_dat and acc=p_acc;
    exception when no_data_found then  nn_:=0;
  end;
  return nn_;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========= Scripts /Sql/BARS/function/fostdt_snpf.sql =========*** End ***
 PROMPT ===================================================================================== 
 