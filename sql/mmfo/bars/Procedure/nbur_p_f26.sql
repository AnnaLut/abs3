

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F26.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F26 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F26 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#26')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #20 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002  12.01.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002  12.01.2017';
/*
   Періодичність: A013 = 4 Декадна.
   
   Розріз консолідації: A014 = 3 Зведений за банк
    
   Формат коду показника > DD MMM HHHHHHHHHH BBBB VVV P

   DD    -    може приймати значення: 
    10 - дебетовий залишок в національній валюті (гривневий еквівалент)
    11 - дебетовий залишок в іноземній валюті
    20 - кредитовий залишок в національній валюті (гривневий еквівалент)
    21 - кредитовий залишок в іноземній валюті
    98 - назва банку
    99 - рейтинг банку
    97 - належність до інвестиційного класу   

   MMM           -    код країни банку (контрагента);
   HHHHHHHHHH    -    може приймати значення: 
   BBBB          -    балансовий рахунок;
   VVV           -    код валюти;
   P             -    приймає значення 0,1,2 в залежності від показника 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
    logger.info ('NBUR_P_F26 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
 
    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
                   
    BEGIN
       INSERT INTO nbur_detail_protocols (report_date,
                                          kf,
                                          report_code,
                                          nbuc,
                                          field_code,
                                          field_value,
                                          description,
                                          acc_id,
                                          acc_num,
                                          kv,
                                          maturity_date,
                                          cust_id,
                                          REF,
                                          nd,
                                          branch)
        SELECT p_report_date,
             p_kod_filii,
             p_file_code,
             (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
             field_code,
             field_value,
             ' ' escription,
             acc_id,
             acc_num,
             kv,
             maturity_date,
             cust_id,
             NULL,
             NULL,
             branch
        from (select cust_id,
                   acc_id,
                   kf,
                   acc_num,
                   kv,
                   maturity_date,
                   branch,
                   nbuc, 
                   substr(colname, 2, 2) ||
                   k040 || kb || 
                   (case when substr(colname, 2, 2) in ('97', '98', '99') 
                        then '00000000' 
                        else nbs || r030 || r013
                   end) field_code,
                   value field_value,
                   colname          
             from (select a.*,
                    b.mfo, 
                    (case when b.mfo = 324485 then 81
                          when b.mfo = 325569 then 93
                          else NVL(r.glb,0)
                    end) glb, 
                    b.alt_bic, 
                    NVL(trim(b.rating),' ') rating,
                    (case when k030 = '2' 
                      THEN
                         (case when trim(b.alt_bic) IS NULL 
                             THEN '0000000000' 
                             ELSE lpad(nvl(trim(b.alt_bic), '0'),10,'0') 
                         end)
                      ELSE
                         (case when trim(b.mfo) IS NULL 
                             THEN '0000000000' 
                             ELSE lpad(nvl(trim(r.glb),'0'),10,'0') 
                         end)
                    end) kb,
                    to_char(abs(DECODE (SIGN (a.ostq), 1, 0, -a.ostq))) P10,
                    to_char(abs(DECODE (SIGN (a.ostq), 1, a.ostq, 0))) P20,
                    to_char(abs(DECODE (SIGN (a.ost), 1, 0, -a.ost))) P11,
                    to_char(abs(DECODE (SIGN (a.ost), 1, a.ost, 0))) P21,
                    (case
                        when substr(trim(b.rating),1,1) in ('A', 'T', 'F') or 
                             trim(b.rating) in ('BBB','BBB+','BBB-','Baa1','Baa2','Baa3')
                        then '1'
                        else '2'
                    end) P97,
                    nvl(nvl(trim(c.name), trim(R.NB)), nmk) P98,
                    NVL(trim(b.rating),' ') P99
                from (
                    SELECT b.cust_id,
                         b.acc_id,
                         a.kf,
                         a.acc_num,
                         a.kv,
                         a.nbs,
                         a.maturity_date,
                         c.k030, 
                         substr(C.CUST_NAME, 1, 60) nmk,
                         c.k040,
                         (case 
                            when a.nbs not in ('1500','1518','1528','1525','1526',
                                               '3540','3640','9100') or
                                 a.nbs = '1500' and b.ost > 0
                            then '0' 
                            when a.nbs = '1500' and b.ost < 0
                            then '1'
                            when a.nbs in ('1518','1528') and a.r013 in ('5','7') 
                            then '1'
                            when a.nbs in ('1518','1528') and a.r013 in ('6','8') 
                            then '2'
                            when a.nbs in ('3540','3640') and a.r013 in ('4','5','6') 
                            then '9'
                            else a.r013 
                         end) r013, 
                         a.r030,
                         b.ost,
                         b.ostq,
                         a.branch,
                         a.nbuc
                    FROM nbur_tmp_kod_r020 k,
                         nbur_dm_accounts a,
                         nbur_dm_customers c,
                         nbur_dm_balances_daily b
                    WHERE     a.nbs = k.r020
                         AND a.report_date = p_report_date
                         AND a.kf = p_kod_filii
                         AND b.acc_id = a.acc_id
                         AND b.report_date = p_report_date
                         AND b.kf = p_kod_filii
                         AND a.cust_id = c.cust_id
                         AND c.report_date = p_report_date
                         AND c.kf = p_kod_filii
                         and b.ostq <> 0) a
                join custbank b
                on (a.cust_id = b.rnk)            
                left outer join rcukru r 
                on (b.mfo = r.mfo) 
                left outer join rc_bnk c 
                on (trim(b.alt_bic) = c.b010) 
                where (a.nbs not in ('1525','1526','3540','3640') or 
                      (a.nbs in ('1525','1526') and a.r013 in ('1','2','3','4','5','6','7')) or 
                      (a.nbs in ('3540','3640') and a.r013 in ('4','5','6', '9')))) 
            UNPIVOT (VALUE FOR colname IN  (P10, P20, P11, P21, P97, P98, P99))) d
            where (d.kv != '980' or 
                   d.colname like 'P_0' or 
                   d.colname in ('P97', 'P98')) and nvl(d.field_value, '0') != '0' or
                   d.colname = 'P99' ;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F26 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    -- формирование показателей файла  в  nbur_agg_protocols
    INSERT INTO nbur_agg_protocols (report_date,
                                    kf,
                                    report_code,
                                    nbuc,
                                    field_code,
                                    field_value)
    select report_date,
           kf,
           report_code,
           nbuc,
           field_code, 
           (case when to_number(substr(field_code, 1,2)) < 97 then to_char(val1) else val2 end) field_value
    from (SELECT report_date,
                kf,
                report_code,
                nbuc,
                field_code, 
                field_value,
                count(*) over (partition by field_code order by field_code, acc_id) cnt,
                DENSE_RANK() over (partition by field_code order by field_code, acc_id) rown,
                sum((case when to_number(substr(field_code, 1,2)) < 97 then to_number(field_value) else 0 end)) 
                     over (partition by field_code, cust_id) val1,
                max(field_value) over (partition by field_code, cust_id) val2
            FROM nbur_detail_protocols
            WHERE     report_date = p_report_date
                AND report_code = p_file_code
                AND kf = p_kod_filii)
    where rown = 1;

    logger.info ('NBUR_P_F26 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_F26;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F26.sql =========*** End **
PROMPT ===================================================================================== 
