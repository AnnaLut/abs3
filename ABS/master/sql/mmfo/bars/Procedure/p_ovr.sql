

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OVR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OVR ***

  CREATE OR REPLACE PROCEDURE BARS.P_OVR ( mode_ SMALLINT DEFAULT NULL) IS
-- Процедура открытия обыкновенного overdraft`а
-- Версия 2.2 для ОЩАДБАНКА

ref_   	   	   INTEGER;
dk_    		   SMALLINT;
id_			   NUMBER;
fact_		   NUMBER;
ttn_    	   VARCHAR(70);   -- OVR Transaction name
s_			   NUMBER;


tt_    CONSTANT CHAR(3) := 'OVR';

CURSOR ALL_OVR_ACC IS
SELECT /*+ USE_NL(o a)*/
       o.acc acc_main,o.acco acc_ovr,a.kv,a.pap, (sa.ostf-sa.dos+sa.kos) s_main,
       a.lim l_main,(sb.ostf-sb.dos+sb.kos) s_ovr, b.lim l_ovr,
       a.nls nls_main, SUBSTR(a.nms,1,38) nam_main,
       b.nls nls_ovr, SUBSTR(b.nms,1,38) nam_ovr
  FROM acc_over o, accounts a, accounts b, saldoa sa, saldoa sb
 WHERE o.FLAG is NULL AND o.acc=a.acc AND o.acco=b.acc AND o.acc=sa.acc AND o.acco=sb.acc AND
     sa.fdat=(SELECT MAX(fdat) FROM SALDOA WHERE fdat<=GL.BD AND acc=o.acc) AND
     sb.fdat=(SELECT MAX(fdat) FROM SALDOA WHERE fdat<=GL.BD AND acc=o.acco) AND
     (a.pap=1 OR a.pap=2);

/* Предыдущий вариант выборки
SELECT o.acc acc_main,o.acco acc_ovr,a.kv,a.pap, (sa.ostf-sa.dos+sa.kos) s_main,
       a.lim l_main,(sb.ostf-sb.dos+sb.kos) s_ovr, b.lim l_ovr,
       a.nls nls_main, SUBSTR(a.nms,1,38) nam_main,
       b.nls nls_ovr, SUBSTR(b.nms,1,38) nam_ovr
  FROM acc_over o, accounts a, accounts b, saldoa sa, saldoa sb
 WHERE o.FLAG is NULL AND a.acc=sa.acc AND b.acc=sb.acc AND
 	   sa.fdat=(SELECT MAX(fdat) FROM SALDOA WHERE fdat<=GL.BD AND acc=a.acc) AND
 	   sb.fdat=(SELECT MAX(fdat) FROM SALDOA WHERE fdat<=GL.BD AND acc=b.acc) AND
       o.acc=a.acc AND o.acco=b.acc AND (a.pap=1 OR a.pap=2); */

ern         CONSTANT POSITIVE := 208;
err         EXCEPTION;
erm         VARCHAR2(80);


BEGIN

BEGIN
   SELECT SUBSTR(flags,38,1), name  INTO  fact_,ttn_ FROM tts WHERE tt=tt_;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
   erm := '8012 - No transaction defined # '||tt_;
   RAISE err;
END;
BEGIN
   SELECT id INTO  id_ FROM  staff  WHERE LTRIM(RTRIM(UPPER(logname)))=USER;
   EXCEPTION
   WHEN NO_DATA_FOUND THEN  erm := '8012 - Unregistered user'; RAISE err;
END;
ttn_ := 'Открытие overdraft`а';

FOR C IN ALL_OVR_ACC LOOP
   IF deb.debug THEN
      deb.trace( ern, 'acc_main', c.acc_main);
      deb.trace( ern, 'acc_ovr',  c.acc_ovr);
      deb.trace( ern, 's_main',   c.s_main);
      deb.trace( ern, 's_ovr',    c.s_ovr);
      deb.trace( ern, 'l_main',   c.l_main);
   END IF;

   s_ := 0;
   IF c.pap=2 THEN --Passive
      IF c.s_main<0 AND -c.s_ovr<c.l_main THEN --Openning
         s_ := LEAST( -c.s_main, c.l_main + c.s_ovr );
		 dk_ := 0;
      ELSIF c.s_main>0 AND c.s_ovr<0  THEN -- Closing
         s_ := LEAST( -c.s_ovr, c.s_main );
		 dk_ := 1;
      END IF;
   ELSIF c.pap=1 THEN --Active
     NULL;
   END IF;

   IF deb.debug THEN
      deb.trace( ern, 's', s_);
      deb.trace( ern, 'dk', dk_);
   END IF;
   IF s_<>0 THEN
      gl.ref (ref_);
      IF deb.debug THEN
         deb.trace( ern, 'ref', ref_);
      END IF;
      INSERT INTO oper
         (ref,tt,vob,nd,dk,pdat,vdat,datd,
         nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,s,nazn,userid)
      VALUES
         (ref_,tt_,6,ref_,dk_,SYSDATE,gl.bDATE,gl.bDATE,
         c.nam_main,c.nls_main,gl.aMFO,c.nam_ovr,c.nls_ovr,gl.aMFO,
		 c.kv,ABS(s_),ttn_,id_);
      gl.pay(null,ref_,gl.bDATE,tt_,c.kv,1-dk_,c.acc_main,ABS(s_),0,ttn_);
      gl.pay(null,ref_,gl.bDATE,tt_,c.kv,dk_,c.acc_ovr,ABS(s_),0,ttn_);
      IF fact_=1 THEN
         gl.pay(2,ref_,gl.bDATE);
      END IF;
   END IF;
END LOOP;

EXCEPTION
   WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);

   WHEN OTHERS
        THEN
	    raise_application_error(-(20000+ern),SQLERRM,TRUE);
END p_ovr;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OVR.sql =========*** End *** ===
PROMPT ===================================================================================== 
