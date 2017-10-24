

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KD888.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KD888 ***

  CREATE OR REPLACE PROCEDURE BARS.P_KD888 
   (id_ SMALLINT, p_s DATE, p_po DATE, maska_ VARCHAR2 )
IS
mfo_   VARCHAR2(12);
fn_    VARCHAR2(12);
nb_    VARCHAR2(38);
okpo_  VARCHAR2(160);
ost_   NUMBER;
i_     NUMBER;
count_ INTEGER;
BEGIN
DELETE FROM tmp_lic WHERE id=id_;
count_:=0;
FOR c IN (SELECT s.acc, a.nls, a.kv, a.isp, a.nms,
                 t.lcv, t.name, s.fdat, s.ostf, s.pdat
          FROM saldoa s, accounts a, tabval t
          WHERE a.acc=s.acc AND a.kv=t.kv AND
                  (s.fdat>=p_s AND s.fdat<=p_po) AND
                       a.kv=980 AND a.nls=maska_)
LOOP
  SELECT ost INTO ost_ FROM sal WHERE acc=c.acc AND fdat=c.fdat;
  FOR c0 IN (SELECT a.acc, a.nls, a.kv, s.fdat
              FROM accounts a, saldoa s
              WHERE a.acc=s.acc AND s.fdat = c.fdat AND a.accc=c.acc)
   LOOP
     count_:=count_+1;
     FOR c1 IN (SELECT ref, dk, tt, s*DECODE(dk,0,-1,1) s
                FROM opldok
                WHERE acc=c0.acc and fdat=c0.fdat and sos=5)
      LOOP
        FOR c2 IN (SELECT o.vdat,o.vob,o.nd,o.nazn,o.userid,o.kv,o.d_rec,
                          o.mfoa,o.nlsa,o.nam_a,o.id_a,
                          o.mfob,o.nlsb,o.nam_b,o.id_b
                    FROM oper o, tts t
                    WHERE o.ref=c1.ref and t.tt=c1.tt)
            LOOP
              IF c1.tt='KDV'  THEN
                 IF c1.dk=1 THEN c2.nlsa:=c2.nlsb; c2.nlsb:=c.nls;
                 ELSE  c2.nlsa:=c2.nlsa;
                 END IF;
              ELSE
                 IF    c0.nls=c2.nlsa AND c0.kv=c2.kv THEN c2.nlsa:=c.nls;
                 ELSIF c0.nls=c2.nlsb AND c0.kv=c2.kv THEN c2.nlsb:=c.nls;
                 ELSE  c2.nlsa:=c2.nlsa;
                 END IF;
              END IF;
              BEGIN
                 IF c.nls=c2.nlsa AND c.kv=c2.kv THEN i_ := INSTR(c2.d_rec,'#o');
                   IF i_>0 THEN okpo_ := SUBSTR(c2.d_rec,i_+2);okpo_ := RTRIM(LTRIM(SUBSTR(okpo_,1,INSTR(okpo_,'#')-1)));
                   ELSE  okpo_ := c2.id_b;
				   END IF;
                   INSERT INTO tmp_lic
                    (id, acc, nls, kv, nms, fdat, dapp, ostf, osti, isp, nb, vob,
                     ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, userid)  VALUES
                    (id_,c.acc,c.nls,c.kv,c.nms,c.fdat,c.pdat,c.ostf,ost_,c.isp, nb_, c2.vob,
                     c1.ref,c1.tt,c1.s,c2.nd,c2.mfob,c2.nlsb,c2.nam_b,c2.nazn,okpo_,c2.vdat,c2.userid);
                 ELSE
                   INSERT INTO tmp_lic
                    (id, acc, nls, kv, nms, fdat, dapp, ostf, osti,  isp, nb, vob,
                     ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat,  userid ) VALUES
                    (id_, c.acc,  c.nls,  c.kv,   c.nms,c.fdat, c.pdat, c.ostf,ost_, c.isp, nb_, c2.vob,
                     c1.ref,  c1.tt,   c1.s,c2.nd,   c2.mfoa, c2.nlsa, c2.nam_a, c2.nazn, c2.id_a,c2.vdat, c2.userid );
                 END IF;
            END LOOP; --c2
      END LOOP;--c1
   END LOOP; --c0
END LOOP; --c
--если не было движения по счету
IF count_=0 THEN
FOR c5 IN
    (SELECT s.acc,s.ost,s.nls,s.kv,t.lcv,t.name,s.isp,s.nms
     FROM sal s, tabval t
     WHERE s.accc=(SELECT acc FROM accounts
                   WHERE kv=980 AND nls=maska_ ) AND
           s.fdat=(SELECT min(fdat) FROM sal
			       WHERE acc=s.acc AND
	                  fdat >= p_s  AND s.fdat <= p_po ) AND
           s.kv=t.kv)
		  LOOP
            INSERT INTO tmp_lic (id, acc, nls, kv, nms, ostf,  isp )
            VALUES (id_, c5.acc, c5.nls,  c5.kv, c5.nms, c5.ost, c5.isp );
          END LOOP;
END IF;
END LOOP;
END p_kd888;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KD888.sql =========*** End *** =
PROMPT ===================================================================================== 
