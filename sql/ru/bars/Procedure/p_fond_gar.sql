

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FOND_GAR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FOND_GAR ***

  CREATE OR REPLACE PROCEDURE BARS.P_FOND_GAR (dat_ DATE) IS
--***************************************************************************--
--                    DEPOSITS
--            (C) Unity-BARS Version 1.00 (03/10/2005)
--               Фонд гарантирования вкладов - ПРАВЭКС
--***************************************************************************--
  mfo_      VARCHAR2(12);
  gar_      NUMBER;
  obl_      VARCHAR2(30);
  dst_      VARCHAR2(30);
  town_     VARCHAR2(30);
  adr_      VARCHAR2(70);
  acra_     NUMBER;
  ostn_     NUMBER;
  ostn_nom_ NUMBER;
  nls_      VARCHAR2(14);
  nlsn_     VARCHAR2(14);

BEGIN

  EXECUTE IMMEDIATE 'TRUNCATE TABLE tmp_fond_gar';

  SELECT substr(f_ourmfo_g,1,12) INTO mfo_ FROM dual;
  -- является ли банк временным участником Фонда
  BEGIN
    SELECT 1 - nvl(to_number(val),0)
      INTO gar_
      FROM params$base
     WHERE kf = mfo_ AND par = 'TU_FOND';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN gar_ := 1;
  END;

  FOR dpt IN
     (SELECT c.rnk RNK, c.nmk FIO, LPAD(NVL(c.okpo,'0'),10,'0') OKPO,
             c.adr ADR, decode(c.codcagent,5,1,0) REZID,
             trim(p.ser)||' '||trim(p.numdoc)||' '||
             trim(p.organ)||' '||TO_CHAR(p.pdate,'dd.mm.yyyy') PASP,
	     nvl(d.nd, d.deposit_id) ND,
             d.datz DATZ, d.deposit_id DPT_ID,
             a.acc ACC, a.nls NLS, a.kv KV, a.accc ACCC, a.nbs NBS,
             nvl(gl.p_icurval(a.kv,fost(a.acc,dat_),dat_),0) OST,
             nvl(fost(a.acc,dat_),0) OST_NOM
        FROM customer c, person p, dpt_deposit_clos d, accounts a
       WHERE c.rnk = p.rnk
         AND d.rnk = c.rnk
         AND d.acc = a.acc
         AND d.action_id = 0
         AND (a.dazs IS NULL OR a.dazs > dat_)
         AND fost(a.acc,dat_) >= 0
       UNION ALL
      SELECT c.rnk RNK, c.nmk FIO, LPAD(NVL(c.okpo,'0'),10,'0') OKPO,
             c.adr ADR, decode(c.codcagent,5,1,0) REZID,
             trim(p.ser)||' '||trim(p.numdoc)||' '||
             trim(p.organ)||' '||TO_CHAR(p.pdate,'dd.mm.yyyy') PASP,
	     c.rnk||'-'||a.kv ND, a.daos DATZ, a.acc DPT_ID,
             a.acc ACC, a.nls NLS, a.kv KV, a.accc ACCC, a.nbs NBS,
             nvl(gl.p_icurval(a.kv, fost(a.acc,dat_), dat_),0) OST,
             nvl(fost(a.acc,dat_),0) OST_NOM
        FROM customer c, person p, cust_acc ca, accounts a,
            (SELECT a.acc
               FROM accounts a
              WHERE (a.dazs IS NULL OR a.dazs > dat_)
                AND a.nbs IN (SELECT UNIQUE bsd FROM dpt_vidd)
              MINUS
             SELECT acc FROM dpt_deposit_clos) b
       WHERE c.rnk = p.rnk
         AND ca.rnk = c.rnk
         AND ca.acc = a.acc
         AND a.acc=b.acc
         AND fost(a.acc,dat_) >= 0
       ORDER BY 3, 2)
  LOOP

    -- структурированная разбивка адреса
    obl_  := '';   dst_  := '';   town_ := '';   adr_  := '';

     SELECT max(substr(decode(tag,'FGOBL',value,''),1,30)),
            max(substr(decode(tag,'FGDST',value,''),1,30)),
            max(substr(decode(tag,'FGTWN',value,''),1,30)),
            max(substr(decode(tag,'FGADR',value,''),1,70))
       INTO obl_, dst_, town_, adr_
       FROM customerw
      WHERE rnk = dpt.rnk AND tag IN ('FGOBL','FGDST','FGTWN','FGADR');

     IF adr_ IS NULL THEN
        adr_ := dpt.adr;
     END IF;

     -- счет начисленных процентов
     acra_ := to_number(null);    ostn_ := 0;

     BEGIN
       SELECT acra INTO acra_
         FROM int_accn
        WHERE acc = dpt.acc AND id = 1 AND nvl(acra,acc)<>acc;
     EXCEPTION
        WHEN NO_DATA_FOUND THEN  acra_ := to_number(null);
     END;

     -- сумма начисленных процентов
     IF acra_ IS NOT NULL THEN
        BEGIN
          SELECT nls, nvl(ost,0), nvl(gl.p_icurval(kv, ost, dat_),0)
            INTO nlsn_, ostn_nom_, ostn_
            FROM sal
           WHERE fdat = dat_ AND acc = acra_;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN  nlsn_ := ''; ostn_ := 0;  ostn_nom_ := 0;
        END;
     ELSE
        nlsn_ :=''; ostn_ := 0; ostn_nom_ := 0;
     END IF;

     nls_ := dpt.nls;

     -- балансовый счет консолидации (если есть)
     IF dpt.accc IS NOT NULL THEN
        SELECT nvl(max(nls), dpt.nls) INTO nls_
          FROM accounts
         WHERE acc = dpt.accc
           AND nvl(substr(nbs,1,1),0) NOT IN (0,8,9);
     END IF;


     INSERT INTO tmp_fond_gar
        (dat, mfo, rnk, fio, okpo, rezid,
         obl, dst, town, adr,  pasp, datz, nd, dpt_id,
         ost, ost_nom, ostn, ostn_nom, nls, nlsn, gar, kv)
     VALUES
        (dat_, mfo_, dpt.rnk, dpt.fio, dpt.okpo, dpt.rezid,
         obl_, dst_, town_, adr_, dpt.pasp, dpt.datz, dpt.nd, dpt.dpt_id,
         dpt.ost, dpt.ost_nom, ostn_, ostn_nom_, nls_, nlsn_, gar_, dpt.kv);

  END LOOP; --dpt

END p_fond_gar;
/
show err;

PROMPT *** Create  grants  P_FOND_GAR ***
grant EXECUTE                                                                on P_FOND_GAR      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FOND_GAR      to RPBN001;
grant EXECUTE                                                                on P_FOND_GAR      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FOND_GAR.sql =========*** End **
PROMPT ===================================================================================== 
