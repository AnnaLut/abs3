prompt Перезаливка таблицы bars_dm.d_lcs_tt_type...
begin
    delete from bars_dm.d_lcs_tt_type;

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('M37', 3);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('MMV', 3);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CN3', 3);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CN4', 3);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('MUB', 3);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('436', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CN1', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CFS', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CFO', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CFB', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CAA', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CAB', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CAS', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CVO', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CVS', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CVB', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('437', 2);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CUV', 2);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('MUI', 2);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('MUK', 2);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CNU', 2);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('MUU', 2);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('MUJ', 2);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CNB', 1);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('MUX', 2);

    insert into bars_dm.d_lcs_tt_type (TT, TYPE)
    values ('CN2', 2);

    commit;
end;
/