PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F8BX_NC.sql =========*** Run *** =
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE NBUR_P_F8BX_nc(
                                            p_report_date    date
                                            , p_kod_filii    varchar2
                                            , p_form_id      number
                                          )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  Процедура формирования 8BX в формате XML для схема "C"
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :  10.12.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_F8BX (p_kod_filii, p_report_date, p_form_id, 'C');
end NBUR_P_F8BX_nc;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F8BX_NC.sql =========*** End *** =
PROMPT ===================================================================================== 