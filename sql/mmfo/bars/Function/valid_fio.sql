
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/valid_fio.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VALID_FIO (par varchar2) return boolean
is
  i  int;
begin
  for i in 1..length(trim(par))
  loop
    if not (substr(trim(par),i,1)=''''                                  or
            substr(trim(par),i,1)='-'                                   or
            substr(trim(par),i,1)=' '                                   or
            substr(trim(par),i,1)='²' or substr(trim(par),i,1)='³'      or
            substr(trim(par),i,1)='ª' or substr(trim(par),i,1)='º'      or
            substr(trim(par),i,1)='¯' or substr(trim(par),i,1)='¿'      or
            substr(trim(par),i,1)='¥' or substr(trim(par),i,1)='´'      or
            substr(trim(par),i,1)='¨' or substr(trim(par),i,1)='¸'      or
            (substr(trim(par),i,1)>='A' and substr(trim(par),i,1)<='Z') or
            (substr(trim(par),i,1)>='a' and substr(trim(par),i,1)<='z') or
            (substr(trim(par),i,1)>='à' and substr(trim(par),i,1)<='ÿ') or
            (substr(trim(par),i,1)>='À' and substr(trim(par),i,1)<='ß')) then
      return false;
    end if;
  end loop;
  return true;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/valid_fio.sql =========*** End *** 
 PROMPT ===================================================================================== 
 