-- Необходимо проставить такие типы счетов на уже открытых счетах:
-- Для счетов NBS = 1623, 2701, 3660 - тип DEP
-- Для счетов NBS = 1628, 2708, 3668 - тип DEN
-- Для счетов NBS = 1626, 2706, 3666 - тип SDI
-- Для счетов NBS = 9510             - тип ZAL
----------------------------------------------

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET LINES        200
SET PAGES        200

begin
  for ru in ( select KF from MV_KF )
  loop
    bars.bc.go(ru.KF);
    for ac in ( select rowid as ROW_ID
                     , case
                       when a.NBS in ('1623','2701','3660')
                       then 'DEP'
                       when a.NBS in ('1628','2708','3668')
                       then 'DEN'
                       when a.NBS in ('1626','2706','3666')
                       then 'SDI'
                       when a.NBS in ('9510')
                       then 'ZAL'
                       else a.TIP
                       end as TIP
                     , a.ACC
                  from ACCOUNTS a
                 where a.NBS in ('1623','2701','3660'
                                ,'1628','2708','3668'
                                ,'1626','2706','3666'
                                ,'9510')
                   and a.TIP = 'ODB'
                   and a.DAZS Is Null
              )
    loop
      begin
        update ACCOUNTS
           set TIP   = ac.TIP
         where ROWID = ac.ROW_ID;
      exception
        when OTHERS then
          dbms_output.put_line( 'ACC='||to_char(ac.ACC)||', errmsg='||sqlerrm );
      end;
    end loop;
    commit;
    -- Присвоение типа счетам фин.деб. по справочнику
    for ac in ( select a.ROWID as ROW_ID
                     , t.TIP
                     , a.ACC
                  from ACCOUNTS a
                  join ( select substr(NBS_N,1,4) as R020
                              , substr(NBS_N,5,2) as OB22
                              , 'ODB' as TIP -- 'SK0'
                           from FIN_DEBT
                          where NBS_N like '357___'
                          union
                         select substr(NBS_P,1,4) as R020
                              , substr(NBS_P,5,2) as OB22
                              , 'OFR' as TIP
                           from FIN_DEBT
                          where NBS_P like '357___'
                       ) t
                    on ( t.R020 = a.NBS and t.OB22 = a.OB22 )
                 where a.DAZS is null
                   and a.TIP not in ( 'SK0', 'SK9', t.TIP )
              )
    loop
      begin
        update ACCOUNTS
           set TIP   = ac.TIP
         where ROWID = ac.ROW_ID;
      exception
        when OTHERS then
          dbms_output.put_line( 'ACC='||to_char(ac.ACC)||', errmsg='||sqlerrm );
      end;
    end loop;
    commit;
    bars.bc.home();
  end loop;
end;
/