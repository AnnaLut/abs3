PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF1X_NC.sql =======*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_FF1X_NC ***

create or replace procedure nbur_p_ff1x_nc(
                                            p_report_date  date
                                            , p_kod_filii  varchar2
                                            , p_form_id    number
                                          )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования #73X для схема "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   30/07/2018 (30.03.2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
  NBUR_P_FF1X (p_kod_filii, p_report_date, p_form_id, 'C');
end nbur_p_ff1X_nc;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF1X_NC.sql =======*** End ***
PROMPT ===================================================================================== 