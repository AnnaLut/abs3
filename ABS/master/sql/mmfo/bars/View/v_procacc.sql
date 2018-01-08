

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PROCACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PROCACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PROCACC ("NN", "TT", "NAME") AS 
  select 1 nn, 'N00/D' tt, 'ќтветные заквитованные кредитовые' name
     from DUAL
   union
   select 2, 'N00/K', 'ќтветные заквитованные дебетовые'
     from DUAL
   union
   select 3, 'N00/K', 'Ќачальные заквитованные кредитовые'
     from DUAL
   union
   select 4, 'N99/D', 'ќтветные незаквитованные кредитовые'
     from DUAL
   union
   select 5, 'N99/K', 'ќтветные незаквитованные дебетовые'
     from DUAL
   union
   select 6, 'TNB/K', 'Ќачальные незаквитованные'
     from DUAL
   union
   select 7, 'T00/K', 'Ќачальные неотобранные неопределенные'
     from DUAL
   union
   select 8, 'T00/K', 'Ќачальные неотобранные разблокированные'
     from DUAL
   union
   select 9, 'T00/K', 'Ќачальные неотобранные заблокированные'
     from DUAL
   union
   select 10, 'T00/K', 'ќтветные заблокированные кредитовые'
     from DUAL
   union
   select 11, 'T0D/D', 'ќтветные заблокированные дебетовые'
     from DUAL
   union
   select 12, '902/K', 'ќтветные невы€сненные кредитовые'
     from DUAL
   union
   select 13, '90D/D', 'ќтветные невы€сненные дебетовые'
     from DUAL
 ;

PROMPT *** Create  grants  V_PROCACC ***
grant SELECT                                                                 on V_PROCACC       to BARS014;
grant SELECT                                                                 on V_PROCACC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PROCACC       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PROCACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
