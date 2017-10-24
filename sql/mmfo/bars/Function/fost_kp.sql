
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fost_kp.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOST_KP (acc_ INTEGER, fdat_ DATE)
-- отримання залишку з врахуванням коригуючих проводок
   RETURN DECIMAL
IS
   ost_   DECIMAL;
   skp_   number := 0;
BEGIN
   BEGIN
      SELECT s.ostf - s.dos + s.kos
        INTO ost_
        FROM saldoa s
       WHERE s.acc = acc_
         AND (s.acc, s.fdat) = (SELECT   acc, MAX (fdat)
                                    FROM saldoa
                                   WHERE acc = acc_ AND fdat <= fdat_
                                GROUP BY acc);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ost_ := 0;
   END;

   dbms_output.put_line(ost_);

   SELECT NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0)
      INTO skp_
      FROM opldok o, oper p
     WHERE o.REF = p.REF
       AND o.sos = 5
       AND p.vob = 96
       AND o.acc = acc_
       AND o.fdat > fdat_
       AND o.fdat <= fdat_+28
       AND p.vdat = fdat_;

   dbms_output.put_line(skp_);

   RETURN NVL (ost_, 0) + skp_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fost_kp.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 