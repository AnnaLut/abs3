

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CORRECT_ACCOUNTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CORRECT_ACCOUNTS ***

  CREATE OR REPLACE PROCEDURE BARS.CORRECT_ACCOUNTS is

/*
  20/12/2011 SERG Выравнивание daos/dazs вынесено в процедуру correct_dazs,
                  которая вызывается в конце этой процедуры

  16/12/2011 SERG Обнуляем dazs если остаток или эквивалент(!) не равен 0.
                  При выравнивании dazs учитываем максимальную дату переоценки dappq.

  15/08/2011 добавлено обнуление dazs для счетов с остатками

  27-07-2011 Проверка и устранение несуразностей по датам и остаткам в ACCOUNTS

             1) DAOS  д.б. <=   минимальной  FDAT в SALDOA
             2) DAZS  д.б. >    максимальной FDAT в SALDOA или пусто
             3) DAPP  д.б. =    максимальной FDAT в SALDOA
             4) DAPPq д.б. =    максимальной FDAT в SALDOB
             5) аналогично ровняем остатки и обороты

             Это есть правильным по логике этих параметров,
             а также есть НЕОБХОДИМЫМ для корректной работы снапов версии-2
              (Щетенюк С, июль 2011)
*/

    l_fRCVR  number;
    p   constant varchar2(60) := 'correct_accounts';
    l_errmsg    varchar2(3000);
begin

    logger.info(p||' start');

    -- входим внутрь МФО

    tuda;

    -- сохраняем флаг восстановления saldoa/saldob
    l_fRCVR := gl.fRCVR;

    -- ставим флаг восстановления, чтобы не писать в saldoa, saldob
    gl.fRCVR := 1;

    --
    dbms_application_info.set_client_info('Заполненяем эквиваленты в accounts (dappq, ostq, dosq, kosq)');
    --
    declare
        l_row   saldob%rowtype;
        l_nom   saldoa%rowtype;
        l_accs  dbms_sql.number_table;
        type t_sb is table of saldob%rowtype index by binary_integer;
        l_sb t_sb;
    begin
        execute immediate 'lock table accounts in exclusive mode';

        -- устанавливаем эквиваленты валютных счетов по последней записи saldob

        select b.*
          bulk collect into l_sb
          from saldob b, accounts a
         where a.kv<>980
           and (b.acc, b.fdat) in (select acc, max(fdat) from saldob group by acc)
           and a.acc = b.acc
           and (a.dosq<>b.dos or a.kosq<>b.kos or a.ostq<>b.ostf-b.dos+b.kos
               or
                nvl(a.dappq,to_date('01.01.4000','dd.mm.yyyy'))<>b.fdat
               );
        --
        forall i in 1..l_sb.count
            update accounts
               set dappq = l_sb(i).fdat,
                   ostq  = l_sb(i).ostf - l_sb(i).dos + l_sb(i).kos,
                   dosq  = l_sb(i).dos,
                   kosq  = l_sb(i).kos
             where acc = l_sb(i).acc;

        logger.info(p||': (1) update accounts set *q = ... '||l_sb.count||' rows updated');

        -- по валютным счетам обнуляем эквиваленты если в saldob нет записей

        select acc
          bulk collect into l_accs
          from accounts a
         where a.kv <> 980
           and not exists (select 1 from saldob where acc=a.acc)
           and (dappq is not null or ostq<>0 or dosq<>0 or kosq<>0);
        --
        forall i in 1..l_accs.count
            update accounts
               set dappq = null,
                   ostq  = 0,
                   dosq  = 0,
                   kosq  = 0
             where acc = l_accs(i);

        logger.info(p||': (2) update accounts set *q = ... '||l_accs.count||' rows updated');

        -- по гривневым счетам эквиваленты сбрасываем в 0 специально

        select acc
          bulk collect into l_accs
          from accounts
         where kv = 980
           and (dappq is not null or ostq<>0 or dosq<>0 or kosq<>0);
        --
        forall i in 1..l_accs.count
            update accounts
               set dappq = null,
                   ostq  = 0,
                   dosq  = 0,
                   kosq  = 0
             where acc = l_accs(i);

        logger.info(p||': (3) update accounts set *q = ... '||l_accs.count||' rows updated');

    end;
    -- фиксируем транзакцию
    commit;

    --
    dbms_application_info.set_client_info('Заполненяем номиналы в accounts (dapp, ostс, dos, kos)');
    --
    declare
        l_row   saldob%rowtype;
        l_nom   saldoa%rowtype;
        l_cnt   number := 0;
        l_tot   number := 0;
        cursor c is
            SELECT c.*, n.fdat, n.dos ndos, n.kos nkos, n.ostf - n.dos + n.kos nostc
              FROM (SELECT   a.acc, a.daos, a.dapp, a.ostc, a.dos, a.kos,
                              s.mfdat
                        FROM accounts a, (select acc, MAX (fdat) mfdat from saldoa group by acc) s
                       WHERE a.acc = s.acc
                    ) c,
                   saldoa n
             WHERE c.acc = n.acc
               AND c.mfdat = n.fdat
               AND (   NVL (c.dapp, c.daos) <> n.fdat
                    OR c.ostc <> n.ostf - n.dos + n.kos
                    OR c.dos <> n.dos
                    OR c.kos <> n.kos
                   );

       type t_rows is table of c%rowtype index by binary_integer;
       l_rows t_rows;
    begin
        execute immediate 'lock table accounts in exclusive mode';
        --
        open c;
        loop
        fetch c bulk collect into l_rows;
            forall i in 1..l_rows.count
            update accounts
                       set dapp = l_rows(i).fdat,
                           ostc = l_rows(i).nostc,
                           dos  = l_rows(i).ndos,
                           kos  = l_rows(i).nkos
                     where acc = l_rows(i).acc;
            exit when c%notfound;
        end loop;
        close c;
        logger.info(p||': (4) update accounts set nominals = ... '||l_rows.count||' rows updated');
    end;

    commit;

    correct_dazs;

    -- возвращаем флаг восстановления
    gl.fRCVR := l_fRCVR;

    dbms_application_info.set_client_info('Процедура выравнивания accounts по saldoa/saldob успешно завершена');

    logger.info(p||': finish');

exception
    when others then
        -- возвращаем флаг восстановления
        gl.fRCVR := l_fRCVR;
        l_errmsg := substr(dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace(), 1, 3000);
        logger.error(p||': '||l_errmsg);
        -- выбрасываем ошибку со стеком
        raise_application_error(-20000, l_errmsg);
        --
end correct_accounts;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CORRECT_ACCOUNTS.sql =========*** 
PROMPT ===================================================================================== 
