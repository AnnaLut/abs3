

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BLKDOCS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BLKDOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BLKDOCS ("REF", "ERR_CODE", "ERR_MSG") AS 
  select
  o.ref,
  max(decode(ow.tag,'APCOD',ow.value)) as err_code,
  max(decode(ow.tag,'APMSG',ow.value)) as err_msg
from
  oper o,
  operw ow
where otm=-1
  and sos=5
  and o.ref = ow.ref
  and o.pdat >= gl.bd - 10
  and ow.tag in ('APCOD', 'APMSG')
group by o.ref

 ;

PROMPT *** Create  grants  V_BLKDOCS ***
grant SELECT                                                                 on V_BLKDOCS       to BARSREADER_ROLE;
grant SELECT                                                                 on V_BLKDOCS       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BLKDOCS       to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_BLKDOCS       to WR_BLKDOCS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BLKDOCS.sql =========*** End *** ====
PROMPT ===================================================================================== 
