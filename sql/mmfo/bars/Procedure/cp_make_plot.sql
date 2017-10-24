

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_MAKE_PLOT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_MAKE_PLOT ***

  CREATE OR REPLACE PROCEDURE BARS.CP_MAKE_PLOT (p_id IN INT)
IS
   cp_row   cp_kod%ROWTYPE;
   mes      NUMBER;
   k_num    NUMBER;
BEGIN
   bars_audit.info ('cp_make_plot:' || TO_CHAR (p_id));

   BEGIN
      SELECT *
        INTO cp_row
        FROM cp_kod
       WHERE id = p_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN bars_audit.error ('Не знайдено кода ЦП =' || TO_CHAR (p_id));
   END;

   IF (cp_row.KY is null AND cp_row.dok IS NOT NULL AND cp_row.dnk IS NOT NULL)
   THEN
      mes := ROUND(((cp_row.DNK - cp_row.DOK) / 30),2);
      bars_audit.info('cp_make_plot 1)' ||mes);
      cp_row.KY := 12 / mes;
   ELSIF (    cp_row.KY > 0
          AND cp_row.KY <= 12
          AND cp_row.dat_em IS NOT NULL
          AND cp_row.datp IS NOT NULL)
   THEN
      mes := ROUND((12/cp_row.KY),2);
      k_num := ROUND ((cp_row.DATP - cp_row.DAT_EM) / (30 * mes));
      bars_audit.info('cp_make_plot 2)' ||mes||' cp_row.KY='|| cp_row.KY||', k_num ='||to_char(k_num)||',cp_row.DATP - cp_row.DAT_EM='|| to_char(cp_row.DATP - cp_row.DAT_EM));
   END IF;

   IF (k_num > 1)
   THEN
      INSERT INTO CP_Dat (id,NPP,DOK,KUP,NOM)
         SELECT p_id,c.num,ADD_MONTHS (cp_row.DAT_EM, c.num * MES),cp_row.CENA_KUP, case when c.num < k_Num then null else cp_row.CENA end
           FROM conductor c
          WHERE c.num <= k_Num;
   ELSE
      INSERT INTO CP_Dat (id,NPP,DOK,KUP,nom)
           VALUES (p_id,1,cp_row.datp,cp_row.cena_kup,cp_row.cena);
   END IF;
EXCEPTION
   WHEN DUP_VAL_ON_INDEX
   THEN bars_audit.error ('cp_make_plot' || SQLERRM);
END;
/
show err;

PROMPT *** Create  grants  CP_MAKE_PLOT ***
grant EXECUTE                                                                on CP_MAKE_PLOT    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_MAKE_PLOT.sql =========*** End 
PROMPT ===================================================================================== 
