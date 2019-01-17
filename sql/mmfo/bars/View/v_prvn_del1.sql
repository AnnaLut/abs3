create or replace view v_prvn_del1 as 
select dat01, kf, kv, sum(DEL_SDM) sdm, sum(nvl(q_sdm,0)) sdmq, sum(DEL_SDF) sdf, sum(nvl(q_sdf,0)) sdfq, sum(DEL_SDI) sdi, sum(nvl(q_sdi,0)) sdiq, 
                           sum(DEL_SDA) sda, sum(nvl(q_sda,0)) sdaq, sum(DEL_SNA) sna, sum(nvl(q_sna,0)) snaq, sum(DEL_SRR) srr, sum(nvl(q_srr,0)) srrq 
from PRVN_DEL1
group by dat01, kf, kv;

grant SELECT on v_prvn_del1       to BARS_ACCESS_DEFROLE;