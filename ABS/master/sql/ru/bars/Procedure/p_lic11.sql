

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC11.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC11 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC11 
(id_ SMALLINT, p_s DATE, p_po DATE, maska varchar2 ) IS
--- ***** Версия от 06/01-06  *****
---       ограничение периода возможной переоценки
  acc_     SMALLINT;      fdat_    DATE;          dapp_    DATE;
  ostf_    DECIMAL(24);   osti_    DECIMAL(24);   ob_      DECIMAL(24);
  nls_     varchar2(15);  kv_      SMALLINT;	  dk_d	   number;
  ref_     SMALLINT;      tip_     char(3);       tt_d      char(3);
  tt_m     char(3);		  kod_g	   varchar2(200); kod_n		varchar2(200);
  s_       DECIMAL(24);   vdat_    DATE;          nd_      char(10);
  mfoa_    varchar2(12);  nlsa_    varchar2(15);  txt_     varchar2(80);
  nama_    varchar2(38);  mfob_    varchar2(12);  nlsb_    varchar2(15);
  namb_    varchar2(38);  nazn_    varchar2(160); nazn1    varchar2(160);
  userid_  SMALLINT;      sk_      SMALLINT;      kvs_     SMALLINT;
  isp_     SMALLINT;      nms_     varchar2(38);  nms_d	   varchar2(38);
  flag_	   CHAR(1);		  nlsk_    varchar2(15);  acck_	   number;
  kv_n_	   number;		  kv2s_    SMALLINT;
  ern      CONSTANT POSITIVE       := 123 ;
  p_sm     date;

  ind_		  int;
  nls1_k		  varchar2(15);
  nls2_k		  varchar2(15);
  nls3_k		  varchar2(15);
  nms1_k		  varchar2(38);
  nms2_k		  varchar2(38);
  nms3_k		  varchar2(38);
  s1_k		  	  number;
  s2_k		  	  number;
  s3_k		  	  number;
  fdat_o	 	  DATE;

  mfo_		  	  varchar2(12);
  sum_sign	  	  number(1);


CURSOR SALDOA1 IS
       SELECT b.acc,b.fdat,(s.ost-s.kos+s.dos),s.ost,
              s.nls,s.kv,b.pdat,s.isp,substr(s.nms,1,38), s.kos+s.dos
       FROM sal s, saldob b
       WHERE s.acc=b.acc  AND  s.kv<>980 and s.fdat=b.fdat and
             LTRIM(RTRIM(s.nls)) LIKE maska AND
             ( b.fdat > p_s - 1  AND b.fdat < p_po + 1 );
CURSOR SALDOA1R IS
       SELECT b.acc,b.fdat,(s.ost-s.kos+s.dos),s.ost,
              s.nls,s.kv,b.pdat,s.isp,substr(s.nms,1,38), s.kos+s.dos
       FROM sal s, saldob b, cust_acc u
       WHERE s.acc=b.acc  AND  s.kv<>980 and s.fdat=b.fdat AND
             u.acc=s.acc  and
             u.rnk = TO_NUMBER(SUBSTR(maska,2)) AND
             ( b.fdat > p_s - 1  AND b.fdat < p_po + 1 );
CURSOR OPLDOK1 IS
       SELECT ref,tt,s*(2*dk-1),SUBSTR(txt,1,80),dk,fdat
       FROM opldok WHERE acc=acc_ and fdat = fdat_ and sos=5;
CURSOR OPER1 IS
       SELECT o.vdat,o.nd,o.mfoa,o.nlsa,o.nam_a,o.mfob,o.nlsb,o.nam_b,o.nazn,
	   o.userid,o.sk,o.kv,o.tt, o.kv2
       FROM oper o WHERE o.ref=ref_;
CURSOR TRAN1 IS
       SELECT a.nls, SUBSTR(a.nms,1,38), o.s FROM opldok o, accounts a
	   WHERE o.acc=a.acc AND
       o.ref=ref_ AND o.tt=tt_d AND
       a.kv=kv_ AND o.dk<>dk_d AND o.fdat=fdat_o;

