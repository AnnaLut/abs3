-- redeploy
begin
    tools.hide_hint(
        deal_utl.create_account_type('DEPOSIT_PRIMARY_ACCOUNT',
                                     'Рахунок обліку суми депозиту',
                                     'CUSTOMER_FUNDS',
                                     p_gl_account_type_code => 'DEP',
                                     p_balance_account => null,
                                     p_ob22_code => null,
                                     p_account_mask => 'DPU',
                                     p_is_permanent => 'Y',
                                     p_is_auto_open_allowed => 'Y',
                                     p_get_deal_account_function => null,
                                     p_value_by_date_flag => 'N',
                                     p_save_history_flag => 'N'));

    commit;
end;
/

begin
    tools.hide_hint(
        deal_utl.create_account_type('DEPOSIT_INTEREST_ACCOUNT',
                                     'Рахунок нарахованих відсотків по депозитах',
                                     'CUSTOMER_FUNDS',
                                     p_gl_account_type_code => 'DEN',
                                     p_balance_account => null,
                                     p_ob22_code => null,
                                     p_account_mask => 'DPU',
                                     p_is_permanent => 'Y',
                                     p_is_auto_open_allowed => 'Y',
                                     p_get_deal_account_function => null,
                                     p_value_by_date_flag => 'N',
                                     p_save_history_flag => 'N'));

    commit;
end;
/

begin
    tools.hide_hint(
        deal_utl.create_account_type('DEPOSIT_INTEREST_EXPENSE_ACCOUNT',
                                     'Рахунок витрат нарахованих відсотків',
                                     'CUSTOMER_FUNDS',
                                     p_gl_account_type_code => 'ODB',
                                     p_balance_account => null,
                                     p_ob22_code => null,
                                     p_account_mask => null,
                                     p_is_permanent => 'N',
                                     p_is_auto_open_allowed => 'N',
                                     p_get_deal_account_function => 'smb_deposit_proc.get_smb_interest_expense_acc',
                                     p_value_by_date_flag => 'N',
                                     p_save_history_flag => 'N'));

    commit;
end;
/

begin
    tools.hide_hint(
        deal_utl.create_account_type('DEPOSIT_PENALTY_EXPENSE_ACCOUNT',
                                     'Рахунок витрат для перерахунку сум (штраф)',
                                     'CUSTOMER_FUNDS',
                                     p_gl_account_type_code => 'ODB',
                                     p_balance_account => null,
                                     p_ob22_code => null,
                                     p_account_mask => null,
                                     p_is_permanent => 'N',
                                     p_is_auto_open_allowed => 'N',
                                     p_get_deal_account_function => 'smb_deposit_proc.get_smb_penalty_expense_acc',
                                     p_value_by_date_flag => 'N',
                                     p_save_history_flag => 'N'));

    commit;
end;
/