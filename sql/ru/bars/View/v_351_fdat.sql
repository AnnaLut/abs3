/*
   05-01-2018
   ¬ьюшка дл€ просмотра кредитного ризику (351) на дату
*/
CREATE OR REPLACE FORCE VIEW BARS.V_351_fdat as
select * from REZ_CR 
where fdat =  NVL (TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'),'dd-mm-yyyy'),trunc(gl.BD,'MM'));
/
show errors VIEW V_351_fdat;
Prompt Privs on VIEW V_351_fdat TO BARS_ACCESS_DEFROLE 
GRANT SELECT ON V_351_fdat TO BARS_ACCESS_DEFROLE
/
Prompt Privs on VIEW V_351_fdat TO START1 
GRANT SELECT ON V_351_fdat TO START1
/


