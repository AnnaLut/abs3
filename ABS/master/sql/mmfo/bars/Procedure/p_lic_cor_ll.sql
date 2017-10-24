

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC_COR_LL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC_COR_LL ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC_COR_LL (id_ SMALLINT, p_s DATE, p_po DATE, maska VARCHAR2, isp_ integer)
IS
mfo_  VARCHAR2(12);
fn_   VARCHAR2(12);
nb_   VARCHAR2(38);
okpo_ VARCHAR2(160);
i_    NUMBER;
nuch_ DATE;
pdat_ DATE;
BEGIN
-------------------------------------------------------------------
delete from tmp_lic where id=id_;
-------------------------------------------------------------------
FOR c0 IN (SELECT DISTINCT s.acc,s.fdat,s.ostf,a.nls,a.kv,t.lcv,t.name,s.pdat,a.isp,a.nms
             FROM saldoa s, accounts a,tabval t,oper o, accounts a2
            WHERE a.acc=s.acc
              --AND a.kv=980
              AND(s.fdat >= p_s  AND s.fdat <= p_po )
              and a.nls=o.nlsb
			  and a.nbs in (2600, 2650)
			  and o.MFOA = f_ourmfo
			  and o.MFOB = f_ourmfo
              and o.tt='KK1' --or  o.nlsa like '20%')
              AND(o.vdat >= p_s  AND o.vdat <= p_po )
              AND a.nls LIKE maska
			  and a2.nls=o.nlsa
			  and o.sos=5
			  and (a2.isp= isp_ or isp_= 0)
              AND a.kv=t.kv
              AND a.tip NOT IN ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00')) LOOP
-------  фрагмент уточнения pdat_
 BEGIN
  SELECT fdat INTO nuch_ FROM saldoa s
  WHERE pdat is null and dos=0 and kos=0 and ostf=0 and acc=c0.acc;
  EXCEPTION
               WHEN NO_DATA_FOUND THEN nuch_ := NULL;
 END;

  IF c0.pdat=nuch_ THEN
   pdat_ := '';
  ELSE
   pdat_ := c0.pdat;
  END IF;
------------
 FOR c1 IN ( SELECT distinct ref,tt,s*DECODE(dk,0,-1,1) s,txt, dk
               FROM opldok
              WHERE acc=c0.acc and fdat=c0.fdat and sos=5) LOOP

  FOR c2 IN (SELECT DISTINCT o.vdat,o.vob,o.nd,o.mfoa,o.nlsa,o.nam_a,o.id_a,
                    o.mfob,o.nlsb,o.nam_b,o.id_b,
                    decode(o.tt,c1.tt,o.nazn,'R00',o.nazn, 'R01',o.nazn,
                          decode(c1.tt,'R00',o.nazn,'R01',o.nazn, t.name)) nazn,
                    o.userid,o.sk,o.kv,o.d_rec
               FROM oper o, tts t
              WHERE o.ref=c1.ref and c1.tt=t.tt ) LOOP
      IF c0.nls=c2.nlsa AND c0.kv=c2.kv THEN
         mfo_ := c2.mfob;
      ELSE
         mfo_ := c2.mfoa;
      END IF;

      BEGIN
         SELECT nb INTO nb_ FROM banks WHERE mfo=mfo_;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN nb_:='';
      END;

      IF c0.nls=c2.nlsa AND c0.kv=c2.kv THEN
         i_ := INSTR(c2.d_rec,'#o');
         IF i_>0 THEN
            okpo_ := SUBSTR(c2.d_rec,i_+2);
            okpo_ := RTRIM(LTRIM(SUBSTR(okpo_,1,INSTR(okpo_,'#')-1)));
         ELSE
            okpo_ := c2.id_b;
         END IF;
