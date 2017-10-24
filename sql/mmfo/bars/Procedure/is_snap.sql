

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IS_SNAP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IS_SNAP ***

  CREATE OR REPLACE PROCEDURE BARS.IS_SNAP ( dat_ DATE, x CHAR DEFAULT NULL) IS
-- Перевіряє чи є знімки балансу
i     SMALLINT;
fdat_ DATE := CASE WHEN x='M' THEN TRUNC(dat_,'MM') ELSE dat_ END;
BEGIN
   IF x='M' THEN
      SELECT 1 INTO i FROM dual
       WHERE EXISTS (SELECT 1 FROM agg_monbals WHERE fdat=fdat_);
   ELSE
      SELECT 1 INTO i FROM dual
       WHERE EXISTS (SELECT 1 FROM snap_balances WHERE fdat=fdat_);
   END IF;
EXCEPTION WHEN NO_DATA_FOUND THEN
   raise_application_error(-20000,'Немає знімка балансу за '|| fdat_);
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IS_SNAP.sql =========*** End *** =
PROMPT ===================================================================================== 
