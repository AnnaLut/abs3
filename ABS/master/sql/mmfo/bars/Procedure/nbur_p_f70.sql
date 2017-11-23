

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F70.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F70 ***

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F70 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#70')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #39 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.015  09/11/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.015  09.11.2017';
/*
   Структура показника DD NNN

  DD    -    може приймати значення:
    10 - код валюти
    20 - сума валюти
    31 - код ЄДРПОУ юридичної особи/ідентифікаційний номер ДРФО фізичної особи/код банку
    32 - назва клієнта/прізвище, ім'я та по-батькові фізичної особи/назва банку.
    33 - місцезнаходження клієнта (адреса)
    40 - код мети операції з валютою (купівлі)
    41 - код виду економічної діяльності клієнта банку
    51 - номер зовнішньоекономічного контракту (кредитного договору) клієнта
    52 - дата укладення зовнішньоекономічного контракту (кредитного договору) клієнта
    60 - дата останньої МД або дата акту про надання послуг, виконання робіт
    61 - дати інших МД
    62 - код країни, до якої була переказана валюта
    63 - підстава для операції з валютою (купівлі)
    64 - код країни бенефіціара
    65 - код іноземного банку
    66 - назва іноземного банку
    71 - код валютної операції

   NNN    -    умовний порядковий номер операції (купівлі безготівкової іноземної валюти) у межах звітного дня.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_file_id       number;
    l_fmt           varchar2(20):='999990D0000';
    l_gr_sum_840    number; -- гранична сума
    l_gr_sum_980    number; -- гранична сума
    l_kurs_840      number := F_NBUR_RET_KURS (840, p_report_date);
    l_max_nnn       number;
BEGIN
    logger.info ('NBUR_P_F70 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    l_file_id := 15548;

    if p_report_date <= to_date('21032016','ddmmyyyy') then
       l_gr_sum_840 := 10000000;
    elsif p_report_date <= to_date('31052017','ddmmyyyy') then
       l_gr_sum_840 := 100000;
    else 
       l_gr_sum_840 := 100; 
    end if;
    
    l_gr_sum_980 := gl.p_icurval(840, 100000, p_report_date);
    
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
        SELECT d.report_date,
               d.kf,
               p_file_code,
               (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
               substr(d.colname,2,2)||d.nnn field_code,
               d.value field_value,
               description,
               d.acc_id,
               d.acc_num,
               d.kv,
               null maturity_date,
               d.cust_id,
               ref,
               NULL nd,
               branch
        from (select report_date, kf, ref, kv, cust_id, acc_id, acc_num,  
                     lpad((dense_rank() 
                           over 
                             (order by nbuc, (case when flag_kons = 0 then to_char(ref) else p10||(case when p31 = '006' then p31 else '0000000000' end) end) )
                           ), 3, '0') nnn,
                     p10, 
                     p20, 
                     (case when flag_kons = 0 then p31 else (case when p31 = '006' then p31 else '0000000000' end) end) p31, 
                     (case when flag_kons = 0 then p32 else 'консолідація' end) p32, 
                     (case when flag_kons = 0 then p33 else 'консолідація' end) p33, 
                     (case when flag_kons = 0 then p40 else '00' end) p40, 
                     (case when flag_kons = 0 then p41 else '00000' end) p41, 
                     (case when flag_kons = 0 then p51 else '0' end) p51, 
                     (case when flag_kons = 0 then p52 else '' end) p52, 
                     (case when flag_kons = 0 then p60 else '' end) p60, 
                     (case when flag_kons = 0 then p61 else '' end) p61, 
                     (case when flag_kons = 0 then p62 else '000' end) p62, 
                     (case when flag_kons = 0 then p63 else '00000000000' end) p63, 
                     (case when flag_kons = 0 then p64 else '000' end) p64, 
                     (case when flag_kons = 0 then p65 else '0' end) p65, 
                     (case when flag_kons = 0 then p66 else '0' end) p66, 
                     (case when flag_kons = 0 then p71 else '01' end) p71,
                     nbuc, branch, description
                FROM (select /*+ ordered */
                            t.report_date, t.kf, t.ref, t.kv,
                            c.cust_id, t.acc_id_cr acc_id, t.acc_num_cr acc_num,
                            lpad(t.kv, 3, '0') P10,
                            TO_CHAR (ROUND (t.bal /  (F_NBUR_Ret_Dig(t.kv, t.report_date) * 100), 0)) P20,
                            (case when c.k030 = '1' and length(trim(c.cust_code))<=8
                                    then lpad(trim(c.cust_code), 8,'0')
                                  when c.k030 = '1' and
                                       lpad(trim(c.cust_code), 10,'0') in
                                        ('99999','999999999','00000','000000000','0000000000')
                                    then ''
                                  when c.k030 = '1' and length(trim(c.cust_code)) > 8
                                    then lpad(trim(c.cust_code), 10,'0')
                                  when c.k030 = '2'
                                    then '0'
                                  else
                                    '0'
                            end) P31,
                            C.CUST_NAME  P32,
                            C.CUST_ADR   P33,
                            C.K110    P41,
                            nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') P40,
                            NVL (SUBSTR (nvl(TRIM (p.d2#70), z.contract), 1, 70), 'N контр.') P51,
                            NVL (nvl(replace(SUBSTR (TRIM (p.d3#70), 1, 70), '.', ''),
                                     to_char(z.dat2_vmd, 'ddmmyyyy')),
                                 'ddmmyyyy') P52,
                            nvl(replace(SUBSTR (TRIM (p.d4#70), 1, 70), '.', ''),
                                     to_char(z.dat_vmd, 'ddmmyyyy')) P60,
                            NVL (SUBSTR (TRIM (p.d5#70), 1, 70), trim(z.dat5_vmd)) P61,
                            (case when TRIM (p.d6#70) is not null
                                    then lpad(TRIM (p.d6#70), 3, '0')
                                    else
                                        NVL (lpad(nvl(TRIM (z.country), w.bankcountry), 3, '0'),
                                        'код країни, до якої була переказана валюта')
                            end) P62,
                            NVL (nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)),
                                 'пiдстава для придбання') P63,
                            nvl(lpad(nvl(nvl(TRIM (p.d8#70), w.benefcountry), z.benefcountry), 3, '0'),
                                'код країни бенефіціара') P64,
                            (case when trim(p.d1#70) in ('03','07') or
                                       nvl(TRIM(p.d6#70), nvl(TRIM (z.country), w.bankcountry)) = '804' and
                                       nvl(nvl(TRIM (p.d8#70), w.benefcountry), z.benefcountry) = '804' and
                                       nvl(TRIM (p.dA#70), trim(z.bank_name)) = '0' or
                                       nvl(TRIM (p.d9#70), trim(z.bank_code)) = '0' or
                                       nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') = '03' and
                                       nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)) = '3.1.а.1' or
                                       nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') = '04' and
                                       nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)) = '2.1.б.1'
                                  then '0'
                                  else nvl(nvl(TRIM (p.d9#70), trim(z.bank_code)), 'код іноземного банку')
                            end) P65,
                            (case when nvl(TRIM(p.d6#70), nvl(TRIM (z.country), w.bankcountry)) = '804' and
                                       nvl(nvl(TRIM (p.d8#70), w.benefcountry), z.benefcountry) = '804' and
                                       nvl(TRIM (p.d9#70), trim(z.bank_code)) = '0' or
                                       nvl(TRIM (p.dA#70), trim(z.bank_name)) = '0' or
                                       nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') = '03' and
                                       nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)) = '3.1.а.1' or
                                       nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') = '04' and
                                       nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)) = '2.1.б.1'
                                  then '0'
                                  else nvl(nvl(TRIM (p.dA#70), trim(z.bank_name)), 'назва iноземного банку')
                                  end) P66,
                            '01' P71,
                            a.nbuc,
                            c.branch,
                            'Відібрані по довіднику ' description,
                            (case when t.bal_uah > l_gr_sum_980 then 0 else 1 end) flag_kons
                        from NBUR_REF_SEL_TRANS r
                        join NBUR_DM_TRANSACTIONS t
                        on (t.acc_num_db like r.acc_num_db||'%' and
                            t.acc_num_cr like r.acc_num_cr||'%')
                        join NBUR_DM_ACCOUNTS a
                        on ( a.report_date = p_report_date and
                             a.kf          = p_kod_filii   and
                             a.acc_id      = t.acc_id_cr  )
                        join NBUR_DM_CUSTOMERS c
                        on (t.report_date = c.report_date and
                            t.kf = c.kf and
                            t.cust_id_cr = c.cust_id)
                        left outer join ZAYAVKA z
                        on (t.ref = z.ref and nvl(z.dk, 1) = 1)
                        left outer join TOP_CONTRACTS w
                        on (z.pid = w.pid)
                        left outer join NBUR_DM_ADL_DOC_RPT_DTL p
                        on (t.report_date = p.report_date and
                            t.kf = p.kf and
                            t.ref = p.ref)
                        join oper o
                        on (t.ref = o.ref)
                        where t.report_date = p_report_date and
                            t.kf = p_kod_filii and
                            t.kv not in (959, 961, 962, 964, 980) and
                            r.file_id = l_file_id and
                            t.ref not in (select ref from zayavka where dk = 3 and ref is not null and sos <> -1) and 
                            not lower(o.nazn) like '%поверн%невикор%кошт%' and
                            not exists (select 1 from opl z where z.ref = t.ref and z.stmt <> t.stmt and z.kv not in (t.kv, 980)) and
                            t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date) 
                ---------------------------------------------------------------
                    union all
                ---------------------------------------------------------------
                select /*+ ordered */
                    t.report_date, t.kf, t.ref, t.kv,
                    c.cust_id, t.acc_id_cr acc_id, t.acc_num_cr acc_num,
                    lpad(t.kv, 3, '0') P10,
                    TO_CHAR (ROUND (t.bal /  (F_NBUR_Ret_Dig(t.kv, t.report_date) * 100), 0)) P20,
                    (case when c.k030 = '1' and length(trim(c.cust_code))<=8
                            then lpad(trim(c.cust_code), 8,'0')
                          when c.k030 = '1' and
                               lpad(trim(c.cust_code), 10,'0') in
                                ('99999','999999999','00000','000000000','0000000000')
                            then ''
                          when c.k030 = '1' and length(trim(c.cust_code)) > 8
                            then lpad(trim(c.cust_code), 10,'0')
                          when c.k030 = '2'
                            then '0'
                          else
                            '0'
                    end) P31,
                    C.CUST_NAME  P32,
                    C.CUST_ADR   P33,
                    C.K110    P41,
                    nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') P40,
                    NVL (SUBSTR (nvl(TRIM (p.d2#70), z.contract), 1, 70), 'N контр.') P51,
                    NVL (nvl(replace(SUBSTR (TRIM (p.d3#70), 1, 70), '.', ''),
                             to_char(z.dat2_vmd, 'ddmmyyyy')),
                         'ddmmyyyy') P52,
                    nvl(replace(SUBSTR (TRIM (p.d4#70), 1, 70), '.', ''),
                             to_char(z.dat_vmd, 'ddmmyyyy')) P60,
                    NVL (SUBSTR (TRIM (p.d5#70), 1, 70), trim(z.dat5_vmd)) P61,
                    (case when TRIM (p.d6#70) is not null
                            then lpad(TRIM (p.d6#70), 3, '0')
                            else
                                NVL (lpad(nvl(TRIM (z.country), w.bankcountry), 3, '0'),
                                'код країни, до якої була переказана валюта')
                    end) P62,
                    NVL (nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)),
                         'пiдстава для придбання') P63,
                    nvl(lpad(nvl(nvl(TRIM (p.d8#70), w.benefcountry), z.benefcountry), 3, '0'),
                        'код країни бенефіціара') P64,
                    (case when trim(p.d1#70) in ('03','07') or
                               nvl(TRIM(p.d6#70), nvl(TRIM (z.country), w.bankcountry)) = '804' and
                               nvl(nvl(TRIM (p.d8#70), w.benefcountry), z.benefcountry) = '804' and
                               nvl(TRIM (p.dA#70), trim(z.bank_name)) = '0' or
                               nvl(TRIM (p.d9#70), trim(z.bank_code)) = '0' or
                               nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') = '03' and
                               nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)) = '3.1.а.1' or
                               nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') = '04' and
                               nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)) = '2.1.б.1'
                          then '0'
                          else nvl(nvl(TRIM (p.d9#70), trim(z.bank_code)), 'код іноземного банку')
                    end) P65,
                    (case when nvl(TRIM(p.d6#70), nvl(TRIM (z.country), w.bankcountry)) = '804' and
                               nvl(nvl(TRIM (p.d8#70), w.benefcountry), z.benefcountry) = '804' and
                               nvl(TRIM (p.d9#70), trim(z.bank_code)) = '0' or
                               nvl(TRIM (p.dA#70), trim(z.bank_name)) = '0' or
                               nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') = '03' and
                               nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)) = '3.1.а.1' or
                               nvl (lpad (nvl(trim (substr (p.d1#70 , 1, 2)), trim(z.meta)), 2, '0'), '00') = '04' and
                               nvl(SUBSTR (TRIM (p.d7#70), 1, 70), trim(Z.basis)) = '2.1.б.1'
                          then '0'
                          else nvl(nvl(TRIM (p.dA#70), trim(z.bank_name)), 'назва iноземного банку')
                          end) P66,
                    '01'  P71,
                    a.nbuc,
                    c.branch,
                    'Додані користувачем ' description,
                    (case when t.bal_uah > l_gr_sum_980 then 0 else 1 end) flag_kons
                from NBUR_TMP_INS_70 r
                join NBUR_DM_TRANSACTIONS t
                on (t.report_date = r.datf and
                    t.kf = r.kf and
                    t.ref = r.ref and
                    r.kodf = l_file_code)
                join NBUR_DM_ACCOUNTS a
                on ( a.report_date = p_report_date and
                     a.kf          = p_kod_filii   and
                     a.acc_id      = t.acc_id_cr  )
                join NBUR_DM_CUSTOMERS c
                on (t.report_date = c.report_date and
                    t.kf = c.kf and
                    t.cust_id_cr = c.cust_id)
                left outer join ZAYAVKA z
                on (t.ref = z.ref and nvl(z.dk, 1) = 1)
                left outer join TOP_CONTRACTS w
                on (z.pid = w.pid)
                left outer join NBUR_DM_ADL_DOC_RPT_DTL p
                on (t.report_date = p.report_date and
                    t.kf = p.kf and
                    t.ref = p.ref)
                where t.report_date = p_report_date and
                    t.kf = p_kod_filii and
                    t.kv not in (959, 961, 962, 964, 980) and
                    t.ref not in (select ref from nbur_detail_protocols where report_code = p_file_code and report_date = p_report_date))
                            )
             UNPIVOT (VALUE FOR colname IN  (p10, p20, p31, p32, p33, p40, p41,
                        p51, p52, p60, p61, p62, p63, p64, p65, p66, p71)
            ) d;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F70 error: '
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
              to_char(sum(to_number(field_value))) 
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii
            and field_code like '20%'
      group by report_date,
               kf,
               report_code,
               nbuc,
               field_code;
    commit;
    
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
              max(field_value)
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii
            and field_code not like '20%'
      group by report_date,
               kf,
               report_code,
               nbuc,
               field_code;
    commit;
    
    -- додаємо в кінець вже заповненого файлу
    select nvl(max(to_number(substr(field_code, 3, 3))), 0)
    into l_max_nnn
    from nbur_agg_protocols
    WHERE     report_date = p_report_date
          AND report_code = p_file_code
          AND kf = p_kod_filii;
          
    -- блок по казначейству, що заповнюється на основі довідників
    INSERT INTO nbur_agg_protocols (report_date,
                                    kf,
                                    report_code,
                                    nbuc,
                                    field_code,
                                    field_value)
    select report_date,
           kf,
           p_file_code,
           l_nbuc,
           field_code,
           field_value
    from (select c.report_date, c.kf,
                   substr(c.colname, 2, 3)||c.nnn field_code,
                   c.value field_value
            from (select REPORT_DATE, KF,
                         lpad(VAR_10, 3, '0') P10,
                         to_char(round(VAR_20, 0)) P20,
                         VAR_63 P63,
                         VAR_71 P71,
                         lpad(rownum + l_max_nnn, 3, '0') nnn
            from NBUR_KOR_DATA_F70
            where report_date = p_report_date and
                  kf = p_kod_filii)
            UNPIVOT (VALUE FOR colname IN (P10, P20, P63, P71)) c
            union all
          select p_report_date, a.kf, a.code_var||b.nnn, a.value
            from NBUR_KOR_DEFAULT a,
                 (select lpad(rownum + l_max_nnn, 3, '0') nnn
                  from NBUR_KOR_DATA_F70
                  where report_date = p_report_date and
                        kf = p_kod_filii) b
            where a.report_code = p_file_code and
                a.kf = p_kod_filii);
                
      -- вставка даних для функції довведення допреквізитів            
      DELETE FROM OTCN_TRACE_70 WHERE kodf = l_file_code and datf = p_report_date and kf = p_kod_filii;

      insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
      select l_file_code, p_report_date, USER_ID, ACC_NUM, KV, p_report_date, FIELD_CODE, FIELD_VALUE, NBUC, null ISP, 
             CUST_ID, ACC_ID, REF, DESCRIPTION, ND, MATURITY_DATE, BRANCH
      FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii;              

    logger.info ('NBUR_P_F70 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F70.sql =========*** End **
PROMPT ===================================================================================== 
