
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/s240.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.S240 
(odat_ IN DATE, acc_ IN NUMBER) RETURN VARCHAR2 IS
kod_ VARCHAR2(2);
delta_   NUMERIC;
nbs_     varchar2(4);
BEGIN
select nbs into nbs_ from accounts a where acc=acc_ ;
IF nbs_ IS NOT NULL THEN
   SELECT s240 INTO kod_ FROM kl_f3_29
   WHERE r020=nbs_ AND kf='22';
   IF kod_ IS NOT NULL THEN
      RETURN kod_;
   END IF;
END IF;
select a.mdate - odat_ into delta_ from accounts a where acc=acc_;
IF (delta_ < 0) THEN
   kod_:='1';
ELSIF (delta_ = 0) THEN
   kod_:='0';
ELSIF (delta_ = 1) THEN
   kod_:='2';
ELSIF (delta_ < 8) THEN
   kod_:='3';
ELSIF (delta_ < 22) THEN
   kod_:='4';
ELSIF (delta_ < 32) THEN
   kod_:='5';
ELSIF (delta_ < 93) THEN
   kod_:='6';
ELSIF (delta_ < 184) THEN
   kod_:='7';
ELSIF (delta_ < 365) THEN
   kod_:='8';
ELSIF delta_ IS NOT NULL THEN
   kod_:='9';
ELSE
   SELECT s240 INTO kod_ FROM specparam where acc=acc_;
   IF kod_ IS NULL THEN
      kod_:='0';
   END IF;
END IF;
RETURN kod_;
END s240;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/s240.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 