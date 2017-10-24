

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NBU23_ARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NBU23_ARC ***

  CREATE OR REPLACE PROCEDURE BARS.P_NBU23_ARC (p_dat01 date) IS

/* Версия 1.0 31-01-2017
   Архив расчета по 23 постанове
   -------------------------------------

*/

z_dat01  date;
s_dat01  varchar2(10);

begin

z_dat01 := p_dat01;   s_dat01 := to_char(z_dat01, 'dd.mm.yyyy')  ;  pul_dat(s_dat01,'') ;

   begin
logger.info('PAY23 0 : z_dat01 = ' || z_dat01 || ' s_dat01 ='  ||s_dat01 || ' p_dat01 =' ||p_dat01 ) ;
      execute immediate 'truncate table NBU23_REZ_ARC';
      insert into NBU23_REZ_ARC select * from nbu23_rez  where fdat =  TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy');
      commit;
   end ;

END;
/
show err;

PROMPT *** Create  grants  P_NBU23_ARC ***
grant EXECUTE                                                                on P_NBU23_ARC     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_NBU23_ARC     to RCC_DEAL;
grant EXECUTE                                                                on P_NBU23_ARC     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NBU23_ARC.sql =========*** End *
PROMPT ===================================================================================== 
