

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_DEB_NBU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_DEB_NBU ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_DEB_NBU ("NBS", "XAR", "PAP", "NAME", "CLASS", "CHKNBS", "AUTO_STOP", "D_CLOSE", "SB") AS 
  select "NBS","XAR","PAP","NAME","CLASS","CHKNBS","AUTO_STOP","D_CLOSE","SB" from ps
where d_close is null and pap in (1,3) and substr(nbs,1,3) in ('181','280','354','357','371') and substr(nbs,4,1)<>' ' and nbs <> '3579';

PROMPT *** Create  grants  FIN_DEB_NBU ***
grant SELECT                                                                 on FIN_DEB_NBU     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_DEB_NBU     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_DEB_NBU.sql =========*** End *** ==
PROMPT ===================================================================================== 
