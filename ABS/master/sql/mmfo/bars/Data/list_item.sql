begin
    list_utl.cor_list_item(interest_utl.LT_RECKONING_GROUPING_MODE, interest_utl.GROUPING_MODE_NO_GROUPING    , 'NO_GROUPING', 'Без стиснення'      , null);
    list_utl.cor_list_item(interest_utl.LT_RECKONING_GROUPING_MODE, interest_utl.GROUPING_MODE_GROUP_BY_RATES , 'BY_RATES'   , 'За значенням ставки', null);
    list_utl.cor_list_item(interest_utl.LT_RECKONING_GROUPING_MODE, interest_utl.GROUPING_MODE_GROUP_ALL      , 'FULL'       , 'Повне стиснення'    , null);
    commit;
end;
/
begin
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_RECKONED      , 'RECKONED'         , 'Прогноз'                , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_MODIFIED      , 'MODIFIED'         , 'Відредаговано'          , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_RECKONING_FAIL, 'RECKONING_FAILED' , 'Помилка при розрахунку' , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_GROUPED       , 'GROUPED'          , 'Згруповано'             , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_ACCRUED       , 'ACCRUED'          , 'Нараховано'             , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_ACCRUAL_FAILED, 'ACCRUAL_FAILED'   , 'Помилка при нарахуванні', p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_ACCR_DISCARDED, 'ACCRUAL_DISCARDED', 'Нарахування скасовано'  , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_PAYED         , 'PAYED'            , 'Виплачено'              , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_PAYMENT_FAILED, 'PAYMENT_FAILED'   , 'Помилка при виплаті'    , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_PAYM_DISCARDED, 'PAYMENT_DISCARDED', 'Виплата скасована'      , p_parent_item_id => null);
    list_utl.cor_list_item('INTEREST_RECKONING_STATE', interest_utl.RECKONING_STATE_ONLY_INFO     , 'ONLY_INFO'        , 'Інформаційний рядок'    , p_parent_item_id => null);
    commit;
end;
/
