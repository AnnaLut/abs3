
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_lim_bycardcode.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_LIM_BYCARDCODE (p_code in w4_card.code%type)
/*
 2017-05-30 Skal
 SC-0036102
 По 2. пункту заявки "При пакетному друці поле (Максимальний (бажаний) розмір Кредиту) повинно заповнюватись відповідно до таблиці: №п/п    Тарифний пакет    максимальний розмір кредиту "

 1) Описание тарифных пакетов ведется в ПЦ, в БАРСе тарифные пакеты не администрируются.
 2) Связки "Группа продуктов БПК" с перечнем указанных тарифных пакетов - однозначно определить нельзя

    ECONOM…                 Економний           5000
    STND…                   Стандартний         5000
    PENS_SOC…               Пенсійний           15000
    PENS_ARS…               Пенсійний "Арсенал" 30000
    SAL_STUD…               Студентський        5000
    SAL… крім (SAL_STUD…)   Зарплатний          100000
    BUDG_LOYAL_             Бюджетний           100000
    OBU_SAL…     Зарплатний Співробітники       60000
    PREM…                   Преміум             120000
    SOC…                    Соціальний          5000

*/
return number
is
 l_lim  number := 0;
begin
 select
 case
  when p_code like 'ECONOM%'    then 50000
  when p_code like 'STND%'      then 50000
  when p_code like 'PENS_SOC%'  then 15000
  when p_code like 'PENS_ARS%'  then 30000
  when p_code like 'SAL_STUD%'  then 50000
  when p_code like 'SAL_%' and p_code not like 'SAL_STUD%' then 100000
  when p_code like 'BUDG_LOYAL%' then 100000
  when p_code like 'OBU_SAL%'   then 250000
  when p_code like 'SAL_NBU%'   then 250000
  when p_code like 'PREM%'      then 120000
  when p_code like 'SOC%'       then 50000
  else 0
 end
 into l_lim
 from dual;


 return l_lim;
end;
/
 show err;
 
PROMPT *** Create  grants  GET_LIM_BYCARDCODE ***
grant EXECUTE                                                                on GET_LIM_BYCARDCODE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_lim_bycardcode.sql =========***
 PROMPT ===================================================================================== 
 