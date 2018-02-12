prompt mv_dpt_deposit_arc
begin
    execute immediate 'drop materialized view MV_DPT_DEPOSIT_ARC';
exception
    when others then
        if sqlcode = -12003 then null; else raise; end if;
end;
/
begin
    execute immediate '
CREATE MATERIALIZED VIEW MV_DPT_DEPOSIT_ARC
partition by list (KF)
(   partition MV_DPT_DEPOSIT_ARC_300465 values (''300465''),
    partition MV_DPT_DEPOSIT_ARC_324805 values (''324805''),
    partition MV_DPT_DEPOSIT_ARC_302076 values (''302076''),
    partition MV_DPT_DEPOSIT_ARC_303398 values (''303398''),
    partition MV_DPT_DEPOSIT_ARC_305482 values (''305482''),
    partition MV_DPT_DEPOSIT_ARC_335106 values (''335106''),
    partition MV_DPT_DEPOSIT_ARC_311647 values (''311647''),
    partition MV_DPT_DEPOSIT_ARC_312356 values (''312356''),
    partition MV_DPT_DEPOSIT_ARC_313957 values (''313957''),
    partition MV_DPT_DEPOSIT_ARC_336503 values (''336503''),
    partition MV_DPT_DEPOSIT_ARC_322669 values (''322669''),
    partition MV_DPT_DEPOSIT_ARC_323475 values (''323475''),
    partition MV_DPT_DEPOSIT_ARC_304665 values (''304665''),
    partition MV_DPT_DEPOSIT_ARC_325796 values (''325796''),
    partition MV_DPT_DEPOSIT_ARC_326461 values (''326461''),
    partition MV_DPT_DEPOSIT_ARC_328845 values (''328845''),
    partition MV_DPT_DEPOSIT_ARC_331467 values (''331467''),
    partition MV_DPT_DEPOSIT_ARC_333368 values (''333368''),
    partition MV_DPT_DEPOSIT_ARC_337568 values (''337568''),
    partition MV_DPT_DEPOSIT_ARC_338545 values (''338545''),
    partition MV_DPT_DEPOSIT_ARC_351823 values (''351823''),
    partition MV_DPT_DEPOSIT_ARC_352457 values (''352457''),
    partition MV_DPT_DEPOSIT_ARC_315784 values (''315784''),
    partition MV_DPT_DEPOSIT_ARC_354507 values (''354507''),
    partition MV_DPT_DEPOSIT_ARC_356334 values (''356334''),
    partition MV_DPT_DEPOSIT_ARC_353553 values (''353553''))
BUILD DEFERRED
REFRESH
START WITH TRUNC(SYSDATE)+1 NEXT ROUND(SYSDATE+1) + 1 + 6/24
AS
SELECT d.KF,
        d.BRANCH,
        d.deposit_id,
        d.ND,
        d.VIDD,
        v.type_name,
        v.kv,
        t.lcv,
        t.denom,
        d.LIMIT,
        d.rnk,
        c.nmk,
        a.nls,
        d.acc,
        i.acra,
        d.datz,
        d.dat_begin,
        d.dat_end,
        NVL (d.cnt_dubl, 0) AS CNT_DUBL,
        d.USERID,
        D.ARCHDOC_ID ,
        r.REQ_BNKDAT RPT_DT,
        d.wb,
        d.bdate
FROM BARS.DPT_DEPOSIT_CLOS d
    JOIN BARS.DPT_VIDD v ON (v.VIDD = d.VIDD)
    JOIN BARS.TABVAL$GLOBAL t ON (t.KV = d.KV)
    JOIN BARS.ACCOUNTS a ON (a.ACC = d.ACC)
    JOIN BARS.CUSTOMER c ON (c.RNK = d.RNK)
    JOIN BARS.INT_ACCN i ON (i.ACC = d.ACC AND i.ID = 1)
    JOIN (SELECT  deposit_id, MAX (IDUPD) IDUPD
                      FROM DPT_DEPOSIT_CLOS
                    GROUP BY deposit_id) dt on (d.IDUPD = dt.IDUPD and dt.deposit_id =d.deposit_id )
    left join  (SELECT REQ_BNKDAT, DPTID
                FROM DPT_EXTREFUSALS  WHERE  REQ_STATE = 1) r  on r.DPTID = d.deposit_id
    order by d.vidd
';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt index I_MV_DPT_DEPOSIT_ARC_VIDD
begin
execute immediate '
    create bitmap index I_MV_DPT_DEPOSIT_ARC_VIDD on MV_DPT_DEPOSIT_ARC (vidd) tablespace brsdyni local compute statistics';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt index I_MV_DPT_DEPOSIT_ARC_BRANCH
begin
execute immediate '
create bitmap index I_MV_DPT_DEPOSIT_ARC_BRANCH on MV_DPT_DEPOSIT_ARC (branch) tablespace brsdyni local compute statistics';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt index I_MV_DPT_DEPOSIT_ARC_RPTDT
begin
execute immediate '
create bitmap index I_MV_DPT_DEPOSIT_ARC_RPTDT on MV_DPT_DEPOSIT_ARC (RPT_DT) tablespace brsdyni local compute statistics';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
prompt MV_DPT_DEPOSIT_ARC policies
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MV_DPT_DEPOSIT_ARC'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MV_DPT_DEPOSIT_ARC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''MV_DPT_DEPOSIT_ARC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/
begin
    bpa.alter_policies('MV_DPT_DEPOSIT_ARC');
end;
/
/*
prompt REFRESHING MVIEW, will take a lot of time
begin
    dbms_mview.refresh('BARS.MV_DPT_DEPOSIT_ARC', method => 'c');
    commit;
end;
/
*/