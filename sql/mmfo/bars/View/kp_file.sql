

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KP_FILE.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view KP_FILE ***

  CREATE OR REPLACE FORCE VIEW BARS.KP_FILE ("TT", "LC", "FIO", "S", "TAG") AS 
  select 'Ý02' TT,
       trim(to_char(B.LC)) LC,
       B.FIO FIO,
       (B.NA+B.DOLG) S,
       1 TAG
from  KP_GOLDEN B
union all
select 'Ý07' TT,
       trim(to_char(B.LC)) LC,
       B.FIO FIO,
       (B.NA+B.DOLG) S,
       1 TAG
from   KP_TELESERVICE B
union all
select 'Ý14' TT,
       trim(to_char(B.LC)) LC,
       B.FIO FIO,
       0 S,
       0 TAG
from   kp_kom_test B
union all
select 'Ý01' TT,
       trim(to_char(B.LC)) LC,
       B.FIO FIO,
       0 S,
       1 TAG
from   kp_kom_test B 
 ;

PROMPT *** Create  grants  KP_FILE ***
grant SELECT                                                                 on KP_FILE         to BARSREADER_ROLE;
grant SELECT                                                                 on KP_FILE         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_FILE         to R_KP;
grant SELECT                                                                 on KP_FILE         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_FILE         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KP_FILE.sql =========*** End *** ======
PROMPT ===================================================================================== 
