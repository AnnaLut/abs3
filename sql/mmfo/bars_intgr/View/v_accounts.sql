prompt create view v_accounts
create or replace force view v_accounts as
select
CHANGENUMBER,
acc,
CAST (branch as CHAR(30)) AS branch,
CAST (kf as CHAR(12)) AS kf,
CAST (rnk as NUMBER(15)) AS rnk,
CAST (nls as CHAR(15)) AS nls,
CAST (vidd as CHAR(10)) AS vidd,
CAST (daos as DATE) AS daos,
CAST (kv as NUMBER(3)) AS kv,
CAST (intrate as NUMBER(5, 2)) AS intrate,
CAST (massa as NUMBER(6, 2)) AS massa,
CAST (count_zl as NUMBER(3)) AS count_zl,
CAST (ostc as NUMBER(15, 2)) AS ostc,
CAST (ob_mon as NUMBER(15, 2)) AS ob_mon,
CAST (last_add_date as DATE) AS last_add_date,
CAST (last_add_suma as NUMBER(15, 2)) AS last_add_suma,
CAST (dazs as DATE) AS dazs,
CAST (blkd as NUMBER(3)) AS blkd,
CAST (blkk as NUMBER(3)) AS blkk,
CAST (acc_status as NUMBER(1)) AS acc_status,
CAST (ob22 as VARCHAR2(2)) AS OB22,
CAST (NMS as VARCHAR2(70)) AS NMS
FROM
(
    select (select changenumber from imp_object_mfo where object_name = 'ACCOUNTS' and rownum = 1) as changenumber,
            acc,
            branch,
            c.kf,
            rnk,
            nls,
            vidd,
            daos,
            kv,
            intrate,
            massa,
            count_zl,
            ostc,
            ob_mon,
            last_add_date,
            last_add_suma,
            dazs,
            blkd,
            blkk,
            acc_status,
            ob22,
            nms
    from bars_dm.dm_accounts c
    where c.per_id = bars_dm.dm_import.get_period_id('MONTH', trunc(sysdate))
    and bars_intgr.xrm_import.get_import_mode('ACCOUNTS') = 'FULL'
    union all
    select
    changenumber,
    acc,
    branch,
    kf,
    rnk,
    nls,
    vidd,
    daos,
    kv,
    intrate,
    massa,
    count_zl,
    ostc,
    ob_mon,
    last_add_date,
    last_add_suma,
    dazs,
    blkd,
    blkk,
    acc_status,
    ob22,
    nms
    from bars_intgr.accounts
    where bars_intgr.xrm_import.get_import_mode('ACCOUNTS') = 'DELTA'
);
