
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_amorep.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_AMOREP (p_par varchar2) RETURN number IS
  s_  char(1);
  i_  number;
BEGIN
  if length(p_par)<2 then
    return length(p_par);
  end if;
  s_ := substr(p_par,1,1);
  i_ := 1;
  while i_<=length(p_par)-1
  loop
    if substr(p_par,i_+1,1)<>s_ then
      return i_;
    end if;
    i_ := i_+1;
  end loop;
  return i_;
END f_amorep;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_amorep.sql =========*** End *** =
 PROMPT ===================================================================================== 
 