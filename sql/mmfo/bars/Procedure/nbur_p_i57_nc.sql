

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I57_NC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_I57_NC ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_I57_NC (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ @57 ��� ����� "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    25.02.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_I57 (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I57_NC.sql =========*** End
PROMPT ===================================================================================== 
