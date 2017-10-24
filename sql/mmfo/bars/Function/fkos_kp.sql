
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fkos_kp.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FKOS_KP (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
-- отримання суми кредитових оборотів з врахуванням коригуючих проводок
   RETURN DECIMAL
IS
   kos_   DECIMAL;
   skp_   number := 0;
   skpp_  number := 0;
BEGIN
   SELECT SUM (kos)
     INTO kos_
     FROM saldoa
    WHERE acc = acc_ AND fdat between fdat1_ AND fdat2_;

   IF kos_ IS NULL
   THEN
      kos_ := 0;
   END IF;

   dbms_output.put_line(kos_);

   -- коригуючі поточного періоду
   SELECT NVL (SUM (o.s), 0)
      INTO skp_
      FROM opldok o, oper p
     WHERE o.REF = p.REF
       AND o.sos = 5
       and o.dk = 1
       AND p.vob = 96
       AND o.acc = acc_
       AND o.fdat > fdat2_
       AND o.fdat <= fdat2_+28
       AND p.vdat <= fdat2_;

   dbms_output.put_line(skp_);

   -- коригуючі попереднього періоду
   SELECT NVL (SUM (o.s), 0)
      INTO skpp_
      FROM opldok o, oper p
     WHERE o.REF = p.REF
       AND o.sos = 5
       and o.dk = 1
       AND p.vob = 96
       AND o.acc = acc_
       AND o.fdat > fdat1_
       AND o.fdat <= fdat1_+28
       AND p.vdat <= fdat1_;

   dbms_output.put_line(skpp_);

   RETURN kos_ + skp_ - skpp_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fkos_kp.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 