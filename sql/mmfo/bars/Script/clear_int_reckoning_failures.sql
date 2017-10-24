begin
    for i in (select * from int_reckonings t where t.state_id = interest_utl.RECKONING_STATE_RECKONING_FAIL) loop
        interest_utl.clear_reckonings(i);
    end loop;

    commit;
end;
/