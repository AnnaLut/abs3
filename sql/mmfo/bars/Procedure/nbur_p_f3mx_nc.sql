CREATE OR REPLACE PROCEDURE bars.nbur_p_f3mx_nc (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :  Процедура формирования 3MX     для схема "C"
 COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :  v.18.001               29.09.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
               p_kod_filii   - МФО банка, для которого строится отчет
               p_form_id     - идентификатор отчета (nbur_ref_files.ID)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin
   NBUR_P_F3MX (p_kod_filii, p_report_date, p_form_id, 'C');
end;
/
Show errors;
