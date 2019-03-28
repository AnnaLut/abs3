PROMPT ======================================================================================================= 
PROMPT *** Run *** ========== Scripts /Sql/CRNV/BARS/MaterializedView/MV_ASVO_IMMOBILE_CRNV.sql =========*** Run **
PROMPT =======================================================================================================
begin
 execute immediate 'drop materialized view MV_ASVO_IMMOBILE_CRNV';
exception
  when others then 
    if sqlcode = -12003 then null; else raise; end if;
end; 
/

begin
    execute immediate q'{
create materialized view MV_ASVO_IMMOBILE_CRNV
partition by hash(mfo)
partitions 26
build deferred
refresh fast on demand
with rowid
as
select m.ND, m.BRANCH, m.DEPVIDNAME, m.NLS, m.KV, m.SOURCE, m.IDCODE, m.FIO, m.OST/100 as OST,
       m.FL,
       m.KOD_OTD, m.MARK, ID,
       substr(m.BRANCH,2,6)                         as mfo,   
       m.ACC_CARD                                   as acc_card,
       replace(replace(replace(m.NLS,'.'),'-'),' ') as norm_nls,
       m.DZAGR,
       m.BATCH_ID,
       substr(m.branch,1,15)                        as norm_branch
from asvo_immobile m}';
exception
    when others then
        if sqlcode = -12006 then null; else raise; end if;
end;
/


GRANT SELECT ON "BARS"."MV_ASVO_IMMOBILE_CRNV" TO "BARS_ACCESS_DEFROLE";
GRANT SELECT ON "BARS"."MV_ASVO_IMMOBILE_CRNV" TO "WR_ALL_RIGHTS";
