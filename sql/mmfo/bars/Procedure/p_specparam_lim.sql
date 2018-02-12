

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SPECPARAM_LIM.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SPECPARAM_LIM ***

  CREATE OR REPLACE PROCEDURE BARS.P_SPECPARAM_LIM (p_dat date) is
  l_error_count number;
  begin
--  if getglobaloption('HAVETOBO') = 2 then
--         execute immediate 'begin tuda; end;';
--  end if;

  --Очищуємо табличку помилок до початку виконання
  delete from err$_specparam;
  for k in (select s.acc, a.accc
              from specparam_update s, accounts a
             where a.acc = s.acc
               and a.accc is not null
               and a.dazs is null
               and a.tip in ('SS ', 'SP ', 'SL ')
               and s.idupd = (select max(idupd)
                                from specparam_update
                               where acc = a.acc
                                 and trunc(fdat) = p_dat
                               group by acc, trunc(fdat))) loop
    update specparam
       set (R011,
            R013,
            S080,
            S180,
            S181,
            S190,
            S200,
            S230,
            S240,
            S120,
            S130,
            S250,
            S182,
            ISTVAL,
            S090,
            S270,
            S260,
            S280,
            S290,
            S370) =
           (select R011,
                   R013,
                   S080,
                   S180,
                   S181,
                   S190,
                   S200,
                   S230,
                   S240,
                   S120,
                   S130,
                   S250,
                   S182,
                   ISTVAL,
                   S090,
                   S270,
                   S260,
                   S280,
                   S290,
                   S370
              from specparam
             where acc = k.acc)
     where acc = k.accc log errors INTO err$_specparam('UPDATE') reject
     LIMIT unlimited;
  end loop;
  -- Перевіряємо результат
  begin
    select count(*) into l_error_count from err$_specparam;
  end;
  if l_error_count > 0 then
    raise_application_error(-20001,'Процедура p_specparam_lim відпрацювала з помилками. Деталі в таблиці err$_specparam');
  end if;

--  if getglobaloption('HAVETOBO') = 2 then
--         execute immediate 'begin suda; end;';
--  end if;

end;
/
show err;

PROMPT *** Create  grants  P_SPECPARAM_LIM ***
grant EXECUTE                                                                on P_SPECPARAM_LIM to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_SPECPARAM_LIM to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SPECPARAM_LIM.sql =========*** E
PROMPT ===================================================================================== 
