

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_DOPREKV.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_DOPREKV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_DOPREKV ("REF", "TAG", "NAME", "VALUE") AS 
  select o.ref, f.tag, f.name, o.value
from op_field f, operw o
where f.tag = o.tag
order by o.tag;

PROMPT *** Create  grants  V_DOCUMENTVIEW_DOPREKV ***
grant SELECT                                                                 on V_DOCUMENTVIEW_DOPREKV to BARSREADER_ROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_DOPREKV to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_DOPREKV to START1;
grant SELECT                                                                 on V_DOCUMENTVIEW_DOPREKV to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_DOPREKV.sql =========***
PROMPT ===================================================================================== 
