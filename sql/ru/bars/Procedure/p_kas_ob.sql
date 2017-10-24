

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KAS_OB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KAS_OB ***

  CREATE OR REPLACE PROCEDURE BARS.P_KAS_OB (fdat_ in date,fdat2_ in date) is
    s integer;
	s1 integer;
	s2 integer;
	s3 integer;
	s4 integer;
	s5 integer;
	s6 integer;
	s7 integer;
	s8 integer;
	s9 integer;
	s10 integer;
	s11 integer;
	s12 integer;
	s13 integer;
	s14 integer;
	s15 integer;
	s16 integer;
	s17 integer;
	s18 integer;
	s19 integer;
	s20 integer;
	s21 integer;
	s22 integer;
	s23 integer;
	s24 integer;
	s25 integer;
	s26 integer;
	s27 integer;
	s28 integer;
	s29 integer;
	s30 integer;
	s31 integer;
	s32 integer;
	s33 integer;
	s34 integer;
	s35 integer;
	s36 integer;
	s37 integer;
	s38 integer;
	s39 integer;
	s40 integer;
	s41 integer;
	s42 integer;
	s43 integer;
	s44 integer;
	s45 integer;
	s46 integer;
	s47 integer;
	s48 integer;
	s49 integer;
	s50 integer;
	s51 integer;
	s52 integer;
	s53 integer;
	s54 integer;
	s55 integer;
	s56 integer;
	s57 integer;
	s58 integer;
	s59 integer;
	s60 integer;
	s61 integer;
	s62 integer;
	s63 integer;
	s64 integer;
	s65 integer;
	s66 integer;
	s67 integer;
	-------------------------------

begin

    -------------------------------

	delete from temp_kas_ob;
	commit;

	-------------------------------
	SELECT NVL(SUM(D),0),NVL(SUM(K),0)
	INTO s52,s53
	FROM (
	  SELECT
	      DECODE(o.dk, 0, sum(o.s), 0 ) D,
    	  DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nbs,1,4) in '1001'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=039
	  Group by o.dk
	  );

	SELECT NVL(SUM(D),0),NVL(SUM(K),0)
	INTO s,s1
	FROM (
	  SELECT
	      DECODE(o.dk, 0, sum(o.s), 0 ) D,
    	  DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nbs,1,4) in '1001'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=840
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s2,s3
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nbs,1,4) in '1001'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=826
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s4,s5
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nbs,1,4) in '1001'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=978
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s6,s7
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nbs,1,4) in '1001'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=756
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s8,s9
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nbs,1,4) in '1001'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=124
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s10,s11
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830701'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=036
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s12,s13
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nbs,1,4) in '1001'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=643
	  Group by o.dk
	  );

	  --------------------------------------------------------------

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s14,s15
   FROM (
 	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830004'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=840
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s16,s17
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830004'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=826
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s18,s19
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830004'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=124
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s20,s21
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830004'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=978
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s24,s25
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830701'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=840
	  Group by o.dk
	  );


   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s22,s23
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830701'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=826
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s26,s27
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830701'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=124
	  Group by o.dk
	  );


   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s28,s29
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830701'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=978
	  Group by o.dk
	  );


   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s30,s31
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830802'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=840
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s32,s33
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830802'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=124
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s34,s35
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830802'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=756
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s36,s37
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830802'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=826
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s38,s39
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830802'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=978
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s40,s41
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830802'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=643
	  Group by o.dk
	  );


   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s42,s43
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,10) in '9821901401'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=980
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s44,s45
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '1101959'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv
	  Group by o.dk
	  );


   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s46,s47
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '1101991'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=959
	  Group by o.dk
	  );


   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s48,s49
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '1101991'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=961
	  Group by o.dk
	  );

   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s50,s51
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830701'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=208
	  Group by o.dk
	  );

	  SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s62,s63
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts
 	  WHERE
   		   substr(a.nls,1,7) in '9830248'
   		   AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=980
	  Group by o.dk
	  );
	-- ********************* 9819 ************************************
	  SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s54,s55
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,12) in '981930200102'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=840
	  Group by o.dk
	  );

	  SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s56,s57
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,12) in '981930200102'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=978
	  Group by o.dk
	  );

	   SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s58,s59
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,12) in '981950200302'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=840
	  Group by o.dk
	  );

	  SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s60,s61
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,12) in '981950200302'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=978
	  Group by o.dk
	  );

	  SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s64,s65
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   substr(a.nls,1,7) in '9830903'
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=959
	  Group by o.dk
	  );

	  SELECT NVL(SUM(D),0),NVL(SUM(K),0)
   INTO s66,s67
   FROM (
	  SELECT
	       DECODE(o.dk, 0, sum(o.s), 0 ) D,
      	   DECODE(o.dk, 1, sum(o.s), 0 ) K
      FROM
           opldok o, sal a, tabval t , oper p, tts,
		   (SELECT TO_NUMBER(val) kv FROM params WHERE par='BASEVAL') p1
 	  WHERE
   		   a.nls=11014900961
   		   AND a.kv<>p1.kv AND o.sos=5 AND
   		   p.ref=o.ref AND tts.tt=p.tt AND o.fdat between fdat_ and fdat2_ AND
   		   a.fdat=o.fdat AND o.acc=a.acc AND a.kv=t.kv and a.kv=961
	  Group by o.dk
	  );

	  insert into Temp_kas_ob values (s,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,
	  s20,s21,s22,s23,s24,s25,s26,s27,s28,s29,s30,s31,s32,s33,s34,s35,s36,s37,s38,s39,
	  s40,s41,s42,s43,s44,s45,s46,s47,s48,s49,s50,s51,s52,s53,s54,s55,s56,s57,s58,s59,s60,s61,s62,s63,s66,s67);

	  commit;


end p_kas_ob;
/
show err;

PROMPT *** Create  grants  P_KAS_OB ***
grant EXECUTE                                                                on P_KAS_OB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KAS_OB        to RPBN001;
grant EXECUTE                                                                on P_KAS_OB        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KAS_OB.sql =========*** End *** 
PROMPT ===================================================================================== 
