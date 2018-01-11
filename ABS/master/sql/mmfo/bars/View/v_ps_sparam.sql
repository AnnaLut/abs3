

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PS_SPARAM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PS_SPARAM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PS_SPARAM ("NBS", "SP_ID", "SP_NAME", "SP_SEMANTIC", "SP_TABNAME", "SP_TYPE", "SP_MAXCHAR", "SP_NSINAME", "SP_PKNAME", "SP_NSISQLWHERE", "SP_OPT", "SP_DEFSQLVAL", "SP_CHECK", "SP_HIST", "CODE", "CODE_NAME", "CODE_ORD") AS 
  select a.nbs nbs, b.spid sp_id, b.name sp_name, b.semantic sp_semantic,
       b.tabname sp_tabname, b.type sp_type, b.max_char sp_maxchar,
       upper(b.nsiname) sp_nsiname, upper(b.pkname) sp_pkname,
       upper(b.nsisqlwhere) sp_nsisqlwhere,
       b.opt sp_opt, b.sqlval sp_defsqlval, b.tabcolumn_check sp_check,
       nvl(b.hist,0) sp_hist,
       c.code code, c.name code_name, c.ord code_ord
  from ( select p.nbs, count(s.spid) n
           from ps_sparam s, ps p
          where p.nbs = s.nbs(+)
          group by p.nbs) a,
       ( select p.nbs, p.opt, p.sqlval, s.*
           from sparam_list s, ps_sparam p
          where s.spid = p.spid
          union all
         select p.nbs, null, null, s.*
           from sparam_list s, ps p
          where not exists (select 1 from ps_sparam where nbs=p.nbs) ) b,
       sparam_codes c
 where a.nbs   = b.nbs
   and b.inuse = 1
   and b.code  = c.code
union all
select null nbs, b.spid sp_id, b.name sp_name, b.semantic sp_semantic,
       b.tabname sp_tabname, b.type sp_type, b.max_char sp_maxchar,
       upper(b.nsiname) sp_nsiname, upper(b.pkname) sp_pkname,
       upper(b.nsisqlwhere) sp_nsisqlwhere,
       null sp_opt, null sp_defsqlval, b.tabcolumn_check sp_check,
       nvl(b.hist,0) sp_hist,
       c.code code, c.name code_name, c.ord code_ord
from sparam_list b, sparam_codes c
where b.code  = c.code;

PROMPT *** Create  grants  V_PS_SPARAM ***
grant SELECT                                                                 on V_PS_SPARAM     to BARSREADER_ROLE;
grant SELECT                                                                 on V_PS_SPARAM     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PS_SPARAM     to CUST001;
grant SELECT                                                                 on V_PS_SPARAM     to START1;
grant SELECT                                                                 on V_PS_SPARAM     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PS_SPARAM.sql =========*** End *** ==
PROMPT ===================================================================================== 
