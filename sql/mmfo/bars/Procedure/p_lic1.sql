

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC1 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC1 (id_ SMALLINT, p_s DATE, p_po DATE, maska varchar2 ) IS

acc_     SMALLINT;
fdat_    DATE;
dapp_    DATE;
ostf_    DECIMAL(24);
osti_    DECIMAL(24);
nls_     varchar2(15);
nlsk_    varchar2(15);
namk_    varchar2(38);
kv_      SMALLINT;
ref_     SMALLINT;
tip_     char(3);
tt_      char(3);
tto_     char(3);
s_       DECIMAL(24);
vdat_    DATE;
nd_      char(10);
txt_     varchar2(50);
nazn_    varchar2(160);
userid_  SMALLINT;
isp_     SMALLINT;
dk_      smallint;
nms_    varchar2(38);
ern             CONSTANT POSITIVE       := 123 ;
CURSOR SALDOA1 IS
       SELECT s.acc,s.fdat,s.ostf,s.ostf+s.kos-s.dos,
              a.nls,a.kv,s.pdat,a.isp,substr(a.nms,1,38)
       FROM saldoa s,accounts a
       WHERE a.acc=s.acc  AND  a.kv<>980 and
             LTRIM(RTRIM(a.nls)) LIKE maska AND
             ( s.fdat > p_s - 1  AND s.fdat < p_po + 1 ) ;
CURSOR OPLDOK1 IS
       SELECT dk,ref,tt,s*(2*dk-1) FROM opldok
       WHERE acc=acc_ and fdat = fdat_ and sos=5;

CURSOR O1 IS
       SELECT o.tt, o.vdat, o.nd,
              decode(p.tt,o.tt,o.nazn,p.txt),
              o.userid,a.nls,substr(a.nms,1,38)
       FROM oper o, opldok p, accounts a
       WHERE o.ref=ref_   AND a.acc=p.acc  AND p.tt =tt_   AND
             p.ref=ref_   AND p.fdat=fdat_ AND p.dk=1-dk_  AND a.kv=kv_;

CURSOR OW IS SELECT substr(value,1,50)
 FROM operw  WHERE ref=ref_ and tag='FIO';
BEGIN
delete from tmp_lic where id=id_;

OPEN SALDOA1;
LOOP FETCH SALDOA1 INTO acc_,fdat_,ostf_,osti_,nls_,kv_,dapp_,isp_,nms_ ;
     EXIT WHEN SALDOA1%NOTFOUND;
     OPEN OPLDOK1;
     LOOP FETCH OPLDOK1 INTO dk_,ref_,tt_,s_ ;
          EXIT WHEN OPLDOK1%NOTFOUND;

          OPEN O1;
          LOOP FETCH O1 INTO tto_, vdat_, nd_,nazn_,userid_,nlsk_,namk_;
          EXIT WHEN O1%NOTFOUND;

               txt_:=null;
               OPEN OW;
               LOOP FETCH OW INTO txt_;   EXIT WHEN OW%NOTFOUND;
                    if tto_ = tt_ and  txt_ is not null then
                       nazn_:= substr(txt_||' '|| nazn_,1,160);
                    end if;
               end LOOP; close OW;
          end LOOP; close O1;

         INSERT INTO tmp_lic    (id,  fdat, acc,  wd,   s,   nd, nazn, vdat,
             nlsk, namk, userid, ref, tt,ostf,osti,dapp, isp, kv, nls,  nms)
         VALUES                 (id_, fdat_,acc_, 1,    s_,  nd_,nazn_,vdat_,
           nlsk_,namk_,userid_,ref_,tt_,ostf_,osti_,dapp_,isp_,kv_,nls_,nms_);
     END LOOP;     CLOSE OPLDOK1;
END LOOP;          CLOSE SALDOA1;
END p_lic1;
 
/
show err;

PROMPT *** Create  grants  P_LIC1 ***
grant EXECUTE                                                                on P_LIC1          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_LIC1          to RPBN001;
grant EXECUTE                                                                on P_LIC1          to START1;
grant EXECUTE                                                                on P_LIC1          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC1.sql =========*** End *** ==
PROMPT ===================================================================================== 
