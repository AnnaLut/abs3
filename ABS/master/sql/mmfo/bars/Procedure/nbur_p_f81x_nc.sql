
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_F81X_NC.sql ======= *** Run ***
PROMPT ===================================================================================== 

 CREATE OR REPLACE PROCEDURE bars.nbur_p_f81x_nc (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :  ��������� ������������ 81X
 COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :  v.19.001             29.03.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_F81X (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
show errors;


PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_F81X_NC.sql ======= *** End ***
PROMPT ===================================================================================== 

