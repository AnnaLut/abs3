
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sec_ctx.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SEC_CTX is

  -- Author  : MOS
  -- Created : 03/06/2014 15:02:12
  -- Purpose : Управління доступами

  --
  -- Додати нову партицію в таблицю по Ід. транзакції
  --
   procedure add_partition(p_tr_id sec_ctx_que.tx_id%type);

   ---
   --- Процедура наповнення черги видачі/відбору доступу
   ---

   procedure set_sec_ctx_que(p_userid number, p_dt date default to_date('01011900','ddmmyyyy'));

   ---
   --- Процедура видалення партиції
   ---
   procedure drop_partition(partition_name varchar2);

   ---
   --- Процедура розбору черги
   ---
   procedure pars_sec_ctx_que;



end SEC_CTX;
/
CREATE OR REPLACE PACKAGE BODY BARS.SEC_CTX is

  --
  -- Додати нову партицію в таблицю по Ід. транзакції
  --
  procedure add_partition(p_tr_id sec_ctx_que.tx_id%type) is
    pragma autonomous_transaction;
  begin
    execute immediate 'alter table sec_ctx_que add partition  p_' ||
                      replace(p_tr_id, '.', '_') || ' VALUES (''' ||
                      p_tr_id || ''')';
  end;

  ---
  --- Процедура наповнення черги видачі/відбору доступу
  ---

  procedure set_sec_ctx_que(p_userid number,
                            p_dt     date default to_date('01011900',
                                                          'ddmmyyyy')) is
    l_tr_id varchar2(150);

  begin

    if DBMS_TRANSACTION.LOCAL_TRANSACTION_ID is null then
      begin
        execute immediate 'set transaction read write';
      exception
        when others then
          if sqlcode = (-01453) then
            null;
          else
            raise;
          end if;
      end;
    end if;

    l_tr_id := DBMS_TRANSACTION.LOCAL_TRANSACTION_ID;

    begin
      insert into sec_ctx_que
        (id, tx_id, userid, dt)
      values
        (s_sec_ctx_que.nextval, l_tr_id, p_userid, p_dt);
    exception
      when others then
        if sqlcode = (-14400) then

          add_partition(l_tr_id);
          insert into sec_ctx_que
            (id, tx_id, userid, dt)
          values
            (s_sec_ctx_que.nextval, l_tr_id, p_userid, p_dt);

        else
          null;
        end if;
    end;

  end set_sec_ctx_que;

  ---
  --- Процедура видалення партиції
  ---
  procedure drop_partition(partition_name varchar2) is
  begin
    execute immediate 'alter table sec_ctx_que drop partition ' ||
                      partition_name;
  end drop_partition;

  ---
  --- Процедура розбору черги
  ---
  procedure pars_sec_ctx_que is
    l_cnt pls_integer;
    i     number := 0;
  begin
    --partitions cursor
    for c in (select *
                from all_tab_partitions
               where table_name = 'SEC_CTX_QUE'
                 and partition_name != 'P_FIRST') loop
      begin
        savepoint sp_before;
        --Перевsрим к-сть запиcів по даній партиції якщо 0 значить зараз наповнюється і ми її пропускаем
        --але ті які з статусом 0, тобто не оброблені(все із-за дат)
      begin 
       execute immediate 'select count(*) from SEC_CTX_QUE partition (' ||
                          c.partition_name || ') where status=0'
          into l_cnt;
           exception when others then if sqlcode=-1429 then l_cnt:=0; else null; end if;
          end;
        if l_cnt > 0 then
          for k in (select *
                      from SEC_CTX_QUE s
                     where s.tx_id =
                           substr(replace(c.partition_name, '_', '.'), 3)
                       and dt <= sysdate
                       and status = 0) loop
            sec.update_sec_ctx(k.userid);
            execute immediate 'update SEC_CTX_QUE partition('||c.partition_name||') s set s.status = 1 where s.id = '||k.id;
            i := i + 1;
          end loop;

          -- Якщо обробили всі записи з партиції - її можна видаляти
          if i = l_cnt then
            drop_partition(c.partition_name);
            --Робимо REBUILD індекса так як він став з статусом UNUSABLE
          --  execute immediate 'alter index PK_SECCTXQUE rebuild';
          end if;
        else
          NULL;
        end if;

        --exception
        --when others then
        --rollback to sp_before;
      end;

    end loop;
    --bars.sec.update_sec_ctx(p_userid);
  end pars_sec_ctx_que;

end SEC_CTX;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sec_ctx.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 