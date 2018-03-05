declare
  l_chk_stmt   clob;
  l_chk_id     number(38);
begin

  DBMS_LOB.CREATETEMPORARY( l_chk_stmt, FALSE, DBMS_LOB.CALL );

  begin

    l_chk_id := null;

    l_chk_stmt := q'[select t1.*
     , t2.*
     , t3.*
  from ( select NBUC, FIELD_CODE
              , DD, BBBB, VVV, R
              , to_number(FIELD_VALUE) as FLD_VAL
           from V_NBUR_#01
          where REPORT_DATE = to_date('04/07/2017','dd/mm/yyyy')
            and KF = sys_context('bars_context','user_mfo')
       ) t1
  full outer
  join ( select NBUC, FIELD_CODE
              , DD, BBBB, VVV, R
              , to_number(FIELD_VALUE) as FLD_VAL
           from V_NBUR_#01
          where REPORT_DATE = to_date('05/07/2017','dd/mm/yyyy')
            and KF = sys_context('bars_context','user_mfo')
       ) t2
    on ( t2.NBUC = t1.NBUC and t2.FIELD_CODE = t1.FIELD_CODE )
  full outer
  join ( select DD || R020 || lpad(R030,3,'0') || K030 as FIELD_CODE
              , DD, R020, R030, K030
              , sum( BAL_IN )
              , sum( BAL_OUT )
              , sum( DOS )
              , sum( KOS )
           from ( select decode( Sign(s.OSTF + s.KOS + s.DOS), 1, '2', '1' ) || decode( a.kv, 980, '0', '1' ) as DD
                       , a.nbs as R020
                       , a.kv  as R030
                       , decode( nvl(c.country,804), 804, '1', '2') as K030
                       , s.OSTF as BAL_IN
                       , ( s.OSTF + s.KOS + s.DOS ) as BAL_OUT
                       , s.DOS
                       , s.KOS
                    from ACCOUNTS a
                    join CUSTOMER c
                      on ( c.rnk = a.rnk )
                    join SALDOA s
                      on ( s.acc = a.acc and s.fdat = to_date('05/07/2017','dd/mm/yyyy') )
                   where a.KF = sys_context('bars_context','user_mfo')
                     and a.NBS is Not Null 
                )
          group by DD, R020, R030, K030
       ) t3
    on ( /*t3.NBUC = t1.NBUC and */t3.FIELD_CODE = t1.FIELD_CODE ) ]';

--  l_chk_stmt := l_chk_stmt || '';

    NBUR_FILES.SET_FILE_CHK
    ( p_chk_id   => l_chk_id
    , p_chk_dsc  => '#01 за попередню дату + обороти за звітну дату з SALDOA = #01 за звітну дату'
    , p_chk_ste  => 1
    , p_chk_stmt => l_chk_stmt
    , p_file_id  => NBUR_FILES.GET_FILE_ID('#01')
    );

    dbms_output.put_line( 'created chk with ID='||to_char(l_chk_id)||' for file #01' );

  end;

  DBMS_LOB.FREETEMPORARY( l_chk_stmt );

end;
/