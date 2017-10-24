

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CORRECT_DAZS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CORRECT_DAZS ***

  CREATE OR REPLACE PROCEDURE BARS.CORRECT_DAZS is

/*
  20/12/2011 SERG Корректируем дату закрытия счета(dazs) в accounts

*/

    p   constant varchar2(60) := 'correct_dazs';
    l_errmsg    varchar2(3000);
begin

    logger.info(p||' start');

    -- входим внутрь МФО

    tuda;

    -- отключаем триггер
    execute immediate 'alter trigger tiu_acca disable';

    --
    dbms_application_info.set_client_info('Выравниваем daos в accounts');
    --
    declare
        cursor c is
        select *
          from (select a.acc, a.daos, nvl(s.min_dat,a.daos) min_dat
                  from accounts a,
                       (select acc, min(fdat) min_dat from saldoa group by acc) s
                 where a.acc=s.acc(+)
               )
         where daos>min_dat;
        type t_rows is table of c%rowtype index by binary_integer;
        l_rows t_rows;
    begin
        --
        open c;
        loop
        fetch c bulk collect into l_rows;
            forall i in 1..l_rows.count
                update accounts
                   set daos = l_rows(i).min_dat
                 where acc = l_rows(i).acc;
            exit when c%notfound;
        end loop;
        close c;
        logger.info(p||': (5) update accounts set daos = ... '||l_rows.count||' rows updated');
    end;

    commit;
    --
    dbms_application_info.set_client_info('Выравниваем dazs в accounts');
    --
    declare
        cursor c is
        select *
          from (select a.acc, a.dazs,
                       greatest(nvl(s.max_dat,to_date('01.01.0001','dd.mm.yyyy')),
                                nvl(q.max_dat,to_date('01.01.0001','dd.mm.yyyy'))
                               ) max_dat
                  from accounts a,
                       (select acc, max(fdat) max_dat from saldoa group by acc) s,
                       (select acc, max(fdat) max_dat from saldob group by acc) q
                 where a.acc=s.acc(+)
                   and a.acc=q.acc(+)
                   and a.dazs is not null
               )
         where dazs<=max_dat;
        type t_rows is table of c%rowtype index by binary_integer;
        l_rows t_rows;
    begin
        --
        open c;
        loop
        fetch c bulk collect into l_rows;
            forall i in 1..l_rows.count
                update accounts
                   set dazs = l_rows(i).max_dat+1
                 where acc = l_rows(i).acc;
            exit when c%notfound;
        end loop;
        close c;
        logger.info(p||': (5) update accounts set dazs = ... '||l_rows.count||' rows updated');
    end;

    commit;

    --
    dbms_application_info.set_client_info('Обнуляем dazs если остаток или эквивалент не равен 0');

    declare
        cursor c is
            select a.acc
              from accounts a
             where (ostc<>0 or ostq<>0) and dazs is not null;
        type t_rows is table of c%rowtype index by binary_integer;
        l_rows t_rows;
    begin
        --
        open c;
        loop
        fetch c bulk collect into l_rows;
            forall i in 1..l_rows.count
                update accounts
                   set dazs = null
                 where acc = l_rows(i).acc;
            exit when c%notfound;
        end loop;
        close c;
        logger.info(p||': (6) update accounts set dazs=null ... '||l_rows.count||' rows updated');
    end;

    commit;

    execute immediate 'alter trigger tiu_acca enable';

    dbms_application_info.set_client_info('Процедура выравнивания dazs успешно завершена');

    logger.info(p||': finish');

exception
    when others then
        l_errmsg := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 3000);
        logger.error(p||': '||l_errmsg);
        --
        execute immediate 'alter trigger tiu_acca enable';
        --
        -- выбрасываем ошибку со стеком
        raise_application_error(-20000, l_errmsg);
        --
end correct_dazs;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CORRECT_DAZS.sql =========*** End 
PROMPT ===================================================================================== 
