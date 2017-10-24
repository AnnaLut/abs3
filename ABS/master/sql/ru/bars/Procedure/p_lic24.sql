

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC24.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC24 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC24 (id_ SMALLINT, p_s DATE, p_po DATE, skClient VARCHAR2 ) IS
--=====================================================
-- Module  : REP
-- Comment : виписка по клиенту с суммирующей строкой для корпорат. клиентоов (ANNY)
-- Modification:
--      ANNY - 10/02/2003 - в строке 48 возникала ошибка
--                         "select returns more than one rows "- изсправлено
--=====================================================
mfo_  VARCHAR2(12);
fn_   VARCHAR2(12);
nb_   VARCHAR2(38);
okpo_ VARCHAR2(160);
i_    NUMBER;
nKCou_    NUMBER;  -- кол-во кред. платежей
nDCou_    NUMBER;  -- кол-во деб. платежей
dat_a_  DATE; -- Дата отправки из б-ка А
dat_b_  DATE; -- Дата получения в б-ке В
BEGIN
delete from tmp_lic where id=id_;
FOR c0 IN (SELECT s.acc,s.fdat,s.ostf, a.nls, a.kv, t.lcv, t.name, s.kos,
                  s.dos, s.pdat, a.isp, a.nms, a.dapp, m.okpo, m.nmk, m.rnk
           FROM saldoa s,accounts a, tabval t, cust_acc c, customer m
           WHERE a.acc=s.acc   AND a.kv=980 AND
              ( s.fdat >= p_s  AND s.fdat <= p_po ) AND
              a.kv=t.kv AND  a.tip NOT IN ('N99','L99','N00','T00','T0D', 'TNB','TND','TUR','TUD','L00')
	 		  AND a.acc=c.acc AND c.rnk=m.rnk AND to_char(m.rnk)=skClient)
LOOP
 nKCou_:=0;
 nDCou_:=0;
 FOR c1 IN (SELECT ref,tt,s*DECODE(dk,0,-1,1) s,txt
            FROM opldok
            WHERE acc=c0.acc and fdat=c0.fdat and sos=5 ) LOOP
  IF c1.s>0 THEN nKCou_ := nKCou_ +1;
  ELSE nDCou_ := nDCou_ +1;
  END IF;
  FOR c2 IN (SELECT o.vdat,o.vob,o.nd,
                    o.mfoa,o.nlsa,o.nam_a,o.id_a,
                    o.mfob,o.nlsb,o.nam_b,o.id_b,
                    decode(o.tt,c1.tt,o.nazn,'R00',o.nazn,'R01',o.nazn,t.name) nazn,
                    o.userid,o.sk,o.kv,o.d_rec,
                    decode(o.mfoa,o.mfob,to_date(''),
                           decode(o.mfob,F_OURMFO,o.datp,to_date(''))) DATP,
					pdat
             FROM oper o, tts t
             WHERE o.ref=c1.ref and c1.tt=t.tt )
  LOOP
 --====================================================
 -- Найдем дату ухода платежа из банка А и дату прихода в банк Б
 --====================================================
 -- платеж внешний
 IF c2.mfoa <>gl.aMFO OR c2.mfob <>gl.aMFO THEN
    -- поступление на наш счет в $B
    IF c2.mfoa <>gl.aMFO THEN
          SELECT to_date(to_char(datp,'DDMMYYYY')||fb_t_arm3, 'DDMMYYYYHH24MI'), dat_b INTO dat_a_, dat_b_
	      FROM arc_rrp WHERE ref = c1.ref AND bis=0;
    -- расход с нашего счета
	ELSE
       BEGIN
  	      SELECT datP, datk INTO dat_a_, dat_b_
          FROM arc_rrp  a, zag_b z
	      WHERE fn_b=fn AND a.ref = c1.ref;
        EXCEPTION   -- деньги еще не пришли в другой банк (файл не сквитовался)
          WHEN NO_DATA_FOUND THEN dat_b_ := NULL;
        END;
    END IF;
 -- платеж внутренний
 ELSE
    dat_a_:=c2.pdat; dat_b_:=c2.vdat;
 END IF;
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
      --===== Приход на счет ============
      IF c0.nls=c2.nlsa AND c0.kv=c2.kv THEN
         i_ := INSTR(c2.d_rec,'#o');
         IF i_>0 THEN
            okpo_ := SUBSTR(c2.d_rec,i_+2);
            okpo_ := RTRIM(LTRIM(SUBSTR(okpo_,1,INSTR(okpo_,'#')-1)));
         ELSE
            okpo_ := c2.id_b;
         END IF;
         INSERT INTO tmp_lic
            (id,  nls, kv, nms,  fdat, dapp, nb,
             s, nd, mfo, nlsk, namk, nazn, okpo, datp, crd_pere, vob, nlsalt, nlskalt, nmk2, DOSPQ)
         VALUES
            (id_, c0.nls,  c0.kv,   c0.nms,
			 c0.fdat, dat_a_,  nb_,
                  c1.s,  c2.nd,   c2.mfob, c2.nlsb, c2.nam_b, c2.nazn, okpo_,
                  dat_b_, 1 , gl.aMFO,  c0.nls, c0.okpo, c0.nmk, c0.rnk);
      --===== Расход со счета ============
      ELSE
         INSERT INTO tmp_lic
            (id, nls, kv, nms, fdat, dapp, nb,
            s, nd, mfo, nlsk, namk, nazn, okpo, datp, crd_pere, vob, nlsalt, nlskalt, nmk2, DOSPQ )
         VALUES
            (id_, c2.nlsa,  c0.kv,   c0.nms,
                  c0.fdat, dat_a_,  nb_,
                  c1.s, c2.nd,   gl.aMFO, c0.nls, c0.nmk, c2.nazn, c0.okpo,
                  dat_b_, 1 , c2.mfoa, c2.nlsa,  c2.id_a, c2.nam_a, c0.rnk);
