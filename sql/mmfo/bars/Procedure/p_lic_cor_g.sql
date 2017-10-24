

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC_COR_G.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC_COR_G ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC_COR_G (id_ SMALLINT, p_s DATE, p_po DATE, maska varchar2 )
IS
dk_      int;	  			s1_      int;		  	  k14_     varchar2(15);
n38_     varchar2(38);		acc_     SMALLINT;		  fdat_    DATE;
dapp_    DATE;				ostf_    DECIMAL(24);	  nls_     varchar2(15);
kv_      SMALLINT;			ref_     SMALLINT;		  tip_     char(3);
tt_      char(3);			tto_     char(3);		  s_       DECIMAL(24);
vdat_    DATE;				nd_      char(10);		  mfoa_    varchar2(12);
nlsa_    varchar2(15);		txt_     varchar2(80);	  nama_    varchar2(38);
mfob_    varchar2(12);		nlsb_    varchar2(15);	  namb_    varchar2(38);
nazn_    varchar2(320);		userid_  SMALLINT;
sk_      SMALLINT;			kvs_     SMALLINT;		  isp_     SMALLINT;
nms_     varchar2(38);		flag_	 CHAR(1);
--
kod_g    varchar2(200);		kod_n	 varchar2(200);	  tt_d	 char(3);
tt_m	 char(3);			nms_d	 varchar2(38);	  nlsk_	 varchar2(15);
kv2s_	 number;		  	dk_d	 number;
acck_	 number;			kv_n_	 number;

ern	 CONSTANT POSITIVE       := 123 ;

ind_		  int;
nls1_k		  varchar2(15);
nls2_k		  varchar2(15);
nls3_k		  varchar2(15);
nms1_k		  varchar2(38);
nms2_k		  varchar2(38);
nms3_k		  varchar2(38);
s1_k		  number;
s2_k		  number;
s3_k		  number;
fdat_o	 	  DATE;

d_last        DATE;
d_next_mb     DATE;
d_next_me     DATE;
vob_		  NUMBER;

mfo_		  varchar2(12);
sum_sign	  number(1);

--ost_in_       NUMBER;

--
xes_1  number;
xes_2  number;
--

CURSOR SALDOA0 IS
       SELECT s.acc,s.fdat,s.ost,a.nls,a.kv,s.dapp,
              a.isp, substr(a.nms,1,38)
       FROM sal s,accounts a
       WHERE a.acc=s.acc  AND  a.kv=gl.baseval and
             ( s.fdat > d_last - 1  AND s.fdat < d_last + 1 ) and
             LTRIM(RTRIM(a.nls)) LIKE maska AND
             a.tip not in
             ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00');
CURSOR SALDOA0R IS
       SELECT s.acc,s.fdat,s.ost,a.nls,a.kv,s.dapp,
              a.isp, substr(a.nms,1,38)
       FROM sal s,accounts a,cust_acc u
       WHERE a.acc=s.acc  AND  a.kv=gl.baseval and
             u.acc=a.acc  AND
             ( s.fdat > d_last - 1  AND s.fdat < d_last + 1 ) and
             u.rnk =TO_NUMBER(SUBSTR(maska,2)) AND
             a.tip not in
             ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00');
CURSOR OPLDOK1 IS
       SELECT o.ref,o.tt,o.s*(2*o.dk-1),SUBSTR(o.txt,1,80),o.dk,d_last
       FROM opldok o, oper d WHERE acc=acc_ and
	   o.ref=d.ref and (
	   (( d.pdat >= d_next_mb and d.pdat <= d_next_me ) and ( d.vob=96 or d.vob=99 ) )
	   ) and
	   o.sos=5;
CURSOR OPER1 IS
       SELECT o.vdat,o.nd,o.mfoa,o.nlsa,o.nam_a,o.mfob,o.nlsb,o.nam_b,o.nazn,
	   o.userid,o.sk,o.kv,o.tt,o.kv2, o.vob
       FROM oper o WHERE o.ref=ref_;
