

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC10.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC10 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC10 (id_ SMALLINT, p_s DATE, p_po DATE, maska  varchar2 ) IS
acc_     SMALLINT;
fdat_    DATE;
dapp_    DATE;
ostf_    DECIMAL(24);
nls_     varchar2(15);
kv_      SMALLINT;
ref_     SMALLINT;
tip_      char(3);
tt_      char(3);
s_       DECIMAL(24);
vdat_    DATE;
nd_      char(10);
mfoa_    varchar2(12);
nlsa_    varchar2(15);
txt_     varchar2(15);
nama_    varchar2(38);
mfob_    varchar2(12);
nlsb_    varchar2(15);
namb_    varchar2(38);
nazn_    varchar2(160);
nazn1    varchar2(160);
userid_  SMALLINT;
sk_      SMALLINT;
kvs_     SMALLINT;
isp_     SMALLINT;
nms_     varchar2(38);
ern		CONSTANT POSITIVE       := 123		       ;
CURSOR SALDOA10 IS
       SELECT s.acc,s.fdat,s.ostf,a.nls,a.kv,s.pdat,
              a.isp, substr(a.nms,1,38)
       FROM saldoa s,accounts a
       WHERE a.acc=s.acc  AND  a.kv=980 AND
             LTRIM(RTRIM(a.nls)) LIKE maska AND
             ( s.fdat > p_s - 1  AND s.fdat < p_po + 1 ) and
             a.tip in
             ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00');
CURSOR OPLDOK1 IS
       SELECT ref,tt,s*(2*dk-1),SUBSTR(txt,1,15)
       FROM opldok
       WHERE acc=acc_ and fdat=fdat_ and sos=5;
BEGIN
delete from tmp_lic where id=id_;
OPEN SALDOA10;
--insert into tta (tta) values (maska);
--deb.tolog(ern,'maska',maska);
--IF deb.debug THEN
--   deb.trace(ern,'maska',maska);
--END IF;
LOOP
FETCH SALDOA10 INTO acc_,fdat_,ostf_,nls_,kv_,dapp_,isp_,nms_ ;
EXIT WHEN SALDOA10%NOTFOUND;
--insert into tta (tta) values (nls_);
--deb.tolog(ern,'nls_',nls_);
--IF deb.debug THEN
--  insert into tta (tta) values (maska);
-- deb.trace(ern,'nls_',nls_);
--END IF;
OPEN OPLDOK1;
LOOP
FETCH OPLDOK1 INTO ref_,tt_,s_, txt_ ;
EXIT WHEN OPLDOK1%NOTFOUND;
   INSERT INTO tmp_lic
       (id,    fdat,  acc,  s,    vdat,  nlsk, ref,  tt,
        ostf,  dapp,  isp,  nls,  nms,   kv)
   values
       (id_,   fdat_, acc_, s_,   vdat_, txt_, ref_, tt_,
        ostf_, dapp_, isp_, nls_, nms_,  kv_);
END LOOP;
CLOSE OPLDOK1;
END LOOP;
CLOSE SALDOA10;
END p_lic10;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC10.sql =========*** End *** =
PROMPT ===================================================================================== 
