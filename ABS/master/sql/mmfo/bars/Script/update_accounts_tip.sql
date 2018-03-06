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
    bars.bc.home();
  end loop;
end;
/