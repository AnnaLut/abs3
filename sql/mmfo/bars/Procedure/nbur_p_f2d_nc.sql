

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F2D_NC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F2D_NC ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F2D_NC (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ #2D ��� ����� "C"
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 13.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_F2D (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F2D_NC.sql =========*** End
PROMPT ===================================================================================== 
