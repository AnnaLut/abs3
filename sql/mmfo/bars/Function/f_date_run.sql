
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_date_run.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DATE_RUN (p_date in date default gl.bd,
                                       p_last_day in number, -- 1=последний рабочий день
                                       p_day in varchar2 ) --конкретный день (или следующий рабочий за ним)
return number
----Внимание !!! Функция DAT_NEXT_U должна принимать дату без времени, иначе беда
is
l_to_do    number(1):=0;  --1-запускаем/0-ничего не делаем
l_day date;
begin
  if p_last_day = 1 then --признак последнего рабочего дня
      if to_number(to_char(p_date,'DD'))  > to_number(to_char(DAT_NEXT_U(p_date,1),'DD')) --банковская дата и следующая рабочая в разных месяцвх
         and trunc(p_date,'DD') = trunc(DAT_NEXT_U(p_date,0),'DD') --банковская дата - это рабочий день
      then l_to_do:= 1;
      else l_to_do:= 0;
      end if;
  else --конкретный день (или следующий рабочий за ним)
     l_day := to_date(p_day||'.'||to_char (p_date,'mm.yyyy'),'dd.mm.yyyy');
      if trunc(p_date,'DD') = trunc(DAT_NEXT_U(l_day,0),'DD') --банковская дата - это рабочий день
      then l_to_do:= 1;
      else l_to_do:= 0;
      end if;
  end if;
  return l_to_do;
end;
/
 show err;
 
PROMPT *** Create  grants  F_DATE_RUN ***
grant EXECUTE                                                                on F_DATE_RUN      to ABS_ADMIN;
grant EXECUTE                                                                on F_DATE_RUN      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_date_run.sql =========*** End ***
 PROMPT ===================================================================================== 
 