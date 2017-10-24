
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_klf2.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_KLF2 return number
is
  l_d_rec  oper.d_rec%type;
  l_s      oper.s%type;
begin
  select s,
         d_rec
  into   l_s,
         l_d_rec
  from   oper
  where  ref=gl.aref;
  if l_d_rec like '%#D%' then
    return l_s;
  else
    return 0;
  end if;
end f_klf2;
/
 show err;
 
PROMPT *** Create  grants  F_KLF2 ***
grant EXECUTE                                                                on F_KLF2          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_klf2.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 