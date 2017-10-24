
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s270_n.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S270_N (dat_ in date, s270_ in varchar2, acc_ in number, nd_  varchar2) return varchar2
is
v_nd_ number := nd_;

begin
  return f_get_s270(dat_ , s270_, acc_ , v_nd_ );
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s270_n.sql =========*** End *
 PROMPT ===================================================================================== 
 