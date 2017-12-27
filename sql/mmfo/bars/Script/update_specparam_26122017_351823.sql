-- замена параметра R011 на новые значения которые будут действовать
-- на  27.12.2017

SET LINES 1000
SET TRIMSPOOL ON
SET SERVEROUTPUT ON SIZE 1000000
SET FEED OFF

spool c:\upd_specparam_26122017_351823.log;

declare 
acco_   number;
r011_   varchar2(1);

begin
    for z in (select kf from mv_kf where kf = '351823')
    loop
        bc.subst_mfo(z.kf);

       dbms_output.put_line(' UPDATE_SPECPARAM R011=0 R013=0 '); 

       update specparam set r011 = '0', r013 = '0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '1001','1002','1005','1101','1102',
                                     '1200','1322','1328',
                                     '1590','1592','2400','2657','2902',
                                     '2903','2909','2924','3040','3117',
                                     '3190','3500','3510','3519','3522',
                                     '3550','3590','3600','3621','3641',
                                     '3739','6300','7030','7040','7399',
                                     '7700','7900','9521','9523','9610'
                                   )
                        and dazs is null
                    );
   
        commit;
        
        ---------------------------------------------------------------------
        -- R011='1', R013='0'

        -- 1500, 2071, 2401, 2520, 2560, 2610, 2630, 2638, 5000, 5030, 5040
        dbms_output.put_line(' UPDATE_SPECPARAM R011=1 R013=0 '); 

        for k in ( select acc from accounts 
                      where nbs in ( '1500','2071','2079','2209','2239',
                                     '2401','2520','2560','2610','2630',
                                     '2638','3660','3666','3668','5000',
                                     '5030','5040' 
                                   )
                        and dazs is null 
                    )

       loop
         
          update specparam set r011 = '1', r013='0' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011, r013 )
             VALUES
                (k.acc, '1', '0');
          END IF;

       end loop;

       commit;
       
      ----------------------------------------------------------------------
      -- R011='2', R013='0'

      -- 1608, 1613, 2513, 5041

      dbms_output.put_line(' UPDATE_SPECPARAM R011=2 R013=0 '); 

      for k in ( select acc from accounts 
                  where nbs in ( '1608','1613','2513','5041' 
                               )
                    and dazs is null 
                )
       loop
         
          update specparam set r011 = '2', r013='0' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011, r013 )
             VALUES
                (k.acc, '2', '0');
          END IF;

       end loop;

       commit;

      ----------------------------------------------------------------------
      -- R011='3', R013='0'

      -- 1623, 2066, 2069
      dbms_output.put_line(' UPDATE_SPECPARAM R011=3 R013=0 '); 

      for k in ( select acc from accounts 
                  where nbs in ( '1623', '2066', '2069', '9122' )
                    and dazs is null 
                )

       loop
          update specparam set r011 = '3', r013='0' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011, r013 )
             VALUES
                (k.acc, '3', '0');
          END IF;

       end loop;

       commit;

      ----------------------------------------------------------------------
      -- R011='1', R013='1'     

      --1207
       dbms_output.put_line(' UPDATE_SPECPARAM R011=1 R013=1 '); 

       for k in ( select acc from accounts 
                  where nbs in ( '1207' )
                    and dazs is null 
                )

       loop
         
          update specparam set r011 = '1', r013='3' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011, r013 )
             VALUES
                (k.acc, '1', '3');
          END IF;

       end loop;

       commit;
    ----------------------------------------------------------------------

    ----------------------------------------------------------------------
    -- 1410, 1420
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1410,1420 '); 
       update specparam set r011='D', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1410', '1420' )
                        and dazs is null
                    );
       commit;
        
    -- 1412
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1412 '); 
       update specparam set r011='4'
       where acc in ( select acc from accounts 
                      where nbs in ( '1412' )
                        and dazs is null
                    )   
         and r013='1';
       commit;
       
       update specparam set r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1412' )
                        and dazs is null
                    );
       commit;
       
    -- 1414
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1414 '); 
       update specparam set r011='A'
       where acc in ( select acc from accounts 
                      where nbs in ( '1414' )
                        and dazs is null
                    )   
         and r013='1';
       commit;
       
       update specparam set r011='B'
       where acc in ( select acc from accounts 
                      where nbs in ( '1414' )
                        and dazs is null
                    )   
         and r013='9';
       commit;
       
       update specparam set r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1414' )
                        and dazs is null
                    );

       commit;

    -- 1502, 1524
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1502,1524 '); 

       for k in ( select acc from accounts 
                  where nbs in ( '1502', '1524' )
                    and dazs is null
                )
       loop

          update specparam set r011 = '6', r013 ='0' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011, r013 )
             VALUES
                (k.acc, '6', '0');
          END IF;

       end loop;

       commit;


    -- 1508
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1508 '); 
       update specparam set r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '1508' )
                        and nlsalt not like '1509%'
                        and dazs is null
                    )   
         and r013='3';
       commit;
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '1508' )
                        and nlsalt not like '1509%'
                        and dazs is null
                    )   
         and r013='4';
       commit;
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '1508' )
                        and nlsalt like '1509%'
                        and dazs is null
                    );   
       commit;

    -- 1518
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1518 '); 
       update specparam set r011='1', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '1518' )
                        and nlsalt not like '1519%'
                        and dazs is null
                    )   
         and r013='5';
       commit;
       
       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '1518' )
                        and nlsalt like '1519%'
                        and dazs is null
                    );   
       commit;
       
    -- 1528
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1528 '); 
       update specparam set r011='6', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '1528' )
                        and nlsalt not like '1529%'
                        and dazs is null
                    );
       commit;
       
       update specparam set r011='6', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '1528' )
                        and nlsalt like '1529%'
                        and dazs is null
                    );
       commit;

    -- 1600
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1600 '); 
       update specparam set r011='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '1600' )
                        and dazs is null
                    )   
         and r013='9';
       commit;
       
       update specparam set r011='1'
       where acc in ( select acc from accounts 
                      where nbs in ( '1600' )
                        and dazs is null
                    )   
         and r013='1';
       commit;
       
       update specparam set r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1600' )
                        and dazs is null 
                    );   
       commit;
       
    -- 1608
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1608 '); 
       update specparam set r011='2', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1608' )
                        and dazs is null
                    );
       commit;
       
    -- 1618
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1618 '); 
       update specparam set r011='2', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1618' )
                        and dazs is null
                    );
       commit;

    -- 1626
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1626 '); 
       update specparam set r011='3', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1626' )
                        and dazs is null
                    )   
         and r013='2';
       commit;

    -- блок по заполнению R011 для счетов процентов
    -- по значениям R011 основного счета
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1628 '); 

        for k in ( select a.acc, s.r011 
                    from accounts a, specparam s 
                    where a.nbs in ( '1628' )
                      and s.acc = a.acc 
                  )

        loop

           BEGIN
            SELECT max(i.acc), max(s1.r011)
              INTO acco_, r011_
              FROM int_accn i, specparam s1
             WHERE i.acra = k.acc
               AND i.ID = 0
               AND s1.acc = i.acc;
           EXCEPTION WHEN NO_DATA_FOUND THEN
               r011_ := null;
           END;

           if r011_ is not null
           then
              update specparam s2 set s2.r011 = r011_
              where s2.acc = k.acc;
           end if;

        end loop;

        commit;


    -- 1811
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1811, 1819 '); 
       update specparam set r011='2', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1811' )
                        and dazs is null
                    )   
         and r013='2';
       commit;
       
    -- 1819
       update specparam set r011='4', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '1819' )
                        and dazs is null
                    )   
         and r013='2';
        commit;

    -- 2063
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2063 ');  
       update specparam set r011='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2063' )
                        and dazs is null
                    )   
         and r013='2';
       commit;
       
       update specparam set r011='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2063' )
                        and dazs is null
                    )   
         and r013<>'2';
       commit;
       
       update specparam set r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2063' )
                        and dazs is null
                    );   
       commit;
       
    -- 2068
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2068 '); 
       update specparam set r011='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2068' )
                        and dazs is null
                    );
       commit;
       
       update specparam set r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2068' )
                        and nlsalt not like '2069%'
                        and dazs is null
                    )
         and r013='3';
       commit;
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2068' )
                        and nlsalt not like '2069%'
                        and dazs is null
                    )
         and r013='4';
       commit;
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2068' )
                        and nlsalt like '2069%'
                        and dazs is null
                    );
       commit;

    -- 2078
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2078 '); 
       update specparam set r011='1', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2078' )
                        and nlsalt not like '2079%'
                        and dazs is null
                     )   
         and r013='3';
       commit;
       
       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2078' )
                        and nlsalt not like '2079%'
                        and dazs is null
                     )   
         and r013='4';
       commit;
       
       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2078' )
                        and nlsalt like '2079%'
                        and dazs is null
                    );   
       commit;

    -- 2083
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2083 '); 
       update specparam set r011='2', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2083' )
                        and dazs is null
                    );
       commit;
       
    -- 2088
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2088 '); 
       update specparam set r011='2', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2088' )
                        and nlsalt not like '2089%'
                        and dazs is null 
                    )   
         and r011='8';
       commit;
       
       update specparam set r011='2', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2088' )
                        and nlsalt not like '2089%'
                        and dazs is null
                    )   
         and r013='7';
       commit;
       
       update specparam set r011='2', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2088' )
                        and nlsalt like '2089%'
                        and dazs is null 
                    );   
       commit;

    -- 2089
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2089 '); 
       update specparam set r011='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2089' )
                        and dazs is null 
                    );
       commit;

    -- 2103
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 210X '); 
       update specparam set r011='3', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2103' )
                        and dazs is null
                    );
       commit;
       
    -- 2108
       update specparam set r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2108' )
                        and nlsalt not like '2109%'
                        and dazs is null
                    )   
         and r013 = '9';
       commit;
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2108' )
                        and nlsalt not like '2109%'
                        and dazs is null
                    )   
         and r013 = 'A';
       commit;
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2108' )
                        and nlsalt like '2109%'
                        and dazs is null
                    );
       commit;

    -- 2203, 2206
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 220X '); 
       update specparam set r011='1', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2203', '2206' )
                        and dazs is null
                    );
       commit;
       
    -- 2208
       update specparam set r011='1', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2208' )
                        and nlsalt not like '2209%'
                        and dazs is null
                    )
         and r013='3';
       commit;
       
       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2208' )
                        and nlsalt not like '2209%'
                        and dazs is null
                    )
         and r013='4';
       commit;
       
       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2208' )
                        and nlsalt like '2209%'
                        and dazs is null
                    );
       commit;

    -- 2233, 2236
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 223X '); 
       update specparam set r011='3', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2233', '2236' )
                        and nlsalt not like '2237%'
                        and dazs is null
                    )   
         and r013='9';
       commit;

       update specparam set r011='1', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2233', '2236' )
                        and nlsalt not like '2237%'
                        and dazs is null
                    )   
         and r013='1';
       commit;

       update specparam set r011='2', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2233' )
                        and nlsalt not like '2237%'
                        and dazs is null
                    )   
         and r013='2';
       commit;

       update specparam set r011='1', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2233' )
                        and nlsalt like '2237%'
                        and dazs is null
                    );   
       commit;

    -- 2238
       update specparam set r011='1', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2238' )
                        and nlsalt not like '2239%'
                        and dazs is null
                    )
         and r013 in ('3','8');
       commit;

       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2238' )
                        and nlsalt not like '2239%'
                        and dazs is null
                    )
         and r013 in ('4','9');
       commit;

       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2238' )
                        and nlsalt like '2239%'
                        and dazs is null
                    );
       commit;

    -- 2560
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2560 '); 
       update specparam set r011='1', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2560' )
                        and dazs is null
                    )   
         and r013='2';
       commit;

    -- 2600
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 260X '); 
       update specparam set r011='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2600' )
                        and dazs is null
                    )   
         and r011 in ('1','2');
       commit;

       update specparam set r011='1'
       where acc in ( select acc from accounts 
                      where nbs in ( '2600' )
                        and dazs is null
                    )   
         and r011 in ('6','9');
       commit;

       update specparam set r013='9'
       where acc in ( select acc from accounts 
                      where nbs in ( '2600' )
                        and dazs is null
                    )   
         and r013 not in ('A');
       commit;

       update specparam set r013='1'
       where acc in ( select acc from accounts 
                      where nbs in ( '2600' )
                        and dazs is null
                    )   
         and r013 in ('A');
       commit;

    -- 2602
       update specparam set r011='6'
       where acc in ( select acc from accounts 
                      where nbs in ( '2602' )
                        and dazs is null
                    )   
         and r011='1';
       commit;

       update specparam set r011='7'
       where acc in ( select acc from accounts 
                      where nbs in ( '2602' )
                        and dazs is null
                    )   
         and r011='2';
       commit;

       update specparam set r013='9'
       where acc in ( select acc from accounts 
                      where nbs in ( '2602' )
                        and dazs is null
                    )   
         and r013='6';
       commit;

    -- 2603
       update specparam set r011='8'
       where acc in ( select acc from accounts 
                      where nbs in ( '2603' )
                        and dazs is null
                    );
       commit;

    -- 2604
       update specparam set r011='9', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2604' )
                        and dazs is null
                    );
       commit;

    -- 2605
       update specparam set r011='A', r013='9'
       where acc in ( select acc from accounts 
                      where nbs in ( '2605' )
                        and dazs is null
                     )   
         and r013<>'3';
       commit;

       update specparam set r011='3', r013='1'
       where acc in ( select acc from accounts 
                      where nbs in ( '2605' )
                        and dazs is null
                     )   
         and r013='3';
       commit;

    -- 2607
       update specparam set r011='0', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2607' )
                        and dazs is null
                     )   
         and r013='3';
       commit;

    -- 2708
    -- блок по заполнению R011 для счетов процентов
    -- по значениям R011 основного счета
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 270X '); 

        for k in ( select a.acc 
                    from accounts a  
                    where a.nbs in ( '2708' )
                      and a.dazs is null
                  )
        loop

           BEGIN
            SELECT max(i.acc), max(s1.r011)
               INTO acco_, r011_
             FROM int_accn i, specparam s1
             WHERE i.acra = k.acc
               AND i.ID = 1
               AND s1.acc = i.acc;
           EXCEPTION WHEN NO_DATA_FOUND THEN
               r011_ := null;
           END;

           if r011_ is not null
           then
              update specparam s2 set s2.r011 = r011_
              where s2.acc = k.acc;
           end if;
           
           commit;
        end loop;

    -- 2608
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2608 '); 
       update specparam set r011 = '1', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2608' )
                        and dazs is null
                    )
         and R011 in ('6','9');
       commit;

       update specparam set r011 = '8', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2608' )
                        and dazs is null
                    )
         and R011='4';
       commit;

       update specparam set r011 = '9', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2608' )
                        and dazs is null
                    )
         and R011='5';
       commit;

       update specparam set r011 = '7', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2608' )
                        and dazs is null
                    )
         and R011='3';
       commit;

    -- 2618
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2618 '); 
       update specparam set r011 = '1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2618' )
                        and dazs is null
                    )
         and R011='6';
       commit;

    -- 2620
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2620 '); 
       update specparam set r011 = '3' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2620' )
                        and dazs is null
                    )
         and r011 in ('1','2');
       commit;

       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2620' )
                        and dazs is null
                    )
         and r011='4';
       commit;

       update specparam set r011 = '1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2620' )
                        and dazs is null
                    )
         and r011='9';
       commit;

       update specparam set r013 = '9' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2620' )
                        and dazs is null
                    )
         and R013<>'3';
       commit;

       update specparam set r013 = '1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2620' )
                        and dazs is null
                    )
         and R013='3';
       commit;

    -- 2622, 2651, 9129
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2622 '); 

       for k in ( select acc from accounts 
                  where nbs in ( '2622','2651','9129' )
                    and dazs is null
                )

       loop

          update specparam set r011 = '4' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011 )
             VALUES
                (k.acc, '4');
          END IF;
          
          commit;

       end loop;

       update specparam set r013 = '0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2651' )
                        and dazs is null
                    );
       commit;  

    -- 2625
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2625 '); 
       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2625' )
                        and dazs is null
                    )
         and r011='1';
       commit;

       update specparam set r011 = '1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2625' )
                        and dazs is null
                    )
         and R011 in ('9');
       commit;

       update specparam set r013 = '9' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2625' )
                        and dazs is null
                    )
         and r013='1';
       commit;

       update specparam set r013 = '1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2625' )
                        and dazs is null
                    )
         and r013='2';
       commit;

    -- 2627
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2627 '); 
       update specparam set r011 = '0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2627' )
                        and dazs is null
                    );
       commit;

       update specparam set r013 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2627' )
                        and dazs is null
                    )
         and R013 is null;
       commit;

       update specparam set r013 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2627' )
                        and dazs is null
                    )
         and R013='3';
       commit;

    -- 2628
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2628 '); 
       update specparam set r011 = '1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2628 ' )
                        and dazs is null
                    )
         and R011 in ('4');
       commit;

       update specparam set r011 = '4' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2628 ' )
                        and dazs is null
                    )
         and R011 in ('3');
       commit;

       update specparam set r011 = '3' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2628 ' )
                        and dazs is null
                    )
         and R011 in ('5','6');
       commit;

       update specparam set r013 = '0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2628' )
                        and dazs is null
                    );
       commit;

    -- 2650
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 265X '); 
       update specparam set r011 = '3' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2650 ' )
                        and dazs is null
                    )
         and R011 in ('1','2');
       commit;

       update specparam set r011 = '1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2650 ' )
                        and dazs is null
                    )
         and R011 not in ('3');
       commit;

       update specparam set r013 = '9' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2650 ' )
                        and dazs is null
                    )
         and R013 not in ('1');
       commit;

    -- 2655
       update specparam set r011 = '3', r013='1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2655 ' )
                        and dazs is null
                    )
         and R013='3';
       commit;

       update specparam set r011 = '1', r013='9' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2655 ' )
                        and dazs is null
                    )
         and R013<>'3';
       commit;

    -- 2658
       update specparam set r011 = '4', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2658 ' )
                        and dazs is null
                    )
         and R011='5';
       commit;

       update specparam set r011 = '1', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2658 ' )
                        and dazs is null
                    )
         and R011<>'4';
       commit;

    -- 2701 
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 270X ');
       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2701' )
                        and dazs is null
                    )
         and R013='2';
       commit;

       update specparam set r013 = '0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2701' )
                        and dazs is null
                    );
       commit;

    -- 2706 
       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2706' )
                        and dazs is null
                    )
         and R013='2';
       commit;

       update specparam set r013 = '0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2706' )
                        and dazs is null
                    );
       commit;

    -- 2801 
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 280X ');
       update specparam set r011 = '3', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2801' )
                        and dazs is null
                    );
       commit;

    -- 2809 
       update specparam set r011 = '6', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2809' )
                        and dazs is null
                    );
       commit;

    -- 3041, 3043
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 304X ');
       update specparam set r011 = '2', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3041','3043' )
                        and dazs is null
                    )
         and R013='2';
       commit;

    -- 3102
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 310X ');
       update specparam set r011 = '1', r013='V' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3102' )
                        and dazs is null
                    );
       commit;

    -- 3103
       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3103' )
                        and dazs is null
                    )
         and R013='1';
       commit;

    -- 3105
       update specparam set r011 = '6' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3105' )
                        and dazs is null
                    )
         and R013='1';
       commit;

       update specparam set r011 = '7' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3105' )
                        and dazs is null
                    )
         and R013='2';
       commit;

    -- 3110
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 311X ');
       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3110' )
                        and dazs is null
                    );
       commit;

