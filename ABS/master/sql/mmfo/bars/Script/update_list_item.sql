begin
    list_utl.cor_list(interest_utl.LT_RECKONING_LINE_TYPE, 'Тип розрахунку відсотків');

    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_RECALCULATION , 'RECALCULATION', 'Перерахунок відсотків', p_parent_item_id => null);
    list_utl.cor_list_item(interest_utl.LT_RECKONING_LINE_TYPE, interest_utl.RECKONING_TYPE_ORDINARY_INT, 'ORDINARY_INTEREST', 'Стандартне нарахування відсотків'   , null);
    list_utl.cor_list_item(interest_utl.LT_RECKONING_LINE_TYPE, interest_utl.RECKONING_TYPE_CORRECTION  , 'RECALCULATION'    , 'Перерахунок відсотків'              , null);

    commit;
end;
/
