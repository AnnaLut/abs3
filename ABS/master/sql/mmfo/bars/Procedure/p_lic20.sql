

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC20.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC20 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC20 (id_ SMALLINT, p_s DATE, p_po DATE, maska VARCHAR2 )
IS
-----                 !! *** Версия 12 от 12/08-08  (26/12-06) ***
-- 26-01-2009 Добавлено поле pdat - дата поступления (oper.pdat/ arc_rrp.datp )
mfo_  VARCHAR2(12);
fn_   VARCHAR2(12);
nb_   VARCHAR2(38);
okpo_ VARCHAR2(160);
i_    NUMBER;
nuch_ DATE;
pdat_ DATE;
SK_   number;
sep_n int; nazn_ VARCHAR2(220);
d_recf_ varchar2(60);
ref_af varchar2(9);
nz_bis varchar2(160);  bis_ int;
e_com number;

BEGIN
select F_GET_PARAMS('SEPNUM',0) into sep_n from dual;
-------------------------------------------------------------------
delete from tmp_lic where id=id_;
-------------------------------------------------------------------
FOR c0 IN ( SELECT s.acc,s.fdat,s.ostf,a.nls,a.kv,t.lcv,t.name,
                   s.pdat,a.isp,a.nms
             FROM saldoa s,accounts a,tabval t
             WHERE a.acc=s.acc   AND a.kv=980 AND
                   ( s.fdat >= p_s  AND s.fdat <= p_po ) AND
                   a.nls LIKE maska AND a.kv=t.kv AND
             a.tip NOT IN ('N99','L99','N00','T00','T0D',
                           'TNB','TND','TUR','TUD','L00'))
LOOP
-------  фрагмент уточнения pdat_
 BEGIN
  SELECT fdat INTO nuch_ FROM saldoa s
  WHERE pdat is null and dos=0 and kos=0 and ostf=0 and acc=c0.acc;
  EXCEPTION WHEN NO_DATA_FOUND THEN nuch_ := NULL;
 END;

  IF c0.pdat=nuch_ THEN
     pdat_ := '';
  ELSE
     pdat_ := c0.pdat;
  END IF;
---------- здесь найдем все реквизиты по opldok для счета по маске и его счет-корреспондент
 FOR c1 IN ( SELECT m.ref, m.tt ,m.s*DECODE(m.dk,0,-1,1) s, m.txt, m.dk, m.stmt,b.nls nlsk
             FROM opldok m, opldok k ,accounts b  -- m - для счета по маске, k - его корреспондент
             WHERE m.ref=k.ref and m.acc=c0.acc and m.fdat=c0.fdat and m.sos=5 and m.stmt=k.stmt and  m.dk<>k.dk and k.acc=b.acc)
 LOOP
--LOGGER.INFO('P_LIC20:=c0.nls '||C0.NLS);
--LOGGER.INFO('P_LIC20:=cursor c1'||'='||C1.REF||'='||C1.TT||'='||C1.S||'='||C1.DK||'='||C1.STMT||'='||C1.NLSK);
------  реквизиты документа по OPER (с учетом DK)
  FOR c2 IN (SELECT o.vdat, o.vob, o.nd,
/*                  decode(o.dk,1,o.mfoa,o.mfob) mfoa,   -- попробовала учитывать знак DK в Oper
                    decode(o.dk,1,o.nlsa,o.nlsb) nlsa,
                    decode(o.dk,1,o.nam_a,o.nam_b) nam_a,
					decode(o.dk,1,o.id_a, o.id_b) id_a,
                    decode(o.dk,1,o.mfob, o.mfoa) mfob,
					decode(o.dk,1,o.nlsb,o.nlsa) nlsb,
					decode(o.dk,1,o.nam_b,o.nam_a) nam_b,
					decode(o.dk,1,o.id_b, o.id_a)  id_b,*/
                    o.mfoa,o.nlsa,o.nam_a,o.id_a,o.mfob,o.nlsb,o.nam_b,o.id_b,o.pdat,
                    decode(o.tt,c1.tt,o.nazn,
                                'R00',o.nazn,
                               'R01',o.nazn,
                                'D01',o.nazn,
                                decode(c1.tt,'R00',o.nazn,
                                             'R01',o.nazn,
                                             'D01',o.nazn,
                                                   t.name)) nazn,
                    o.userid, o.sk, o.kv, o.d_rec, o.tt
               FROM oper o, tts t
              WHERE o.ref=c1.ref and c1.tt=t.tt )
  LOOP
--LOGGER.INFO('P_LIC20:=cursor c2'||'='||C2.NLSA||'='||C2.NLSB||'='||C2.NAZN);
--LOGGER.INFO('P_LIC20:=cursor c2_парам.'||'='||C0.NLS||'='||C2.NLSA||'='||C0.KV||'='||C2.KV);
      nazn_ := c2.nazn; bis_:=0;
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
--LOGGER.INFO('P_LIC20:=FOR_BIG_IF'||'='||C0.NLS||'='||C2.NLSA||'='||C0.KV||'='||C2.KV);
      IF c0.nls=c2.nlsa AND c0.kv=c2.kv THEN
