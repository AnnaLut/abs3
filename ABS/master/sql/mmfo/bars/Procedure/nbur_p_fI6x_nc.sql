PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FI6X_NC.sql =========*** Run *** =
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE NBUR_P_FI6X_nc(
                                            p_report_date    date
                                            , p_kod_filii    varchar2
                                            , p_form_id      number
                                          )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  ��������� ������������ I6X � ������� XML ��� ����� "C"
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :  31.10.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_FI6X (p_kod_filii, p_report_date, p_form_id, 'C');
end NBUR_P_FI6X_nc;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FI6X_NC.sql =========*** End *** =
PROMPT ===================================================================================== 