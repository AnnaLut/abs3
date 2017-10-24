

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F3C_NC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F3C_NC ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F3C_NC (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ @3C ��� ����� "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   30.11.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
    p_f3C_NN (p_report_date);
    
    p_nbu_save_rezult(p_report_date, p_kod_filii, '#3C'); 
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F3C_NC.sql =========*** End
PROMPT ===================================================================================== 
