

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FF4.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FF4 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FF4 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#F4')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #F4 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002  19.12.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002  19.12.2016';
/*
   Структура показника   L D BBBB P A У K R JJ VVV

    L - сума/процентна ставка     [1,2]
    D - може приймати значення:
    5 - дебетові обороти (гривневий еквівалент);
    6 - кредитові обороти (гривневий еквівалент)    [5,6]

    BBBB     -    балансовий рахунок;
    P        -    розподіл рахунку за визначеним критерієм; 
    A        -    код секції виду економічної діяльності; 
    У        -    код сектора економіки;
    K        -    код початкового строку погашення;
    R        -    код резидентності;
    JJ       -    код параметру розподілу суми оборотів; 
    VVV      -    код валюти;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_date_beg      date := nbur_files.f_get_date (p_report_date, 1);
BEGIN
    logger.info ('NBUR_P_FF4 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
 
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
        select p_report_date,
              kf,
              p_file_code,
              (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
              substr(colname,2,1)||field_code,
              value field_value,
              '' description,
              acc_id,
              acc_num,
              kv,
              maturity_date,
              cust_id,
              REF,
              null nd,
              branch
        from(select report_date, kf, report_code, nbuc, branch,
                acc_id, acc_num, kv, cust_id, maturity_date, ref,
                tt||nbs||r013||k112||k072||s180||k030||d020||lpad(kv,3,'0') field_code,
                p1, p2, p1 * round(p2, 4) p3
             from(select p.REPORT_DATE, p.KF, p.REPORT_CODE, p.NBUC,
                     (case
                        when a.nbs not in ('1600','2600','2605','2620','2625','2650','2655') AND
                               substr(p.FIELD_CODE,2,1) = '5'
                        then to_number(p.field_value) + b.crdos
                        when (a.nbs not in ('1600','2600','2605','2650','2655') or
                              a.nbs = '2600' and a.r013 = '7' or
                              a.kf <> '324805' and a.nbs in ('2605','2655') and a.r013 = '1' or
                              a.kf = 324805 and
                              (a.nbs = '2605' and a.r013 = '1' and nvl(g.rate_val, 0) <> 0   OR
                               A.nbs = '2655' and A.r013 = '1') or
                              a.nbs = '2650' and a.r013 = '8') and
                              substr(p.FIELD_CODE,2,1) = '6'
                        then to_number(p.field_value) + b.crdos
                        else to_number(p.field_value)
                     end) p1, nvl(g.rate_val, 0) p2,
                    p.acc_id, p.acc_num, substr(p.field_code,3,4) nbs, p.kv, p.maturity_date, a.r013,
                    substr(p.field_code,8,1) s180, substr(p.field_code,10,2) d020,
                    p.cust_id, c.k030, c.k112, c.k072, p.branch,
                    substr(p.field_code,2,1) tt, p.ref
                from (select *
                      from nbur_detail_protocols_arch a
                      where report_date between l_date_beg and p_report_date and
                            kf = p_kod_filii and
                            report_code = '#3A' and
                            version_id = any (select l.version_id
                                          from nbur_lst_files l, nbur_ref_files r
                                          where l.report_date = a.report_date and
                                                l.kf = a.kf and
                                                l.file_status = 'FINISHED' and
                                                l.file_id = r.id and
                                                r.FILE_CODE = '#3A')) p
                join NBUR_DM_ACCOUNTS a
                on (p.acc_id = a.acc_id)
                join NBUR_DM_CUSTOMERS c
                on (p.cust_id = c.cust_id)
                join NBUR_DM_BALANCES_MONTHLY b
                on (b.report_date = p_report_date and
                    b.kf = p_kod_filii and
                    b.acc_id = p.acc_id)
                left outer join NBUR_DM_ACNT_RATES g
                on (g.report_date = p_report_date and
                    g.kf = p_kod_filii and
                    g.acc_id = a.acc_id and
                    g.rate_tp = 0)
                where p.report_date = p_report_date and
                    p.kf = p_kod_filii and
                    p.report_code = '#3A' and
                    substr(p.FIELD_CODE,3,4) in (select r020 from nbur_tmp_kod_r020) and
                    substr(p.FIELD_CODE,1,1) = '1'))
                UNPIVOT (VALUE FOR colname IN  (p1, p2, p3));
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_FF4 error: '
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
       SELECT report_date,
              kf,
              report_code,
              nbuc,
              field_code,
              to_char(field_value)
         FROM (  SELECT report_date,
                        kf,
                        report_code,
                        nbuc,
                        field_code,
                        SUM (field_value) field_value
                   FROM nbur_detail_protocols
                  WHERE     report_date = p_report_date
                        AND report_code = p_file_code
                        AND kf = p_kod_filii
                        and field_code like '1%'
               GROUP BY report_date,
                        kf,
                        report_code,
                        nbuc,
                        field_code)
            UNION
         SELECT a.report_date,
              a.kf,
              a.report_code,
              a.nbuc,
              '2'||a.field_code,
              trim(to_char(a.field_value/b.field_value, '999990D0000')) field_value
         FROM (  SELECT report_date,
                        kf,
                        report_code,
                        nbuc,
                        substr(field_code, 2) field_code,
                        SUM (field_value) field_value
                   FROM nbur_detail_protocols
                  WHERE     report_date = p_report_date
                        AND report_code = p_file_code
                        AND kf = p_kod_filii
                        and field_code like '3%'
               GROUP BY report_date,
                        kf,
                        report_code,
                        nbuc,
                        substr(field_code, 2)) a
         join
         (  SELECT substr(field_code, 2) field_code,
                   SUM (field_value) field_value
            FROM nbur_detail_protocols
                  WHERE     report_date = p_report_date
                        AND report_code = p_file_code
                        AND kf = p_kod_filii
                        and field_code like '1%'
               GROUP BY substr(field_code, 2)) b
          on (a.field_code = b.field_code);

    logger.info ('NBUR_P_FF4 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_FF4;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FF4.sql =========*** End **
PROMPT ===================================================================================== 
