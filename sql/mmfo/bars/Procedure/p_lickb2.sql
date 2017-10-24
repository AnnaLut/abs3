

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LICKB2.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LICKB2 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LICKB2 (id_ SMALLINT, p_s DATE, p_po DATE, maska varchar2, p_kv number default 980 ) IS
acc_     SMALLINT;
fdat_    DATE;
dapp_    DATE;
ostf_    DECIMAL(24);
osti_    DECIMAL(24);
nls_     varchar2(15);
nlsk_    varchar2(60);
nlsa_    varchar2(15);
nlsb_    varchar2(15);
namk_    varchar2(38);
nama_    varchar2(38);
namb_    varchar2(38);
mfo_     varchar2(12);
mfoa_    varchar2(12);
mfob_    varchar2(12);
nb_      varchar2(38);
nba_     varchar2(38);
nbb_     varchar2(38);
nmk_     varchar2(70);
okpo_    varchar2(14);
okpoa_   varchar2(14);
okpob_   varchar2(14);
kv_      SMALLINT;
kv2_     SMALLINT;
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
nms_     varchar2(70);
benif_   varchar2(200);
pos_     number;
ern             CONSTANT POSITIVE       := 123 ;
CURSOR SALDOA1 IS
       SELECT s.acc,s.fdat,s.ostf,s.ostf+s.kos-s.dos,
              a.nls,a.kv,s.pdat,a.isp, a.nms, c.nmk
       FROM saldoa s,accounts a, customer c
       WHERE a.acc=s.acc  AND a.rnk=c.rnk and
             a.nls LIKE maska AND a.kv=p_kv and
             s.fdat between p_s AND p_po;
CURSOR OPLDOK1 IS
       SELECT dk,ref,tt,s*(2*dk-1) FROM opldok
       WHERE acc=acc_ and fdat = fdat_ and sos=5;

CURSOR O1 IS
       SELECT o.tt, o.vdat, o.nd,
              decode(p.tt,o.tt,o.nazn,p.txt), o.userid,
              o.nlsa, o.nam_a, o.id_a, b1.nb, o.mfoa,
              o.nlsb, o.nam_b, o.id_b, b2.nb, o.mfob
       FROM oper o, opldok p, accounts a, banks b1,banks b2
       WHERE o.ref=ref_   AND a.acc=p.acc  AND p.tt =tt_  AND o.mfoa=b1.mfo AND o.mfob=b2.mfo AND
             p.ref=ref_   AND p.fdat=fdat_ AND p.dk=1-dk_  AND a.kv=kv_;

BEGIN
delete from tmp_lic where id=id_;

OPEN SALDOA1;
LOOP FETCH SALDOA1 INTO acc_,fdat_,ostf_,osti_,nls_,kv_,dapp_,isp_,nms_,nmk_;
     EXIT WHEN SALDOA1%NOTFOUND;
     OPEN OPLDOK1;
     LOOP FETCH OPLDOK1 INTO dk_,ref_,tt_,s_ ;
          EXIT WHEN OPLDOK1%NOTFOUND;

          OPEN O1;
          LOOP FETCH O1 INTO tto_, vdat_, nd_,nazn_,userid_, nlsa_,nama_,okpoa_,nba_,mfoa_,nlsb_,namb_,okpob_,nbb_,mfob_;
          EXIT WHEN O1%NOTFOUND;
               txt_:=null;
          end LOOP; close O1;


          if (nls_ = nlsa_)
          then
            nlsk_ := nlsb_;
            namk_ := namb_;
            okpo_ := okpob_;
            nb_   := nbb_;
            mfo_  := mfob_;
          else
            nlsk_ := nlsa_;
            namk_ := nama_;
            okpo_ := okpoa_;
            nb_   := nba_;
            mfo_  := mfoa_;
          end if;

          if(tt_ in ('KLO', 'KLB', 'KLS'))
          then
            begin
                select value into benif_ from operw where ref=ref_ and tag='59';
                exception when no_data_found then null;
            end;
            if(benif_ is not null)
            then
                pos_ := instr(benif_,chr(13) || chr(10)) - 1;
                nlsk_ := replace(substr(substr(benif_, 1, pos_),1,15),'/','');
                benif_ := substr(benif_,pos_ + 3);
                pos_ := instr(benif_,chr(13) || chr(10)) - 1;
                namk_ := substr(substr(benif_, 1, pos_),1, 38);
            end if;
          end if;

         --nlsk_,namk_,okpo_,nb_,mfo_;
         INSERT INTO tmp_lic    (id,  fdat, acc,  wd,   s,   nd, nazn, vdat,
             nlsk, namk, userid, ref, tt,ostf,osti,dapp, isp, kv, nls,  nms,nmk2,okpo,nb,mfo,sk)
         VALUES                 (id_, fdat_,acc_, 1,    s_,  nd_,nazn_,vdat_,
           nlsk_,namk_,userid_,ref_,tt_,ostf_,osti_,dapp_,isp_,kv_,nls_,nms_,nmk_,okpo_,nb_,mfo_, dk_);
     END LOOP;     CLOSE OPLDOK1;
END LOOP;          CLOSE SALDOA1;
END p_lickb2;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LICKB2.sql =========*** End *** 
PROMPT ===================================================================================== 