--LOGGER.INFO('P_LIC20:=BIG_IF'||'='||C0.NLS||'='||C2.NLSA||'='||C0.KV||'='||C2.KV);
         i_ := INSTR(c2.d_rec,'#o');
         IF i_>0 THEN
            okpo_ := SUBSTR(c2.d_rec,i_+2);
            okpo_ := RTRIM(LTRIM(SUBSTR(okpo_,1,INSTR(okpo_,'#')-1)));
         ELSE
            okpo_ := c2.id_b;
         END IF;
----------------------------------------------------------------------
      IF c1.tt = 'OVR' AND c1.dk = 1 THEN
--LOGGER.INFO('P_LIC20:=OVR'||C1.TT||C1.DK);
        FOR i IN ( SELECT a.kv, a.nls, o.txt, o.s
                   FROM accounts a, opldok o
                   WHERE a.acc  =  o.acc
                         AND o.acc  <> c0.acc
                         AND o.ref  =  c1.ref
                         AND o.dk   =  0
                         AND o.s    =  c1.s )
        LOOP
--LOGGER.INFO('P_LIC20:=Insert #1');
         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid,pdat )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, pdat_, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   i.s,
                  c2.nd,   c2.mfob, i.nls, c2.nam_b, i.txt, okpo_,
                  c2.vdat, c2.sk,   c2.userid,c2.pdat );

        END LOOP;
--------   обробка доч_рн_х проводок ( п_дм_на nls, nms, ks, nazn )
      ELSIF c1.tt <> c2.tt AND c1.dk = 0 THEN
--LOGGER.INFO('P_LIC20:=doch=c1.tt <> c2.tt'||C1.TT||C2.TT||C1.DK);
         FOR i IN
		   (SELECT a.kv, a.nls, o.txt, o.s,
                           a.nms
              FROM accounts a, opldok o
             WHERE a.acc   =  o.acc
               AND o.acc   <> c0.acc
               AND o.ref   =  c1.ref
               AND o.dk    =  1 - c1.dk
               AND o.s     =  abs(c1.s)
			   AND c1.stmt =  o.stmt  )
         LOOP
          begin
          select sk into SK_ from TTS where tt=c1.tt;
          EXCEPTION WHEN NO_DATA_FOUND THEN SK_ := NULL;
          end;
--LOGGER.INFO('P_LIC20:=Insert #2');
          INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
             ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid ,pdat)
          VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
             c0.fdat, pdat_, c0.ostf, c0.isp, nb_, c2.vob,
             c1.ref,  c1.tt,   -i.s,
             c2.nd,   c2.mfob, i.nls, substr(i.nms,1,38), i.txt, okpo_,
             c2.vdat, SK_,   c2.userid ,c2.pdat);
         END LOOP;
----------
      ELSE
--LOGGER.INFO('P_LIC20:=c1.tt=901-1'||C1.TT);
         if c1.tt='901' then
            i_ := INSTR(c2.d_rec,'#C');
         IF i_>0 THEN
            d_recf_ := SUBSTR(c2.d_rec,i_+2);
            d_recf_ := RTRIM(LTRIM(SUBSTR(d_recf_,1,INSTR(d_recf_,'#')-1)));
            d_recf_ := substr('Платник: '||d_recf_,1,60);
         ELSE
            d_recf_ := NULL;
         END IF;
            nazn_ := substr(nazn_||' '||d_recf_,1,220);
         end if;
         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid, pdat )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, pdat_, c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   c1.s,
                  c2.nd,   c2.mfob, c2.nlsb, c2.nam_b, nazn_, okpo_,
                  c2.vdat, c2.sk,   c2.userid,c2.pdat);
     END IF;
----------------------------------------------------------------------
      ELSE
--LOGGER.INFO('P_LIC20:=оcновная вставка'||C1.TT);
         if c1.tt='901' then   -- доуточнение реквизитов для 901
--LOGGER.INFO('P_LIC20:=c1.tt=901-2'||C1.TT);
            i_ := INSTR(c2.d_rec,'#C');
         IF i_>0 THEN
            d_recf_ := SUBSTR(c2.d_rec,i_+2);
            d_recf_ := RTRIM(LTRIM(SUBSTR(d_recf_,1,INSTR(d_recf_,'#')-1)));
            d_recf_ := substr('Платник: '||d_recf_,1,60);
         ELSE
            d_recf_ := NULL;
         END IF;
            nazn_ := substr(nazn_||' '||d_recf_,1,220);
         end if;

