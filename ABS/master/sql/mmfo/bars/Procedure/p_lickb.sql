

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LICKB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LICKB ***

  CREATE OR REPLACE PROCEDURE BARS.P_LICKB 
  (id_ SMALLINT, p_s DATE, p_po DATE, maska varchar2 )
IS
dk_      int;                  s1_      int;                k14_     varchar2(15);
n38_     varchar2(38);        acc_     SMALLINT;          fdat_    DATE;
dapp_    DATE;                ostf_    DECIMAL(24);      nls_     varchar2(15);
kv_      SMALLINT;            ref_     SMALLINT;          tip_     char(3);
tt_      char(3);            tto_     char(3);          s_       DECIMAL(24);
vdat_    DATE;                nd_      char(10);          mfoa_    varchar2(12);
nlsa_    varchar2(15);        txt_     varchar2(80);      nama_    varchar2(38);
mfob_    varchar2(12);        nlsb_    varchar2(15);      namb_    varchar2(38);
nazn_    varchar2(320);        userid_  SMALLINT;        d_rec_   varchar2(60);
sk_      SMALLINT;            kvs_     SMALLINT;          isp_     SMALLINT;
nms_     varchar2(38);        flag_     CHAR(1);
--
kod_g    varchar2(200);        kod_n     varchar2(200);      tt_d     char(3);
tt_m     char(3);            nms_d     varchar2(38);      nlsk_     varchar2(15);
kv2s_     number;              dk_d     number;
acck_     number;            kv_n_     number;

ern     CONSTANT POSITIVE       := 123 ;

ind_          int;
nls1_k          varchar2(15);
nls2_k          varchar2(15);
nls3_k          varchar2(15);
nms1_k          varchar2(38);
nms2_k          varchar2(38);
nms3_k          varchar2(38);
s1_k          number;
s2_k          number;
s3_k          number;
fdat_o           DATE;
fli_m             number;
mfo_          varchar2(12);

--
xes_1  number;
xes_2  number;
--

move_count_      number;
prev_acc_     number;
ostfp_        number;
prev_dapp_    date;
prev_isp_     number;
prev_kv_      number;
prev_nls_     varchar2(15);
prev_nms_     varchar2(38);

CURSOR SALDOA0 IS
       SELECT s.acc,s.fdat,s.ost-s.kos+s.dos,a.nls,a.kv,s.dapp,
              a.isp, substr(a.nms,1,38)
       FROM sal s,saldo a
       WHERE a.acc=s.acc  AND
             ( s.fdat > p_s - 1  AND s.fdat < p_po + 1 ) and
             LTRIM(RTRIM(a.nls)) LIKE maska AND
             a.tip not in
             ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00')
       ORDER BY s.acc,s.fdat;
CURSOR SALDOA0R IS
       SELECT s.acc,s.fdat,s.ost-s.kos+s.dos,a.nls,a.kv,s.dapp,
              a.isp, substr(a.nms,1,38)
       FROM sal s,saldo a,cust_acc u
       WHERE a.acc=s.acc  AND
             u.acc=a.acc  AND
             ( s.fdat > p_s - 1  AND s.fdat < p_po + 1 ) and
             u.rnk =TO_NUMBER(SUBSTR(maska,2)) AND
             a.tip not in
             ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00')
       ORDER BY s.acc,s.fdat;
CURSOR OPLDOK1 IS
       SELECT ref,tt,s*(2*dk-1),SUBSTR(txt,1,80),dk,fdat
       FROM opldok WHERE acc=acc_ and fdat = fdat_ and sos=5;
CURSOR OPER1 IS
       SELECT o.vdat,o.nd,o.mfoa,o.nlsa,o.nam_a,o.mfob,o.nlsb,o.nam_b,o.nazn,
       o.d_rec,o.userid,o.sk,o.kv,o.tt, o.kv2, t.fli
       FROM oper o,tts t WHERE o.tt=t.tt AND o.ref=ref_;
CURSOR TRAN1 IS
       SELECT a.nls, SUBSTR(a.nms,1,38), o.s FROM opldok o, saldo a
       WHERE o.acc=a.acc AND
       o.ref=ref_ AND o.tt=tt_d AND
       a.kv=kv_ AND o.dk<>dk_d AND o.fdat=fdat_o;

