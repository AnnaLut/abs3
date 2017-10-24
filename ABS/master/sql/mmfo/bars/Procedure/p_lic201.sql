

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC201.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC201 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC201 (id_ SMALLINT, p_s DATE, p_po DATE, maska VARCHAR2 )
IS
mfo_  VARCHAR2(12);
fn_   VARCHAR2(12);
nb_   VARCHAR2(38);
okpo_ VARCHAR2(160);
i_    NUMBER;
len_  NUMBER;
tt_   CHAR(3);
l_dat_a date;
BEGIN
--------------------------------------------------------------------
delete from tmp_lic where id=id_;
--------------------------------------------------------------------
FOR c0 IN ( SELECT s.acc, s.fdat, s.ostf, a.nls,
                   a.kv,  t.lcv,  t.name, s.pdat,
                   a.isp, a.nms
            FROM   saldoa s,accounts  a,tabval t
            WHERE  a.acc=s.acc      AND  a.kv=980 AND
                   s.fdat = p_s     AND
                   a.nls LIKE maska AND a.kv=t.kv AND
                   a.tip NOT IN ('N99','L99','N00','T00','T0D',
                           'TNB','TND','TUR','TUD','L00')) LOOP

FOR c1 IN ( SELECT ref, tt, s*DECODE(dk,0,-1,1) s, txt
            FROM   opldok
            WHERE  acc=c0.acc AND fdat=c0.fdat and sos=5) LOOP

FOR c2 IN ( SELECT o.vdat,  o.vob,    o.nd,    o.mfoa,
                   o.nlsa,  o.nam_a,  o.id_a,  o.mfob,
                   o.nlsb,  o.nam_b,  o.id_b,
                   decode(o.tt,c1.tt,o.nazn,'R00',o.nazn,t.name) nazn,
                   o.userid,o.sk,     o.kv,    o.d_rec
           FROM    oper o, tts t
           WHERE   o.ref=c1.ref and c1.tt=t.tt ) LOOP

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

         len_:=Length(okpo_);

         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, c0.pdat, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   c1.s,
                  c2.nd,   c2.mfob, c2.nlsb, c2.nam_b, c2.nazn, okpo_,
                  c2.vdat, c2.sk,   c2.userid );
      ELSE
         len_:=Length(okpo_);

         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, c0.pdat, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   c1.s,
                  c2.nd,   c2.mfoa, c2.nlsa, c2.nam_a, c2.nazn, c2.id_a,
                  c2.vdat, c2.sk,   c2.userid );
         IF c2.mfoa<>gl.aMFO THEN -- smotrim bisi
            BEGIN
               SELECT fn_a, dat_a, rec_a - bis
                 INTO fn_, l_dat_a, i_
                 FROM arc_rrp
                WHERE ref = c1.ref
                  AND bis=1;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN fn_ := NULL;
            END;
            IF fn_ IS NOT NULL THEN
               FOR c4 IN (SELECT RTRIM(nazn)||RTRIM(LTRIM(d_rec)) nazn, bis
                            FROM arc_rrp
                           WHERE fn_a = fn_
                             AND dat_a = l_dat_a
                             AND rec_a-bis=i_
                             AND bis>1)
               LOOP
         len_:=Length(c4.nazn);

         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid, bis )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, c0.pdat, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   c1.s,
                  c2.nd,   c2.mfoa, c2.nlsa, c2.nam_a,
              CONVERT(c4.nazn, 'CL8MSWIN1251','RU8PC866'), c2.id_a,
                  c2.vdat, c2.sk,   c2.userid, c4.bis );
               END LOOP;  -- c4
            END IF;
         END IF;
      END IF;
END LOOP;
END LOOP;
END LOOP;

