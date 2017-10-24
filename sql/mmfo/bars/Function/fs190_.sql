
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs190_.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS190_ 
(odat_ IN DATE, acc_ IN NUMBER) RETURN VARCHAR2 IS
kod2_ VARCHAR2(2);
delta2_   NUMERIC;
nbs2_     varchar2(4);
BEGIN
select odat_ - a.dapp into delta2_ from accounts a where acc=acc_;
IF (delta2_ < 1) THEN
   kod2_:='0';
ELSIF (delta2_ < 32) THEN
   kod2_:='1';
ELSIF (delta2_ < 93) THEN
   kod2_:='2';
ELSIF (delta2_ < 184) THEN
   kod2_:='3';
ELSIF (delta2_ < 365) THEN
   kod2_:='4';
ELSIF delta2_ IS NOT NULL THEN
   kod2_:='5';
ELSE
   kod2_:='0';
END IF;
RETURN kod2_;
END FS190_;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs190_.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 