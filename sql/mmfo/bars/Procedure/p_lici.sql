

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LICI.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LICI ***

  CREATE OR REPLACE PROCEDURE BARS.P_LICI (id_ SMALLINT, dt_ DATE, maskasab_ varchar2, kvz_ SMALLINT,
                  maskanls_ varchar2) IS
dk_       int;
s1_       int;
k14_      varchar2(15);
n38_      varchar2(38);
acc_      SMALLINT;
fdat_     DATE;
dapp_     DATE;
ostf_     DECIMAL(24);
nls_      varchar2(15);
kv_       SMALLINT;
ref_      SMALLINT;
tip_      char(3);
tt_       char(3);
tto_      char(3);
s_        DECIMAL(24);
vdat_     DATE;
nd_       char(10);
mfoa_     varchar2(12);
nlsa_     varchar2(15);
txt_      varchar2(160);
nama_     varchar2(38);
mfob_     varchar2(12);
nlsb_     varchar2(15);
namb_     varchar2(38);
nazn_     varchar2(160);
nazn1     varchar2(160);
userid_   SMALLINT;
sk_       SMALLINT;
kvs_      SMALLINT;
isp_      SMALLINT;
nms_      varchar2(38);
pond_     varchar2(10);
filename_ varchar2(12);
kokb_     varchar2(14);
koka_     varchar2(14);
id_a_     varchar2(14);
vob_      SMALLINT;
nazns_    VARCHAR2(2);
bis_      NUMBER;
naznk_    VARCHAR2(3);
d_rec_    VARCHAR2(80);
fn_a_     VARCHAR2(12);
amfo_     varchar2(12);
sosa_     SMALLINT;
CURSOR SALDOA0 IS
       SELECT s.acc,s.fdat,s.ostf,a.nls,a.kv,s.pdat,a.isp,substr(a.nms,1,38),
              c.okpo
       FROM saldoa s, accounts a, customer c, cust_acc cu
       WHERE a.acc=s.acc and a.acc IN (SELECT acc FROM acce) and
             s.fdat=dt_ and a.acc=cu.acc and cu.rnk=c.rnk and
             c.sab=maskasab_ and c.stmt=5 and a.kv=kvz_ and
             a.nls like maskanls_ and a.tip not in
             ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00');
CURSOR OPLDOK1 IS
       SELECT dk,s,ref,tt,ABS(s*(2*dk-1)),txt
       FROM opldok
       WHERE acc=acc_ and fdat=fdat_ and sos=5;
CURSOR OPER1 IS
       SELECT o.tt,o.vdat,o.nd,o.mfoa,o.nlsa,o.nam_a,o.mfob,o.nlsb,o.nam_b,
              o.nazn,o.userid,o.sk,o.kv,o.vob
       FROM oper o
       WHERE o.ref=ref_;
BEGIN
delete from tmp_lici where id=id_;
begin
   select TO_CHAR(f_ourmfo)
   into amfo_
   from dual;
exception when no_data_found then
   amfo_:='300175';
