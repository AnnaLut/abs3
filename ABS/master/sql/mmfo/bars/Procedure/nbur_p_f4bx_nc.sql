
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_F4BX_NC.sql ======= *** Run ***
PROMPT ===================================================================================== 

 CREATE OR REPLACE PROCEDURE bars.nbur_p_f4bx_nc (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :  Процедура формирования 4BX
 COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :  v.18.001             09.10.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_F4BX (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
show errors;


PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_F4BX_NC.sql ======= *** End ***
PROMPT ===================================================================================== 

