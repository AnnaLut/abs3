
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/npi_ui.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NPI_UI is

    -- Author  : VITALII.KHOMIDA
    -- Created : 15.03.2017 19:41:12
    -- Purpose : Пакет для нарахування відсотків по не портфельних рахунках
    procedure prepare_portfolio_interest(p_nbs         in varchar2, --NBS
                                         p_currency_id in varchar2,
                                         p_date_to     in date);

    procedure prepare_portfolio_interest888(
        p_nbs         in varchar2,--NBS
        p_currency_id in varchar2,
        p_date_to     in date);

    procedure reckon_portfolio_interest(
        p_balance_accounts in varchar2,
        p_ob22 in varchar2,
        p_currencies in varchar2,
        p_managers in varchar2,
        p_date_through in date,
        p_grouping_mode_id in integer);

    procedure reckon_interest(
        p_account_numbers in varchar2,
        p_currencies in varchar2,
        p_customer_ids in varchar2,
        p_customer_codes in varchar2,
        p_date_through in date,
        p_grouping_mode_id in integer);
/*
    procedure reckon_interest(
        p_dictionary_list in t_dictionary_list,
        p_date_through in date default null,
        p_grouping_mode_id in integer default null);
*/
    procedure accrue_interest(
        p_reckoning_id in integer);

    procedure remove_reckoning(
        p_reckoning_id in integer);

    procedure pay_accrued_interest;

    procedure pay_selected_interest(p_id in integer);

    procedure remove_selected_reckoning(p_id in integer);

    procedure edit_selected_reckoning(p_id in integer, p_interest_amount in number, p_purpose in varchar2);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.NPI_UI is

    procedure prepare_portfolio_interest(
        p_nbs         in varchar2, --NBS
        p_currency_id in varchar2,
        p_date_to     in date)
    is
        l_products      string_list;
        l_currencies    number_list;
        l_mismatch_list string_list;
        l_accs          number_list;
        l_date_to date := case when p_date_to is null then
                                    least(bankdate(), trunc(sysdate)) - 1
                               else p_date_to
                          end;
    begin
        bars_audit.info('Розрахунок %% по не портфельних рахунках, що відповідають таким параметрам фільтру { ' ||
                        'NBS: ' || nvl(p_nbs, 'всі') || ', валюта : ' ||
                        nvl(p_currency_id, 'всі') ||
                        '}. Дату по яку відбувається розрахунок: ' ||
                        to_char(p_date_to, 'dd.mm.yyyy'));

        l_products := tools.string_to_words(p_nbs, p_splitting_symbol => ',', p_trim_words => 'Y', p_ignore_nulls => 'Y');
        l_currencies := tools.string_to_number_list(p_currency_id, p_splitting_symbol => ',', p_ignore_nulls     => 'Y');

        select t.column_value
        bulk collect into l_mismatch_list
        from   table(l_products) t
        where  not exists (select 1
                           from   v_notportfolio_nbs tt
                           where  tt.nbs = t.column_value) or
               t.column_value like '26%'; -- забороняємо нарахування по поточних рахунках через даний функціонал

        if (l_mismatch_list.count > 0) then
            raise_application_error(-20000, 'Недопустимий балансовий рахунок {' || tools.words_to_string(l_mismatch_list) || '}');
        end if;

        select a.acc
        bulk collect into l_accs
        from   saldo a
        join   int_accn i on i.acc = a.acc and i.id = a.pap - 1 and i.acr_dat < l_date_to
        join   notportfolio_nbs n on a.nbs = n.nbs
        where  (l_products is null or l_products is empty or a.nbs in (select column_value from table(l_products))) and
               (l_currencies is null or l_currencies is empty or a.kv in (select column_value from table(l_currencies)));

        tools.hide_hint(interest_utl.prepare_interest(l_accs, l_date_to));
    end;

    procedure prepare_portfolio_interest888(
        p_nbs         in varchar2,--NBS
        p_currency_id in varchar2,
        p_date_to     in date)
    is
      l_products      string_list;
      l_currencies    number_list;
      l_mismatch_list string_list;
      l_accs          number_list;
      l_date_to       date := case when p_date_to is null then least(bankdate(),trunc(sysdate)) - 1 else p_date_to end;
    begin
        bars_audit.info('Розрахунок %% по не портфельних рахунках,що відповідають таким параметрам фільтру { ' ||
                        'NBS: ' || nvl(p_nbs,'всі') || ',валюта : ' ||
                        nvl(p_currency_id,'всі') ||
                        '}. Дату по яку відбувається розрахунок: ' ||
                        to_char(p_date_to,'dd.mm.yyyy'));

        l_products   := tools.string_to_words(p_nbs,p_splitting_symbol => ',',p_ignore_nulls     => 'Y');
        l_currencies := tools.string_to_number_list(p_currency_id,p_splitting_symbol => ',',p_ignore_nulls     => 'Y');

        select value(t)
        bulk collect into l_mismatch_list
        from   table(l_products) t
        where  not exists (select 1 from notportfolio_kd888 tt where tt.nbs = value(t));

        if (l_mismatch_list.count > 0) then
            raise_application_error(-20000, 'Недопустимий балансовий рахунок {' || tools.words_to_string(l_mismatch_list) || '}');
        end if;

        select a.acc
        bulk collect into l_accs
        from   saldo a
        join   int_accn i on i.acc = a.acc and i.id = a.pap - 1 and i.acr_dat < l_date_to
        join   notportfolio_kd888 n on a.nbs = n.nbs
        where  (l_products is null or l_products is empty or a.nbs in (select column_value from table(l_products))) and
               (l_currencies is null or l_currencies is empty or a.kv in (select column_value from table(l_currencies)));

        tools.hide_hint(interest_utl.prepare_interest(l_accs,l_date_to));
    end;

    procedure prepare_oldbpk_interest(
        p_date_to     in date)
    is
        l_accs          number_list;
        l_date_to date := case when p_date_to is null then
                                    least(bankdate(), trunc(sysdate)) - 1
                               else p_date_to
                          end;
    begin
        bars_audit.info('Розрахунок %% по рахунках заборгованості БПК, що відповідають таким параметрам фільтру { ' ||
                        ', валюта : ' ||
                        'всі' ||
                        '}. Дату по яку відбувається розрахунок: ' ||
                        to_char(p_date_to, 'dd.mm.yyyy'));

        select a.acc
          bulk collect
          into l_accs
          from accounts a
          join int_accn i
            on i.acc = a.acc and i.id = a.pap - 1 and i.acr_dat < l_date_to
        -- and i.stp_dat is null
         where i.acc in (select acc_2207
                           from bpk_acc
                         union
                         select acc_ovr
                           from bpk_acc);

        tools.hide_hint(interest_utl.prepare_interest(l_accs, l_date_to));
    end;

    procedure reckon_portfolio_interest(
        p_balance_accounts in varchar2,
        p_ob22 in varchar2,
        p_currencies in varchar2,
        p_managers in varchar2,
        p_date_through in date,
        p_grouping_mode_id in integer)
    is
        l_balance_accounts string_list;
        l_ob22 string_list;
        l_currencies number_list;
        l_managers number_list;
        l_mismatch_list string_list;
        l_accounts number_list;
        l_accounts_cursor sys_refcursor;
        l_date_through date := case when p_date_through is null then trunc(sysdate) - 1 else p_date_through end;
    begin
        bars_audit.log_info('npi_ui.reckon_interest',
                            'p_balance_accounts : ' || p_balance_accounts || chr(10) ||
                            'p_ob22             : ' || p_ob22             || chr(10) ||
                            'p_currencies       : ' || p_currencies       || chr(10) ||
                            'p_managers         : ' || p_managers         || chr(10) ||
                            'p_date_through     : ' || p_date_through     || chr(10) ||
                            'p_grouping_mode_id : ' || p_grouping_mode_id);

        l_balance_accounts := tools.string_to_words(p_balance_accounts, p_splitting_symbol => ',', p_trim_words => 'Y', p_ignore_nulls => 'Y');
        l_ob22 := tools.string_to_words(p_ob22, p_splitting_symbol => ',', p_trim_words => 'Y', p_ignore_nulls => 'Y');
        l_currencies := tools.string_to_number_list(p_currencies, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_managers := tools.string_to_number_list(p_managers, p_splitting_symbol => ',', p_ignore_nulls => 'Y');

        select value(t)
        bulk collect into l_mismatch_list
        from   table(l_balance_accounts) t
        where  not exists (select 1 from notportfolio_nbs tt where tt.nbs = value(t));

        if (l_mismatch_list.count > 0) then
            raise_application_error(-20000, 'Недопустимий балансовий рахунок {' || tools.words_to_string(l_mismatch_list) || '}');
        end if;

        open l_accounts_cursor for
        select /*+ no_parallel*/ a.acc
        from   saldo a
        where  a.nbs in (select column_value from table(l_balance_accounts)) and
               (l_ob22 is null or l_ob22 is empty or a.ob22 in (select column_value from table(l_ob22))) and
               (l_currencies is null or l_currencies is empty or a.kv in (select column_value from table(l_currencies))) and
               (l_managers is null or l_managers is empty or a.isp in (select column_value from table(l_managers))) and
               a.dazs is null and
               not exists (select 1 from cc_add d where d.accs = a.acc) and
               not exists (select 1 from dpt_deposit p where p.acc = a.acc) and
               a.branch like sys_context('bars_context', 'user_branch_mask');

        loop
            fetch l_accounts_cursor
            bulk collect into l_accounts limit 1000;

            interest_utl.reckon_interest(l_accounts, l_date_through);

            interest_utl.group_reckonings(l_accounts, p_grouping_mode_id);

            exit when l_accounts_cursor%notfound;
        end loop;
        close l_accounts_cursor;
    end;

    procedure reckon_interest(
        p_account_numbers in varchar2,
        p_currencies in varchar2,
        p_customer_ids in varchar2,
        p_customer_codes in varchar2,
        p_date_through in date,
        p_grouping_mode_id in integer)
    is
        l_account_numbers string_list;
        l_currencies number_list;
        l_customer_ids number_list;
        l_customer_codes string_list;

        l_allowed_balance_accounts string_list;

        l_customers number_list := number_list();
        l_accounts number_list := number_list();
    begin
        bars_audit.log_info('npi_ui.reckon_interest',
                            'p_account_numbers  : ' || p_account_numbers || chr(10) ||
                            'p_currencies       : ' || p_currencies      || chr(10) ||
                            'p_customer_ids     : ' || p_customer_ids    || chr(10) ||
                            'p_customer_codes   : ' || p_customer_codes  || chr(10) ||
                            'p_date_through     : ' || p_date_through    || chr(10) ||
                            'p_grouping_mode_id : ' || p_grouping_mode_id);

        l_account_numbers := tools.string_to_words(p_account_numbers, p_splitting_symbol => ',', p_trim_words => 'Y', p_ignore_nulls => 'Y');
        l_currencies := tools.string_to_number_list(p_currencies, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_customer_ids := tools.string_to_number_list(p_customer_ids, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_customer_codes := tools.string_to_words(p_customer_codes, p_splitting_symbol => ',', p_trim_words => 'Y', p_ignore_nulls => 'Y');

        if ((l_account_numbers is null or l_account_numbers is empty) and
            (l_customer_codes is null or l_customer_codes is empty) and
            (l_customer_ids is null or l_customer_ids is empty)) then
            raise_application_error(-20000, 'Не вказаний жодний критерій для розрахунку прогнозу відсотків - заповніть номер рахунку або ідентифікатор/ЄДРПОУ клієнта');
        end if;

        -- визначимось з переліком РНК, з якими відбуватиметься робота
        if (l_customer_ids is not null and l_customer_ids is not empty) then
            for i in (select t.column_value customer_id, c.rnk, c.nmk, c.date_off
                      from   table(l_customer_ids) t
                      left join customer c on c.rnk = t.column_value) loop

                if (i.rnk is null) then
                    raise_application_error(-20000, 'Клієнт з ідентифікатором {' || i.customer_id || '} не існує');
                end if;

                if (i.date_off is not null and i.date_off <= gl.bd()) then
                    raise_application_error(-20000, 'Клієнт {' || i.nmk ||
                                                    '} з ідентифікатором {' || i.customer_id ||
                                                    '} закритий - дата закриття: ' || to_char(i.date_off, 'dd.mm.yyyy'));
                end if;

                l_customers.extend(1);
                l_customers(l_customers.last) := i.rnk;
            end loop;
        else
            -- якщо конкретні ідентифікатори клієнтів не вказані - виконуємо пошук клієнтів по кодах ЄДРПОУ
            if (l_customer_codes is not null and l_customer_codes is not empty) then
                for i in (select t.column_value
                          from   table(l_customer_codes) t
                          where  regexp_like(t.column_value, '^0{1,}$') or
                                 regexp_like(t.column_value, '^9{1,}$')) loop
                    raise_application_error(-20000, 'Технічний ЄДРПОУ {' || i.column_value ||
                                                    '} не може використовуватися для ідентифікації клієнта - уточніть РНК клієнта');
                end loop;

                for i in (select t.column_value customer_code,
                                 c.rnk,
                                 c.nmk,
                                 c.date_off,
                                 sum(case when c.date_off is null or c.date_off > gl.bd() then 1
                                          else 0
                                     end) over (partition by c.okpo) number_of_active_records
                          from   table(l_customer_codes) t
                          left join customer c on c.okpo = t.column_value) loop

                    if (i.rnk is null) then
                        raise_application_error(-20000, 'Клієнт з ЄДРПОУ {' || i.customer_code || '} не знайдений');
                    end if;

                    if (i.number_of_active_records = 0) then
                        raise_application_error(-20000, 'Клієнт {' || i.nmk ||
                                                        '} з ЄДРПОУ {' || i.customer_code ||
                                                        '} закритий - дата закриття: ' || to_char(i.date_off, 'dd.mm.yyyy'));
                    end if;

                    l_customers.extend(1);
                    l_customers(l_customers.last) := i.rnk;
                end loop;
            end if;
        end if;

        select t.nbs
        bulk collect into l_allowed_balance_accounts
        from   notportfolio_nbs t
        where  t.userid is null or t.userid = sys_context('bars_global', 'user_id');

        if (l_account_numbers is not null and l_account_numbers is not empty) then
            for i in (select t.column_value account_number, a.acc, a.rnk, a.dazs, a.nbs, a.nls,
                             sum(case when a.dazs is null or a.dazs > gl.bd() then 1
                                      else 0
                                 end) over (partition by a.nls) number_of_active_records
                      from table(l_account_numbers) t
                      left join saldo a on a.kf = sys_context('bars_context', 'user_mfo') and
                                           a.branch like sys_context('bars_context', 'user_branch_mask') and
                                           a.nls = t.column_value and
                                           (l_currencies is null or l_currencies is empty or a.kv member of l_currencies)) loop
                if (i.acc is null) then
                    raise_application_error(-20000, 'Рахунок з номером {' || i.account_number || '}' ||
                                                    case when p_currencies is not null then ' для фільтру валют {' || p_currencies || '}'
                                                         else null
                                                    end || ' не знайдений');
                end if;

                if (i.nbs not member of l_allowed_balance_accounts) then
                    raise_application_error(-20000, 'Недопустимий балансовий рахунок {' || i.nbs || '} по рахунку {' || i.nls || '}');
                end if;

                if (l_customers is not null and l_customers is not empty and i.rnk not member of l_customers) then
                    raise_application_error(-20000, 'Рахунок {' || i.nls ||
                                                    '} належить клієнту {' || customer_utl.get_customer_name(i.rnk) ||
                                                    '} з ідентифікатором {' || i.rnk ||
                                                    '}, що не входить в допустимий набір ідентифікаторів клієнтів {' ||
                                                    tools.number_list_to_string(l_customers, p_splitting_symbol => ', ', p_ceiling_length => 200) ||
                                                    '} - уточніть відповідність вказаних рахунків та клієнтів');
                end if;

                if (i.number_of_active_records = 0) then
                    raise_application_error(-20000, 'Рахунок з номером {' || i.account_number ||
                                                    '} закритий - дата закриття: ' || to_char(i.dazs, 'dd.mm.yyyy'));
                end if;

                l_accounts.extend(1);
                l_accounts(l_accounts.last) := i.acc;
            end loop;
        else
            -- на даному етапі в l_customers обов'язково повинні бути дані, в іншому разі одна з попередніх перевірок вже повинна була спрацювати
            select a.acc
            bulk collect into l_accounts
            from   saldo a
            where  a.kf = sys_context('bars_context', 'user_mfo') and
                   a.branch like sys_context('bars_context', 'user_branch_mask') and
                   (a.dazs is null or a.dazs > gl.bd()) and
                   (l_currencies is null or l_currencies is empty or a.kv member of l_currencies) and
                   a.rnk in (select column_value from table(l_customers)) and
                   a.nbs in (select column_value from table(l_allowed_balance_accounts));
        end if;

        if (l_accounts is empty) then
            raise_application_error(-20000, 'Не знайдено жодного відкритого рахунку, що відповідав би заданим критеріям пошуку}');
        end if;

        interest_utl.reckon_interest(l_accounts, case when p_date_through is null then trunc(sysdate) - 1 else p_date_through end);

        interest_utl.group_reckonings(l_accounts, p_grouping_mode_id);
    end;
/*
    procedure reckon_interest(
        p_dictionary_list in t_dictionary_list,
        p_date_through in date default null,
        p_grouping_mode_id in integer default null)
    is
        l_balance_accounts string_list;
        l_currencies number_list;
        l_managers number_list;
        l_mismatch_list string_list;
        l_accounts number_list;
        l_accounts_cursor sys_refcursor;
        l_date_through date := case when p_date_through is null then trunc(sysdate) - 1 else p_date_through end;
        i integer;
        j integer;
        l_message varchar2(32767 byte);
        l_interest_kinds number_list;
    begin
        if (p_dictionary_list is null or p_dictionary_list is empty) then
            return;
        end if;

        l_accounts := tools.string_list_to_number_list(
                          tools.varchar2_list_to_string_list(
                              tools.dimension_from_dictionary_list(p_dictionary_list, 'ACCOUNT_ID', p_ignore_nulls => 'N', p_trim_values => 'N'),
                              p_ignore_nulls => 'N',
                              p_truncate_long_values => 'N'),
                          p_ignore_nulls => 'N');

        l_interest_kinds := tools.string_list_to_number_list(
                                tools.varchar2_list_to_string_list(
                                    tools.dimension_from_dictionary_list(p_dictionary_list, 'INTEREST_KIND_ID', p_ignore_nulls => 'N', p_trim_values => 'N'),
                                    p_ignore_nulls => 'N',
                                    p_truncate_long_values => 'N'),
                                p_ignore_nulls => 'N');

        bars_audit.log_info('cdb_mediator.accrue_interest',
                            'p_date_through     : ' || p_date_through || chr(10) ||
                            'p_grouping_mode_id : ' || p_grouping_mode_id || chr(10) ||
                            'p_dictionary_list  : ' || l_message);
    end;
*/

    procedure accrue_interest(
        p_reckoning_id in integer)
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        bars_audit.log_info('npi_ui.accrue_interest', 'p_reckoning_id : ' || p_reckoning_id);

        l_reckoning_row := interest_utl.read_reckoning_row(p_reckoning_id, p_lock => true);

        interest_utl.accrue_interest(l_reckoning_row, p_silent_mode => true);
    end;

    procedure remove_reckoning(
        p_reckoning_id in integer)
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        bars_audit.log_trace('npi_ui.remove_reckoning', 'p_reckoning_id : ' || p_reckoning_id);

        l_reckoning_row := interest_utl.read_reckoning_row(p_reckoning_id, p_lock => true, p_raise_ndf => false);

        interest_utl.clear_reckonings(l_reckoning_row.account_id, l_reckoning_row.interest_kind_id, l_reckoning_row.date_from);
    end;

    procedure pay_accrued_interest
    is
    begin
        bars_audit.trace('npi_ui.pay_accrued_interest' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id'));

        interest_utl.pay_accrued_interest;
    end;

    procedure pay_selected_interest(
        p_id in integer)
    is
        l_int_reckoning_row int_reckoning%rowtype;
    begin
        bars_audit.trace('npi_ui.pay_selected_interest' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id') || chr(10) ||
                         'p_id : ' || p_id);

        l_int_reckoning_row := interest_utl.lock_reckoning_row(p_id, p_skip_locked => true);

        if (l_int_reckoning_row.id is not null) then
            interest_utl.pay_int_reckoning_row(l_int_reckoning_row, p_silent_mode => true);
        end if;
    end;

    procedure remove_selected_reckoning(
        p_id in integer)
    is
    begin
        bars_audit.trace('npi_ui.remove_selected_reckoning' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id') || chr(10) ||
                         'p_id : ' || p_id);

        interest_utl.remove_reckoning(p_id);
    end;

    procedure edit_selected_reckoning(
        p_id in integer,
        p_interest_amount in number,
        p_purpose in varchar2)
    is
        l_int_reckoning_row int_reckoning%rowtype;
        l_account_row accounts%rowtype;
    begin
        bars_audit.trace('npi_ui.remove_selected_reckoning' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id') || chr(10) ||
                         'p_id                                    : ' || p_id || chr(10) ||
                         'p_interest_amount                       : ' || p_interest_amount || chr(10) ||
                         'p_purpose                               : ' || p_purpose);

        l_int_reckoning_row := interest_utl.lock_reckoning_row(p_id, p_skip_locked => false);
        l_account_row := account_utl.read_account(l_int_reckoning_row.account_id);

        interest_utl.edit_reckoning_row(p_id, currency_utl.to_fractional_units(p_interest_amount, l_account_row.kv), p_purpose);
    end;

end npi_ui;
/
 show err;
 
PROMPT *** Create  grants  NPI_UI ***
grant EXECUTE                                                                on NPI_UI          to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/npi_ui.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 