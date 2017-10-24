

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VPOZ.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VPOZ ***

  CREATE OR REPLACE PROCEDURE BARS.VPOZ (para NUMBER,fdat_ DATE,tmp_ varchar2) IS
kv_ number;
kv1 number;
nom  DECIMAL(24);
ekv  DECIMAL(24);
bal  DECIMAL(4);
c    number;
er   number;
g1   DECIMAL(24);
g2   DECIMAL(24);
g3   DECIMAL(24);
g4   DECIMAL(24);
g5   DECIMAL(24);
g6   DECIMAL(24);
g8   DECIMAL(24);
g9   DECIMAL(24);
z char(1);
CURSOR SAL0 IS
   SELECT kv,ost,gl.p_icurval(kv,ost,fdat_),substr(nls,1,4)+0
   FROM  sal
   WHERE fdat=fdat_ AND
         kv not in (select kv from euro) and
         kv<>gl.baseval and
         ost<>0
   UNION ALL
   SELECT 978,EUR(kv,ost),gl.p_icurval(kv,ost,fdat_),substr(nls,1,4)+0
   FROM  sal
   WHERE fdat=fdat_ AND
         kv in (select kv from euro) and
         kv<>gl.baseval and
         ost<>0
   ORDER BY 1;
CURSOR SAL1 IS
   SELECT kv,ost,gl.p_icurval(kv,ost,fdat_),substr(nls,1,4)+0
   FROM  sal
   WHERE fdat=fdat_ AND
         kv in (select kv from euro) and
         kv<>gl.baseval and
         ost<>0
   ORDER BY 1;
CURSOR SAL2 IS
   SELECT kv,ostb,gl.p_icurval(kv,ostb,gl.bdate),nbs+0
   FROM  accounts
   WHERE kv not in (select kv from euro) and
         kv<>gl.baseval and
         ostb<>0
   UNION ALL
   SELECT 978,EUR(kv,ostb),gl.p_icurval(kv,ostb,gl.bdate),nbs+0
   FROM  accounts
   WHERE kv in (select kv from euro) and
         kv<>gl.baseval and
         ostb<>0
   ORDER BY 1;
CURSOR SAL3 IS
   SELECT kv,ostb,gl.p_icurval(kv,ostb,gl.bdate),nbs+0
   FROM  accounts
   WHERE kv in (select kv from euro) and
         kv<>gl.baseval and
         ostb<>0
   ORDER BY 1;
BEGIN
z:=',';
if para=0 THEN
   OPEN SAL0;  -- открыть файл
end if;
if para=1 THEN
   OPEN SAL1;  -- открыть файл
end if;
if para=2 THEN
   OPEN SAL2;  -- открыть файл
end if;
if para=3 THEN
   OPEN SAL3;  -- открыть файл
end if;
kv1:=0;
c := DBMS_SQL.OPEN_CURSOR;
LOOP
   if para=0 THEN
      FETCH SAL0 INTO kv_,nom,ekv,bal ;
      EXIT WHEN SAL0%NOTFOUND;
   end if;
   if para=1 THEN
      FETCH SAL1 INTO kv_,nom,ekv,bal ;
      EXIT WHEN SAL1%NOTFOUND;
   end if;
   if para=2 THEN
      FETCH SAL2 INTO kv_,nom,ekv,bal ;
      EXIT WHEN SAL2%NOTFOUND;
   end if;
   if para=3 THEN
      FETCH SAL3 INTO kv_,nom,ekv,bal ;
      EXIT WHEN SAL3%NOTFOUND;
   end if;
   IF kv1<>kv_ THEN
      if kv1>0 THEN
         DBMS_SQL.PARSE(c,
         'INSERT INTO '|| tmp_ ||' (kv,g1,g2,g3,g4,g5,g6,g8,g9) VALUES
         ('||kv_||z||g1||z||g2||z||g3||z||g4||z||g5||z||g6||z||g8||z||g9||')',
         DBMS_SQL.NATIVE);
         er:=DBMS_SQL.EXECUTE(c);
      end if;
      kv1:=kv_;
      g1:=0;
      g2:=0;
      g3:=0;
      g4:=0;
      g5:=0;
      g6:=0;
      g8:=0;
      g9:=0;
   end if;
   if bal=3800 THEN
      g5:=g5+nom;
      g8:=g8+ekv;
   else
      if bal<8000 THEN
         if nom<0 THEN
            g1:=g1-nom;
         else
            g2:=g2+nom;
         end if;
      end if;
   end if;
   if bal=9280 THEN
      g6:=g6+nom;
      g9:=g9+ekv;
   else
      if bal>8999 THEN
         if nom<0 THEN
            g3:=g3-nom;
         else
            g4:=g4+nom;
         end if;
      end if;
   end if;
END LOOP;
if kv1>0 THEN
   DBMS_SQL.PARSE(c,
   'INSERT INTO '|| tmp_ ||' (kv,g1,g2,g3,g4,g5,g6,g8,g9) VALUES
   ('||kv_||z||g1||z||g2||z||g3||z||g4||z||g5||z||g6||z||g8||z||g9||')',
   DBMS_SQL.NATIVE);
   er:=DBMS_SQL.EXECUTE(c);
end if;
if para=0 THEN
   close sal0;
end if;
if para=1 THEN
   close sal1;
end if;
if para=2 THEN
   close sal2;
end if;
if para=3 THEN
   close sal3;
end if;
DBMS_SQL.CLOSE_CURSOR(c);
END VPOZ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VPOZ.sql =========*** End *** ====
PROMPT ===================================================================================== 
