
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostq_new.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTQ_NEW (p_acc integer, p_dat date, p_id integer) return  decimal
is
  nn_     decimal;
begin
  if p_id is not null then
     nn_ := fostq_snp_day(p_acc, p_id);
  else
     nn_ := fostq(p_acc, p_dat);
  end if;

  return nn_;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostq_new.sql =========*** End *** 
 PROMPT ===================================================================================== 
 