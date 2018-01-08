

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FM_VSN.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view FM_VSN ***

  CREATE OR REPLACE FORCE VIEW BARS.FM_VSN ("NAME", "ID") AS 
  select 'Задовільний' name, '1' id from dual
UNION ALL
select 'Незадовільний' name, '-1' id from dual
UNION ALL
select 'Невизначений' name, '0' id from dual;

PROMPT *** Create  grants  FM_VSN ***
grant SELECT                                                                 on FM_VSN          to BARSREADER_ROLE;
grant SELECT                                                                 on FM_VSN          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_VSN          to CUST001;
grant SELECT                                                                 on FM_VSN          to FINMON01;
grant SELECT                                                                 on FM_VSN          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FM_VSN.sql =========*** End *** =======
PROMPT ===================================================================================== 