end;
OPEN SALDOA0;
LOOP
FETCH SALDOA0 INTO acc_,fdat_,ostf_,nls_,kv_,dapp_,isp_,nms_,koka_;
EXIT WHEN SALDOA0%NOTFOUND;
OPEN OPLDOK1;
LOOP
FETCH OPLDOK1 INTO dk_,s1_,ref_,tt_,s_,txt_;
EXIT WHEN OPLDOK1%NOTFOUND;
   OPEN OPER1;
   LOOP
   FETCH OPER1 INTO tto_,vdat_,nd_,mfoa_,nlsa_,nama_,mfob_,nlsb_,namb_,nazn_,
         userid_,sk_,kvs_,vob_;
   EXIT WHEN OPER1%NOTFOUND;
      sosa_   :=null;
      kokb_   :=null;
      if tt_<>tto_ then
         pond_:=    '';
         filename_:='';
         nazns_:='';
         bis_  :=null;
         naznk_:='';
         d_rec_:='';
         fn_a_ :='';
         mfob_:='';
         mfoa_:='';
         sk_  :=null;
         nazn_:=txt_;
         select a.nls,substr(a.nms,1,38)
         into k14_,n38_
         from opldok o, accounts a
         where rownum<2    and
               a.kv=980    and
               o.ref=ref_  and
               o.tt=tt_    and
               o.s=s1_     and
               o.acc=a.acc and
               o.dk=decode(dk_,1,0,1);
      else
         begin
            select k1.pond,k1.filename,k2.kokb
            into pond_,filename_,kokb_
            from klpond k1, klp k2
            where rownum<2        and
                  k1.ref=ref_     and
                  k1.pond=k2.pond and
                  substr(k2.naex,3,4)=maskasab_;
         exception when no_data_found then
            pond_:=    '';
            filename_:='';
         end;
         begin
            select nazns,bis,naznk,d_rec,fn_a,id_a,sos
            into nazns_,bis_,naznk_,d_rec_,fn_a_,id_a_,sosa_
            from arc_rrp
            where ref=ref_;
         exception when no_data_found then
            nazns_:='';
            bis_  :=null;
            naznk_:='';
            d_rec_:='';
            fn_a_ :='';
            id_a_ :=null;
         end;
         if id_a_<>koka_ and id_a_ is not null then
            kokb_ :=id_a_;
         end if;
      end if;
      IF nls_=nlsa_ and kv_=kvs_ THEN
         IF tt_<>tto_ THEN
            nlsb_:=k14_;
            namb_:=n38_;
         END IF;
         if kokb_ is null and (mfob_=amfo_ or mfob_ is null) THEN
            begin
               select c.okpo
               into kokb_
               from customer c, accounts a, cust_acc cu
               where a.nls=nlsb_ and a.kv=kv_ and a.acc=cu.acc and
                     cu.rnk=c.rnk;
            exception when no_data_found then
               kokb_:=kokb_;
            end;
         end if;
         if koka_=kokb_ then
            kokb_:=null;
         end if;
         if sosa_ is null or sosa_>3 then
            INSERT INTO tmp_lici
                  (id, daopl,acc, s, nd, mfob, nazn, isp, nlsa,kv, nama,
                   nlsb, namb, ref, tt, iost, sk, dapp, okpoa,okpob,dk, vob,
                   pond, namefilea,kodirowka,nazns, bis, naznk, d_rec,
                   fn_a)
            VALUES
                  (id_,fdat_,acc_,s_,nd_,mfob_,nazn_,isp_,nls_,kv_,nms_,
                   nlsb_,namb_,ref_,tt_,ostf_,sk_,dapp_,kokb_,kokb_,dk_,vob_,
                   pond_,filename_,0,        nazns_,bis_,naznk_,d_rec_,
                   fn_a_);
         end if;
      ELSE
         IF tt_<>tto_ THEN
            nlsa_:=k14_;
            nama_:=n38_;
         END IF;
         if kokb_ is null and (mfoa_=amfo_ or mfoa_ is null) THEN
            begin
               select c.okpo
               into kokb_
               from customer c, accounts a, cust_acc cu
               where a.nls=nlsa_ and a.kv=kv_ and a.acc=cu.acc and
                     cu.rnk=c.rnk;
            exception when no_data_found then
               kokb_:=kokb_;
            end;
         end if;
         if koka_=kokb_ then
            kokb_:=null;
         end if;
         if sosa_ is null or sosa_>3 then
            INSERT INTO tmp_lici
                  (id, daopl,acc, s, nd, mfob, nazn, isp, nlsa,kv, nama,
                   nlsb, namb, ref, tt, iost, sk, dapp, okpoa,okpob,dk, vob,
                   pond, namefilea,kodirowka,nazns, bis, naznk, d_rec,
                   fn_a)
            VALUES
                  (id_,fdat_,acc_,s_,nd_,mfoa_,nazn_,isp_,nls_,kv_,nms_,
                   nlsa_,nama_,ref_,tt_,ostf_,sk_,dapp_,kokb_,kokb_,dk_,vob_,
                   pond_,filename_,0,        nazns_,bis_,naznk_,d_rec_,
                   fn_a_);
         end if;
      END IF;
   END LOOP;
   CLOSE OPER1;
END LOOP;
CLOSE OPLDOK1;
END LOOP;
CLOSE SALDOA0;
END p_lici;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LICI.sql =========*** End *** ==
PROMPT ===================================================================================== 
