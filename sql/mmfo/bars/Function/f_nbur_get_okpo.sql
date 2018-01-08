
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_get_okpo.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_GET_OKPO (p_ref in number) return varchar2
 -------------------------------------------------------------------
 -- функція визначення код okpo
 -------------------------------------------------------------------
 -- ВЕРСИЯ: 08/06/2017
 -------------------------------------------------------------------
 -- параметри:
 --    p_ref - референс документу
 --    p_type = 1- код платника
 --           = 2- код отримувача
 ----------------------------------------------------------------
is
    l_kod_okpo  varchar2(20);
    l_nls  varchar2(20);
    l_swift_k   varchar2 (200);
    l_pos       number;
begin
    select trim(value) 
    into l_swift_k
    from operw 
    where ref = p_ref and 
         tag like 'C%' and
         value like 'F59:/%' and
         rownum = 1;
         
   l_nls := substr(l_swift_k,instr(l_swift_k, '2625'), 15);
   
   select max(c.okpo)
   into l_kod_okpo
   from accounts a, customer c
   where a.nls = l_nls and
         a.rnk = c.rnk;

   return trim(l_kod_okpo);
exception
    when others then 
        return null;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_get_okpo.sql =========*** En
 PROMPT ===================================================================================== 
 