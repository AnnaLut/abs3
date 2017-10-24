

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DPT_RPT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DPT_RPT ***

  CREATE OR REPLACE PROCEDURE BARS.P_DPT_RPT 
   (id_ INT, kod_ INT, dat1_ DATE, dat2_ DATE, maska VARCHAR2 )
IS
  ost_   NUMBER;
  ostn_  NUMBER;
  count_ NUMBER;
  nal_   NUMBER;
  nls_   VARCHAR2(15);
  nlsn_  VARCHAR2(15);
  acc_   NUMBER;
  accn_  NUMBER;
  dos_   NUMBER;
  kos_   NUMBER;

BEGIN

 DELETE FROM tmp_dpt_rpt WHERE id=id_ AND kod=kod_;

 -------- 1. Операційний щоденник  -----------
 IF kod_=1 THEN
    FOR dpt IN
         (SELECT d.deposit_id, d.vidd, v.type_name, d.acc,
                 a.nls, a.kv, t.name, s.ostf OST
          FROM dpt_deposit_clos d, saldoa s, accounts a, tabval t, dpt_vidd v
          WHERE d.action_id=0 AND d.acc=a.acc  AND a.acc=s.acc   AND
                t.kv=a.kv     AND s.fdat=dat1_ AND v.vidd=d.vidd
          UNION ALL
          SELECT d.deposit_id, d.vidd, v.type_name, a.acc,
                 a.nls, a.kv, t.name, s.ostf
          FROM dpt_deposit_clos d, int_accn i, saldoa s, accounts a, tabval t, dpt_vidd v
          WHERE d.action_id=0 AND d.acc=i.acc AND i.acra=a.acc AND t.kv=a.kv AND
                a.acc=s.acc   AND i.id=1      AND s.fdat=dat1_ AND v.vidd=d.vidd
          ORDER BY 1, 4)
    LOOP

      count_:=0; ost_:=dpt.ost;

      FOR opl IN
          (SELECT o.tt, o.ref, p.userid, f.fio, p.nazn,
                  decode(o.dk,1,o.s,0) S_K, decode(o.dk,0,o.s,0) S_D
           FROM opldok o, staff f, oper p
           WHERE o.acc=dpt.acc AND p.ref=o.ref AND o.sos=5 AND
                 p.userid=f.id AND o.fdat=dat1_
           ORDER BY o.ref, o.dk desc)
      LOOP

        INSERT INTO tmp_dpt_rpt
            (id, kod, dat, deposit_id, nls, kv, kv_name, vidd, type_name,
             tt, ref, ost, s_k, s_d, vdat, userid, fio, nazn)
         VALUES
            (id_, kod_, dat1_, dpt.deposit_id, dpt.nls, dpt.kv, dpt.name, dpt.vidd, dpt.type_name,
             opl.tt, opl.ref, ost_, opl.s_k, opl.s_d, dat1_, opl.userid, opl.fio, opl.nazn );

         count_:=count_+1;
         ost_:=ost_-opl.s_d+opl.s_k;

      END LOOP;
    END LOOP;
 -------- 2. Підсумки по операціям   -----------
 ELSIF kod_=2 THEN
     FOR opt IN
	  (SELECT d.vidd VIDD, d.kv, o.tt TT, o.ref,o.fdat,o.stmt, o.dk, o.s S1,0 S2
       FROM dpt_deposit_clos d, opldok o
       WHERE o.acc=d.acc AND o.sos=5 AND d.action_id=0 AND o.fdat>=dat1_ AND o.fdat<=dat2_
       UNION ALL
       SELECT d.vidd VIDD, d.kv, o.tt TT, o.ref,o.fdat,o.stmt, o.dk, 0 S1, o.s S1
       FROM dpt_deposit_clos d, int_accn i, opldok o, accounts a
       WHERE d.acc=a.acc AND i.id=1 AND o.acc=i.acra AND  o.sos=5 AND d.action_id=0 AND
	         a.acc=i.acc AND  o.fdat>=dat1_ AND o.fdat<=dat2_)
     LOOP

       BEGIN
	     SELECT 0 INTO nal_    FROM accounts a, opldok o
         WHERE a.acc=o.acc     AND o.ref=opt.ref AND o.tt=opt.tt     AND
	           o.stmt=opt.stmt AND o.dk=1-opt.dk AND o.fdat=opt.fdat AND
			   (a.tip='KAS' OR a.nbs LIKE '100%') ;
         EXCEPTION WHEN NO_DATA_FOUND THEN nal_:=1;
       END;

       INSERT INTO tmp_dpt_rpt (id, kod,  vidd,kv, tt, ref, s_k, s_d)
        VALUES (id_, 2, opt.vidd, opt.kv, opt.tt, nal_, opt.s1, opt.s2);

    END LOOP;

 -------- 3. Обороти в розрізі ГОТ\БезГот коштів   -----------
 ELSIF kod_=3 THEN
     FOR opd IN
		  (SELECT d.vidd, d.kv, o.ref, o.tt, o.fdat, o.stmt, o.dk,
                  decode(o.dk,0,o.s,0) s_d, decode(o.dk,1,o.s,0) s_k
           FROM dpt_deposit_clos d, opldok o
           WHERE o.acc=d.acc AND o.sos=5 AND d.action_id=0 AND o.fdat>=dat1_ AND o.fdat<=dat2_
           UNION ALL
           SELECT d.vidd, d.kv, o.ref, o.tt, o.fdat, o.stmt, o.dk,
                  decode(o.dk,0,o.s,0) s_d, decode(o.dk,1,o.s,0) s_k
           FROM dpt_deposit_clos d, int_accn i, opldok o, accounts a
           WHERE d.acc=a.acc AND i.id=1 AND o.acc=i.acra AND  o.sos=5 AND d.action_id=0 AND
                 a.acc=i.acc AND  o.fdat>=dat1_ AND o.fdat<=dat2_)
     LOOP

       BEGIN
	     SELECT 0 INTO nal_    FROM accounts a, opldok o
         WHERE a.acc=o.acc     AND o.ref=opd.ref AND o.tt=opd.tt     AND
	           o.stmt=opd.stmt AND o.dk=1-opd.dk AND o.fdat=opd.fdat AND
			   (a.tip='KAS' OR a.nbs LIKE '100%') ;
         EXCEPTION WHEN NO_DATA_FOUND THEN nal_:=1;
       END;

       INSERT INTO tmp_dpt_rpt (id, kod, vidd, kv, tt, ref, s_k, s_d)
        VALUES (id_, 3, opd.vidd,  opd.kv, opd.tt, nal_, opd.s_k, opd.s_d);

    END LOOP;
 -------- 5. Ощадна книжка (фактичний рух)   -----------------
 ELSIF kod_=5 THEN
	 FOR acc IN
        (SELECT d.deposit_id, a.acc, a.nls, a.kv, t.lcv, t.name,
		substr(c.nmk,1,60) FIO, v.vidd, v.type_name
         FROM accounts a, dpt_deposit_clos d, customer c, tabval t,dpt_vidd v
         WHERE d.action_id=0 AND d.deposit_id=to_number(maska) AND v.vidd=d.vidd AND
               c.rnk=d.rnk   AND t.kv=a.kv                     AND
              (a.acc=d.acc OR
               a.acc=(SELECT acra FROM int_accn WHERE acc=d.acc)))
	 LOOP
       FOR sal IN
          (SELECT fdat, nvl(dos,0) DOS, nvl(kos,0) KOS FROM saldoa
           WHERE acc=acc.acc AND  fdat>=dat1_ AND fdat<=dat2_)
	   LOOP

         SELECT a.nls, nvl(fost(d.acc,sal.fdat),0) INTO nls_, ost_
         FROM dpt_deposit_clos d, accounts a
         WHERE a.acc=d.acc AND d.action_id=0 AND d.deposit_id=acc.deposit_id;

         SELECT a.nls, nvl(fost(i.acra,sal.fdat),0) INTO nlsn_, ostn_
		 FROM dpt_deposit_clos d, int_accn i, accounts a
         WHERE i.acc=d.acc AND i.id=1 AND i.acra=a.acc AND
		       d.action_id=0 AND d.deposit_id=acc.deposit_id;

         INSERT INTO tmp_dpt_rpt
             (id, kod, dat, deposit_id, nls, nazn, fio, kv, kv_name,
		      vidd, type_name, ost, ref, s_k, s_d)
         VALUES
             (id_, 5, sal.fdat, acc.deposit_id, nls_, nlsn_, acc.fio,
		      acc.kv, acc.name, acc.vidd, acc.type_name,
		      ost_,ostn_, sal.kos, sal.dos );
       END LOOP;
    END LOOP;

 ------- 6. Ощадна книжка (з урахув. незавізованих док-тів) --

 ELSIF kod_=6 THEN
   FOR acc IN
        (SELECT d.deposit_id, a.acc, a.nls, a.kv, t.lcv, t.name,
	        substr(c.nmk,1,60) FIO, v.vidd, v.type_name
         FROM accounts a, dpt_deposit_clos d, customer c, tabval t,dpt_vidd v
         WHERE d.action_id=0 AND d.deposit_id=to_number(maska) AND v.vidd=d.vidd AND
               c.rnk=d.rnk   AND t.kv=a.kv                     AND
              (a.acc=d.acc OR
               a.acc=(SELECT acra FROM int_accn WHERE acc=d.acc))
		 ORDER BY a.acc)
   LOOP
     FOR sal IN
          (SELECT fdat, sum(decode(dk,0,s,0)) DOS, sum(decode(dk,1,s,0)) KOS
           FROM opldok
           WHERE acc=acc.acc AND fdat>=dat1_ AND fdat<=dat2_ AND sos>=0
           GROUP BY fdat)
     LOOP
          -- фактический остаток депозитного счета
          SELECT s.acc, s.nls, nvl(s.ost,0) INTO acc_, nls_, ost_
          FROM dpt_deposit_clos d, sal s
          WHERE s.acc=d.acc                 AND d.action_id=0 AND
	        d.deposit_id=acc.deposit_id AND s.fdat=sal.fdat;
          -- есть ли незавизир.док-ты по депозитному счету за этот день
	  BEGIN
            SELECT nvl(sum(decode(dk,0,s,0)),0), nvl(sum(decode(dk,1,s,0)),0)
            INTO dos_, kos_  FROM opldok
            WHERE acc=acc_ AND fdat=sal.fdat AND sos>=0 AND sos<5;
	  EXCEPTION WHEN NO_DATA_FOUND THEN dos_:=0; kos_:=0;
          END;
          ost_:=ost_ - dos_ + kos_ ;

	  -- фактический остаток счета начисленных %%
          SELECT s.acc, s.nls, nvl(s.ost,0) INTO accn_, nlsn_, ostn_
          FROM dpt_deposit_clos d, int_accn i, sal s
          WHERE i.acc=d.acc   AND i.id=1   AND i.acra=s.acc    AND
		d.action_id=0 AND d.deposit_id=acc.deposit_id  AND s.fdat=sal.fdat;
          -- есть ли незавизир.док-ты по счету нач.%% за этот день
	  BEGIN
            SELECT nvl(sum(decode(dk,0,s,0)),0), nvl(sum(decode(dk,1,s,0)),0)
            INTO dos_, kos_  FROM opldok
            WHERE acc=accn_ AND fdat=sal.fdat AND sos>=0 AND sos<5;
	  EXCEPTION WHEN NO_DATA_FOUND THEN dos_:=0; kos_:=0;
          END;
          ostn_:=ostn_ - dos_ + kos_ ;

         INSERT INTO tmp_dpt_rpt
             (id, kod, dat, deposit_id, nls, nazn, fio, kv, kv_name,
		      vidd, type_name, ost, ref, s_k, s_d)
         VALUES
             (id_, 6, sal.fdat, acc.deposit_id, nls_, nlsn_, acc.fio,
		      acc.kv, acc.name, acc.vidd, acc.type_name,
		      ost_,ostn_, sal.kos, sal.dos );
       END LOOP;
    END LOOP;
 ELSE
   RETURN;
 END IF;
END p_dpt_rpt;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DPT_RPT.sql =========*** End ***
PROMPT ===================================================================================== 
