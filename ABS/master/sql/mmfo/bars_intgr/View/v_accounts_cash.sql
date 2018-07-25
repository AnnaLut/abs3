prompt create view v_accounts_cash
create or replace force view v_accounts_cash as
select
    CHANGENUMBER,
    acc,
    rnk,
    kf,
    nls,
    kv,
    branch,
    nms,
    ob22,
    nmk,
    okpo
FROM
(
    select (select changenumber from imp_object_mfo where object_name = 'ACCOUNTS_CASH' and rownum = 1) as changenumber,
            c.acc,
            c.rnk,
            c.kf,
            c.nls,
            c.kv,
            c.branch,
            c.nms,
            c.ob22,
            c.nmk,
            c.okpo
    from bars_intgr.vw_ref_accounts_xrm c
    where bars_intgr.xrm_import.get_import_mode('ACCOUNTS_CASH') = 'FULL'
    union all
    select
    changenumber,
    c.acc,
    c.rnk,
    c.kf,
    c.nls,
    c.kv,
    c.branch,
    c.nms,
    c.ob22,
    c.nmk,
    c.okpo
    from bars_intgr.accounts_cash c
    where bars_intgr.xrm_import.get_import_mode('ACCOUNTS_CASH') = 'DELTA'
);
