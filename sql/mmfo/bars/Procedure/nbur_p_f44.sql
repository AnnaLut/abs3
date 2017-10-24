

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F44.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F44 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F44 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#44')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #39 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.001  19.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.001  19.08.2016';
/*
   Структура показника  > L DD VVV YYYYYYYY ZZZZZZ

   L    -    може приймати значення:
    1 - сума
    4 - курс

   DDD    -   сегмент показника, може приймати значення:
    92 - маса банкiвських металів у стандартних і мірних зливках, куплених в iнших банків без фізичної поставки
    93 - маса банкiвських металів у стандартних і мірних зливках, куплених у юридичних осіб без фізичної поставки
    94 - маса банкiвських металів у стандартних і мірних зливках, куплених у фізичних осіб без фізичної поставки
    95 - маса банкiвських металів у стандартних і мірних зливках, проданих iншим банкам без фізичної поставки
    96 - маса банкiвських металів у стандартних і мірних зливках, проданих юридичним особам без фізичної поставки
    97 - маса банкiвських металів у стандартних і мірних зливках, проданих ф•зичним особам без фізичної поставки
    B2 - середньозважений курс операцій без фізичної поставки банківських  металів, куплених в iнших банків
    B3 - середньозважений курс операцій без фізичної поставки банківських металів, куплених у юридичних осіб
    B4 - середньозважений курс операцій без фізичної поставки банківських металів, куплених у фізичних осіб
    B5 - середньозважений курс операцій без фізичної поставки банківських металів, проданих iншим банкам
    B6 - середньозважений     курс операцій без фізичної поставки банківських металів, проданих юридичнимособам
    B7 - середньозважений    курс операцій без фізичної поставки банківських металів,проданих фізичним особам

   VVV    -    код банківського металу;
   YYYYYYYY    -    приймає значення 00000000
   ZZZZZZ    -    приймає значення 000000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_fmt           varchar2(20):='999990D0000';
    l_date_beg      date := nbur_files.f_get_date (p_report_date, 2);
BEGIN
    logger.info ('NBUR_P_F44 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

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
        SELECT report_date,
               kf,
               p_file_code,
               l_nbuc nbuc,
               substr(colname,2,1) ||
               kodp field_code,
               value field_value,
               NULL description,
               acc,
               nls,
               kv,
               null maturity_date,
               rnk,
               ref,
               NULL nd,
               null branch
        from (select report_date, kf, ref, kv,
                   (case when d44 in ('92','93','94') then cust_id_db else cust_id_cr end) rnk,
                   (case when d44 in ('92','93','94') then acc_id_db else acc_id_cr end) acc,
                   (case when d44 in ('92','93','94') then acc_num_db else acc_num_cr end) nls,
                   d44 || ckv || '00000000000000' kodp,
                   p1, p2, TO_CHAR(to_number(p1)*to_number(translate(p2, ',','.'))) p3
             from (
                select
                    t.report_date, t.kf, t.ref, t.kv,
                    lpad(t.kv, 3, '0') ckv,
                    t.cust_id_db, t.acc_id_db, t.acc_num_db,
                    t.cust_id_cr, t.acc_id_cr, t.acc_num_cr,
                    to_char(t.bal) p1,
                    nvl(trim(w2.value),
                       (case
                            when trim(w1.value) = '112' and
                                 not (t.acc_num_db like '3800%' and
                                      nvl(trim(w2.value), trim(w1.value))
                                        in ('92','93','94','112'))
                             then '92' else '95' end)) d44,
                    (case when nvl(trim(w3.value), '1') = '1'
                        then to_char(f_ret_kurs(t.kv, p_report_date))
                        else trim(w3.value)
                     end)  p2
                from nbur_dm_transactions t
                join oper o
                on (t.ref = o.ref)
                left outer join operw w1
                on (t.ref = w1.ref and
                    w1.tag = 'D#39')
                left outer join operw w2
                on (t.ref = w2.ref and
                    w2.tag = 'D#44')
                left outer join operw w3
                on (t.ref = w3.ref and
                    w3.tag = 'KURS')
                where t.report_date = p_report_date and
                    t.kf = p_kod_filii and
                    t.kv in (959,961,962,964)  AND
                    t.acc_num_db not like '110%' AND
                    t.acc_num_db not like '8%' AND
                    t.acc_num_cr not like '110%' AND
                    t.tt <> '024' and
                    (substr(w1.value,1,3) in ('112','122') or
                     substr(w2.value,1,2) in ('92','93','94', '95','96','97')) and
                    SUBSTR(LOWER(TRIM(o.nazn)),1,4) <> 'конв' and
                    t.bal <> 0 and
                    (substr(o.nlsb,1,4) = '2600' or
                     not ((o.mfoa = o.mfob and
                            nvl(trim(w2.value), trim(w1.value)) in ('92','93','94','112') and
                           '3901' in (substr(t.acc_num_db,1,4), substr( t.acc_num_cr,1,4)))
                           or
                           (o.mfoa <> o.mfob and
                            nvl(trim(w2.value), trim(w1.value)) in ('95','96','97','122') and
                           (SELECT count(*) FROM v_branch
                             WHERE o.mfob = mfo and mfo <> mfou)>0))) and
                    nvl(trim(w2.value), trim(w1.value)) is not null)
              )
              UNPIVOT (VALUE FOR colname IN  (p1, p2, p3));
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F44 error: '
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
              '4'||a.field_code,
              trim(to_char(a.field_value/b.field_value, l_fmt)) field_value
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

    logger.info ('NBUR_P_F44 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F44.sql =========*** End **
PROMPT ===================================================================================== 
