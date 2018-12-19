PROMPT ======================================================================================================= 
PROMPT *** Run *** ========== Scripts /Sql/CRNV/BARS/MaterializedView/MV_ASVO_IMMOBILE_MMFO.sql =========*** Run **
PROMPT =======================================================================================================
begin
  execute immediate 'drop materialized view MV_ASVO_IMMOBILE_MMFO';
exception 
    when others then
        if sqlcode = -12003 then null; else raise; end if;
end;
/

begin
    execute immediate q'{
create materialized view MV_ASVO_IMMOBILE_MMFO
partition by hash(mfo)
partitions 26
build deferred
refresh fast on demand
as
select m.ND, m.BRANCH, m.DEPVIDNAME, m.NLS, m.KV, m.SOURCE, m.IDCODE, m.FIO, m.OST/100 as OST,
       m.FL,
       m.KOD_OTD, m.MARK, ID,
       substr(m.BRANCH,2,6)                         as mfo,
       m.ACC_CARD,
       replace(replace(replace(m.NLS,'.'),'-'),' ') as norm_NLS,
       case -- cutting of tail
          when substr(m.id,-2,2) = case substr(m.branch,2,6)
                                    when '300465' then '01'
                                    when '324805' then '02'
                                    when '302076' then '03'
                                    when '303398' then '04'
                                    when '305482' then '05'
                                    when '335106' then '06'
                                    when '311647' then '07'
                                    when '312356' then '08'
                                    when '313957' then '09'
                                    when '336503' then '10'
                                    when '322669' then '11'
                                    when '323475' then '12'
                                    when '304665' then '13'
                                    when '325796' then '14'
                                    when '326461' then '15'
                                    when '328845' then '16'
                                    when '331467' then '17'
                                    when '333368' then '18'
                                    when '337568' then '19'
                                    when '338545' then '20'
                                    when '351823' then '21'
                                    when '352457' then '22'
                                    when '315784' then '23'
                                    when '354507' then '24'
                                    when '356334' then '25'
                                    when '353553' then '26'
                                  end
             then coalesce(substr(m.id,1,length(m.id)-2),' ')
             else  m.id
        end                                          as norm_id
from MMFO_ASVO_IMMOBILE m}';
exception
    when others then
        if sqlcode = -12006 then null; else raise; end if;
end;
/



GRANT SELECT ON "BARS"."MV_ASVO_IMMOBILE_MMFO" TO "BARS_ACCESS_DEFROLE";
GRANT SELECT ON "BARS"."MV_ASVO_IMMOBILE_MMFO" TO "WR_ALL_RIGHTS";
