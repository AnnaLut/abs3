PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FX2X_NC.sql =========*** Run *** =
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE NBUR_P_FX2X_nc(
                                            p_report_date    date
                                            , p_kod_filii    varchar2
                                            , p_form_id      number
                                          )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  ��������� ������������ X2X � ������� XML ��� ����� "C"
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 29/03/2019 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_FX2X (p_kod_filii, p_report_date, p_form_id, 'C');
end NBUR_P_FX2X_nc;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FX2X_NC.sql =========*** End *** =
PROMPT ===================================================================================== 