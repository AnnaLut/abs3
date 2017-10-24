begin
    delete notportfolio_nbs;

    merge into notportfolio_nbs a
    using (select '9802' nbs, null user_id, 'CCK' portfolio_code from dual union all
           select '9122', null, 'CCK'             from dual union all
           select '9129', null, 'CCK'             from dual union all
           select '9020', null, 'CCK'             from dual union all
           select '3666', null, 'MBDK'            from dual union all
           select '1626', null, 'MBDK'            from dual union all
           select '2706', null, 'MBDK'            from dual union all
           select '1600', null, 'MBDK'            from dual union all
           select '2600', null, 'CURRENT_ACCOUNT' from dual union all
           select '2700', null, 'MBDK'            from dual union all
           select '2701', null, 'MBDK'            from dual union all
           select '2603', null, 'CURRENT_ACCOUNT' from dual union all
           select '3660', null, 'MBDK'            from dual union all
           select '2604', null, 'CURRENT_ACCOUNT' from dual union all
           select '2650', null, 'CURRENT_ACCOUNT' from dual union all
           select '2560', null, 'CURRENT_ACCOUNT' from dual union all
           select '2520', null, 'CURRENT_ACCOUNT' from dual union all
           select '2602', null, 'CURRENT_ACCOUNT' from dual) s
    on (a.nbs = s.nbs and
        tools.compare(a.userid, s.user_id) = 0 and
        tools.compare(a.portfolio_code, s.portfolio_code) = 0)
    when not matched then insert
         values (s.nbs, s.user_id, s.portfolio_code);

    commit;
end;
/

