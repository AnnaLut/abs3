
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_import.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_IMPORT is
    procedure import_mfo(p_mfo_code in varchar2, p_force_mode in boolean default false);
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_IMPORT as

    STATE_IMPORT_DONE              constant integer := 0;
    STATE_NEW                      constant integer := 1;
    STATE_BARS_READY               constant integer := 2;
    STATE_IMPORT_DONE_WITH_WARNING constant integer := 9;

    CHECK_BARS_DEAL_NOT_FOUND      constant integer := 101;
    CHECK_BARS_ACC_REST_DIFF       constant integer := 102;
    CHECK_BARS_ACC_NOT_FOUND       constant integer := 103;
    CHECK_CONTR_NUM_DUPLICATES     constant integer := 104;

    CHECK_CDB_DEAL_ALREADY_EXISTS  constant integer := 201;
    CHECK_CDB_DEAL_NOT_FOUND       constant integer := 202;
    CHECK_CDB_BRANCH_NOT_FOUND     constant integer := 203;
    CHECK_CDB_TRANS_ACC_NOT_FOUND  constant integer := 204;

    procedure check_before_import
    is
    begin
        update tmp_imp_deals t
        set    t.state = CHECK_CDB_BRANCH_NOT_FOUND,
               t.state_message = 'МФО кредитора не зареєстрований в ЦБД'
        where  t.state = STATE_BARS_READY and
               not exists (select 1
                           from   branch b
                           where  b.branch_code = t.lender_mfo);

        update tmp_imp_deals t
        set    t.state = CHECK_CDB_BRANCH_NOT_FOUND,
               t.state_message = 'МФО позичальника не зареєстрований в ЦБД'
        where  t.state = STATE_BARS_READY and
               not exists (select 1
                           from   branch b
                           where  b.branch_code = t.borrower_mfo);

        update tmp_imp_deals t
        set    t.state = CHECK_CDB_TRANS_ACC_NOT_FOUND,
               t.state_message = 'Попередження: Транзитний рахунок кредитора не знайдений в ЦБД'
        where  t.state = STATE_BARS_READY and
               not exists (select 1
                           from   bars_account ba
                           where  ba.account_number = t.loan_transit_account);

        update tmp_imp_deals t
        set    t.state = CHECK_CDB_TRANS_ACC_NOT_FOUND,
               t.state_message = 'Попередження: Транзитний рахунок позичальника не знайдений в ЦБД'
        where  t.state = STATE_BARS_READY and
               not exists (select 1
                           from   bars_account ba
                           where  ba.account_number = t.deposit_transit_account);
    end;

    procedure import_new_deals
    is
        l_allowed_states t_number_list := t_number_list(STATE_BARS_READY, CHECK_CDB_DEAL_NOT_FOUND, CHECK_CDB_TRANS_ACC_NOT_FOUND);
    begin
        update tmp_imp_deals t
        set    t.state = CHECK_CDB_DEAL_ALREADY_EXISTS,
               t.state_message = 'Угода вже зареєстрована в ЦБД'
        where  t.state = STATE_BARS_READY and
               exists (select 1
                       from   deal d
                       where  d.deal_number = t.deal_number);

        -- виконаємо перевірки на стороні ЦБД
        check_before_import();

        -- знайдемо ідентифікатори філіалів, що відповідають МФО кредитора/позичальника
        update tmp_imp_deals t
        set    t.cdb_lender_id = (select b.id from branch b where b.branch_code = t.lender_mfo),
               t.cdb_borrower_id = (select b.id from branch b where b.branch_code = t.borrower_mfo)
        where  t.state member of l_allowed_states;

        -- зарезервуємо ідентифікатори під майбутні об'єкти
        update tmp_imp_deals t
        set    t.cdb_deal_id = deal_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_loan_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_deposit_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_loan_account_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_loan_int_account_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_deposit_account_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_deposit_int_account_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        insert into deal
        select d.cdb_deal_id,
               d.deal_number,
               d.cdb_lender_id,
               d.cdb_borrower_id,
               d.start_date,
               d.expiry_date,
               null,
               d.deal_amount,
               d.deal_currency,
               d.interest_calendar
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into deal_interest_rate
        select deal_interest_rate_seq.nextval,
               d.cdb_deal_id,
               cdb_deal.RATE_KIND_MAIN,
               r.start_date,
               r.rate_value
        from   bars_crsour_deal_rates r
        join   tmp_imp_deals d on d.deal_number = r.deal_number and
                                  d.deal_currency = r.account_currency
        where  d.state member of l_allowed_states and
               r.start_date is not null;

        -- рахунки кредитора
        insert into bars_object
        select d.cdb_loan_account_id, cdb_bars_object.OBJ_TYPE_ACCOUNT, d.cdb_deal_id, d.cdb_lender_id, d.bars_loan_account_id
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_account
        select d.cdb_loan_account_id, cdb_bars_object.BALANCE_ACC_LENT_FUNDS, d.bars_loan_account
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_object
        select d.cdb_loan_int_account_id, cdb_bars_object.OBJ_TYPE_ACCOUNT, d.cdb_deal_id, d.cdb_lender_id, d.bars_loan_int_account_id
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_account
        select d.cdb_loan_int_account_id, cdb_bars_object.BALANCE_ACC_LENDER_INTEREST, d.bars_loan_int_account
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        -- рахунки позичальника
        insert into bars_object
        select d.cdb_deposit_account_id, cdb_bars_object.OBJ_TYPE_ACCOUNT, d.cdb_deal_id, d.cdb_borrower_id, d.bars_deposit_account_id
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_account
        select d.cdb_deposit_account_id, cdb_bars_object.BALANCE_ACC_BORROWED_FUNDS, d.bars_deposit_account
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_object
        select d.cdb_deposit_int_account_id, cdb_bars_object.OBJ_TYPE_ACCOUNT, d.cdb_deal_id, d.cdb_borrower_id, d.bars_deposit_int_account_id
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_account
        select d.cdb_deposit_int_account_id, cdb_bars_object.BALANCE_ACC_BORROWER_INTEREST, d.bars_deposit_int_account
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        -- дзеркало угод
        insert into bars_object
        select d.cdb_deposit_id, cdb_bars_object.OBJ_TYPE_DEPOSIT, d.cdb_deal_id, d.cdb_borrower_id, d.bars_deposit_id
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_deal
        select d.cdb_deposit_id, cdb_bars_client.BARS_DEAL_TYPE_BORROWING, cdb_bars_client.BARS_DEAL_KIND_DEPOSIT, d.cdb_deposit_account_id, d.cdb_deposit_int_account_id,
               (select ta.id from bars_account ta
                join   bars_object bo on bo.id = ta.id  
                where  ta.account_number = d.deposit_transit_account and
                       bo.branch_id = d.cdb_borrower_id), null
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_object
        select d.cdb_loan_id, cdb_bars_object.OBJ_TYPE_LOAN, d.cdb_deal_id, d.cdb_lender_id, d.bars_loan_id
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        insert into bars_deal
        select d.cdb_loan_id, cdb_bars_client.BARS_DEAL_TYPE_LENDING, cdb_bars_client.BARS_DEAL_KIND_LOAN, d.cdb_loan_account_id, d.cdb_loan_int_account_id,
               (select ta.id 
                from   bars_account ta
                join   bars_object bo on bo.id = ta.id  
                where  ta.account_number = d.loan_transit_account and
                       bo.branch_id = d.cdb_lender_id), null
        from   tmp_imp_deals d
        where  d.state member of l_allowed_states;

        -- поєднаємо угоди між собою
        merge into bars_deal bd
        using (select t.cdb_loan_id deal_id, t.cdb_deposit_id party_deal_id
               from   tmp_imp_deals t
               where  t.state member of l_allowed_states
               union
               select t.cdb_deposit_id, t.cdb_loan_id
               from   tmp_imp_deals t
               where  t.state member of l_allowed_states) s
        on (bd.id = s.deal_id)
        when matched then update
             set bd.party_bars_deal_id = s.party_deal_id;

        update tmp_imp_deals d
        set    d.state = STATE_IMPORT_DONE
        where  d.state = STATE_BARS_READY;

        update tmp_imp_deals d
        set    d.state = STATE_IMPORT_DONE_WITH_WARNING
        where  d.state member of l_allowed_states;

        update bars_crsour_deals bd 
        set    (bd.state, bd.state_message) = (select t.state, t.state_message from tmp_imp_deals t where t.id = bd.id)
        where  bd.id in (select t.id from tmp_imp_deals t);
    end;

    procedure update_deals
    is
        l_allowed_states t_number_list := t_number_list(STATE_BARS_READY, CHECK_CDB_TRANS_ACC_NOT_FOUND);
    begin
        -- виконаємо перевірки на стороні ЦБД
        check_before_import();
