

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_TRAN_STAT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_TRAN_STAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_TRAN_STAT ("ID", "FILE_NAME", "FILE_DATE", "TRAN_TYPE", "CURRENCY", "C", "S", "C1", "S1", "C2", "S2") AS 
  select id, file_name, file_date, tran_type, currency,
       sum(c) c, sum(s) s,
       sum(decode(flag,1,c,0)) c1, sum(decode(flag,1,s,0)) s1,
       sum(decode(flag,0,c,0)) c2, sum(decode(flag,0,s,0)) s2
  from (
       -- обработанные
       select 1 flag, f.id, f.file_name, f.file_date, f.arc, t.tran_type, t.currency,
              count(*) c, sum(t.amount) s
         from obpc_files f,
              ( select id, tran_type, currency,  amount
                  from obpc_tran_hist
                 union all
                select id, tran_type, currency,  amount
                  from obpc_tran_arc) t
        where f.id = t.id
        group by f.id, f.file_name, f.file_date, f.arc, t.tran_type, t.currency
        union all
       -- необработанные
       select 0, f.id, f.file_name, f.file_date, f.arc, t.tran_type, t.currency,
              count(*), sum(t.amount)
         from obpc_files f, obpc_tran t
        where f.id = t.id
        group by f.id, f.file_name, f.file_date, f.arc, t.tran_type, t.currency)
 where file_name <> 'IMP'
   and arc = 0
 group by id, file_name, file_date, tran_type, currency;

PROMPT *** Create  grants  V_OBPC_TRAN_STAT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_TRAN_STAT to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_TRAN_STAT to OBPC;
grant FLASHBACK,SELECT                                                       on V_OBPC_TRAN_STAT to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_TRAN_STAT.sql =========*** End *
PROMPT ===================================================================================== 
