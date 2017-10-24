

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F26_NC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F26_NC ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F26_NC (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   ��������� ������������ #01 ��� ����� "D"
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   07/03/2017 (12.08.2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
 --  nbur_p_F26 (p_kod_filii, p_report_date, p_form_id, 'D');
    p_f26 (p_report_date);

    p_nbu_save_rezult(p_report_date, p_kod_filii, '#26');

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F26_NC.sql =========*** End
PROMPT ===================================================================================== 