/*
        update tmp_imp_deals t
        set    t.state = CHECK_CDB_DEAL_NOT_FOUND,
               t.state_message = 'Угода не зареєстрована в ЦБД'
        where  t.state = STATE_BARS_READY and
               not exists (select 1
                           from   deal d
                           where  d.deal_number = t.deal_number);
*/
        -- знайдемо ідентифікатори філіалів, що відповідають МФО кредитора/позичальника
        update tmp_imp_deals t
        set    t.cdb_lender_id = (select b.id from branch b where b.branch_code = t.lender_mfo),
               t.cdb_borrower_id = (select b.id from branch b where b.branch_code = t.borrower_mfo)
        where  t.state member of l_allowed_states;
/*
        -- зарезервуємо ідентифікатори під майбутні об'єкти
        update tmp_imp_deals t
        set    t.cdb_deal_id = deal_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_loan_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_deposit_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_loan_account_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_loan_int_account_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_deposit_account_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;

        update tmp_imp_deals t
        set    t.cdb_deposit_int_account_id = bars_object_seq.nextval
        where  t.state member of l_allowed_states;
*/
        merge into deal d
        using (select t.deal_number,
                      t.cdb_lender_id,
                      t.cdb_borrower_id,
                      t.start_date,
                      t.expiry_date,
                      t.deal_amount,
                      t.deal_currency,
                      t.interest_calendar
               from   tmp_imp_deals t
               where  t.state member of l_allowed_states) s
        on (d.deal_number = s.deal_number)
        when matched then update 
             set d.lender_id   = s.cdb_lender_id,
                 d.borrower_id = s.cdb_borrower_id,
                 d.open_date   = s.start_date,
                 d.expiry_date = s.expiry_date,
                 d.amount      = s.deal_amount,
                 d.currency_id = s.deal_currency,
                 d.base_year   = s.interest_calendar;

        delete deal_interest_rate r
        where  r.deal_id in (select d.id
                             from   deal d
                             where  d.deal_number in (select t.deal_number 
                                                      from   tmp_imp_deals t
                                                      where  t.state member of l_allowed_states));
        insert into deal_interest_rate
        select deal_interest_rate_seq.nextval,
               d.id,
               cdb_deal.RATE_KIND_MAIN,
               r.start_date,
               r.rate_value
        from   bars_crsour_deal_rates r
        join   tmp_imp_deals t on t.deal_number = r.deal_number
        join   deal d on d.deal_number = r.deal_number
        where  t.state member of l_allowed_states;

        update tmp_imp_deals d
        set    d.state = STATE_IMPORT_DONE
        where  d.state = STATE_BARS_READY;

        update tmp_imp_deals d
        set    d.state = STATE_IMPORT_DONE_WITH_WARNING
        where  d.state member of l_allowed_states;

        update bars_crsour_deals bd
        set    (bd.state, bd.state_message) = (select t.state, t.state_message from tmp_imp_deals t where t.id = bd.id)
        where  bd.id in (select t.id from tmp_imp_deals t);
    end;

    procedure prepare_import_data(p_mfo_code varchar2, p_deal_numbers t_varchar2_list)
    is
    begin
        insert into tmp_imp_deals
        select bd.id,

               bd.center_cc_id,
               bd.center_start_date,
               bd.center_expiry_date,
               bd.center_deal_amount,
               bd.center_deal_currency,
               bd.center_interest_calendar,

               -- МФО кредитора/позичальника
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_LOAN then bd.kf                           -- lender_mfo                    varchar2(6 char),
                    else bd.party_mfo
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_DEPOSIT then bd.kf                        -- borrower_mfo                  varchar2(6 char),
                    else bd.party_mfo
               end,

               -- параметри кредитора
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_LOAN then bd.nd                           -- bars_loan_id                  number(10),
                    else bd.center_nd
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_LOAN then bd.main_account_id              -- bars_loan_account_id          number(10),
                    else bd.center_main_account_id
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_LOAN then bd.main_account_number          -- bars_loan_account             varchar2(15 char),
                    else bd.center_main_account_number
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_LOAN then bd.interest_account_id          -- bars_loan_int_account_id      number(10),
                    else bd.center_int_account_id
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_LOAN then bd.interest_account_number      -- bars_loan_int_account         varchar2(15 char),
                    else bd.center_int_account_number
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_LOAN then bd.transit_account_number       -- loan_transit_account          varchar2(15 char),
                    else bd.center_transit_account_number
               end,

               -- параметри позичальника
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_DEPOSIT then bd.nd                        -- bars_deposit_id               number(10),
                    else bd.center_nd
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_DEPOSIT then bd.main_account_id           -- bars_deposit_account_id       number(10),
                    else bd.center_main_account_id
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_DEPOSIT then bd.main_account_number       -- bars_deposit_account          varchar2(15 char),
                    else bd.center_main_account_number
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_DEPOSIT then bd.interest_account_id       -- bars_deposit_int_account_id   number(10),
                    else bd.center_int_account_id
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_DEPOSIT then bd.interest_account_number   -- bars_deposit_int_account      varchar2(15 char),
                    else bd.center_int_account_number
               end,
               case when bd.vidd = cdb_bars_client.BARS_DEAL_KIND_DEPOSIT then bd.transit_account_number    -- deposit_transit_account       varchar2(15 char),
                    else bd.center_transit_account_number
               end,

               bd.state,
               null,

               null,
               null,
               null,
               null,
               null,
               null,
               null,
               null,
               null
        from   bars_crsour_deals bd
        where  bd.kf = p_mfo_code and
               bd.cc_id in (select column_value from table(p_deal_numbers));
    end;

    procedure import_mfo(p_mfo_code in varchar2, p_force_mode in boolean default false)
    is
        l_new_deals t_varchar2_list;
        l_existing_deals t_varchar2_list;
    begin
        execute immediate 'truncate table tmp_imp_deals';

        if (p_force_mode) then
            select bd.cc_id
            bulk collect into l_existing_deals
            from   bars_crsour_deals bd
            where  bd.kf = p_mfo_code and
                   bd.state = STATE_BARS_READY and
                   exists (select 1
                           from   deal d
                           where  d.deal_number = bd.cc_id);
            prepare_import_data(p_mfo_code, l_existing_deals);
            update_deals();

            select bd.cc_id
            bulk collect into l_new_deals
            from   bars_crsour_deals bd
            where  bd.kf = p_mfo_code and
                   bd.state = STATE_BARS_READY and
                   not exists (select 1
                               from   deal d
                               where  d.deal_number = bd.cc_id);
            prepare_import_data(p_mfo_code, l_new_deals);
            import_new_deals();
        else
            select bd.cc_id
            bulk collect into l_new_deals
            from   bars_crsour_deals bd
            where  bd.kf = p_mfo_code and
                   bd.state = STATE_BARS_READY;

            prepare_import_data(p_mfo_code, l_new_deals);
            import_new_deals();
        end if;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_import.sql =========*** End *** =
 PROMPT ===================================================================================== 
 