----------------------------------------------------------------------
      IF c1.tt = 'OVR' AND c1.dk = 1 THEN
        FOR i IN ( SELECT a.kv, a.nls, o.txt, o.s
                    FROM accounts a, opldok o
                     WHERE a.acc  =  o.acc
                       AND o.acc  <> c0.acc
                       AND o.ref  =  c1.ref
                       AND o.dk   =  0
                       AND o.s    =  c1.s )
        LOOP
         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, pdat_, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   i.s,
                  c2.nd,   c2.mfob, i.nls, c2.nam_b, i.txt, okpo_,
                  c2.vdat, c2.sk,   c2.userid );

        END LOOP;
      ELSE
         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, pdat_, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   c1.s,
                  c2.nd,   c2.mfob, c2.nlsb, c2.nam_b, c2.nazn, okpo_,
                  c2.vdat, c2.sk,   c2.userid );
     END IF;
----------------------------------------------------------------------
      ELSE
         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, pdat_, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   c1.s,
                  c2.nd,   c2.mfoa, c2.nlsa, c2.nam_a, c2.nazn, c2.id_a,
                  c2.vdat, c2.sk,   c2.userid );

         IF c2.mfoa<>gl.aMFO THEN -- smotrim bisi
            BEGIN
               SELECT fn_a,rec_a - bis INTO fn_, i_
                FROM arc_rrp WHERE ref = c1.ref AND bis=1;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN fn_ := NULL;
            END;

            IF fn_ IS NOT NULL THEN
               FOR c4 IN (SELECT RTRIM(nazn)||RTRIM(LTRIM(d_rec)) nazn,bis
                            FROM arc_rrp
                           WHERE fn_a = fn_ AND rec_a-bis=i_ AND bis>1) LOOP

         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid, bis )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, pdat_, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   c1.s,
                  c2.nd,   c2.mfoa, c2.nlsa, c2.nam_a,
                  decode(sep.version,2,c4.nazn,CONVERT(c4.nazn, 'CL8MSWIN1251','RU8PC866')), c2.id_a,
                  c2.vdat, c2.sk,   c2.userid, c4.bis );

               END LOOP;  -- c4
            END IF;
         END IF;

      END IF;
  END LOOP;
 END LOOP;
END LOOP;

FOR c3 IN ( SELECT a.acc,r.dat_a,a.nls,a.kv,a.isp,a.nms,
                   r.vob,r.s*DECODE(r.dk,2,-1,1) s,
                   r.nd,r.mfoa,r.nlsa,r.nam_a,r.nazn,r.id_a
              FROM arc_rrp r,accounts a
             WHERE r.dk>1 AND r.s>0 AND a.nls=r.nlsb AND r.kv=980 AND
                 a.kv=980 AND
                ( r.dat_a >= p_s  AND r.dat_a - 1 <= p_po ) AND
                a.nls LIKE maska ) LOOP

     BEGIN
        SELECT nb INTO nb_ FROM banks WHERE mfo=c3.mfoa;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN nb_:='';
     END;

     INSERT INTO tmp_lic
        (id, acc, nls, kv, nms, fdat, isp, nb, vob,
            tt, s, nd, mfo, nlsk, namk, nazn, okpo, userid )
     VALUES
        (id_, c3.acc,   c3.nls, c3.kv,   c3.nms,
              c3.dat_a, c3.isp, nb_, c3.vob,
      'ЗПТ',  c3.s, c3.nd, c3.mfoa, c3.nlsa,
           decode(sep.version,2,c3.nam_a,CONVERT(c3.nam_a,'CL8MSWIN1251','RU8PC866')),
           decode(sep.version,2,c3.nazn,CONVERT(c3.nazn, 'CL8MSWIN1251','RU8PC866')),c3.id_a,c3.isp );

END LOOP;

END p_lic_cor_ll;
 
/
show err;

PROMPT *** Create  grants  P_LIC_COR_LL ***
grant EXECUTE                                                                on P_LIC_COR_LL    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_LIC_COR_LL    to START1;
grant EXECUTE                                                                on P_LIC_COR_LL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC_COR_LL.sql =========*** End 
PROMPT ===================================================================================== 
