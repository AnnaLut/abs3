

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_BLOCK_351.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_BLOCK_351 ***

  CREATE OR REPLACE PROCEDURE BARS.P_BLOCK_351 (p_dat01 date) IS

/* Версия 1.0 20-01-2017
   Блокування розрахунку кредитного ризику
   -------------------------------------

*/

l_dat  date;  dat31_  date;

fl_    number;

begin

   l_dat := to_date('01-02-2017','dd-mm-yyyy');

   IF p_DAT01 IS NULL THEN
      raise_application_error(-20000,'Укажiть звiтну дату !');
      z23.to_log_rez (user_id , 99 , p_dat01 ,'Немає звiтної дати ');
   END IF;

   if p_DAT01 < l_dat THEN
      raise_application_error(-20000,'Розрахунок за '|| to_char(p_dat01,'dd.mm.yyyy') || ' - неможливий!');
      z23.to_log_rez (user_id , 99 , p_dat01 ,'Розрахунок за '|| to_char(p_dat01,'dd.mm.yyyy') || ' - неможливий!');
   end if;
/*
   if p_dat01 <= sysdate and sys_context('bars_context','user_mfo') not in ('300465','324805') THEN
      raise_application_error(-20000,'Розрахунок кредитного ризику заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
      z23.to_log_rez (user_id , 99 , p_dat01 ,'Розрахунок кредитного ризику заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
   end if;
*/
   dat31_ := Dat_last_work ( p_dat01 - 1 ) ;
   begin
      select 1 into fl_ from rez_protocol where dat = dat31_ and crc = '1' and rownum=1;
      raise_application_error(-20000,'Модифiкацiя NBU23_REZ - неможлива!
                               Виконанi проводки по резерву за '|| to_char(DAT31_,'dd.mm.yyyy')
                              );
      z23.to_log_rez (user_id , 99 , p_dat01 ,'Модифiкацiя NBU23_REZ - неможлива!
                               Виконанi проводки по резерву за '|| to_char(DAT31_,'dd.mm.yyyy'));
   EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
   --   --select BARSUPL.CHECK_UPLOADED_T0(p_dat01) into FV_ from dual;
   --   FV_ := 0;
   --   if FV_ = 1 THEN
   --      raise_application_error(-20000,'Модифiкацiя NBU23_REZ - неможлива!
   --                              Виконана загрузка данних в FINEVARE за '|| to_char(p_DAT01,'dd.mm.yyyy'));
   --   end if;
   END;

end;
/
show err;

PROMPT *** Create  grants  P_BLOCK_351 ***
grant EXECUTE                                                                on P_BLOCK_351     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_BLOCK_351     to RCC_DEAL;
grant EXECUTE                                                                on P_BLOCK_351     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_BLOCK_351.sql =========*** End *
PROMPT ===================================================================================== 
