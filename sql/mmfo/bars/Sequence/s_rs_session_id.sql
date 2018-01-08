

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_RS_SESSION_ID.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_RS_SESSION_ID ***

   CREATE SEQUENCE  BARS.S_RS_SESSION_ID  MINVALUE 175838 MAXVALUE 1175838 INCREMENT BY 1 START WITH 208666 CACHE 20 NOORDER  CYCLE ;

PROMPT *** Create  grants  S_RS_SESSION_ID ***
grant SELECT                                                                 on S_RS_SESSION_ID to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S_RS_SESSION_ID to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Sequence/S_RS_SESSION_ID.sql =========*** En
PROMPT ===================================================================================== 
