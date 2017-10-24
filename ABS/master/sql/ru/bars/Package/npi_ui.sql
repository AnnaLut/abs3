create or replace package body bars.npi_ui is

  procedure prepare_portfolio_interest(p_nbs         in varchar2, --NBS
                                       p_currency_id in varchar2,
                                       p_date_to     in date) is
    l_products      string_list;
    l_currencies    number_list;
    l_mismatch_list string_list;
    l_accs          number_list;
    l_date_to date := case
                        when p_date_to is null then
                         least(bankdate(), trunc(sysdate)) - 1
                        else
                         p_date_to
                      end;
  begin
    bars_audit.info('Розрахунок %% по не портфельних рахунках, що відповідають таким параметрам фільтру { ' ||
                    'NBS: ' || nvl(p_nbs, 'всі') || ', валюта : ' ||
                    nvl(p_currency_id, 'всі') ||
                    '}. Дату по яку відбувається розрахунок: ' ||
                    to_char(p_date_to, 'dd.mm.yyyy'));
  
    l_products   := tools.string_to_words(p_nbs, p_splitting_symbol => ',', p_ignore_nulls     => 'Y');
    
    l_currencies := tools.string_to_number_list(p_currency_id, p_splitting_symbol => ',', p_ignore_nulls     => 'Y');

    select value(t)
      bulk collect
      into l_mismatch_list
      from table(l_products) t
     where not exists
     (select 1 from notportfolio_nbs tt where tt.nbs = value(t));
    
    if (l_mismatch_list.count > 0) then
      raise_application_error(-20000,
                              'Недопустимий балансовий рахунок {' ||
                              tools.words_to_string(l_mismatch_list) || '}');
    end if;
    
    select a.acc
      bulk collect
      into l_accs
      from accounts a
      join int_accn i
        on i.acc = a.acc and i.id = a.pap - 1 and i.acr_dat < l_date_to
      join NOTPORTFOLIO_NBS n on a.nbs = n.nbs
     where (l_products is null or l_products is empty or a.nbs in (select column_value from table(l_products))) and
           (l_currencies is null or l_currencies is empty or a.kv in (select column_value from table(l_currencies)));
  
    tools.hide_hint(interest_utl.prepare_interest(l_accs, l_date_to));
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
grant execute on BARS.NPI_UI to BARS_ACCESS_DEFROLE;


