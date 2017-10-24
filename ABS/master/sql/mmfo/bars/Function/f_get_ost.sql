
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_ost.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_OST (p_acc number, p_di number, p_zo number, p_mod number,  p_nbs char default null)
----
/* ‘ункци€, возвращающа€ остаток по счету на дату
   p_di - это может быть число-дата из снапов либо дата в формате DDMMYYYY
   p_zo -  ежемес/ежедн (1/0)
   p_mod - номинал/экв  (7/8) */
----
return number
is
   l_rezult    number;
   l_tmp       number;
   l_kv        number := null;
   l_title     varchar2(20) := 'CCK F_GET_OST:'; -- дл€ трассировки
begin
   bars_audit.trace('%s 0. p_acc=%s, p_di=%s, p_zo=%s, p_mod=%s',l_title, to_char(p_acc),to_char(p_di),to_char(p_zo),to_char(p_mod));
   if length(p_di)=8 then
      -- значит просто дата
         -- если задаем дату формировани€ наперед от банковской - вернем текущий на банковскую дату остаток
         if trunc(to_date(p_di,'DD/MM/YYYY'), 'MM') > trunc(gl.bdate, 'MM') then
            select ostc, kv into l_rezult, l_kv  from accounts where acc = p_acc;
         else
            l_rezult := rez1.ostc96(p_acc,to_date(p_di,'DD/MM/YYYY'));
            bars_audit.trace('%s 1.1 l_rezult=%s',l_title, to_char(l_rezult));
         end if;
         if p_mod = 8 then
            if l_kv is null then
              select kv into l_kv from accounts where acc = p_acc;
            end if;
            select gl.p_icurval(l_kv, l_rezult, to_date(p_di,'DD/MM/YYYY')) into l_rezult from dual;
            bars_audit.trace('%s 1.2 l_rezult=%s',l_title, to_char(l_rezult));
         end if;

   else
      -- значит это снапы
         -- проверим - должны быть заданы p_zo и p_mod
         --begin
         --   select 1 into l_tmp from dual where p_zo is not null and p_mod is not null;
         --exception when no_data_found then
         --                  RAISE_APPLICATION_ERROR (-20000,'Ќеверно заданы параметры вызова функции! ƒл€ заданной даты снапов '||to_char(p_di)||' задайте параметры "ежемс/ежедн" и "вал/экв"!' );
         --end;

      if nvl(p_nbs, 0) not like '8%'
         then
            execute immediate 'select snp.fost(:p_acc, :p_di, :p_zo, :p_mod) from dual' into l_rezult using p_acc, p_di, p_zo, p_mod;
            bars_audit.trace('%s 2.1 l_rezult=%s',l_title, to_char(l_rezult));
      else
         if p_mod = 8 then
            if l_kv is null then
              select kv into l_kv from accounts where acc = p_acc;
            end if;
            select gl.p_icurval(l_kv, rez1.ostc96(p_acc,to_date(p_di,'DD/MM/YYYY')), to_date(p_di,'DD/MM/YYYY')) into l_rezult from dual;
            bars_audit.trace('%s 2.2.1 l_rezult=%s',l_title, to_char(l_rezult));
         else
            l_rezult := rez1.ostc96(p_acc,to_date(p_di,'DD/MM/YYYY'));
            bars_audit.trace('%s 2.2.2 l_rezult=%s',l_title, to_char(l_rezult));
         end if;

      end if;
   end if;

  return l_rezult;

end f_get_ost;
/
 show err;
 
PROMPT *** Create  grants  F_GET_OST ***
grant EXECUTE                                                                on F_GET_OST       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_OST       to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_ost.sql =========*** End *** 
 PROMPT ===================================================================================== 
 