CREATE OR REPLACE function BARS.inv_f_days(p_dat01 date, p_acc number) RETURN integer is
-- Определение к-ва дней просрочки по счету (без учета параметров просрочки по договору для кредитов)

/* Версия 1.0  24-05-2017(1) 

   10-03-2017(1.0) - Попадала отч
   Расчет к-ва дней просрочки по счету
 */
 l_ost   NUMBER; l_KOL INTEGER;
 l_dat31 date;  -- последний рабочий день месяца

begin 
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   select - nvl(ost_korr(p_acc,l_dat31,null,'2'),0) into l_ost from dual;  -- остаток с корректирующими
   for k in (select * from saldoa where acc = p_acc order by fdat desc)
   LOOP 
      --logger.info('kol 1 : ACC = ' || P_ACC || ' L_OST = '|| L_OST || ' k.dos= ' || k.dos ) ;
      l_ost := l_ost - k.DOS;
      --logger.info('kol 2 : ACC = ' || P_ACC || ' L_OST = '|| L_OST || ' k.dos= ' || k.dos ) ;
      IF l_ost <= 0 THEN  
         l_KOL := greatest(0,p_DAT01 - k.fdat); 
         --logger.info('kol 3 : ACC = ' || P_ACC || ' P_DAT01 = '|| P_DAT01 || ' k.fdat= ' || k.fdat ) ;
         EXIT;  
      end if;
  
   end LOOP;
   return l_kol;
end;
/

 show err;

grant execute on inv_f_days to bars_access_defrole;
grant execute on inv_f_days to start1;