-- 3113
--   update specparam set r011 = 'A' 
--   where acc in ( select acc from accounts 
--                  where nbs in ( '3113' )
--                    and dazs is null
--                )
--     and R013='1';

-- 3114
--   update specparam set r011 = 'L' 
--   where acc in ( select acc from accounts 
--                  where nbs in ( '3114' )
--                    and dazs is null
--                )
--     and R013='9';

--   update specparam set r011 = 'K' 
--   where acc in ( select acc from accounts 
--                  where nbs in ( '3114' )
--                    and dazs is null
--                )
--     and R013='1';

       -- 3540
       dbms_output.put_line(' UPDATE_SPECPARAM NBS = 354X ');
       update specparam set r011 = '2', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3540' )
                        and dazs is null
                    )
         and R013 in ('4','5');
       commit;

       update specparam set r011 = '3', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3540' )
                        and dazs is null
                    )
         and R013='6';
       commit;

    -- 3541
       update specparam set r011 = '4' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3541' )
                        and dazs is null
                    )
         and r011='2' and r013='2';
       commit;

       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3541' )
                        and dazs is null
                    )
         and r011='1' and r013='2';
       commit;

       update specparam set r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3541' )
                        and dazs is null
                    );
       commit;

    -- 3548
       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3548' )
                        and dazs is null
                    )
         and r011='3';
       commit;

       update specparam set r011 = 'A' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3548' )
                        and dazs is null
                    )
         and r011='9';
       commit;

       update specparam set r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3548' )
                        and dazs is null
                    );
       commit;

    -- 3570, 3578
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 357X ');
       update specparam set r011 = '1', r013='2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3570', '3578' )
                        and nlsalt not like '3579%'
                        and dazs is null
                    );
       commit;

       update specparam set r011 = '1', r013='3' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3570', '3578' )
                        and nlsalt like '3579%'
                        and dazs is null
                    );
       commit;

    -- 3599
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 3599 ');
       update specparam set r013 = '3' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3599' )
                        and dazs is null
                    )
         and r013='5';
       commit;

       update specparam set r013 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3599' )
                        and dazs is null
                    )
         and r013='4';
       commit;

       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3599' )
                        and dazs is null
                    );
       commit;

    -- 3640
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 364X ');
       update specparam set r011 = '6' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3640' )
                        and dazs is null
                    )
         and r013='6';
       commit;

       update specparam set r011 = '4' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3640' )
                        and dazs is null
                    )
         and r013='4';
       commit;

       update specparam set r011 = '5' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3640' )
                        and dazs is null
                    )
         and r013='5';
       commit;

       update specparam set r013 = '0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3640' )
                        and dazs is null
                    );
       commit;

    -- 4203
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 4203 ');
       update specparam set r011 = '2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '4203' )
                        and dazs is null
                    );
       commit;

