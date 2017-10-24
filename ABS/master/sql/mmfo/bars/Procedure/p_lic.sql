

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC (id_  SMALLINT, p_s DATE,p_po DATE ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : p_lic
% DESCRIPTION : Подготовительные работы для печать ЛС
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1998.  All Rights Reserved.
% HISTORY     : STA 19-10-98 original version
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
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
ern		CONSTANT POSITIVE       := 123		       ;
CURSOR SALDOA1 IS
       SELECT s.acc,s.fdat,s.ostf,a.nls,a.kv,s.pdat, a.tip
       FROM saldoa s,accounts a
       WHERE a.acc=s.acc  AND a.isp=11 AND
             s.fdat > p_s-1 AND s.fdat < p_po+1;
CURSOR OPLDOK1 IS
       SELECT ref,tt,s*(2*dk-1),SUBSTR(txt,1,15)
       FROM opldok
       WHERE acc=acc_ and fdat=fdat_ and sos=5;
CURSOR OPER1 IS
       SELECT vdat,nd,mfoa,nlsa,nam_a,mfob,nlsb,nam_b,nazn,userid,sk,kv
       FROM oper
       WHERE ref=ref_ ;
CURSOR ARC1 IS
       SELECT nd,mfoa,nlsa,nam_a,mfob,nlsb,nam_b,nazn,kv
       FROM arc_rrp
       WHERE ref=ref_;
BEGIN
------
delete from tmp_lic where id=id_;
OPEN SALDOA1;
LOOP
FETCH SALDOA1 INTO acc_,fdat_,ostf_,nls_,kv_,dapp_, tip_;
EXIT WHEN SALDOA1%NOTFOUND;
   OPEN OPLDOK1;
   LOOP
   FETCH OPLDOK1 INTO ref_,tt_,s_, txt_ ;
   EXIT WHEN OPLDOK1%NOTFOUND;
--IF deb.debug THEN
--   deb.trace(ern,'tt_',tt_);
--END IF;
      IF tip_ = 'N99' OR
         tip_ = 'L99' OR
         tip_ = 'N00' OR
         tip_ = 'T00' OR
         tip_ = 'T0D' OR
         tip_ = 'TNB' OR
         tip_ = 'TND' OR
         tip_ = 'TUR' OR
         tip_ = 'TUD' OR
         tip_ = 'L00' THEN
         INSERT INTO tmp_lic
                (id, fdat, acc, wd, s,  vdat,
                 nlsk,  ref, tt,ostf,dapp)
         VALUES
                (id_, fdat_, acc_, 1, s_, fdat_,
                 txt_,  ref_, tt_, ostf_, dapp_);
      ELSE
         IF tt_<> 'R01' and tt_<>'D01'  THEN
            OPEN OPER1;
            LOOP
            FETCH OPER1 INTO
               vdat_,nd_,mfoa_,nlsa_,nama_,mfob_,nlsb_,
               namb_,nazn_,userid_,sk_,kvs_;
            EXIT WHEN OPER1%NOTFOUND;
               IF nls_= nlsa_ and kv_=kvs_ THEN
                  INSERT INTO tmp_lic
                     (id,fdat, acc, wd,s, nd, mfo,  nazn, vdat,
                      nlsk, namk, userid, ref, tt,ostf,sk,dapp)
                  VALUES
                     (id_,fdat_,acc_, 1, s_,nd_,mfob_,nazn_,vdat_,
                      nlsb_,namb_,userid_,ref_,tt_,ostf_,sk_,dapp_);
               ELSE
                  INSERT INTO tmp_lic
                     (id,fdat, acc, wd,s, nd, mfo,  nazn, vdat,
                      nlsk, namk, userid, ref, tt,ostf,sk,dapp)
                  VALUES
                     (id_,fdat_,acc_, 1, s_,nd_,mfoa_,nazn_,vdat_,
                      nlsa_,nama_,userid_,ref_,tt_,ostf_,sk_,dapp_);
               END IF;
            END LOOP;
            CLOSE OPER1;
         ELSE
            OPEN arc1;
            LOOP
            FETCH arc1 INTO
               nd_,mfoa_,nlsa_,nama_,mfob_,nlsb_,namb_,nazn_,kvs_;
            EXIT WHEN arc1%NOTFOUND;
               IF nls_= nlsb_ and kv_=kvs_ THEN
                  INSERT INTO tmp_lic
                     (id,fdat, acc, wd,s, nd, mfo,  nazn,
                      nlsk, namk, ref, tt,ostf)
                  VALUES
                     (id_,fdat_,acc_, 0, s_,nd_,mfoa_,nazn_,
                      nlsa_,nama_,ref_,tt_,ostf_);
               ELSE    ---dikary
                  nazn1 := substr(nlsb_ || '/' || namb_ || '/' || nazn_,1,160);
                  INSERT INTO tmp_lic
                     (id,fdat, acc, wd,s, nd, mfo,  nazn,
                      nlsk, namk, ref, tt,ostf)
                  VALUES
                     (id_,fdat_,acc_, 0, s_,nd_,mfoa_, nazn1,
                      nlsa_,nama_,ref_,tt_,ostf_);
               END IF;
            END LOOP;
            CLOSE arc1;
         END IF;
      END IF;
   END LOOP;
   CLOSE OPLDOK1;
END LOOP;
CLOSE SALDOA1;
END p_lic;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC.sql =========*** End *** ===
PROMPT ===================================================================================== 
