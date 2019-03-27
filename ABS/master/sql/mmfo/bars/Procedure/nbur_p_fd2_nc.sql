

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FD2_NC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FD2_NC ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FD2_NC (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ @D2 ��� ����� "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 14.D2.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
    p_fD2_NN (p_report_date);
    
    p_nbu_save_rezult(p_report_date, p_kod_filii, '#D2'); 
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FD2_NC.sql =========*** End
PROMPT ===================================================================================== 