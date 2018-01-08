

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FF1.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FF1 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FF1 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#F1')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #E2 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.001  17.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.001  17.08.2016';
/*
    Формат коду показника >  L DD R VVV MMM

    L    -    сума    [1]

    DD    -    може приймати значення:

    11 - здійснено переказів за межі України, що унесено/видано готівкою
    12 - здійснено переказів за межі України, що списано з рахунку/зараховано на рахунок
    41 - надходження переказів в Україну, що унесено/видано готівкою
    42- надходження переказів в Україну, що списано з рахунку/зараховано на рахунок

    R    -    код резидентності;

    VVV    -    код валюти

    MMM    -    код країни

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_file_id       number;
    l_fmt           varchar2(20):='999990D0000';
    l_gr_sum_840    number         := 100000; -- гранична сума
    l_kurs_840      number := F_NBUR_RET_KURS (840, p_report_date);
    l_ourOKPO       varchar2(20);
    l_ourGLB        varchar2(20);
    l_last_nnn      number := 0;
BEGIN
    logger.info ('NBUR_P_FF1 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    execute immediate 'truncate table NBUR_TMP_TRANS_1';

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    l_file_id := 17049;

    begin
        select max(decode(glb, 0, '0', lpad(to_char(glb), 3, '0')))
        into l_ourGLB
        from rcukru
        where mfo = p_kod_filii;
    exception
        when no_data_found then
            l_ourGLB := null;
    end;

    l_ourOKPO := lpad(F_Get_Params('OKPO',null), 8, '0');

   -- формування детального протоколу
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
   SELECT /*+ parallel(8) */
           report_date,
           kf,
           p_file_code,
           l_nbuc nbuc,
           '1'||
           (case when dd = '11' and substr(acc_num_db,1,2) in ('26', '29') THEN '12'
                 when dd = '11' and substr(acc_num_db,1,2) not in ('26', '29') THEN '11'
                 when dd = '41' and
                      (substr(acc_num_cr,1,3) like '262%' or
                       substr(acc_num_cr,1,4) in ('2900', '2924')) THEN '42'
                 else dd
           end)||
           rez||ckv||lpad(kod_g, 3, '0') field_code,
           to_char(bal) field_value,
           substr(trim('Резидентнiсть = '||rez||
                          ' док. = '||trim(pasp)||
                          ' N док. = '||trim(paspn)||
                          ' ким виданий '||trim(atr)) , 1 ,200) description,
           acc,
           nls,
           kv,
           null maturity_date,
           rnk,
           ref,
           NULL nd,
           null branch
    from (
        select a.*,
            (case when ((b.atr LIKE '%МВД%' OR b.atr LIKE '%МВС%') AND b.atr NOT LIKE '%РОС%') OR
                        b.atr LIKE '%УКРА%' OR
                        b.natio LIKE '%УКР%' OR
                        b.natio LIKE '%804%' OR
                        substr(nvl(b.paspn,b.pasp),1,1) in ('А','В','С','Е','?','I','К','М','О','Р','Т','Х')
                  then '1'
                  when ((b.atr LIKE '%МВД%' OR b.atr LIKE '%МВС%') AND b.atr LIKE '%РОС%') OR
                        not (b.atr LIKE '%МВД%' OR b.atr LIKE '%МВС%') OR
                        not (b.natio LIKE '%УКР%' OR b.natio LIKE '%804%')
                  then '2'
                  else c.k030
             end) rez,
             b.pasp, b.paspn,b.atr,
             nvl((case when d.country is not null
                    then d.country
                    else
                     (case when substr(nvl(nvl(trim(p.KOD_G), trim(P.D6#70)), trim(P.D6#E2)),1,1) in ('O','P','О','П') -- додати ще D1#E9 та F1
                           then substr(nvl(nvl(trim(p.KOD_G), trim(P.D6#70)), trim(P.D6#E2)), 2, 3)
                           else substr(nvl(nvl(trim(p.KOD_G), trim(P.D6#70)), trim(P.D6#E2)), 1, 3)
                     end)
                  end), '000') kod_g,
             lpad(to_char(a.kv),3,'0') ckv
        from (
            select /*+leading(r) */ unique t.*,
                (case when substr(t.acc_num_db,1,4) in ('1500','2620','2625','2902','2924') then t.cust_id_db
                      when substr(t.acc_num_cr,1,4) in ('1500','2620','2625','2902','2924') then t.cust_id_cr
                      when t.acc_num_db like '100%' then t.cust_id_cr
                      when t.acc_num_cr like '100%' then t.cust_id_db
                      else t.cust_id_db
                end) rnk,
                (case when substr(t.acc_num_db,1,3) in ('100', '262') or
                           substr(t.acc_num_db,1,4) in ('2900','2902','2924')
                      then t.acc_id_db
                      else t.acc_id_cr
                end) acc,
                (case when substr(t.acc_num_db,1,3) in ('100', '262') or
                           substr(t.acc_num_db,1,4) in ('2900','2902','2924')
                      then t.acc_num_db
                      else t.acc_num_cr
                end) nls,
                (case when R.PR_DEL = 2
                    then '11'
                    when R.PR_DEL = 3
                    then '41'
                    else '00'
                 end) dd
            from NBUR_DM_TRANSACTIONS t
            join NBUR_REF_SEL_TRANS r
            on (t.acc_num_db like r.acc_num_db||'%' and
                t.acc_num_cr like r.acc_num_cr||'%' and
                nvl(t.ob22_db, '00') = nvl(r.ob22_db, nvl(t.ob22_db, '00')) and
                nvl(t.ob22_cr, '00') = nvl(r.ob22_cr, nvl(t.ob22_cr, '00')) and
                t.tt = nvl(r.tt, t.tt) and
                t.kf = nvl(r.mfo, t.kf) and
                not nvl(r.pr_del, 0) = 1)
            join oper o
            on (t.ref = o.ref)
            left outer join (select w.ref,
                                   max((case when w.tag like '%REF%' then trim(w.value) else null end)) ref_m37,
                                   max((case when w.tag like '%REF%' or trim(w.value) is null then null
                                         else  to_date(substr(replace(replace(trim(w.value), ',','/'),
                                               '.','/'),1,10), 'dd/mm/yyyy')
                                       end))  dat_m37
                              from operw w
                              where (w.tag like 'D_REF%' or
                                     w.tag like 'REFT%' or
                                     w.tag like 'D_1PB%' or
                                     w.tag like 'DATT%')
                              group by w.ref) o1
            on (t.ref = o1.ref)
            where t.report_date = p_report_date and
                t.kf = p_kod_filii and
                t.kv <> 980 and
                r.file_id = l_file_id and
                not (t.acc_num_db LIKE '2909%' and t.acc_num_cr LIKE '2909%' and
                     (nvl(t.ob22_cr, '00') <> '24' or lower (o.nazn) like ('%перераховано%для продажу%'))) and
                not (t.acc_num_db like '2620%' and t.acc_num_cr like '2909%' and
                     t.tt like 'DP%' and lower (o.nazn) like ('%з рах%на рах%')) and
                not ((t.acc_num_db LIKE '2809%' OR t.acc_num_db like '2909%') and
                      t.acc_num_cr LIKE '100%' and t.tt in ('M37','MMV','CN3','CN4') and
                      (o1.ref_m37 is not null and o1.ref_m37 = t.ref or o1.dat_m37 is not null))) a
        join NBUR_DM_CUSTOMERS c
        on (a.rnk = c.cust_id)
        left outer join NBUR_DM_ADL_DOC_RPT_DTL p
        on (a.ref = p.ref)
        left outer join (select w.ref,
                               max((case when w.tag = 'ATRT' then upper(trim(w.value)) else null end))  atr,
                               max((case when w.tag = 'NATIO' then upper(trim(w.value)) else null end))  natio,
                               max((case when w.tag like '%PASP%' then substr(upper(trim(w.value)),1,20) else null end))  pasp,
                               max((case when w.tag = 'PASPN' then substr(upper(trim(w.value)),1,20) else null end))  paspn
                            from operw w
                            where (w.tag = 'ATRT' or
                                   w.tag = 'NATIO' or
                                   w.tag like '%PASP%')
                            group by w.ref) b
        on (a.ref = b.ref)
        left outer join (SELECT unique ref, '804' country
                         FROM OPERW
                         WHERE tag like '59%'
                          AND (substr(trim(value),1,3) = '/UA' or
                              instr(UPPER(trim(value)),'UKRAINE') > 0)
                         group by ref) d
        on (a.ref = d.ref)
    )
    where kod_g <> '804';
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
              sum(field_value)
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii
     group by report_date,
              kf,
              report_code,
              nbuc,
              field_code;

    logger.info ('NBUR_P_FF1 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FF1.sql =========*** End **
PROMPT ===================================================================================== 
