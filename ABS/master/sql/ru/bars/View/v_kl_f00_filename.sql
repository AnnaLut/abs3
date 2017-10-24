

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KL_F00_FILENAME.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KL_F00_FILENAME ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KL_F00_FILENAME ("KODF", "A017", "DATF", "FILENAME", "DATZ") AS 
  SELECT g.kodf,
          g.a017,
          l.datf,
          f_createfilename (g.kodf, g.a017, TRUNC (l.datf)) FILENAME,
          x.b DATZ
     FROM kl_f00$global g,
          kl_f00$local l,
          (SELECT DISTINCT
                  NVL (
                     TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'),
                     gl.bd)
                     B
             FROM DUAL) x
    WHERE g.kodf = 'A7' AND g.kodf = l.kodf;

PROMPT *** Create  grants  V_KL_F00_FILENAME ***
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to RPBN002;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to SALGL;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KL_F00_FILENAME.sql =========*** End 
PROMPT ===================================================================================== 
