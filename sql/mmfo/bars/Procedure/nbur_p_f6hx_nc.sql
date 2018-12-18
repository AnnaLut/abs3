
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_F6HX_NC.sql ======= *** Run ***
PROMPT ===================================================================================== 

 CREATE OR REPLACE PROCEDURE bars.nbur_p_f6Hx_nc (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :  ��������� ������������ 6HX
 COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :  v.18.001             26.11.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: p_report_date - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_F6HX (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
show errors;


PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Procedure/NBUR_P_F6HX_NC.sql ======= *** End ***
PROMPT ===================================================================================== 

