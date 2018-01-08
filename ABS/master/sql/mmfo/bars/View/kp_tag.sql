

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KP_TAG.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KP_TAG ***

  CREATE OR REPLACE FORCE VIEW BARS.KP_TAG ("TT", "LC", "TAG", "VALUE") AS 
  select O.TT,
       to_char(trim(B.LC)),
       O.TAG,
       TRIM(TO_CHAR(B.ADRESS))
from   KP_GOLDEN B,OP_RULES O
where trim(o.TAG)='ADRS'
      and o.tt='Ý02'
	  AND B.K_USL=1
UNION ALL
select O.TT,
       to_char(trim(B.LC)),
       O.TAG,
       TRIM(TO_CHAR(B.PHONE))
from   KP_GOLDEN B,OP_RULES O
where trim(o.TAG)='TELEF'
      and o.tt='Ý02'
	  AND B.K_USL=1
UNION ALL
select O.TT,
       to_char(trim(B.LC)),
       O.TAG,
       TRIM(TO_CHAR(B.DOLG))
from   KP_GOLDEN B,OP_RULES O
where trim(o.TAG)='BORG'
      and o.tt='Ý02'
	  AND B.K_USL=1
UNION ALL
select O.TT,
       to_char(trim(B.LC)),
       O.TAG,
       TRIM(TO_CHAR(B.NA))
from   KP_GOLDEN B,OP_RULES O
where trim(o.TAG)='TARIF'
      and o.tt='Ý02'
	  AND B.K_USL=1
UNION ALL
select O.TT,
       to_char(trim(B.LC)),
       O.TAG,
       TRIM(TO_CHAR(B.DOLG))
from   KP_TELESERVICE B,OP_RULES O
where trim(o.TAG)='BORG'
      and o.tt='Ý07'
	  AND B.K_USL=1
UNION ALL
select O.TT,
       to_char(trim(B.LC)),
       O.TAG,
       TRIM(TO_CHAR(B.ADRESS))
from   KP_TELESERVICE B,OP_RULES O
where trim(o.TAG)='ADRS'
      and o.tt='Ý07'
	  AND B.K_USL=1
UNION ALL
select O.TT,
       to_char(trim(B.LC)),
       O.TAG,
       TRIM(TO_CHAR(B.NA))
from   KP_TELESERVICE B,OP_RULES O
where trim(o.TAG)='TARIF'
      and o.tt='Ý07'
	  AND B.K_USL=1
 ;

PROMPT *** Create  grants  KP_TAG ***
grant SELECT                                                                 on KP_TAG          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_TAG          to R_KP;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_TAG          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KP_TAG.sql =========*** End *** =======
PROMPT ===================================================================================== 
