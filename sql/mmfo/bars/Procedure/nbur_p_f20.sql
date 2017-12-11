

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F20.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F20 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F20 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#20')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #20 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.005  01.12.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.005  01.12.2017';
/*
   Періодичність: A013 = 1 Щоденна 
   
   Розріз консолідації: A014 = 3 Зведений за банк

   Структура показника    DDDDDDDD

   cегмент, який приймає постійні значення в кодах показників
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
    logger.info ('NBUR_P_F20 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
 
    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 5, l_file_code, l_nbuc, l_type);
                 
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
             ddd field_code,
             TO_CHAR(ABS(ostq)) field_value,
             't020='||t020||
             ' k030='||k030||
             ' r031='||r031||
             ' s181='||s181||
             ' r013='||r013 description,
             acc_id,
             acc_num,
             kv,
             maturity_date,
             cust_id,
             NULL,
             NULL,
             branch
        from (select a.cust_id, 
                   a.acc_id,
                   a.kf,
                   a.acc_num,
                   a.kv,
                   a.nbs,
                   a.maturity_date,
                   a.k030, 
                   a.r031, 
                   a.r011, 
                   a.r013,
                   a.s181,
                   a.r016,
                   a.ostq, 
                   a.t020,
                   (case when substr(trim(b.ddd),1,3) in ('754') and a.kv = 840 
                            then substr(trim(b.ddd),1,7)||'4'
                         when substr(trim(b.ddd),1,3) in ('753','754','763','764') and a.kv = 978
                            then to_char(to_number(substr(trim(b.ddd),1,3)) + 2) ||
                                 substr(trim(b.ddd),4,4)||
                                 to_char(to_number(substr(trim(b.ddd),8,1)) + 2)
                         when substr(trim(b.ddd),1,3) in ('837','838','839','847') and a.r016='10'
                            then to_char(to_number(substr(trim(b.ddd),1,3)) - 6) ||
                                 substr(trim(b.ddd),4,5)
                         when substr(trim(b.ddd),1,3) in ('283','284')  and a.r016='20'
                            then substr(trim(b.ddd),1,7)||
                                 to_char(to_number(substr(trim(b.ddd),8,1)) - 4)
                         else nvl(b.ddd, '99900000')
                   end) ddd,
                   a.branch,
                   a.nbuc
            from (
                SELECT /*+ index(a, IDX_DMACCOUNTS_NBS_OB22) */
                     b.cust_id,
                     b.acc_id,
                     a.kf,
                     a.acc_num,
                     a.kv,
                     a.nbs,
                     a.maturity_date,
                     c.k030, 
                     a.r034 r031, 
                     a.r011, 
                     (case when a.nbs in ('1406','1407','1416','1417','1426','1427','3016','3017',
                                 '3116','3117','3216','3217') and a.r013 <>'1' then '1' 
                           when a.nbs in ('1410','1420') and a.r013 <> '1' then '9'
                           else a.r013
                     end) r013, 
                     (case when a.s180 = '0' and a.maturity_date is not null 
                        then FS181(a.acc_id, p_report_date, a.s180)
                        else a.s181 end) s181, 
                     a.r016,
                     b.ostq,
                     (case sign(b.ostq) when -1 then '1' else '2' end) t020,
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
            left outer join 
            (select unique r020, t020, k030, r031, s181, r013, trim(ddd) ddd
            FROM kl_f20
            WHERE kf='20') b
            on (a.nbs = b.r020 and
                a.t020 = b.t020 and
                b.k030 in ('X', a.k030) and
                b.r031 in ('X', a.r031) and
                b.s181 in ('X', a.s181) and
                b.r013 in ('X', a.r013))                                      
            where (substr(a.nbs,1,2) in ('14','31') and 
                       (substr(a.nbs,4,1) not in ('6','7') and a.r016 in ('10','90','99') OR
                        substr(a.nbs,4,1) in ('6','7') and a.r016 in ('10','90')) OR
                   substr(a.nbs,1,2) not in ('14','31')) and
                  ((a.nbs = '2600' and a.r031 in ('1','2') and a.r013 = '1' and a.ostq > 0 ) OR
                   (a.nbs = '2604' and a.r031 in ('1','2') and a.r013 = '2') OR
                   (a.nbs = '2600' and a.r031 = '2' and a.r013 <> '1' and a.ostq > 0 )         OR
                   (a.nbs in ('2909','3739') and a.r031='2')                       OR
                   (a.nbs not in ('1001','1200','2600','2604','2909','3739'))))
        where  ostq <> 0 and
               (not to_number(substr(ddd, 1, 3)) between 721 and 738 or
               to_number(substr(ddd, 1, 3)) between 721 and 738 and
               maturity_date <= to_date('31122008','ddmmyyyy') and
               ((substr(nbs,4,1) in ('6','7') and r011='1') OR
                 substr(nbs,4,1)='0')) and
              (p_report_date < to_date('01122017','ddmmyyyy') and    
               substr(ddd,1,3) not in ( '821','822','823','824','825','826','827','831',
                                     '832','833','834','835','836','837','841','842',
                                     '843','844','845','846','847','851','852','853',
                                     '854','855','856','857','861','862','863','864',
                                     '865','866','867','871','872','873','874','875',
                                     '876','877') or
               p_report_date >= to_date('01122017','ddmmyyyy') and    
               substr(ddd,1,3) not in ( '821','822','823','824','825','826','827','831',
                                     '832','833','834','835','836','837','841','842',
                                     '843','844','845','846','847','851','852','853',
                                     '854','855','856','857','861','862','863','864',
                                     '865','866','867','871','872','873','874','875',
                                     '876','877',
                                     '058','059','158','159',         -- 2601
                                     '092','093','192','193',         -- 2700, 2701
                                     '717','817','719','819'));          -- 2707, 2706                     
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F20 error: '
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
              field_value
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
                        and field_code <> '99900000'
               GROUP BY report_date,
                        kf,
                        report_code,
                        nbuc,
                        field_code);

    logger.info ('NBUR_P_F20 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_F20;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F20.sql =========*** End **
PROMPT ===================================================================================== 
