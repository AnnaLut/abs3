

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FM_YESNO.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view FM_YESNO ***

  CREATE OR REPLACE FORCE VIEW BARS.FM_YESNO ("NAME", "ID") AS 
  select 'Taê' name, 'YES' id from dual
UNION ALL
select 'Í³' name, 'NO' id from dual;

PROMPT *** Create  grants  FM_YESNO ***
grant SELECT                                                                 on FM_YESNO        to BARSREADER_ROLE;
grant SELECT                                                                 on FM_YESNO        to BARSUPL;
grant SELECT                                                                 on FM_YESNO        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_YESNO        to FINMON01;
grant SELECT                                                                 on FM_YESNO        to UPLD;
grant SELECT                                                                 on FM_YESNO        to BARS_INTGR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FM_YESNO.sql =========*** End *** =====
PROMPT ===================================================================================== 