-- Отбираем ответные информационные
FOR c3 IN ( SELECT a.acc, r.dat_a, a.nls,  a.kv,    a.isp,  a.nms,
                   r.vob, r.s*DECODE(r.dk,2,-1,1) s,
                   r.nd,  r.mfoa,  r.nlsa, r.nam_a, r.nazn, r.id_a, r.dk, r.ref
            FROM   arc_rrp r,accounts a
            WHERE  r.dk>1	        AND r.s>0          AND
                   a.nls=r.nlsb         AND
                   r.mfob=gl.aMFO AND
                   r.mfoa <> gl.aMFO    AND
                   r.kv=980       AND
                   a.kv=980             AND r.dat_a - 1 <= p_s  AND
                   (r.dat_a >= p_s  AND r.dat_a - 1 <= p_s ) AND
                   a.nls LIKE maska )   LOOP
     BEGIN
        SELECT nb INTO nb_ FROM banks WHERE mfo=c3.mfoa;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN nb_:='';
     END;
     BEGIN
        SELECT tt INTO tt_ FROM oper o  WHERE c3.ref=o.ref;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN tt_:='';
     END;


-- информационные для репорта делаем с одним hh:mi, т.е. по fdat одна группа
     c3.dat_a:=trunc(c3.dat_a,'dd')+0.5;
     INSERT INTO tmp_lic
        (id, acc, nls, kv, nms, fdat , isp, nb, vob,
            tt, s, nd, mfo, nlsk, namk, nazn, okpo, userid )
     VALUES
        (id_,      c3.acc,   c3.nls, c3.kv,   c3.nms,
         c3.dat_a, c3.isp,   nb_,    c3.vob,
         tt_,    c3.s,     c3.nd,  c3.mfoa, c3.nlsa,
         CONVERT(c3.nam_a,'CL8MSWIN1251','RU8PC866'),
         CONVERT(c3.nazn, 'CL8MSWIN1251','RU8PC866'),c3.id_a,c3.isp );
END LOOP;

-- Отбираем начальные информационные
FOR c5 IN ( SELECT a.acc, r.dat_a, a.nls,  a.kv,    a.isp,  a.nms,
                   r.vob, r.s*DECODE(r.dk,2,-1,1) s,
                   r.nd,  r.mfob,   r.nlsa, r.nlsb, r.nam_a, r.nazn, r.id_b, r.dk, r.ref
            FROM   arc_rrp r,accounts a
            WHERE  r.dk>1	AND	r.s>0    AND
                   a.nls=r.nlsa AND
                   r.mfoa=gl.aMFO     AND
                   r.mfob <>gl.aMFO AND
                   r.kv=980 AND
                   a.kv=980     AND     (r.dat_a >= p_s  AND r.dat_a - 1 <= p_s ) AND
                   a.nls LIKE maska )   LOOP
     BEGIN
        SELECT nb INTO nb_ FROM banks WHERE mfo=c5.mfob;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN nb_:='';
     END;
     BEGIN
        SELECT tt INTO tt_ FROM oper o  WHERE c5.ref=o.ref;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN tt_:='';
     END;


-- информационные для репорта делаем с одним hh:mi, т.е. по fdat одна группа
     c5.dat_a:=trunc(c5.dat_a,'dd')+0.5;
     INSERT INTO tmp_lic
        (id, acc, nls, kv, nms, fdat , isp, nb, vob,
            tt, s, nd, mfo, nlsk, namk, nazn, okpo, userid )
     VALUES
        (id_,      c5.acc,   c5.nls, c5.kv,   c5.nms,
         c5.dat_a, c5.isp,   nb_,    c5.vob,
         tt_,    c5.s,     c5.nd,  c5.mfob, c5.nlsb,
         CONVERT(c5.nam_a,'CL8MSWIN1251','RU8PC866'),
         CONVERT(c5.nazn, 'CL8MSWIN1251','RU8PC866'),c5.id_b,c5.isp );
END LOOP;

