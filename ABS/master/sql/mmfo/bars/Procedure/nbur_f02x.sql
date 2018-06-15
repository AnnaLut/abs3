prompt *** Create procedure NBUR_F02X ***

create or replace procedure NBUR_F02X
( p_rpt_dt      in     date
, p_kf          in     varchar2
, p_scheme      in     varchar2 default 'C'
) is
  /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % DESCRIPTION : Процедура формирования 02X для НБУ
  % COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
  %
  % VERSION     : v.2  18.04.2018
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  e_ptsn_not_exsts      exception; -- Specified partition does not exist
  pragma exception_init( e_ptsn_not_exsts, -02149 );
  -- ORA-14092: number of expressions is not equal to the number of partitioning columns
BEGIN

  bars_audit.info( $$PLSQL_UNIT||' begin for date = '||to_char(p_rpt_dt,'dd.mm.yyyy') );

  begin
    execute immediate 'alter table NBUR_LOG_F02X truncate subpartition for ( to_date('''||
                      to_char(p_rpt_dt,'YYYYMMDD')||''',''YYYYMMDD''),'''||p_kf||''' )';
  exception
    when e_ptsn_not_exsts
    then null;
  end;

  insert all /*+ APPEND */
    when ( ADJ_BAL < 0 )
    then -- Актив (дебетовий залишок)
      into NBUR_LOG_F02X
        ( REPORT_DATE, KF, EKP, KU, R020, T020, R030, K040, T070, T071, ACC_ID )
      values
        ( p_rpt_dt, p_kf, EKP, KU, R020, 1, R030, K040, abs(ADJ_BAL_UAH), abs(ADJ_BAL), ACC_ID )
    when ( ADJ_BAL > 0 )
    then -- Пасив (кредитовий залишок)
      into NBUR_LOG_F02X
        ( REPORT_DATE, KF, EKP, KU, R020, T020, R030, K040, T070, T071, ACC_ID )
      values
        ( p_rpt_dt, p_kf, EKP, KU, R020, 2, R030, K040, ADJ_BAL_UAH, ADJ_BAL, ACC_ID )
    when ( DOS > 0 )
    then -- Дебетовi обороти
      into NBUR_LOG_F02X
        ( REPORT_DATE, KF, EKP, KU, R020, T020, R030, K040, T070, T071, ACC_ID )
      values
        ( p_rpt_dt, p_kf, EKP, KU, R020, 5, R030, K040, DOSQ, DOS, ACC_ID )
    when ( KOS > 0 )
    then -- Кредитовi обороти
      into NBUR_LOG_F02X
        ( REPORT_DATE, KF, EKP, KU, R020, T020, R030, K040, T070, T071, ACC_ID )
      values
        ( p_rpt_dt, p_kf, EKP, KU, R020, 6, R030, K040, KOSQ, KOS, ACC_ID )
    when ( CRDOS > 0 )
    then -- Дебетовi обороти по коригуючих мiсячних
      into NBUR_LOG_F02X
        ( REPORT_DATE, KF, EKP, KU, R020, T020, R030, K040, T070, T071, ACC_ID )
      values
        ( p_rpt_dt, p_kf, EKP, KU, R020, 7, R030, K040, CRDOSQ, CRDOS, ACC_ID )
    when ( CRKOS > 0 )
    then -- Кредитовi обороти по коригуючих мiсячних
      into NBUR_LOG_F02X
        ( REPORT_DATE, KF, EKP, KU, R020, T020, R030, K040, T070, T071, ACC_ID )
      values
        ( p_rpt_dt, p_kf, EKP, KU, R020, 8, R030, K040, CRKOSQ, CRKOS, ACC_ID )
    when ( YR_DOS > 0 )
    then -- Дебетовi обороти по коригуючих рiчних
      into NBUR_LOG_F02X
        ( REPORT_DATE, KF, EKP, KU, R020, T020, R030, K040, T070, T071, ACC_ID )
      values
        ( p_rpt_dt, p_kf, EKP, KU, R020, 9, R030, K040, YR_DOS_UAH, YR_DOS, ACC_ID )
    when ( YR_KOS > 0 )
    then -- Кредитовi обороти по коригуючих рiчних
      into NBUR_LOG_F02X
        ( REPORT_DATE, KF, EKP, KU, R020, T020, R030, K040, T070, T071, ACC_ID )
      values
        ( p_rpt_dt, p_kf, EKP, KU, R020, 0, R030, K040, YR_KOS_UAH, YR_KOS, ACC_ID )
   select /*+ ORDERED FULL( a ) FULL( c ) FULL( b ) USE_HASH( b ) */
          'A02'||t.I010||'0' as EKP
        , a.NBUC as KU
        , t.R020
        , a.R030
        , a.ACC_ID
        , c.K040
        , b.ADJ_BAL_UAH
        , b.ADJ_BAL
        , b.DOSQ - b.CUDOSQ as DOSQ
        , b.DOS  - b.CUDOS  as DOS
        , b.KOSQ - b.CUKOSQ as KOSQ
        , b.KOS  - b.CUKOS  as KOS
        , b.CRDOSQ
        , b.CRDOS
        , b.CRKOSQ
        , b.CRKOS
        , b.YR_DOS_UAH
        , b.YR_DOS
        , b.YR_KOS_UAH
        , b.YR_KOS
     from ( select /*+ MATERIALIZE */ t2.R020, t2.I010
              from ( select R020
                       from KOD_R020
                      where A010 = '02'
                        and PREM = 'КБ'
                        and D_OPEN <= p_rpt_dt
                        and lnnvl( D_CLOSE <= p_rpt_dt )
                   ) t1
              join ( select R020, I010
                       from KL_R020
                      where PREM = 'КБ'
                        and D_OPEN <= p_rpt_dt
                        and lnnvl( D_CLOSE <= p_rpt_dt )
                   ) t2
                on ( t2.R020 = t1.R020 )
          ) t
     join NBUR_DM_ACCOUNTS a
       on ( a.KF = p_kf and a.NBS = t.R020 )
     join NBUR_DM_CUSTOMERS c
       on ( c.KF = a.KF and c.CUST_ID = a.CUST_ID )
     join NBUR_DM_BALANCES_MONTHLY b
       on ( b.KF = a.KF and b.ACC_ID = a.ACC_ID )
  ;

  bars_audit.info( $$PLSQL_UNIT||': '||to_char(sql%rowcount)||' inserted.' );

  commit;

  bars_audit.info( $$PLSQL_UNIT||' end for date = '||to_char(p_rpt_dt, 'dd.mm.yyyy') );

end NBUR_F02X;
/

show errors;

grant EXECUTE on NBUR_F02X to BARS_ACCESS_DEFROLE;
