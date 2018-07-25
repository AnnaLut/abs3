insert /* +append */ into ob_corp_data_acc
select distinct
SESS_ID, ACC, KF, file_date, CORP_ID, NLS, KV, OKPO, OBDB, OBDBQ, OBKR, OBKRQ, OST, OSTQ, KOD_USTAN, KOD_ANALYT, 
   DAPP, POSTDAT, NAMK, NMS, case when LAST_S = SESS_ID then 1 else 0 end as IS_LAST from (
select  session_id as  SESS_ID, coalesce((select acc from accounts a where a.kf = d.kf and a.kv = d.kv and a.nls = d.nls),
                                         (select acc from accounts a where a.kf = d.kf and a.kv = d.kv and a.nlsalt = d.nls)) as ACC,  
   KF,
   file_date, 
   corporation_id as CORP_ID, 
   NLS, 
   KV, 
   OKPO, OBDB, OBDBQ, 
   OBKR, OBKRQ, OST, 
   OSTQ, KOD_USTAN, lpad(KOD_ANALYT,2,'0') as KOD_ANALYT, 
   DAPP, POSTDAT, NAMK, 
   NMS,   
   max(session_id) over (partition by kf, corporation_id, file_date) as LAST_S 
   from ob_corporation_data d where rowtype = 0) z
   where not exists (select 1 from ob_corp_data_acc q where q.sess_id = z.sess_id and q.kf = z.kf and q.kf = z.kf and q.kv = z.kv and q.nls = z.nls)
   and acc is not null;
   /
   commit;
   /