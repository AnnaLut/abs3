

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OWNERUCH.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OWNERUCH ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OWNERUCH ("ID", "PRUCH_VIDSOTOK", "PRUCH_NOMINAL", "PRUCH_GOLOSI", "OPRUCH_VIDSOTOK", "OPRUCH_NOMINAL", "OPRUCH_GOLOSI", "GOLUCH_VIDSOTOK", "GOLUCH_GOLOS", "ZAGUCH_VIDSOTOK", "ZAGUCH_GOLOS", "ROZ") AS 
  select id, pruch_vidsotok, pruch_nominal, pruch_golosi,
       opruch_vidsotok, opruch_nominal, opruch_golosi,
       goluch_vidsotok, goluch_golos,
       zaguch_vidsotok, zaguch_golos, roz
  from sv_owner;

PROMPT *** Create  grants  V_SV_OWNERUCH ***
grant SELECT                                                                 on V_SV_OWNERUCH   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_OWNERUCH   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OWNERUCH.sql =========*** End *** 
PROMPT ===================================================================================== 