BEGIN
  flag_:=SUBSTR(maska,1,1);
  delete from tmp_lic where id=id_;

  kv_n_ := gl.baseval;
  p_sm:=p_s;
  if bankdate - p_s > 0    then     -- ! переоценка только в bankdate
     p_sm:=bankdate;
  end if;

  --Переформировнаие эквивалентов
  FOR c IN (SELECT kv FROM tabval WHERE kv<>kv_n_) LOOP
    p_rev(c.kv,p_sm);
  END LOOP;

  IF flag_ = '@' THEN
    OPEN SALDOA1R;
  ELSE
    OPEN SALDOA1;
  END IF;

  LOOP

    IF flag_ = '@' THEN
      FETCH SALDOA1R INTO acc_,fdat_,ostf_,osti_,nls_,kv_,dapp_,isp_,nms_ ,ob_;
      EXIT WHEN SALDOA1R%NOTFOUND;
    ELSE
      FETCH SALDOA1 INTO acc_,fdat_,ostf_,osti_,nls_,kv_,dapp_,isp_,nms_ ,ob_;
      EXIT WHEN SALDOA1%NOTFOUND;
    END IF;

    IF ob_=0 THEN
     INSERT INTO tmp_lic (id, fdat, acc, ostf, osti, isp, kv, nls, nms, dapp )
                VALUES (id_,fdat_,acc_,ostf_,ostf_,isp_,kv_,nls_,nms_,dapp_);
    ELSE

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
            namb_,nazn_,userid_,sk_,kvs_,tt_m,kv2s_;
		  EXIT WHEN OPER1%NOTFOUND;

		  mfo_ := F_OURMFO;

          --Вычисляем назначение платежа для доч операций
          IF tt_d<>tt_m THEN
             nazn_:=SUBSTR(RTRIM(LTRIM(txt_)) || ' ' || nazn_,1,160);
          ELSE
             --Добавляем в назначение кода 1ПБ для выписки по 39
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

          -- Берем корр. из OPER
		  ind_ := 1;
          IF  nls_= nlsa_ and kv_=kvs_ and kvs_=kv2s_ and
	          (tt_d=tt_m) THEN
            nms_d := namb_;
	        nlsk_ := nlsb_;
			mfo_  := mfob_;
          ELSIF nls_= nlsb_ and kv_=kv2s_ and kvs_=kv2s_ and
	          (tt_d=tt_m) THEN
            nms_d := nama_;
	        nlsk_ := nlsa_;
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
			--Вычитываем корр. проводки
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
			  --Единственная корр.
	          nlsk_ := nls1_k;
              nms_d := nms1_k;
			  ind_ := 1;
			ELSIF (ABS(s1_k)+ABS(s2_k) = ABS(s_)) THEN
			  --Расщепление
			  ind_ := 2;
			ELSE
			  --ХЕЗ, что это за фигня
			  --берем чо попало
			  IF nls1_k IS NOT NULL AND nms1_k IS NOT NULL THEN
	            nlsk_ := nls1_k;
                nms_d := nms1_k;
			  ELSE
	            nlsk_ := nlsa_;
                nms_d := nama_;
			  END IF;
			  ind_ := 1;
			END IF;
          END IF;

		  IF ind_ = 1 THEN
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,osti,sk,dapp,isp,kv,nls,nms)
            VALUES (id_,fdat_,acc_, 1, sum_sign*ABS(s_),nd_,mfo_,nazn_,vdat_,nlsk_,nms_d,
              userid_,ref_,tt_d,ostf_,osti_,sk_,dapp_,isp_,kv_,nls_,nms_);
		  ELSE
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,osti,sk,dapp,isp,kv,nls,nms)
            VALUES (id_,fdat_,acc_, 1, sum_sign*ABS(s1_k),nd_,mfo_,nazn_,vdat_,nls1_k,nms1_k,
              userid_,ref_,tt_d,ostf_,osti_,sk_,dapp_,isp_,kv_,nls_,nms_);
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,osti,sk,dapp,isp,kv,nls,nms)
            VALUES (id_,fdat_,acc_, 1, sum_sign*ABS(s2_k),nd_,mfo_,nazn_,vdat_,nls2_k,nms2_k,
              userid_,ref_,tt_d,ostf_,osti_,sk_,dapp_,isp_,kv_,nls_,nms_);
		  END IF;

        END LOOP;
		CLOSE OPER1;
      END LOOP;
	  CLOSE OPLDOK1;
    END IF;
  END LOOP;

  IF flag_ = '@' THEN
    CLOSE SALDOA1R;
  ELSE
    CLOSE SALDOA1;
  END IF;

END p_lic11;
/
show err;

PROMPT *** Create  grants  P_LIC11 ***
grant EXECUTE                                                                on P_LIC11         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_LIC11         to RPBN001;
grant EXECUTE                                                                on P_LIC11         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC11.sql =========*** End *** =
PROMPT ===================================================================================== 
