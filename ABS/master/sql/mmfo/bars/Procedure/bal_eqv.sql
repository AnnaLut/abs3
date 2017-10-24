

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BAL_EQV.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BAL_EQV ***

  CREATE OR REPLACE PROCEDURE BARS.BAL_EQV (dat_ DATE) IS
tmp_  varchar2(30);  -- имя USERa временной таблицы tmp
cr   number;
er   number;
nbs2  CHAR(4);       -- строка курсора
kv2   SMALLINT;
dos2  DECIMAL(24);
kos2  DECIMAL(24);
isd2  DECIMAL(24);
isk2  DECIMAL(24);
nbs1  CHAR(4);       -- строка для вставки
dos1  DECIMAL(24);
kos1  DECIMAL(24);
isd1  DECIMAL(24);
isk1  DECIMAL(24);
CURSOR fa0 IS
SELECT a.nbs,
       a.kv,
       SUM(DECODE(s.fdat,dat_,s.dos,0)),
       SUM(DECODE(s.fdat,dat_,s.kos,0)),
      -SUM(DECODE(SIGN(s.ostf-s.dos+s.kos),-1,s.ostf-s.dos+s.kos,0)),
       SUM(DECODE(SIGN(s.ostf-s.dos+s.kos), 1,s.ostf-s.dos+s.kos,0))
 FROM accounts a, saldoa s
 WHERE (s.acc, s.fdat) IN
       (SELECT acc, MAX(fdat)
        FROM saldoa
        WHERE fdat <=dat_
        GROUP BY acc)
     AND a.acc = s.acc
 GROUP BY a.nbs,a.kv
 ORDER BY a.nbs,a.kv ;
BEGIN
   cr := DBMS_SQL.OPEN_CURSOR;                 -- создать таблицу
   select user || '.tmpbal' into tmp_ from dual; -- имя временной таблицы
   DBMS_SQL.PARSE(cr,'CREATE TABLE '||tmp_||'
   ( nbs char(4),
     dos DECIMAL(24),
     kos DECIMAL(24),
     isd DECIMAL(24),
     isk DECIMAL(24) )', DBMS_SQL.NATIVE );
   er:=DBMS_SQL.EXECUTE(cr);
   OPEN fa0;   -- открыть файл
   nbs1:='****';
   dos1:=0;
   kos1:=0;
   isd1:=0;
   isk1:=0;
LOOP
   FETCH fa0
   INTO nbs2,kv2,dos2,kos2,isd2,isk2 ;
   EXIT WHEN fa0%NOTFOUND;
   If nbs2<> nbs1   THEN
      If dos1+kos1+isd1+isk1>0 THEN          -- ВЫГРУЗИТЬ ПРОМЕЖУТОЧНЫЙ БС
         DBMS_SQL.PARSE(cr,
  'INSERT INTO '||tmp_||' (nbs,dos,kos,isd,isk) VALUES ('||
           nbs1||','||
           dos1||','||
           kos1||','||
           isd1||','||
           isk1||')',     DBMS_SQL.NATIVE);
         er:=DBMS_SQL.EXECUTE(cr);
      end if;
      nbs1:=nbs2;    -- ОБНУЛИТЬ
      dos1:=0;
      kos1:=0;
      isd1:=0;
      isk1:=0;
   end if;
   dos1:=dos1+gl.p_icurval(kv2,dos2,dat_); --  НАКОПИТЬ
   kos1:=dos1+gl.p_icurval(kv2,kos2,dat_);
   isd1:=isd1+gl.p_icurval(kv2,isd2,dat_);
   isk1:=isk1+gl.p_icurval(kv2,isk2,dat_);
END LOOP;
If dos1+kos1+isd1+isk1>0 THEN  -- ВЫГРУЗИТЬ ПОСЛЕДНЕЕ
   DBMS_SQL.PARSE(cr,
  'INSERT INTO '||tmp_||' (nbs,dos,kos,isd,isk) VALUES ('||
           nbs1||','||
           dos1||','||
           kos1||','||
           isd1||','||
           isk1||')',     DBMS_SQL.NATIVE);
   er:=DBMS_SQL.EXECUTE(cr);
end if;
close fa0;
DBMS_SQL.CLOSE_CURSOR(cr);
END BAL_EQV;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BAL_EQV.sql =========*** End *** =
PROMPT ===================================================================================== 
