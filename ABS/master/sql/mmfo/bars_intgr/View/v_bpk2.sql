prompt create view v_bpk2
create or replace force view v_bpk2 as
select
CHANGENUMBER,
CAST (branch as VARCHAR2(30)) AS branch,
CAST (kf as VARCHAR2(6)) AS kf,
CAST (trunc(rnk/100) as NUMBER(15)) AS rnk,
CAST (trunc(nd/100) as NUMBER(15)) AS nd,
CAST (dat_begin as DATE) AS dat_begin,
CAST (bpk_type as VARCHAR2(50)) AS bpk_type,
CAST (nls as VARCHAR2(15)) AS nls,
CAST (daos as DATE) AS daos,
CAST (kv as NUMBER(3)) AS kv,
CAST (intrate as NUMBER(5, 2)) AS intrate,
CAST (ostc as NUMBER(15, 2)) AS ostc,
CAST (date_lastop as DATE) AS date_lastop,
CAST (cred_line as VARCHAR2(20)) AS cred_line,
CAST (cred_lim as NUMBER(15, 2)) AS cred_lim,
CAST (use_cred_sum as NUMBER(15, 2)) AS use_cred_sum,
CAST (dazs as DATE) AS dazs,
CAST (blkd as NUMBER(3)) AS blkd,
CAST (blkk as NUMBER(3)) AS blkk,
CAST (bpk_status as NUMBER(1)) AS bpk_status,
CAST (pk_okpo as VARCHAR2(10)) AS pk_okpo,
CAST (pk_name as VARCHAR2(100)) AS pk_name,
CAST (pk_okpo_n as NUMBER(22)) AS pk_okpo_n,
CAST (VID as VARCHAR2(35)) AS VID,
CAST (LIE_SUM as VARCHAR2(254)) AS LIE_SUM,
CAST (LIE_VAL as VARCHAR2(254)) AS LIE_VAL,
CAST (LIE_DATE as VARCHAR2(254)) AS LIE_DATE,
CAST (LIE_DOCN as VARCHAR2(254)) AS LIE_DOCN,
CAST (LIE_ATRT as VARCHAR2(254)) AS LIE_ATRT,
CAST (LIE_DOC as VARCHAR2(254)) AS LIE_DOC,
CAST (PK_TERM as VARCHAR2(254)) AS PK_TERM,
CAST (PK_OLDND as VARCHAR2(254)) AS PK_OLDND,
CAST (PK_WORK as VARCHAR2(254)) AS PK_WORK,
CAST (PK_CNTRW as VARCHAR2(254)) AS PK_CNTRW,
CAST (PK_OFAX as VARCHAR2(254)) AS PK_OFAX,
CAST (PK_PHONE as VARCHAR2(254)) AS PK_PHONE,
CAST (PK_PCODW as VARCHAR2(254)) AS PK_PCODW,
CAST (PK_ODAT as VARCHAR2(254)) AS PK_ODAT,
CAST (PK_STRTW as VARCHAR2(254)) AS PK_STRTW,
CAST (PK_CITYW as VARCHAR2(254)) AS PK_CITYW,
CAST (PK_OFFIC as VARCHAR2(30)) AS PK_OFFIC,
CAST (DKBO_DATE_OFF as DATE) AS DKBO_DATE_OFF,
CAST (DKBO_START_DATE as DATE) AS DKBO_START_DATE,
CAST (DKBO_DEAL_NUMBER as VARCHAR2(30)) AS DKBO_DEAL_NUMBER,
CAST (KOS as NUMBER(24)) AS KOS,
CAST (DOS as NUMBER(24)) AS DOS,
CAST (W4_ARSUM as VARCHAR2(254)) AS W4_ARSUM,
CAST (W4_KPROC as VARCHAR2(254)) AS W4_KPROC,
CAST (W4_SEC as VARCHAR2(254)) AS W4_SEC,
CAST (trunc(ACC/100) as NUMBER(24)) AS ACC,
CAST (ob22 as VARCHAR2(2)) AS OB22,
CAST (NMS as VARCHAR2(70)) AS NMS
FROM
(
    select (select changenumber from imp_object_mfo where object_name = 'BPK2' and kf = c.kf) as changenumber,
    c.kf,
    branch,
    rnk,
    nd,
    dat_begin,
    bpk_type,
    nls,
    daos,
    kv,
    intrate,
    ostc,
    date_lastop,
    cred_line,
    cred_lim,
    use_cred_sum,
    dazs,
    blkd,
    blkk,
    bpk_status,
    pk_okpo,
    pk_name,
    pk_okpo_n,
    vid,
    lie_sum,
    lie_val,
    lie_date,
    lie_docn,
    lie_atrt,
    lie_doc,
    pk_term,
    pk_oldnd,
    pk_work,
    pk_cntrw,
    pk_ofax,
    pk_phone,
    pk_pcodw,
    pk_odat,
    pk_strtw,
    pk_cityw,
    pk_offic,
    dkbo_date_off,
    dkbo_start_date,
    dkbo_deal_number,
    kos,
    dos,
    w4_arsum,
    w4_kproc,
    w4_sec,
    acc,
    ob22,
    nms
    from bars_dm.bpk_plt c
    cross join (select * from bars_intgr.imp_object_mfo where object_name = 'BPK2' and rownum = 1) i 
    where c.per_id = bars_dm.dm_import.get_period_id('MONTH', trunc(sysdate))
    and bars_intgr.xrm_import.get_import_mode('BPK2') = 'FULL'
    union all
    select
    changenumber,
    kf,
    branch,
    rnk,
    nd,
    dat_begin,
    bpk_type,
    nls,
    daos,
    kv,
    intrate,
    ostc,
    date_lastop,
    cred_line,
    cred_lim,
    use_cred_sum,
    dazs,
    blkd,
    blkk,
    bpk_status,
    pk_okpo,
    pk_name,
    pk_okpo_n,
    vid,
    lie_sum,
    lie_val,
    lie_date,
    lie_docn,
    lie_atrt,
    lie_doc,
    pk_term,
    pk_oldnd,
    pk_work,
    pk_cntrw,
    pk_ofax,
    pk_phone,
    pk_pcodw,
    pk_odat,
    pk_strtw,
    pk_cityw,
    pk_offic,
    dkbo_date_off,
    dkbo_start_date,
    dkbo_deal_number,
    kos,
    dos,
    w4_arsum,
    w4_kproc,
    w4_sec,
    acc,
    ob22,
    nms
    from bars_intgr.bpk2
    where bars_intgr.xrm_import.get_import_mode('BPK2') = 'DELTA'
);