--========  Бисы не показываем ======================
      END IF;
  END LOOP;
 END LOOP;
--===============================================
-- искусственно сделаем груповую строку по счету
--===============================================
  INSERT INTO tmp_lic
         (id, nls,    nms,     fdat,    dapp,    ostf,    dosq,    kosq,    bis,    s,     crd_pere, DOSPQ)
  VALUES (id_, c0.nls, c0.nms,  c0.fdat, c0.dapp, c0.ostf, c0.dos, c0.kos, nDCou_, nKCou_, 0	   ,c0.rnk);
END LOOP;
--====== Информационные платежи =====================
FOR c3 IN ( SELECT a.acc,r.dat_a,a.nls,a.kv,a.isp,a.nms,
                   r.vob,r.s*DECODE(r.dk,2,-1,1) s,
                   r.nd,r.mfoa,r.nlsa,r.nam_a,r.nazn,r.id_a ,r.datp, m.nmk, m.okpo, m.rnk
              FROM arc_rrp r,accounts a, cust_acc c, customer m
             WHERE r.dk>1 AND r.s>0 AND a.nls=r.nlsb AND r.kv=980 AND
                 a.kv=980 AND
                ( r.dat_a >= p_s  AND r.dat_a - 1 <= p_po ) AND
                  a.acc=c.acc AND c.rnk=m.rnk AND  to_char(m.rnkp)=skClient)
LOOP
     BEGIN
        SELECT nb INTO nb_ FROM banks WHERE mfo=c3.mfoa;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN nb_:='';
     END;
     INSERT INTO tmp_lic
        (id, nls, nms, fdat, nb,
            s, nd, mfo, nlsk, namk, nazn, okpo, datp, crd_pere,  vob, nlsalt, nlskalt, nmk2, DOSPQ )
     VALUES
        (id_, c3.nlsa, c3.nms,  c3.dat_a,  nb_,
          c3.s, c3.nd, c3.mfoa, c3.nlsa,
		  CONVERT(c3.nam_a,'CL8MSWIN1251','RU8PC866'),
          CONVERT(c3.nazn, 'CL8MSWIN1251','RU8PC866'),
		  c3.id_a,  c3.datp, 2, gl.aMFO, c3.nlsa, c3.okpo, CONVERT(c3.nmk, 'CL8MSWIN1251','RU8PC866') , c3.rnk );
END LOOP;
END p_lic24;
/
show err;

PROMPT *** Create  grants  P_LIC24 ***
grant EXECUTE                                                                on P_LIC24         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC24.sql =========*** End *** =
PROMPT ===================================================================================== 
