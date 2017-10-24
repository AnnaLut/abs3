
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_mdate_hist.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_MDATE_HIST (pn_acc NUMBER, pd_dat DATE)
   RETURN DATE
IS
   ln_mdate   DATE;
BEGIN
   SELECT mdate
     INTO ln_mdate
     FROM accounts_update a
    WHERE     a.acc = pn_acc
          AND a.idupd = (SELECT MAX (idupd)
                           FROM accounts_update
                          WHERE acc = pn_acc AND effectdate <= pd_dat);

   RETURN ln_mdate;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN NULL;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_mdate_hist.sql =========*** End *
 PROMPT ===================================================================================== 
 