

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_PREPARE_TURNS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_PREPARE_TURNS ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_PREPARE_TURNS (p_kod_filii        varchar2,
                                                     p_report_date      date)
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ������������ ��������� ������� ��� ���� ����� �������
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.01.002  18.12.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.01.002  18.12.2017';
/*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
BEGIN
    logger.info ('NBUR_PREPARE_TURNS begin for date = '||to_char(p_report_date, 'dd.mm.yyyy') || ' KF=' || p_kod_filii);
    
    delete from NBUR_KOR_BALANCES where report_date = p_report_date and kf = p_kod_filii;

    insert into NBUR_KOR_BALANCES(REPORT_DATE, KF, CUST_ID, ACC_ID, ACC_NUM, KV, ACC_OB22, 
        ACC_TYPE, DOS_BAL, DOSQ_BAL, KOS_BAL, KOSQ_BAL, OST_BAL, OSTQ_BAL, 
        DOS_REPD, DOSQ_REPD, KOS_REPD, KOSQ_REPD, 
        DOS_REPM, DOSQ_REPM, KOS_REPM, KOSQ_REPM, 
        OST_REP, OSTQ_REP)
    select fdat REPORT_DATE, KF, rnk CUST_ID, acc ACC_ID, nls ACC_NUM, KV, ob22 ACC_OB22, 
        ACC_TYPE, DOS_BAL, DOSQ_BAL, KOS_BAL, KOSQ_BAL, OST_BAL, OSTQ_BAL, 
        DOS_REPD, DOSQ_REPD, KOS_REPD, KOSQ_REPD, 
        DOS_REPM, DOSQ_REPM, KOS_REPM, KOSQ_REPM,
        OST_REP, OSTQ_REP
    from (
    with temp_sel as     
    (select p_report_date fdat, a.kf, a.rnk, a.acc, a.nls, a.kv, a.ob22, 
        s.dos, s.dosq, s.kos, s.kosq,
        s.ost, s.ostq, A.NLSALT, T2017.OB22_old (NBS, OB22, SUBSTR (nlsalt, 1, 4)) ob22alt,
        s.ost + s.dos - s.kos ostf, s.ostq + s.dosq - s.kosq ostqf, sign(s.ost + s.dos - s.kos) sgn
    from accounts a
    left outer join snap_balances s
    on (a.acc = s.acc and
        s.fdat = p_report_date)
    where a.kf = p_kod_filii and
          a.dat_alt is not null and
          a.dat_alt = p_report_date)
    select 'OLD' ACC_TYPE, t.fdat, t.kf, t.rnk, t.acc, t.nlsalt nls, t.kv, t.ob22alt ob22, 
       t.dos dos_bal, t.dosq dosq_bal, t.kos kos_bal, t.kosq kosq_bal, 
       t.ost ost_bal, t.ostq ostq_bal, 0 ost_rep, 0 ostq_rep,  
       decode(sgn, 1, t.ostf, 0) dos_repd, decode(sgn, 1, t.ostqf, 0) dosq_repd, 
       decode(sgn, -1, -t.ostf, 0) kos_repd, decode(sgn, -1, -t.ostqf, 0) kosq_repd,
       sum(s.dos) + decode(sgn, 1, t.ostf, 0) dos_repm, 
       sum(s.dosq) + decode(sgn, 1, t.ostqf, 0) dosq_repm, 
       sum(s.kos) + decode(sgn, -1, -t.ostf, 0) kos_repm, 
       sum(s.kosq) + decode(sgn, -1, -t.ostqf, 0) kosq_repm
    from temp_sel t, snap_balances s
    where t.acc = s.acc and
        s.fdat = p_report_date
        --any(select fdat from fdat where fdat between trunc(p_report_date, 'mm') and p_report_date) 
    group by t.fdat, t.kf, t.rnk, t.acc, t.nlsalt, t.kv, t.ob22alt, t.dos, t.dosq, t.kos, t.kosq,
       t.ost, t.ostq,  decode(sgn, 1, t.ostf, 0), decode(sgn, 1, t.ostqf, 0), 
       decode(sgn, -1, -t.ostf, 0), decode(sgn, -1, -t.ostqf, 0)  
    union all
    select 'NEW' ACC_TYPE, t.fdat, t.kf, t.rnk, t.acc, t.nls, t.kv, t.ob22, 
       0 dos_bal, 0 dosq_bal, 0 kos_bal, 0 kosq_bal, 
       0 ost_bal, 0 ostq_bal, t.ost ost_rep, t.ostq ostq_rep,  
       t.dos + decode(sgn, -1, -t.ostf, 0) dos_repd, t.dosq + decode(sgn, -1, -t.ostqf, 0) dosq_repd, 
       t.kos + decode(sgn, 1, t.ostf, 0) kos_repd, t.kosq + decode(sgn, 1, t.ostqf, 0) kosq_repd,
       decode(sgn, -1, -t.ostf, 0) dos_repm, decode(sgn, -1, -t.ostqf, 0) dosq_repm, 
       decode(sgn, 1, t.ostf, 0) kos_repm, decode(sgn, 1, t.ostqf, 0) kosq_repm
    from temp_sel t);    
    
    commit;
      
    logger.info ('NBUR_PREPARE_TURNS end for date = '||to_char(p_report_date, 'dd.mm.yyyy') || ' KF=' || p_kod_filii);

END NBUR_PREPARE_TURNS;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_PREPARE_TURNS.sql =========**
PROMPT ===================================================================================== 