BEGIN
  --Формирование лицевых с включением в выписку
  --счетов с нулевыми оборотами

  flag_ := SUBSTR(maska,1,1);
  delete from tmp_lic where id=id_;

  kv_n_ := gl.baseval;
  prev_acc_:=0;
  move_count_ := 0;
  ostfp_:=0;

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

      IF prev_acc_<>acc_ THEN
        IF move_count_ = 0 AND prev_acc_<>0 THEN
          --Включаем в выписку пустые обороты по пред. счету
          INSERT INTO tmp_lic (id, acc, ostf,dapp,isp,kv,nls,nms)
          VALUES (id_,prev_acc_,ostfp_,prev_dapp_,prev_isp_,prev_kv_,prev_nls_,prev_nms_);
        END IF;
        move_count_ := 0;
        ostfp_:=ostf_;
      END IF;

      OPEN OPLDOK1;
      LOOP
        FETCH OPLDOK1 INTO ref_,tt_d,s_, txt_, dk_d, fdat_o;
        EXIT WHEN OPLDOK1%NOTFOUND;
        OPEN OPER1;
        LOOP
          FETCH OPER1 INTO  vdat_,nd_,mfoa_,nlsa_,nama_,mfob_,nlsb_,
            namb_,nazn_,d_rec_,userid_,sk_,kvs_,tt_m,kv2s_, fli_m;
          EXIT WHEN OPER1%NOTFOUND;

          mfo_ :=F_OURMFO;

         -- проверим есть ли "Подовжене призначення платежу" (доп.реквизит #П )
          IF SUBSTR(d_rec_,1,2) = '#П' THEN
            nazn_ := RTRIM(LTRIM(nazn_)) || '' || SUBSTR(RTRIM(LTRIM(d_rec_)),3,60);
          END IF;

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
                nazn_:=RTRIM(nazn_) || ' ' || kod_g;
                nazn_:=RTRIM(nazn_) || ' ' || kod_n;
                nazn_:=SUBSTR(nazn_,1,160);
             END IF;
          END IF;

          -- Берем корр. из OPER
          ind_ := 1;
          IF  nls_= nlsa_ and kv_=kvs_ and kvs_=kv2s_ and
              (tt_d=tt_m OR (fli_m>0) ) THEN
            nlsk_ := nlsb_;
            nms_d := namb_;
            mfo_  := mfob_;
          ELSIF nls_= nlsb_ and kv_=kv2s_ and kvs_=kv2s_ and
              (tt_d=tt_m OR (fli_m>0) ) THEN
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
              userid, ref, tt,ostf,sk,dapp,isp,kv,nls,nms)
            VALUES (id_,fdat_,acc_, 1, s_,nd_,mfo_,nazn_,vdat_,nlsk_,nms_d,
              userid_,ref_,tt_d,ostfp_,sk_,dapp_,isp_,kv_,nls_,nms_);

            move_count_ := move_count_ + 1;

          ELSE
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,sk,dapp,isp,kv,nls,nms)
            VALUES (id_,fdat_,acc_, 1, -s1_k,nd_,mfo_,nazn_,vdat_,nls1_k,nms1_k,
              userid_,ref_,tt_d,ostfp_,sk_,dapp_,isp_,kv_,nls_,nms_);
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,sk,dapp,isp,kv,nls,nms)
            VALUES (id_,fdat_,acc_, 1, -s2_k,nd_,mfo_,nazn_,vdat_,nls2_k,nms2_k,
              userid_,ref_,tt_d,ostfp_,sk_,dapp_,isp_,kv_,nls_,nms_);

            move_count_ := move_count_ + 2;

          END IF;

        END LOOP;
        CLOSE OPER1;
      END LOOP;
      CLOSE OPLDOK1;

    prev_acc_:=acc_;
    prev_dapp_:=dapp_;
    prev_isp_:=isp_;
    prev_kv_:=kv_;
    prev_nls_:=nls_;
    prev_nms_:=nms_;
  END LOOP;
  IF move_count_ = 0 THEN
    --Включаем в выписку пустые обороты по последнему счету, если их не было
    INSERT INTO tmp_lic (id, acc, ostf,dapp,isp,kv,nls,nms)
    VALUES (id_,acc_,ostfp_,dapp_,isp_,kv_,nls_,nms_);
  END IF;

  IF flag_ = '@' THEN
     CLOSE SALDOA0R;
  ELSE
     CLOSE SALDOA0;
  END IF;

  DBMS_OUTPUT.PUT_LINE('XES1: ' || xes_1);
  DBMS_OUTPUT.PUT_LINE('XES2: ' || xes_2);
END p_lickb;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LICKB.sql =========*** End *** =
PROMPT ===================================================================================== 
