-- замена параметра R011 на новые значения которые будут действовать
-- на  27.12.2017

SET LINES 1000
SET TRIMSPOOL ON
SET SERVEROUTPUT ON SIZE 1000000
SET FEED OFF

spool c:\upd_specparam_26122017.log;

declare 
acco_   number;
r011_   varchar2(1);

begin
    for z in (select kf from mv_kf)
    loop
        bc.subst_mfo(z.kf);

    -- 1508
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1508 '); 
       update specparam set r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '1508' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )
         and r013='3';
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '1508' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )   
         and r013='4';

       commit;

    -- 1518
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1518 '); 
       update specparam set r011='1', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '1518' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )   
         and r013='5';

       commit;

    -- 1528
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 1528 '); 
       update specparam set r011='6', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '1528' )
                        and trim(nlsalt) is null 
                        and dazs is null
                    );
       commit;

    -- 2030
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2030 ');  
       update specparam set r011='1', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2030' )
                        and dazs is null
                    );
       commit;


    -- 2063
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2063 ');  
       update specparam set r011='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2063' )
                        and dazs is null
                    )   
         and (r011 not in ('0','2','3') OR trim(r011) is null);
 
       commit;

    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2068 ');  
       update specparam set r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2068' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )
         and r013='3';
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2068' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )
         and r013='4';
       commit;

    -- 2078
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2078 '); 
       update specparam set r011='1', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2078' )
                        and trim(nlsalt) is null
                        and dazs is null
                     )   
         and r013='3';
       
       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2078' )
                        and trim(nlsalt) is null
                        and dazs is null
                     )   
         and r013='4';
       commit;

    -- 2088
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2088 '); 
       update specparam set r011='2', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2088' )
                        and trim(nlsalt) is null
                        and dazs is null 
                    )   
         and r011='8';
       
       update specparam set r011='2', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2088' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )   
         and r013='7';
       commit;

    -- 2108
       update specparam set r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2108' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )   
         and r013 = '9';
       
       update specparam set r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2108' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )   
         and r013 = 'A';
       commit;

    -- 2208
       update specparam set r011='1'
       where acc in ( select acc from accounts 
                      where nbs in ( '2208' )
                        and dazs is null
                    )
         and r011 in ('D','E');

       update specparam set r011='1', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2208' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )
         and r013='3';
       
       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2208' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )
         and r013='4';
       commit;

    -- 2238
       update specparam set r011='1', r013='2'
       where acc in ( select acc from accounts 
                      where nbs in ( '2238' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )
         and r013 in ('3','8');

       update specparam set r011='1', r013='3'
       where acc in ( select acc from accounts 
                      where nbs in ( '2238' )
                        and trim(nlsalt) is null
                        and dazs is null
                    )
         and r013 in ('4','9');
       commit;

    -- 3570, 3578
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 357X ');
       update specparam set r011 = '1', r013='2' 
       where acc in ( select acc from accounts 
                      where nbs in ( '3570', '3578' )
                        and nlsalt is null
                        and dazs is null
                    );
       commit;

    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2233 ');
       update specparam set r011='1', r013='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2233', '2236' )
                        and dazs is null
                    )   
         and trim(r011) is null;
       commit;


    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 260X '); 
       update specparam set r011='1'
       where acc in ( select acc from accounts 
                      where nbs in ( '2600' )
                        and dazs is null
                    )   
         and (r011 not in ('1','3') OR trim(r011) is null);
       commit;

       update specparam set r013='9'
       where acc in ( select acc from accounts 
                      where nbs in ( '2600' )
                        and dazs is null
                    )   
         and r013='6';
       commit;

    -- 2607
       update specparam set r011='0'
       where acc in ( select acc from accounts 
                      where nbs in ( '2607' )
                        and dazs is null
                     );
       commit;

    -- 2805 
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 280X ');
       update specparam set r011 = '4', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2805' )
                        and dazs is null
                    );
       commit;

    -- 2620
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2620 '); 
       update specparam set r011 = '1' 
       where acc in ( select acc from accounts 
                      where nbs in ( '2620' )
                        and dazs is null
                    )
         and (r011 not in ('1','2','3') OR trim(r011) is null);
       commit;

    -- 2605
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2605 ');
       update specparam set r011='1'
       where acc in ( select acc from accounts 
                      where nbs in ( '2605' )
                        and dazs is null
                     )   
         and r011='A';
       commit;

    -- 2650
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 2650 ');
       update specparam set r011='1'
       where acc in ( select acc from accounts 
                      where nbs in ( '2650' )
                        and dazs is null
                     );
       commit;

    -- 8610
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 8610 ');
       update specparam set r011 = '1', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs = '8610'
                        and dazs is null
                    );
       commit;

    -- 9000
    dbms_output.put_line(' UPDATE_SPECPARAM NBS = 9000 ');
       update specparam set r011 = '2', r013='0' 
       where acc in ( select acc from accounts 
                      where nbs = '9000'
                        and dazs is null
                    );
       commit;


   end loop;
end;
/

spool off;
