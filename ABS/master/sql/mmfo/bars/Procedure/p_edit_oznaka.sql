PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_EDIT_OZNAKA.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_EDIT_OZNAKA ***

CREATE OR REPLACE PROCEDURE BARS.p_edit_oznaka (p_par number, p_nd in number, p_pr in integer, p_kod integer, p_id integer ) AS

/* Версия 1.0  15-05-2018
   Коригування ознаки дефолту nd_oznaka_351
   -------------------------------------
*/

BEGIN
   IF p_par=0 THEN
      if p_pr = 0 THEN
         DELETE FROM nd_oznaka_351 WHERE nd = p_nd and kod = p_Kod;
      end if; 
   ELSIF p_par=1 THEN NULL;
   ELSIF p_par=2 THEN  
      DELETE FROM nd_oznaka_351 WHERE nd = p_nd and kod = p_Kod;
      if p_pr = 1 THEN
          INSERT INTO nd_oznaka_351 (nd, id, kod) VALUES (p_nd, p_id, p_kod);
      end if; 
 END IF;
END;
/

show err;

PROMPT *** Create  grants P_EDIT_OZNAKA ***
grant EXECUTE                                                                on P_EDIT_OZNAKA   to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_EDIT_OZNAKA.sql =========*** End
PROMPT ===================================================================================== 