CURSOR TRAN1 IS
       SELECT a.nls, SUBSTR(a.nms,1,38), o.s FROM opldok o, accounts a
	   WHERE o.acc=a.acc AND
       o.ref=ref_ AND o.tt=tt_d AND
       a.kv=kv_ AND o.dk<>dk_d AND o.fdat=fdat_o;

BEGIN
  --��� ������� �� ������ �� ��������� ���� ������ � ���. ����������

  flag_ := SUBSTR(maska,1,1);
  delete from tmp_lic where id=id_;

  kv_n_ := gl.baseval;

  --�����. ����
  d_last:=LAST_DAY( p_s );               --��������� ������� ���� ����� ������
  d_next_mb:=d_last+1;                   --������ ���� ����. ������
  d_next_me:=LAST_DAY( d_next_mb );      --��������� ���� ����. ������
  SELECT MAX(fdat) INTO d_last FROM FDAT WHERE fdat<=d_last;

  IF flag_ = '@' THEN
    OPEN SALDOA0R;
  ELSE
    OPEN SALDOA0;
  END IF;

  xes_1:=0;
  xes_2:=0;
  LOOP

    IF flag_ = '@' THEN
      FETCH SALDOA0R INTO acc_,fdat_,ostf_,nls_,kv_,dapp_,isp_,nms_ ;
      EXIT WHEN SALDOA0R%NOTFOUND;
    ELSE
      FETCH SALDOA0 INTO acc_,fdat_,ostf_,nls_,kv_,dapp_,isp_,nms_ ;
      EXIT WHEN SALDOA0%NOTFOUND;
    END IF;

	--���������� ����. �������
	--SELECT ostf INTO ost_in_ FROM saldoa
	--WHERE acc=acc_ AND fdat=d_last;

      OPEN OPLDOK1;
      LOOP
	    FETCH OPLDOK1 INTO ref_,tt_d,s_, txt_, dk_d, fdat_o;
	    EXIT WHEN OPLDOK1%NOTFOUND;

		IF dk_d = 0 THEN
  		  sum_sign := -1;
		ELSE
  		  sum_sign := 1;
		END IF;

        OPEN OPER1;
        LOOP
		  FETCH OPER1 INTO  vdat_,nd_,mfoa_,nlsa_,nama_,mfob_,nlsb_,
            namb_,nazn_,userid_,sk_,kvs_,tt_m,kv2s_,vob_;
		  EXIT WHEN OPER1%NOTFOUND;

		  mfo_ := F_OURMFO;

          --��������� ���������� ������� ��� ��� ��������
          IF tt_d<>tt_m THEN
             nazn_:=SUBSTR(RTRIM(LTRIM(txt_)) || ' ' || nazn_,1,160);
          ELSE
             --��������� � ���������� ���� 1�� ��� ������� �� 39
             IF SUBSTR(nls_,1,2)='39' THEN
                BEGIN
                  SELECT value INTO kod_g FROM operw
                  WHERE ref=ref_ AND tag='KOD_G';
                  EXCEPTION WHEN NO_DATA_FOUND THEN kod_g:='';
                  END;
                  BEGIN
                    SELECT value INTO kod_n FROM operw
                  WHERE ref=ref_ AND tag='KOD_N';
                  EXCEPTION WHEN NO_DATA_FOUND THEN kod_n:='';
                END;
                nazn_:=SUBSTR( TRIM(nazn_) || ' ' || TRIM(kod_g), 1,160);
                nazn_:=SUBSTR( TRIM(nazn_) || ' ' || TRIM(kod_n), 1,160);
             END IF;
          END IF;

          -- ����� ����. �� OPER
		  ind_ := 1;
          IF  nls_= nlsa_ and kv_=kvs_ and kvs_=kv2s_ and
	          (tt_d=tt_m) THEN
	        nlsk_ := nlsb_;
            nms_d := namb_;
			mfo_  := mfob_;
          ELSIF nls_= nlsb_ and kv_=kv2s_ and kvs_=kv2s_ and
	          (tt_d=tt_m) THEN
	        nlsk_ := nlsa_;
            nms_d := nama_;
			mfo_  := mfoa_;
          ELSE
		    ind_:=1;
			nls1_k:=NULL;
			nms1_k:=NULL;
			s1_k  :=NULL;
			nls2_k:=NULL;
			nms2_k:=NULL;
			s2_k  :=NULL;
			nls3_k:=NULL;
			nms3_k:=NULL;
			s3_k  :=NULL;
			--���������� ����. ��������
            OPEN TRAN1;
            LOOP
			  IF ind_=1 THEN
  	            FETCH TRAN1 INTO nls1_k,nms1_k,s1_k;
  	            EXIT WHEN TRAN1%NOTFOUND;
			  ELSIF ind_=2 THEN
  	            FETCH TRAN1 INTO nls2_k,nms2_k,s2_k;
  	            EXIT WHEN TRAN1%NOTFOUND;
			  ELSIF ind_=3 THEN
  			    FETCH TRAN1 INTO nls3_k,nms3_k,s3_k;
  	            EXIT WHEN TRAN1%NOTFOUND;
				ind_ :=3;
				EXIT;
			  END IF;
			  ind_ := ind_ + 1;
			END LOOP;
			CLOSE TRAN1;

            IF (s2_k IS NULL AND ABS(s_) <= ABS(s1_k) ) THEN
			  --������������ ����.
              nlsk_ := nls1_k;
              nms_d := nms1_k;
			  ind_ := 1;
			ELSIF (ABS(s1_k)+ABS(s2_k) = ABS(s_)) THEN
			  --�����������
			  ind_ := 2;
			ELSE
			  --���, ��� ��� �� �����
			  --����� �� ������
			  IF nls1_k IS NOT NULL AND nms1_k IS NOT NULL THEN
	            nlsk_ := nls1_k;
                nms_d := nms1_k;
				xes_1 := xes_1 + 1;
			  ELSE
	            nlsk_ := nlsa_;
                nms_d := nama_;
				xes_2 := xes_2 + 1;
			  END IF;
			  ind_ := 1;
			END IF;
          END IF;

		  IF ind_ = 1 THEN
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,sk,dapp,isp,kv,nls,nms, vob)
            VALUES (id_,fdat_,acc_, 1, sum_sign*ABS(s_),nd_,mfo_,nazn_,vdat_,nlsk_,nms_d,
              userid_,ref_,tt_d,ostf_,sk_,dapp_,isp_,kv_,nls_,nms_, vob_);
		  ELSE
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,sk,dapp,isp,kv,nls,nms,vob)
            VALUES (id_,fdat_,acc_, 1, sum_sign*ABS(s1_k),nd_,mfo_,nazn_,vdat_,nls1_k,nms1_k,
              userid_,ref_,tt_d,ostf_,sk_,dapp_,isp_,kv_,nls_,nms_,vob_);
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,sk,dapp,isp,kv,nls,nms,vob)
            VALUES (id_,fdat_,acc_, 1, sum_sign*ABS(s2_k),nd_,mfo_,nazn_,vdat_,nls2_k,nms2_k,
              userid_,ref_,tt_d,ostf_,sk_,dapp_,isp_,kv_,nls_,nms_,vob_);
		  END IF;

        END LOOP;
		CLOSE OPER1;
      END LOOP;
	  CLOSE OPLDOK1;

  END LOOP;

  IF flag_ = '@' THEN
     CLOSE SALDOA0R;
  ELSE
     CLOSE SALDOA0;
  END IF;

  DBMS_OUTPUT.PUT_LINE('XES1: ' || xes_1);
  DBMS_OUTPUT.PUT_LINE('XES2: ' || xes_2);
END p_lic_cor_g;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC_COR_G.sql =========*** End *
PROMPT ===================================================================================== 
