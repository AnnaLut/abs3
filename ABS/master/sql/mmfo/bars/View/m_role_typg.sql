

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_TYPG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_TYPG ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_TYPG ("ARM", "FUN", "REF", "REP", "CHK", "ACC", "OTC", "TTS", "ROL", "STA") AS 
  select 
  to_number(PUL.GET( 'ARM' ) )  ARM,
  to_number(PUL.GET( 'FUN' ) )  FUN,
  to_number(PUL.GET( 'REF' ) )  REF,
  to_number(PUL.GET( 'REP' ) )  REP,
  to_number(PUL.GET( 'CHK' ) )  CHK,
  to_number(PUL.GET( 'ACC' ) )  ACC,
  to_number(PUL.GET( 'OTC' ) )  OTC,
  to_number(PUL.GET( 'TTS' ) )  TTS,
  to_number(PUL.GET( 'ROL' ) )  ROL,
  to_number(PUL.GET( 'STA' ) )  STA  
from dual;

PROMPT *** Create  grants  M_ROLE_TYPG ***
grant SELECT                                                                 on M_ROLE_TYPG     to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_TYPG     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_TYPG     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_TYPG.sql =========*** End *** ==
PROMPT ===================================================================================== 
