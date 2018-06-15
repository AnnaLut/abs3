prompt *** Create procedure NBUR_F01X ***

create or replace procedure NBUR_F01X
( p_rpt_dt      in     date
, p_kf          in     varchar2
, p_scheme      in     varchar2 default 'C'
) is
  /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % DESCRIPTION : Процедура формирования 01X для НБУ
  % COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
  %
  % VERSION     : v.1  29.03.2018
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  l_file_code     varchar2(2) := '01';
BEGIN

  bars_audit.info( $$PLSQL_UNIT||' begin for date = '||to_char(p_rpt_dt,'dd.mm.yyyy') );

--insert /*+ APPEND */
--  into NBUR_DETAIL_PROTOCOLS
--     ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE
--     , ACC_ID, ACC_NUM, KV, MATURITY_DATE, BRANCH, CUST_ID )
--values
--     ( p_report_date, p_kod_filii, p_file_code
--     ,
--
---- T020:1,R020:2600,R030:008,K040:004
--select /*+ ORDERED FULL( a ) FULL( c ) FULL( b ) USE_HASH( b ) */
--       case when b.OST < 0 then 1 else 2 end as T020
--     , t.R020
--     , t.I010
--     , a.R030
--     , c.K040
--     , b.OST  as T071
--     , b.OSTQ as T070
--     , a.NBUC as KU
--     , a.ACC_ID
--     , a.ACC_NUM
--     , a.KV
--     , a.MATURITY_DATE
--     , a.BRANCH
--     , c.CUST_ID
--  from ( select /*+ MATERIALIZE */ t2.R020, t2.I010
--           from ( select R020
--                    from KOD_R020
--                   where A010 = '01'
--                     and PREM = 'КБ'
--                     and D_OPEN <= :p_datz
--                     and lnnvl( D_CLOSE <= :p_datz )
--                ) t1
--           join ( select R020, I010
--                    from KL_R020
--                   where PREM = 'КБ'
--                     and D_OPEN <= :p_datz
--                     and lnnvl( D_CLOSE <= :p_datz )
--                ) t2
--             on ( t2.R020 = t1.R020 )
--       ) t
--  join NBUR_DM_ACCOUNTS a
--    on ( a.KF = :p_kod_filii and a.NBS = t.R020 )
--  join NBUR_DM_CUSTOMERS c
--    on ( c.KF = a.KF and c.CUST_ID = a.CUST_ID )
--  join NBUR_DM_BALANCES_DAILY b
--    on ( b.KF = a.KF and b.ACC_ID = a.ACC_ID )
-- where b.OSTQ != 0;
--
--commit;

  bars_audit.info( $$PLSQL_UNIT||' end for date = '||to_char(p_rpt_dt, 'dd.mm.yyyy') );

end NBUR_F01X;
/

show errors;

grant EXECUTE on NBUR_F01X to BARS_ACCESS_DEFROLE;
