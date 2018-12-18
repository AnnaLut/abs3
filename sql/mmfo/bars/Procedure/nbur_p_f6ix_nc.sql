
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_F6IX_NC.sql ======= *** Run ***
PROMPT ===================================================================================== 

 CREATE OR REPLACE PROCEDURE bars.nbur_p_f6Ix_nc (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :  Процедура формирования 6IX
 COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :  v.18.001             27.11.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_F6IX (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
show errors;


PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_F6IX_NC.sql ======= *** End ***
PROMPT ===================================================================================== 

