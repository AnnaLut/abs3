

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XMLREFPAR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XMLREFPAR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XMLREFPAR ("KLTABLE_NAME", "PARCOUNT", "PARNAM1", "PARVAL1", "PARNAM2", "PARVAL2", "PARNAM3", "PARVAL3", "PARNAM4", "PARVAL4") AS 
  select kltable_name,  count(*),
                         max(pardesc1),  max(parval1),
                         max(pardesc2),  max(parval2),
                         max(pardesc3),  max(parval3),
                         max(pardesc4),  max(parval4)
    from (  select kltable_name, decode(parnum,1, pardesc, '') pardesc1,
                         decode(parnum,1, decode(substr(pardefval,1,1),'#', bars_xmlklb_ref.dynfunc(substr(pardefval,2)), ''||pardefval||''), '') parval1,
                         decode(parnum,2, pardesc, '') pardesc2,
                         decode(parnum,2, decode(substr(pardefval,1,1),'#', bars_xmlklb_ref.dynfunc(substr(pardefval,2)), ''||pardefval||''), '') parval2,
                         decode(parnum,3, pardesc, '') pardesc3,
                         decode(parnum,3, decode(substr(pardefval,1,1),'#', bars_xmlklb_ref.dynfunc(substr(pardefval,2)), ''||pardefval||''), '') parval3,
                         decode(parnum,4, pardesc, '') pardesc4,
                         decode(parnum,4, decode(substr(pardefval,1,1),'#', bars_xmlklb_ref.dynfunc(substr(pardefval,2)), ''||pardefval||''), '') parval4
            from   xml_refreqv_par
         )
    group by  kltable_name
 ;

PROMPT *** Create  grants  V_XMLREFPAR ***
grant SELECT                                                                 on V_XMLREFPAR     to BARSREADER_ROLE;
grant SELECT                                                                 on V_XMLREFPAR     to KLBX;
grant SELECT                                                                 on V_XMLREFPAR     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_XMLREFPAR     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XMLREFPAR.sql =========*** End *** ==
PROMPT ===================================================================================== 