-- 5004
dbms_output.put_line(' UPDATE_SPECPARAM NBS = 5XXX ');

   for k in ( select acc from accounts 
              where nbs in ( '5004' )
                and dazs is null
            )

       loop

          update specparam set r011 = '3' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011 )
             VALUES
                (k.acc, '3');
          END IF;
    
          commit;

       end loop;

       commit;


-- 5021

       for k in ( select acc from accounts 
                  where nbs in ( '5021' )
                    and dazs is null
                )

       loop

          update specparam set r011 = '2', r013='0' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011, r013 )
             VALUES
                (k.acc, '6', '0');
          END IF;
    
          commit;

       end loop;

       commit;

-- 5100   R011='1'

       for k in ( select acc from accounts 
                  where nbs in ( '5100' )
                    and dazs is null
                )

       loop

          update specparam set r011 = '1' 
          where acc = k.acc;

          IF SQL%ROWCOUNT = 0 
          THEN
             insert into specparam 
                (acc, r011 )
             VALUES
                (k.acc, '1');
          END IF;
    
          commit;

       end loop;

       commit;


    -- 9000
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 9XXX ');
       update specparam set r011 = '2', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs = '9000'
                        and dazs is null
                    )
         and r013='2';
       commit;

    -- 9031
       update specparam set r011 = '0' 
       where acc in ( select acc from accounts 
                      where nbs = '9031'
                        and dazs is null
                    );
       commit;

    -- 9100
       update specparam set r011 = '2', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs = '9100'
                        and dazs is null
                    )
         and r013='2';
       commit;

   end loop;
end;
/

spool off;
