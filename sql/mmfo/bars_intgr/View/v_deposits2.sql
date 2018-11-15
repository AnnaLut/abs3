prompt create view v_deposits2
create or replace force view v_deposits2 as
select
CHANGENUMBER,
CAST (branch as CHAR(30)) AS branch,
CAST (kf as CHAR(12)) AS kf,
CAST (trunc(rnk/100) as NUMBER(15)) AS rnk,
CAST (nd as VARCHAR2(35)) AS nd,
CAST (dat_begin as DATE) AS dat_begin,
CAST (dat_end as DATE) AS dat_end,
CAST (nls as VARCHAR2(15)) AS nls,
CAST (vidd_name as VARCHAR2(50)) AS vidd_name,
CAST (term as NUMBER(4, 2)) AS term,
CAST (sdog as NUMBER(15, 2)) AS sdog,
CAST (massa as NUMBER(8, 2)) AS massa,
CAST (kv as NUMBER(3)) AS kv,
CAST (intrate as NUMBER(5, 2)) AS intrate,
CAST (sdog_begin as NUMBER(15, 2)) AS sdog_begin,
CAST (last_add_date as DATE) AS last_add_date,
CAST (last_add_suma as NUMBER(15, 2)) AS last_add_suma,
CAST (ostc as NUMBER(15, 2)) AS ostc,
CAST (suma_proc as NUMBER(15, 2)) AS suma_proc,
CAST (suma_proc_plan as NUMBER(15, 2)) AS suma_proc_plan,
CAST (trunc(deposit_id/100) as NUMBER(15)) AS deposit_id,
CAST (dpt_status as NUMBER(1)) AS dpt_status,
CAST (suma_proc_payoff as NUMBER(15, 2)) AS suma_proc_payoff,
CAST (date_proc_payoff as DATE) AS date_proc_payoff,
CAST (date_dep_payoff as DATE) AS date_dep_payoff,
CAST (datz as DATE) AS datz,
CAST (dazs as DATE) AS dazs,
CAST (blkd as NUMBER(3)) AS blkd,
CAST (blkk as NUMBER(3)) AS blkk,
CAST (cnt_dubl as NUMBER(3)) AS cnt_dubl,
CAST (archdoc_id as NUMBER(15)) AS archdoc_id,
CAST (ncash as VARCHAR2(128)) AS ncash,
CAST (name_d as VARCHAR2(128)) AS name_d,
CAST (okpo_d as VARCHAR2(14)) AS okpo_d,
CAST (NLS_D as VARCHAR2(15)) AS NLS_D,
CAST (MFO_D as VARCHAR2(12)) AS MFO_D,
CAST (NAME_P as VARCHAR2(128)) AS NAME_P,
CAST (OKPO_P as VARCHAR2(14)) AS OKPO_P,
CAST (NLSB as VARCHAR2(15)) AS NLSB,
CAST (MFOB as VARCHAR2(12)) AS MFOB,
CAST (NLSP as VARCHAR2(15)) AS NLSP,
CAST (ROSP_M as NUMBER(1)) AS ROSP_M,
CAST (MAL as NUMBER(1)) AS MAL,
CAST (BEN as NUMBER(1)) AS BEN,
CAST (vidd as NUMBER(5)) AS vidd,
CAST (WB as VARCHAR2(1)) AS WB,
CAST (ob22 as VARCHAR2(2)) AS OB22,
CAST (NMS as VARCHAR2(70)) AS NMS
FROM
(
    select (select changenumber from imp_object_mfo where object_name = 'DEPOSITS2' and kf = c.kf) as changenumber,
            branch,
            c.kf,
            rnk,
            nd,
            dat_begin,
            dat_end,
            nls,
            vidd_name,
            term,
            sdog,
            massa,
            kv,
            intrate,
            sdog_begin,
            last_add_date,
            last_add_suma,
            ostc,
            suma_proc,
            suma_proc_plan,
            deposit_id,
            dpt_status,
            suma_proc_payoff,
            date_proc_payoff,
            date_dep_payoff,
            datz,
            dazs,
            blkd,
            blkk,
            cnt_dubl,
            archdoc_id,
            ncash,
            name_d,
            okpo_d,
            NLS_D,
            MFO_D,
            NAME_P,
            OKPO_P,
            NLSB,
            MFOB,
            NLSP,
            ROSP_M,
            MAL,
            BEN,
            vidd,
            WB,
            ob22,
            nms
    from bars_dm.deposit_plt c
    where c.per_id = bars_dm.dm_import.get_period_id(trunc(sysdate), 'MONTH')
    and bars_intgr.xrm_import.get_import_mode('DEPOSITS2') = 'FULL'
    union all
    select
            changenumber,
            branch,
            kf,
            rnk,
            nd,
            dat_begin,
            dat_end,
            nls,
            vidd_name,
            term,
            sdog,
            massa,
            kv,
            intrate,
            sdog_begin,
            last_add_date,
            last_add_suma,
            ostc,
            suma_proc,
            suma_proc_plan,
            deposit_id,
            dpt_status,
            suma_proc_payoff,
            date_proc_payoff,
            date_dep_payoff,
            datz,
            dazs,
            blkd,
            blkk,
            cnt_dubl,
            archdoc_id,
            ncash,
            name_d,
            okpo_d,
            NLS_D,
            MFO_D,
            NAME_P,
            OKPO_P,
            NLSB,
            MFOB,
            NLSP,
            ROSP_M,
            MAL,
            BEN,
            vidd,
            WB,
            ob22,
            nms
    from bars_intgr.deposits2
    where bars_intgr.xrm_import.get_import_mode('DEPOSITS2') = 'DELTA'
);
