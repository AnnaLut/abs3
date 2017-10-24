
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sn.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SN (txt_ varchar2)  return number is
  n_ number;
begin
 begin
   select to_number(trim(txt_),'999G999G999G999G999G999D99',
                         'NLS_NUMERIC_CHARACTERS='', ''')
   into n_
   from dual;
 exception  when others then n_:=0;
 end;
 return Nvl(n_,0);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sn.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 