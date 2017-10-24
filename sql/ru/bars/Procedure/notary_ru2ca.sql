

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NOTARY_RU2CA.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NOTARY_RU2CA ***

  CREATE OR REPLACE PROCEDURE BARS.NOTARY_RU2CA 
is
    l_midw   varchar2(4000);
    l_midwN  int;
    l_midwG  int;
    -- l_mref   varchar2(4000);
    -- l_mrefN  int;
    -- l_mrefG  int;

    l_accreditation_requests number_list;
    -- l_transactions number_list;

    l_url varchar2(4000 byte);
    l_authorization_val varchar2(4000 byte);
    l_walett_path varchar2(4000 byte);
    l_walett_pass varchar2(4000 byte);

    function get_notary_param(
        p_param_tag in varchar2)
    return varchar2
    is
        l_value varchar2(4000 byte);
    begin
        select value
        into   l_value
        from   notary_params t
        where  t.tag = p_param_tag and
               t.kf = sys_context('bars_context', 'user_mfo')
        for update;

        return l_value;
    end;

    procedure set_notary_param(
        p_param_tag in varchar2,
        p_value in varchar2)
    is
    begin
        update notary_params t
        set    t.value = p_value
        where  t.tag = p_param_tag and
               t.kf = sys_context('bars_context', 'user_mfo');
    end;
begin

    bars_audit.info('notary_ru2ca: begin');

    tokf;

    -- відслідковуємо зміну ознаки відправки запиту на акредитацію до ЦА
    l_midw := get_notary_param('LAST_CUSTW_UPDATE');

    l_midwN := nvl(to_number(l_midw), 0);

    select max(idupd), set(cast(collect (rnk) as number_list))
    into   l_midwG, l_accreditation_requests
    from   customerw_update t
    where  t.idupd > l_midwN and
           t.tag in ('NOTAR') and
           t.value = 'Так';

    if (l_accreditation_requests is not empty) then
        -- додамо до черги всі ідентифікатори клієнтів, по яких ще відсутні запити на акредитацію
        insert into notary_queue (object_type, object_id)
        select distinct 'ACCREDITATION', column_value
        from   table(l_accreditation_requests)
        minus
        select q.object_type, q.object_id
        from   notary_queue q
        where  q.object_type = 'ACCREDITATION';

        set_notary_param('LAST_CUSTW_UPDATE', l_midwG);
    end if;

    -- проаналізуємо номери рахунків нотаріусів
    for i in (select z.*
              from   (select s.*,
                             case when s.current_notary_account is null and s.open_accounts_set is not empty then
                                       (select min(column_value) from table(s.open_accounts_set))
                                  when s.current_notary_account is not null and s.current_notary_account member of s.closed_accounts_set then
                                       (select min(column_value) from table(s.open_accounts_set))
                                  else s.current_notary_account
                             end new_notary_account
                      from   (select a.rnk,
                                     set(cast(collect(case when a.dazs is null then a.nls else null end) as varchar2_list)) open_accounts_set,
                                     set(cast(collect(case when a.dazs is null then null else a.nls end) as varchar2_list)) closed_accounts_set,
                                     (select t.value from customerw t where t.rnk = a.rnk and t.tag = 'NOTAS') current_notary_account
                              from   accounts a
                              where  a.nbs = '2620' and
                                     a.ob22 = '32' and
                                     a.kv = 980
                              group by a.rnk) s) z
              where  (z.current_notary_account is null and z.new_notary_account is not null) or
                     (z.current_notary_account is not null and z.new_notary_account is null) or
                     (z.current_notary_account <> z.new_notary_account)) loop

        kl.setCustomerElement(i.rnk, 'NOTAS', i.new_notary_account, 0);

        insert into notary_queue(object_type, object_id)
        select 'RNK', i.rnk
        from   DUAL
        where  not exists (select 1
                           from   notary_queue t
                           where  t.object_type = 'RNK' and
                                  t.object_id = i.rnk and
                                  t.kf = sys_context('bars_context', 'user_mfo'));
    end loop;

/*
    -- відслідковуємо нові транзакції по рахунках нотаріусів (час для цього блоку коду ще не прийшов)
    l_mref := get_notary_param('LAST_REF');
    l_mrefN := nvl(to_number(l_mref), 0);

    select max(ref), cast(collect (ref) as number_list)
    into   l_mrefG, l_transactions
    from   oper t
    where  t.sos >= 5 and
           t.tt in ('40M','40N');

    insert into notary_queue (object_type, object_id)
    select distinct 'REF', column_value
    from   table(l_transactions)
    minus
    select q.object_type, q.object_id
    from   notary_queue q
    where  q.object_type = 'REF';

    set_notary_param('LAST_REF', l_mrefG);
*/

    commit;

    l_url := GetGlobalOption('NOTA_URL_CA');
    l_authorization_val := 'Basic ' || utl_raw.cast_to_varchar2(
                                utl_encode.base64_encode(
                                    utl_raw.cast_to_raw(
                                        GetGlobalOption('NOTA_LOGIN_CA') || ':' || GetGlobalOption('NOTA_PASS_CA'))));

    l_walett_path := GetGlobalOption('NOTA_WALLET_PATH_CA');
    l_walett_pass := GetGlobalOption('NOTA_WALLET_PASS_CA');

    for i in (select * from notary_queue for update) loop

        savepoint queue_item;

        begin
            if (i.object_type = 'ACCREDITATION') then
                if (notary_accreditation_request(l_url, l_authorization_val, l_walett_path, l_walett_pass, i.object_id)) then
                    kl.setCustomerElement(i.object_id, 'NOTAR', null, 0);
                    delete notary_queue t where t.object_type = i.object_type and t.object_id = i.object_id and t.kf = i.kf;
                end if;
            elsif (i.object_type = 'RNK') then
                if (notary_alter_request(l_url, l_authorization_val, l_walett_path, l_walett_pass, i.object_id)) then
                    delete notary_queue t where t.object_type = i.object_type and t.object_id = i.object_id and t.kf = i.kf;
                end if;
            elsif (i.object_type = 'USE_ACCREDITATION') then
                if (notary_redemption_request(l_url, l_authorization_val, l_walett_path, l_walett_pass, i.object_id)) then
                    delete notary_queue t where t.object_type = i.object_type and t.object_id = i.object_id and t.kf = i.kf;
                end if;
            end if;
        exception
            when others then
                 rollback to queue_item;
                 bars_audit.error('notary_ru2ca' || chr(10) ||
                                  sqlerrm || chr(10) || dbms_utility.format_error_backtrace() || chr(10) ||
                                  'object_type : ' || i.object_type || chr(10) ||
                                  'object_id   : ' || i.object_id   || chr(10) ||
                                  'kf          : ' || i.kf);
        end;
    end loop;

    commit;
end notary_ru2ca;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NOTARY_RU2CA.sql =========*** End 
PROMPT ===================================================================================== 
