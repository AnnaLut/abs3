
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fs180_.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FS180_ 
(acc_ IN NUMBER) RETURN VARCHAR2 IS
kod1_ VARCHAR2(2);
delta1_   NUMERIC;
nbs1_     varchar2(4);
BEGIN
delta1_:=0 ;
BEGIN
   SELECT d.wdate-a.wdate INTO delta1_
     FROM  cc_add a, cc_deal d, nd_acc n
    WHERE n.acc = acc_ AND n.nd=a.nd AND n.nd = d.nd AND a.adds=0;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      SELECT a.mdate - a.daos into delta1_ from accounts a where a.acc=acc_;
END;
IF (delta1_ < 0) THEN
   kod1_:='1';
ELSIF (delta1_ = 0) THEN
   kod1_:='0';
ELSIF (delta1_ = 1) THEN
   kod1_:='2';
ELSIF (delta1_ < 8) THEN
   kod1_:='3';
ELSIF (delta1_ < 22) THEN
   kod1_:='4';
ELSIF (delta1_ < 32) THEN
   kod1_:='5';
ELSIF (delta1_ < 93) THEN
   kod1_:='6';
ELSIF (delta1_ < 184) THEN
   kod1_:='7';
ELSIF (delta1_ < 365) THEN
   kod1_:='8';
ELSIF delta1_ IS NOT NULL THEN
   kod1_:='9';
ELSE
   kod1_:='0';
END IF;
RETURN kod1_;
END FS180_;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fs180_.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 