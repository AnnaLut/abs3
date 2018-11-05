
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_FF8X_NC.sql ======= *** Run ***
PROMPT ===================================================================================== 

 CREATE OR REPLACE PROCEDURE bars.nbur_p_ff8x_nc (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :  Процедура формирования F8X
 COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :  v.18.001             30.10.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_FF8X (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
show errors;


PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_FF8X_NC.sql ======= *** End ***
PROMPT ===================================================================================== 