--LOGGER.INFO('P_LIC20:=Insert #3');
  -- основная вставка
         INSERT INTO tmp_lic
              (id,     acc,      nls,        kv,       nms,
	          fdat,    dapp,     ostf,       isp,      nb,   vob,
              ref,     tt,       s,          nd,       mfo,  nlsk,
	          namk,    nazn,     okpo,       vdat,     sk,   userid, bis,pdat )
         VALUES
              (id_,     c0.acc,  c0.nls,    c0.kv,   c0.nms,
              c0.fdat,  pdat_,   c0.ostf,   c0.isp,    nb_,   c2.vob,
              c1.ref,   c1.tt,   c1.s,      c2.nd,   c2.mfoa,decode(c1.tt,c2.tt,c2.nlsa,c1.nlsk),   -- здесь подменили корресп. по дочерним
	          c2.nam_a, nazn_, c2.id_a,     c2.vdat, c2.sk,   c2.userid, bis_, c2.pdat);

         IF c2.mfoa<>gl.aMFO and INSTR(c2.d_rec,'#B')=1  THEN -- smotrim БИС
            BEGIN
               SELECT fn_a,rec_a - bis, ref_a INTO fn_, i_, ref_af
                FROM arc_rrp WHERE ref = c1.ref AND bis=1;
            EXCEPTION
               WHEN NO_DATA_FOUND THEN fn_ := NULL;
            END;

            IF fn_ IS NOT NULL THEN
               FOR c4 IN (SELECT substr((RTRIM(nazn)||RTRIM(LTRIM(d_rec))),1,220) nazn, bis
                          FROM arc_rrp
                          WHERE fn_a = fn_
                                and TO_CHAR(dat_a, 'YYYY') = TO_CHAR(p_s, 'YYYY')
                                and ref_a = ref_af
                                AND rec_a-bis=i_ AND bis>1
                          order by bis)
LOOP
    nz_bis:=c4.nazn;
    if c4.bis>bis_ then bis_:=c4.bis; end if;
	if instr(nvl(c4.nazn,''),'#C')=1 or instr(nvl(c4.nazn,''),'#П')=1 then
	-- Убираем символы '#C','#П' из NAZN в дополнительных строках БИС
           e_com:=instr(c4.nazn,'#',1,2);
	   if e_com+1<length(c4.nazn) then
	      nz_bis:=substr(c4.nazn,3,e_com-3)
	              ||substr(c4.nazn,e_com,160);
	   else
	      nz_bis:=substr(c4.nazn,3,e_com-3);
	   end if;
	end if;

--logger.info('P_LIC20: '||TRANSLATEDOS2WIN(c4.nazn)||' '||c4.bis);
--LOGGER.INFO('P_LIC20:=Insert #4(БИС)');
         INSERT INTO tmp_lic
            (id, acc, nls, kv, nms, fdat, dapp, ostf,  isp, nb, vob,
               ref, tt, s, nd, mfo, nlsk, namk, nazn, okpo, vdat, sk, userid, bis,pdat )
         VALUES
            (id_, c0.acc,  c0.nls,  c0.kv,   c0.nms,
                  c0.fdat, pdat_,
                  c0.ostf, c0.isp, nb_, c2.vob,
                  c1.ref,  c1.tt,   c1.s,
                  c2.nd,   c2.mfoa, c2.nlsa, c2.nam_a,
                  decode(SEP_N,2,nz_bis,substr(TRANSLATEDOS2WIN(nz_bis),1,220)),
                  c2.id_a,
                  c2.vdat, c2.sk,   c2.userid, c4.bis , c2.pdat);

               END LOOP;  -- c4
            END IF;
         END IF;

      END IF;
  END LOOP;
 END LOOP;
END LOOP;
                 --- _нформац_йн_ (в пред_д большой цикл они не попали, так как их нет в opldok)
FOR c3 IN ( SELECT a.acc, r.dat_a, a.nls, a.kv, a.isp, a.nms,
                   r.vob, r.s*DECODE(r.dk,2,-1,1) s,
                   r.nd, r.mfoa, r.nlsa, r.nam_a, r.nazn, r.id_a, r.datp
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
--LOGGER.INFO('P_LIC20:=Insert #5');
     INSERT INTO tmp_lic
        (id, acc, nls, kv, nms, fdat, isp, nb, vob,
            tt, s, nd, mfo, nlsk, namk, nazn, okpo, userid ,pdat)
     VALUES
        (id_, c3.acc,   c3.nls, c3.kv,   c3.nms,
              c3.dat_a, c3.isp, nb_, c3.vob,
              'ЗПТ',  c3.s, c3.nd, c3.mfoa, c3.nlsa,
           decode(SEP_N,2,c3.nam_a,TRANSLATEDOS2WIN(c3.nam_a)),
           decode(SEP_N,2,c3.nazn,TRANSLATEDOS2WIN(c3.nazn)),
           c3.id_a,c3.isp,c3.datp );

END LOOP;

END p_lic20; 
 
/
show err;

PROMPT *** Create  grants  P_LIC20 ***
grant EXECUTE                                                                on P_LIC20         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_LIC20         to RPBN001;
grant EXECUTE                                                                on P_LIC20         to START1;
grant EXECUTE                                                                on P_LIC20         to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_LIC20         to WR_CREPORTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC20.sql =========*** End *** =
PROMPT ===================================================================================== 
