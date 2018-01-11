

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F2D.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F2D ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F2D (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#2D')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #2D для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.008  15.11.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.008  15.11.2017';
/*
   Структура показника DD NNN

  DD    -   може приймати значення:
    10 - Код валюти;
    20 - Сума валюти (в одиницях валюти);
    31 - код ЄДРПОУ юридичної особи/ ідентифікаційний номер ДРФО фізичної особи/ код банку;
    62 - Код резидентності;
    40 - Мета переказу;
    64 - Код країни бенефіціара;
    65 - Код банку бенефіціара;
    67 - Назва клієнта/прізвище, ім’я, по батькові;

   NNN    -    умовний порядковий номер операції у межах звітного дня.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_file_id       number;
    l_fmt           varchar2(20):='999990D0000';
    l_kurs_840      number := F_NBUR_RET_KURS (840, p_report_date);
    l_ourGLB        varchar2(20);
    l_last_nnn      number := 0;
    l_ourOKPO       varchar2(20) := LPAD (F_Get_Params ('OKPO', NULL), 8, '0');

BEGIN
    logger.info ('NBUR_P_F2D begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    execute immediate 'truncate table NBUR_TMP_TRANS_1';

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    l_file_id := 15068;

    begin
        select max(decode(glb, 0, '0', lpad(to_char(glb), 3, '0')))
        into l_ourGLB
        from rcukru
        where mfo = p_kod_filii;
    exception
        when no_data_found then
            l_ourGLB := null;
    end;

  -- підготовка даних
  insert
    into NBUR_TMP_TRANS_1
       ( REPORT_DATE, KF, REF, TT, RNK, ACC, NLS, KV,
         P10, P20, P31, P40, P62, REFD,
         D1#E2, D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, NAZN, NMK )
  select REPORT_DATE, KF, REF, TT, CUST_ID, ACC_ID, ACC_NUM, KV,
         P10, P20, P31, D1#E2 P40, P62, REFD,
         D1#E2, D6#E2, D7#E2, D8#E2, DA#E2, KOD_G, NB, substr(NAZN, 1, 70), NMK
    from ( select /*+ ordered */
                  unique t.report_date, t.kf, t.ref, t.tt,
                  c.cust_id, t.acc_id_db acc_id, t.acc_num_db acc_num, t.kv,
                  lpad((dense_rank() over (order by t.ref)), 3, '0') nnn,
                  lpad(t.kv, 3, '0') P10,
                  TO_CHAR (t.bal) P20,
                  (case when t.kf = '300465' and
                    t.acc_num_cr like '1500%' and
                    (t.acc_num_db in ('29091000580557',
                                     '29092000040557',
                                     '29095000081557',
                                     '29095000046547',
                                     '29091927',
                                     '2909003101',
                                     '292460205',
                                     '292490204') OR
                     substr(t.acc_num_db,1,4) = '1502') or
                     C.CUST_CODE = l_ourOKPO
                then '006'
                when trim(c.CUST_CODE) = l_ourOKPO or c.cust_type = '1' and c.k040 = '804'
                then l_ourGLB
                else
                    (case when c.k030 = '2' or C.K040 <> '804'
                            then lpad(trim(c.cust_code), 10, '0')
                          when c.k030 = '1' and length(trim(c.cust_code))<=8
                            then lpad(trim(c.cust_code), 8,'0')
                          when c.k030 = '1' and
                               lpad(trim(c.cust_code), 10,'0') in
                                ('99999','999999999','00000','000000000','0000000000')
                            then ''
                          when c.k030 = '1' and length(trim(c.cust_code)) > 8
                            then lpad(trim(c.cust_code), 10,'0')
                          else
                            lpad(trim(c.cust_code), 10, '0')
                    end)
            end) P31,
            substr(trim(p.D1#2D), 1, 2) D1#E2,
            nvl((case when substr(trim(p.KOD_G),1,1) in ('O','P','О','П')
                    then SUBSTR (trim(p.KOD_G), 2, 3)
                    else SUBSTR (trim(p.KOD_G), 1, 3)
                 end),
                 substr(nvl(p.D6#70, p.D6#E2),1,3)) D6#E2,
            substr(trim(nvl(p.D9#70, p.D7#E2)),1,10) D7#E2,
            substr(trim(nvl(p.DA#70, p.D8#E2)),1,70) D8#E2,
            substr(trim(p.DD#70),1,70) DA#E2,
            (case when c.k040 <> '804' then '0' else to_char(2 - to_number(c.k030)) end) P62,
            to_number(trim(f_dop(t.ref, 'NOS_R'))) refd,
            (case when nvl(b.kodc,'000') <> '000' then b.kodc
                  else SUBSTR (trim(p.KOD_G), 1, 3)
            end) kod_g,
            substr(trim(u.nb), 1, 70) nb,
            o.nazn, C.CUST_NAME nmk
         from NBUR_DM_TRANSACTIONS t
         join NBUR_REF_SEL_TRANS   r
           on ( t.acc_num_db like r.acc_num_db||'%' and
                t.acc_num_cr like r.acc_num_cr||'%' )
         left outer
         join NBUR_DM_ADL_DOC_RPT_DTL p
           on ( t.report_date = p.report_date and
                t.kf          = p.kf          and
                t.ref         = p.ref         )
         join NBUR_DM_CUSTOMERS c
           on ( t.REPORT_DATE = c.report_date and
                t.KF          = c.kf          and
                t.CUST_ID_DB  = c.cust_id     )
         left outer
         join RCUKRU u
           on ( u.IKOD = c.CUST_CODE )
         join OPER o
           on ( t.ref = o.ref)
         left outer
         join BOPCOUNT b
           on ( b.iso_countr = SUBSTR( trim(p.KOD_G), 1, 3 ) )
        where t.report_date = p_report_date
          and t.kf = p_kod_filii
          and t.kv not in (959, 961, 962, 964, 980)
          and r.file_id = l_file_id
          and t.ref not in ( select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date )
          and not ( o.nlsa like '1500%' and o.nlsb like '1500%'
                    or
                    o.kf = '300465' and o.mfoa <> o.mfob
                    or
                    t.kf = '300465' and t.r020_db in ('2600', '2620') and t.r020_cr in ('1919','2909','3739')
                    or
                    o.nlsa like '1500%' and (o.nlsb like '7100%' or o.nlsb like '7500%') and
                    o.dk = 0 and round(t.bal_uah / l_kurs_840, 0) < 100000
                  )
      );

   commit;

   -- формування детального протоколу (частина 1)
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
           (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
           substr(colname,2,2)||nnn field_code,
           value field_value,
           'Part 1' description,
           acc,
           nls,
           kv,
           null maturity_date,
           rnk,
           ref,
           NULL nd,
           branch
    FROM (select z.report_date,
               z.kf,
               z.ref,
               z.rnk,
               z.acc,
               z.nls,
               z.kv,
               z.p10,
               z.p20,
               z.p31,
               z.p40,
               nvl(nvl(substr(trim (z.D6#E2), 1, 70), f_get_swift_country(z.ref)),
                   'код краiни у яку переказана валюта' ) p64,
               nvl(nvl(substr(trim (z.D7#E2), 1, 10),
                   f_get_swift_bank_code(z.ref)), '0000000000') p65,
              z.p62, z.p67, z.nbuc, z.branch,
              lpad((dense_rank() over (order by z.rnk, z.ref)), 3, '0') nnn
        from (
            select a.report_date,
                a.kf, a.ref, a.tt, a.rnk, a.acc, a.nls, a.kv,
                a.p10, a.p20, a.p31, a.p40, a.refd,
                20+t.id_oper D1#E2,
                nvl(t.bankcountry, nvl(a.D6#E2, a.kod_g)) D6#E2,
                a.D7#E2,
                nvl(t.benefbank, a.D8#E2) D8#E2,
                a.nb, a.nazn,
                a.p62, a.nmk p67, b.nbuc, b.branch
            from NBUR_TMP_TRANS_1 a
            left outer join NBUR_DM_ACCOUNTS b
            on (b.report_date = p_report_date and
                b.kf = p_kod_filii and
                b.acc_id = a.acc)
            left outer join (select ref, pid,
                                    min(pid) id_min,
                                    max(id) id,
                                    count(*) cnt
                             from contract_p
                             group by ref, pid) p
            on (a.ref = p.ref)
            left outer join top_contracts t
            on (p.pid = t.pid)
            left outer join operw y
            on (a.ref = y.ref and
                y.tag = 'D1#2D')
            where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                and not ((a.nls like '1919%' or
                          a.nls like '3739%' ) and
                          a.tt = 'NOS') and
                 substr(trim(y.value), 1, 2) in ('01','02','03','04','05','06','07','08') )  z)
        UNPIVOT (VALUE FOR colname IN (p10, p20, p31, p40, P62, p64, p65, p67));

   commit;

   select nvl(to_number(ltrim(max(substr(field_code, 3, 3)), '0')), 0)
   into l_last_nnn
   from nbur_detail_protocols
   where report_date = p_report_date and
         kf = p_kod_filii and
         report_code = p_file_code;

   -- формування детального протоколу (частина 2)
   -- операції форексу
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
           (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
           substr(colname,2,2)||nnn field_code,
           value field_value,
           'Part 2 refd='||to_char(refd) description,
           acc,
           nls,
           kv,
           null maturity_date,
           rnk,
           ref,
           refd nd,
           branch
    FROM (select z.report_date,
               z.kf,
               z.ref,
               z.rnk,
               z.acc,
               z.nls,
               z.kv,
               z.p10,
               z.p20,
               z.p31,
               z.p40,
               nvl(lpad(nvl(nvl(trim(translate(z.kod_g, '0123456789OPОП', '0123456789')),
                                substr(trim (z.D6#E2), 1, 70)),
                            f_get_swift_country(z.ref)), 3, '0'),
                   'код краiни у яку переказана валюта' ) p64,
               nvl(nvl(substr(trim (z.D7#E2), 1, 10),
                   f_get_swift_bank_code(z.ref)),
                   rpad(nvl(trim (z.D7#E2), z.kod_g), 10, '0')) p65,
              z.p62, z.p67, z.refd, z.nbuc, z.branch,
              lpad((dense_rank() over (order by z.rnk, z.ref)) + l_last_nnn, 3, '0') nnn
        from (select  /*+ parallel(4) leading(a) */
                    a.report_date,
                    a.kf,
                    a.ref,
                    a.tt,
                    t1.rnkd rnk,
                    t1.accd acc,
                    t1.nlsd nls,
                    a.kv,
                    a.p10,
                    a.p20,
                    l_ourGLB P31,
                    a.p40,
                    '1' P62,
                    a.D6#E2,
                    a.D7#E2,
                    a.D8#E2,
                    a.KOD_G,
                    a.NB,
                    a.NAZN,
                    nvl(decode(f.kva, 980, '30', '28'), a.p40) d1#E2,
                    t1.ref refd,
                    nvl(C.CUST_NAME, a.nmk) p67, b.nbuc, b.branch
                from NBUR_TMP_TRANS_1 a
                left outer join oper x
                on (x.vdat between p_report_date - 7 and p_report_date
                    and x.nlsb = a.nls
                    and x.kv = a.kv
                    and x.refl = a.ref)
                left outer join operw x
                on (a.REF = x.ref and
                    x.tag = 'D1#2D')
                left outer join operw y
                on (X.REF = y.ref and
                    y.tag = 'D1#2D')
                left outer join provodki_otc t1
                on (x.ref = t1.ref and
                    t1.fdat = a.report_date)
                left outer join fx_deal f
                on (f.refb=x.ref)
                left outer join NBUR_DM_CUSTOMERS c
                on (c.report_date = p_report_date and
                    c.kf = p_kod_filii and
                    f.rnk = c.cust_id)
                left outer join NBUR_DM_ACCOUNTS b
                on (b.report_date = p_report_date and
                    b.kf = p_kod_filii and
                    b.acc_id = t1.accd)
                where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                      and ((a.nls like '1919%' or
                            a.nls like '3739%' ) and
                            a.tt = 'NOS')
                      and nvl(t1.tt, '***') like 'FX%'
                      and decode(f.kva, 980, '30', '28')<>'30'
                      and substr(nvl(trim(y.value), trim(x.value)), 1, 2) in ('01','02','03','04','05','06','07','08')) z)
   UNPIVOT (VALUE FOR colname IN (p10, p20, p31, p40, P62, p64, p65, p67));

   commit;

   select nvl(to_number(ltrim(max(substr(field_code, 3, 3)), '0')), 0)
   into l_last_nnn
   from nbur_detail_protocols
   where report_date = p_report_date and
         kf = p_kod_filii and
         report_code = p_file_code;

   -- формування детального протоколу (частина 3)
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
           (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
           substr(colname,2,2)||nnn field_code,
           value field_value,
           'Part 3 refd='||to_char(refd) description,
           acc,
           nls,
           kv,
           null maturity_date,
           rnk,
           ref,
           refd nd,
           branch
    FROM (select z.report_date,
               z.kf,
               z.ref,
               z.rnk,
               z.acc,
               z.nls,
               z.kv,
               z.p10,
               z.p20,
               z.p31,
               z.p40,
               nvl(lpad(nvl(nvl(trim(translate(z.kod_g, '0123456789OPОП', '0123456789')),
                                substr(trim (z.D6#E2), 1, 70)),
                            f_get_swift_country(z.ref)), 3, '0'),
                   'код краiни у яку переказана валюта' ) p64,
               nvl(nvl(substr(trim (z.D7#E2), 1, 10),
                   f_get_swift_bank_code(z.ref)),
                   rpad(nvl(trim (z.D7#E2), z.kod_g), 10, '0')) p65,
              (case when z.p31 = '0' or z.p62 = '2' then '0' else z.p62 end) p62,
              lpad((dense_rank() over (order by z.rnk, z.ref)) + l_last_nnn, 3, '0') nnn,
              z.refd, z.p67, z.nbuc, z.branch
        from (select  /*+ parallel(4) leading(a) */
                    a.report_date,
                    a.kf,
                    a.ref,
                    a.tt,
                    nvl(t1.rnkd, a.rnk) rnk,
                    nvl(t1.accd, a.acc) acc,
                    nvl(t1.nlsd, a.nls) nls,
                    nvl(b.kv, a.kv) kv,
                    a.p10,
                    a.p20,
                    (case when C.CUST_TYPE = '1'
                        then l_ourGLB
                        else nvl(trim(c.cust_code), a.p31)
                    end) P31,
                    substr(nvl(trim(y.value), trim(z.value)), 1, 2) p40,
                    nvl(c.k030, a.p62) p62,
                    nvl(t.bankcountry, nvl(a.D6#E2, a.kod_g)) D6#E2,
                    a.D7#E2,
                    nvl(t.benefbank, a.D8#E2) D8#E2,
                    a.KOD_G,
                    a.NB,
                    a.NAZN,
                    a.p40 d1#E2,
                    x.ref refd, b.nbuc, b.branch,
                    nvl(C.CUST_NAME, a.nmk) p67
                from NBUR_TMP_TRANS_1 a
                left outer join oper x
                on (x.vdat between p_report_date - 7 and p_report_date
                    and x.nlsb = a.nls
                    and x.kv = a.kv
                    and x.refl = a.ref)
                left outer join operw z
                on (a.REF = z.ref and
                    z.tag = 'D1#2D')
                left outer join operw y
                on (X.REF = y.ref and
                    y.tag = 'D1#2D')
                left outer join provodki_otc t1
                on (x.ref = t1.ref)
                left outer join (select ref, pid,
                                        min(pid) id_min,
                                        max(id) id,
                                        count(*) cnt
                                 from contract_p
                                 group by ref, pid) p
                on (x.ref = p.ref)
                left outer join top_contracts t
                on (p.pid = t.pid)
                left outer join NBUR_DM_ACCOUNTS b
                on (b.report_date = p_report_date and
                    b.kf = p_kod_filii and
                    b.acc_id = t1.accd)
                left outer join NBUR_DM_CUSTOMERS c
                on (c.report_date = p_report_date and
                    c.kf = p_kod_filii and
                    c.cust_id = t1.rnkd)
                where nvl(nvl(a.d6#E2, a.kod_g), 'ZZZ') not in ('804','UKR')
                      and ((a.nls like '1919%' or
                            a.nls like '3739%' ) and
                            a.tt = 'NOS')
                      and nvl(t1.tt, '***') not like 'FX%'
                      and substr(nvl(trim(y.value), trim(z.value)), 1, 2) in ('01','02','03','04','05','06','07','08')) z)
    UNPIVOT (VALUE FOR colname IN (p10, p20, p31, p40, P62, p64, p65, p67));

    commit;

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
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii;

      -- вставка даних для функції довведення допреквізитів
      DELETE FROM OTCN_TRACE_70 WHERE kodf = l_file_code and datf = p_report_date and kf = p_kod_filii;

      insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
      select l_file_code, p_report_date, USER_ID, ACC_NUM, KV, p_report_date, FIELD_CODE, FIELD_VALUE, NBUC, null ISP,
             CUST_ID, ACC_ID, REF, DESCRIPTION, ND, MATURITY_DATE, BRANCH
      FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii;

    logger.info ('NBUR_P_F2D end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F2D.sql =========*** End **
PROMPT ===================================================================================== 
