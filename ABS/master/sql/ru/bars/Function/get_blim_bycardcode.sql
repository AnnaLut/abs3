
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_blim_bycardcode.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_BLIM_BYCARDCODE (p_code in w4_card.code%type)
/*
 2016-05-26 LSO
 http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-4398
 функц≥€ заповнюЇ  Ђбажаним розм≥ром в≥дновлюваноњ кредитноњ л≥н≥њї в≥дпов≥дно до даних в таблиц≥

    ECONOMЕ                 ≈кономний           0
    STNDЕ                   —тандартний         0
    PENS_SOCЕ               ѕенс≥йний           1500
    PENS_ARSЕ               ѕенс≥йний "јрсенал" 1500
    SAL_STUDЕ               —тудентський        0
    SALЕ кр≥м (SAL_STUDЕ)   «арплатний          1500
    OBU_SALЕ     «арплатний —п≥вроб≥тники       1500
    PREMЕ                   ѕрем≥ум             0
    SOCЕ                    —оц≥альний          0

*/
return number
is
 l_lim  number := 0;
begin
 select
 case
  when p_code like 'ECONOM%'    then 0
  when p_code like 'STND%'      then 0
  when p_code like 'PENS_SOC%'  then 1500
  when p_code like 'PENS_ARS%'  then 1500
  when p_code like 'SAL_STUD%'  then 0
  when p_code like 'SAL_%' and p_code not like 'SAL_STUD%' then 1500
  when p_code like 'OBU_SAL%'   then 1500
  when p_code like 'PREM%'      then 0
  when p_code like 'SOC%'       then 0
  else 0
 end
 into l_lim
 from dual;


 return l_lim;
end;
/
 show err;
 
PROMPT *** Create  grants  GET_BLIM_BYCARDCODE ***
grant EXECUTE                                                                on GET_BLIM_BYCARDCODE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_blim_bycardcode.sql =========**
 PROMPT ===================================================================================== 
 