-- Отбираем внутренние ответные информационные
FOR c6 IN ( SELECT a.acc, r.dat_a, a.nls,  a.kv,    a.isp,  a.nms,
                   r.vob, r.s*DECODE(r.dk,2,-1,1) s,
                   r.nd,  r.mfob, r.mfoa,   r.nlsa, r.nam_a, r.nazn, r.id_a, r.dk, r.ref
            FROM   arc_rrp r,accounts a
            WHERE  r.dk>1	AND	r.s>0    AND
                   a.nls=r.nlsb AND
                   r.mfoa=gl.aMFO     AND
                   r.mfob = gl.aMFO AND
                   r.kv=980 AND
                   a.kv=980     AND     (r.dat_a >= p_s  AND r.dat_a - 1 <= p_s ) AND
                   a.nls LIKE maska )   LOOP
     BEGIN
        SELECT nb INTO nb_ FROM banks WHERE mfo=c6.mfob;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN nb_:='';
     END;
     BEGIN
        SELECT tt INTO tt_ FROM oper o  WHERE c6.ref=o.ref;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN tt_:='';
     END;


-- информационные для репорта делаем с одним hh:mi, т.е. по fdat одна группа
     c6.dat_a:=trunc(c6.dat_a,'dd')+0.5;
     INSERT INTO tmp_lic
        (id, acc, nls, kv, nms, fdat , isp, nb, vob,
            tt, s, nd, mfo, nlsk, namk, nazn, okpo, userid )
     VALUES
        (id_,      c6.acc,   c6.nls, c6.kv,   c6.nms,
         c6.dat_a, c6.isp,   nb_,    c6.vob,
         tt_,    c6.s,     c6.nd,  c6.mfoa, c6.nlsa,
         CONVERT(c6.nam_a,'CL8MSWIN1251','RU8PC866'),
         CONVERT(c6.nazn, 'CL8MSWIN1251','RU8PC866'),c6.id_a,c6.isp );
END LOOP;

--- Отбираем внутренние начальные информационные
FOR c7 IN ( SELECT a.acc, r.dat_a, a.nls,  a.kv,    a.isp,  a.nms,
                   r.vob, r.s*DECODE(r.dk,2,-1,1) s,
                   r.nd,  r.mfob,   r.nlsa,  r.nlsb, r.nam_a, r.nazn, r.id_b, r.dk, r.ref
            FROM   arc_rrp r,accounts a
            WHERE  r.dk>1	AND	r.s>0    AND
                   a.nls=r.nlsa AND
                   r.mfoa=gl.aMFO     AND
                   r.mfob = gl.aMFO AND
                   r.kv=980 AND
                   a.kv=980     AND     (r.dat_a >= p_s  AND r.dat_a - 1 <= p_s ) AND
                   a.nls LIKE maska )   LOOP
     BEGIN
        SELECT nb INTO nb_ FROM banks WHERE mfo=c7.mfob;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN nb_:='';
     END;
     BEGIN
        SELECT tt INTO tt_ FROM oper o  WHERE c7.ref=o.ref;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN tt_:='';
     END;


-- информационные для репорта делаем с одним hh:mi, т.е. по fdat одна группа
     c7.dat_a:=trunc(c7.dat_a,'dd')+0.5;
     INSERT INTO tmp_lic
        (id, acc, nls, kv, nms, fdat , isp, nb, vob,
            tt, s, nd, mfo, nlsk, namk, nazn, okpo, userid )
     VALUES
        (id_,      c7.acc,   c7.nls, c7.kv,   c7.nms,
         c7.dat_a, c7.isp,   nb_,    c7.vob,
         tt_,    c7.s,     c7.nd,  c7.mfob, c7.nlsb,
         CONVERT(c7.nam_a,'CL8MSWIN1251','RU8PC866'),
         CONVERT(c7.nazn, 'CL8MSWIN1251','RU8PC866'),c7.id_b,c7.isp );
END LOOP;

END p_lic201;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC201.sql =========*** End *** 
PROMPT ===================================================================================== 
