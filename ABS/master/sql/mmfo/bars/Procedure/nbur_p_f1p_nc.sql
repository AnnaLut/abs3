

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F1P_NC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F1P_NC ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F1P_NC (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования @1P для схема "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    05.D4.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    ln_cnt1  number := 0;
    ln_cnt2  number := 0;
begin
    select count(*)
    into ln_cnt1
    from V_NBUR_#1P_EDIT
    where datf = p_report_date and
        fl_mod = 1;

    select count(*)
    into ln_cnt2
    from TMP_NBU_HIST
    where kodf='1P' and
          datf = p_report_date;           
    
    if ln_cnt1 = 0 and ln_cnt2 = 0 then
       p_f1P_NN (p_report_date);
    end if;
    
    p_nbu_save_rezult(p_report_date, p_kod_filii, '#1P'); 
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F1P_NC.sql =========*** End
PROMPT ===================================================================================== 
