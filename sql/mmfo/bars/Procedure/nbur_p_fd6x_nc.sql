CREATE OR REPLACE PROCEDURE NBUR_P_FD6X_NC (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  ��������� ������������ #D6X ��� ����� "C"
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 31.08.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_FD6X (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
