

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_LIC4.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_LIC4 ***

  CREATE OR REPLACE PROCEDURE BARS.P_LIC4 
(id_ SMALLINT, p_s DATE, p_po DATE, maska varchar2, kvl_ number ) IS
--- **** Версия от 01/03/2012
---     EAY - исправлена ошибка выбора счета по маске!
--- ***** Версия от 13/01-06       *****
---       ограничение периода возможной переоценки
  acc_     SMALLINT;      fdat_    DATE;          dapp_    DATE;
  nls_     varchar2(15);  kv_      SMALLINT;	  dk_d	   number;
  ref_     SMALLINT;      tip_     char(3);       tt_d      char(3);
  tt_m     char(3);		  kod_g	   varchar2(200); kod_n		varchar2(200);
  s_       DECIMAL(24);   vdat_    DATE;          nd_      char(10);
  mfoa_    varchar2(12);  nlsa_    varchar2(15);  txt_     varchar2(80);
  nama_    varchar2(38);  mfob_    varchar2(12);  nlsb_    varchar2(15);
  namb_    varchar2(38);  nazn_    varchar2(160); nazn1    varchar2(160);
  userid_  SMALLINT;      sk_      SMALLINT;      kvs_     SMALLINT;
  isp_     SMALLINT;      nms_     varchar2(38);  nms_d	   varchar2(38);
  nlsk_    varchar2(15);  acck_	   number;
  fli_m	   number;
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

  move_count_	  number;	   	   	  	   		  	--Количество движений по счету
  day_count_	  number;	   	   	  	   		  	--Количество движений по счету за день

  ostf_           number;  ostfq_          number;  --Входящий остаток за день
  osti_           number;  ostiq_          number;  --Исходящий остаток за день

  dosq_           number;                           --Эквивалент оборотов дебет за день (без учета переоценки)
  kosq_           number;                           --Эквивалент оборотов кредит за день (без учета переоценки)

  dospq_          number;                           --Эквивалент оборотов дебет за период (без учета переоценки)
  kospq_          number;                           --Эквивалент оборотов кредит за период (без учета переоценки)

  cur_rate_       number;                           --Текущий курс
  prev_cur_rate_  number;

  dos_      	  number;
  kos_      	  number;

  deb_pere_       number;                           --Переоценка дебет
  crd_pere_       number;                           --Переоценка кредит

  prev_acc_       number;
  prev_dapp_      date;
  prev_isp_       number;
  prev_kv_        number;
  prev_nls_       varchar2(15);
  prev_nms_       varchar2(38);
  prev_ostf_      number;
  prev_osti_      number;
  prev_ostfq_     number;
  prev_ostiq_     number;
  prev_dosq_      number;
  prev_kosq_      number;
  prev_dospq_     number;
  prev_kospq_     number;
  prev_deb_pere_  number;
  prev_crd_pere_  number;

  prev_fdat_      DATE;
  eq_			  NUMBER;

  CID  	   INTEGER;
  SEG_NAME VARCHAR2(34);

CURSOR SALDOA1 IS
       SELECT
	     s.acc,s.fdat,(s.ost-s.kos+s.dos),s.ost,
		 b.dos,b.kos,s.dos,s.kos,
         s.nls,s.kv,s.dapp,s.isp,substr(s.nms,1,38)
       FROM sal s, saldob b
       WHERE s.acc=b.acc(+)  AND  s.kv<>kv_n_ and s.fdat=b.fdat(+) and
             s.nls like maska AND
			 (s.dazs IS NULL OR s.dazs > p_s) AND
             ( s.fdat > p_s - 1  AND s.fdat < p_po + 1 )
	   ORDER BY s.acc,s.fdat;
CURSOR SALDOA1V IS
       SELECT
	     s.acc,s.fdat,(s.ost-s.kos+s.dos),s.ost,
		 b.dos,b.kos,s.dos,s.kos,
         s.nls,s.kv,s.dapp,s.isp,substr(s.nms,1,38)
       FROM sal s, saldob b
       WHERE s.acc=b.acc(+)  AND  s.kv<>kv_n_ and s.fdat=b.fdat(+) and
             s.nls like maska AND s.kv=kvl_ AND
			 (s.dazs IS NULL OR s.dazs > p_s) AND
             ( s.fdat > p_s - 1  AND s.fdat < p_po + 1 )
	   ORDER BY s.acc,s.fdat;
CURSOR OPLDOK1 IS
       SELECT ref,tt,s*(2*dk-1),SUBSTR(txt,1,80),dk,fdat
       FROM opldok WHERE acc=acc_ and fdat = fdat_ and sos=5;
CURSOR OPER1 IS
       SELECT o.vdat,o.nd,o.mfoa,o.nlsa,o.nam_a,o.mfob,o.nlsb,o.nam_b,o.nazn,
	   o.userid,o.sk,o.kv,o.tt, o.kv2, t.fli
       FROM oper o,tts t WHERE o.tt=t.tt AND o.ref=ref_;
CURSOR TRAN1 IS
       SELECT a.nls, SUBSTR(a.nms,1,38), o.s FROM opldok o, accounts a
	   WHERE o.acc=a.acc AND
       o.ref=ref_ AND o.tt=tt_d AND
       a.kv=kv_ AND o.dk<>dk_d AND o.fdat=fdat_o;

BEGIN
  --Процедура формирование ВАЛ выписок в TMP_LIC с включением в выписку
  --счетов без оборотов, с курсами и всеми переоценками

  delete from tmp_lic where id=id_;

  kv_n_ := gl.baseval;
  prev_acc_:=0;
  move_count_:=0;
  day_count_:=0;
  eq_:=0;
  cur_rate_ := NULL;

  --Переформирование эквивалентов
  p_sm:=p_s;
  if bankdate - p_s > 0    then     -- ! переоценка только в bankdate
     p_sm:=bankdate;
  end if;

  IF kvl_ IS NOT NULL AND kvl_<>0 THEN
    p_rev(kvl_,p_sm);
  ELSE
    FOR c IN (SELECT kv FROM tabval WHERE kv<>kv_n_) LOOP
      p_rev(c.kv,p_sm);
    END LOOP;
  END IF;

  COMMIT;

  --Получаю имя большого сегмента отката
  BEGIN
    SELECT VAL INTO SEG_NAME FROM PARAMS WHERE PAR='RNBURBCK';
    EXCEPTION WHEN NO_DATA_FOUND THEN SEG_NAME :=NULL;
  END;

  IF SEG_NAME IS NOT NULL AND LENGTH(LTRIM(RTRIM(SEG_NAME)))>0 THEN
    --Устанавливаю сегмент
    CID := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(CID, 'SET TRANSACTION USE ROLLBACK SEGMENT ' || SEG_NAME, dbms_sql.v7);
    DBMS_SQL.CLOSE_CURSOR( CID );
  END IF;

  IF kvl_ IS NOT NULL AND kvl_<>0 THEN
    OPEN SALDOA1V;
  ELSE
    OPEN SALDOA1;
  END IF;

  LOOP

    IF kvl_ IS NOT NULL AND kvl_<>0 THEN
      FETCH SALDOA1V INTO acc_,fdat_,ostf_,osti_,
	    deb_pere_,crd_pere_,dos_,kos_,nls_,kv_,dapp_,isp_,nms_;
    ELSE
      FETCH SALDOA1 INTO acc_,fdat_,ostf_,osti_,
	    deb_pere_,crd_pere_,dos_,kos_,nls_,kv_,dapp_,isp_,nms_;
    END IF;

    ostfq_:=gl.P_ICURVAL(kv_,ostf_,fdat_-1);
    ostiq_:=gl.P_ICURVAL(kv_,osti_,fdat_);

    dosq_:=deb_pere_;
    kosq_:=crd_pere_;

    deb_pere_:=deb_pere_-gl.P_ICURVAL(kv_,dos_,fdat_);
    crd_pere_:=crd_pere_-gl.P_ICURVAL(kv_,kos_,fdat_);

    IF deb_pere_=0 THEN
	  deb_pere_ := NULL;
	END IF;

    IF crd_pere_=0 THEN
	  crd_pere_ := NULL;
	END IF;

    IF kvl_ IS NOT NULL AND kvl_<>0 THEN
      EXIT WHEN SALDOA1V%NOTFOUND;
    ELSE
      EXIT WHEN SALDOA1%NOTFOUND;
    END IF;

    --Формируем итоги за период
    IF prev_acc_ <> acc_ THEN
      dospq_  := FDOSN( kv_, acc_, p_s, p_po );
	  kospq_  := FKOSN( kv_, acc_, p_s, p_po );

      IF move_count_ = 0  AND prev_acc_<>0 THEN
        --Включаем в выписку пустые обороты по предыдущему счету, если их не было
        INSERT INTO tmp_lic (id,acc,ostf,osti,dapp,isp,kv,nls,nms,
          ostfq,ostiq,dosq,kosq,dospq,kospq,deb_pere,crd_pere,wd)
        VALUES (id_,prev_acc_,prev_ostf_,prev_osti_,prev_dapp_,prev_isp_,prev_kv_,prev_nls_,prev_nms_,
          prev_ostfq_,prev_ostiq_,prev_dosq_,prev_kosq_,prev_dospq_,prev_kospq_,
		  prev_deb_pere_,prev_crd_pere_,prev_cur_rate_);
		--DBMS_OUTPUT.PUT_LINE('Включаем в выписку пустые обороты по предыдущему счету, если их не было');
      END IF;

      move_count_ := 0;
	END IF;
    IF prev_acc_<>acc_ OR prev_fdat_<>fdat_ THEN
      day_count_:=0;
	  eq_:=0;
	END IF;
    --Формируем курс
    IF cur_rate_ IS NULL OR prev_acc_ <> acc_ OR prev_fdat_<>fdat_ THEN
	  SELECT rate_o INTO cur_rate_ FROM cur_rates
	  WHERE kv=kv_ AND
	        vdate=(SELECT MAX(vdate) FROM cur_rates WHERE kv=kv_ AND vdate<=fdat_);
	END IF;

    IF TRUE THEN
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
            namb_,nazn_,userid_,sk_,kvs_,tt_m,kv2s_, fli_m;
		  EXIT WHEN OPER1%NOTFOUND;

		  mfo_ := F_OURMFO;

          --Вычисляем назначение платежа для доч. операций
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
            nms_d := namb_;
	        nlsk_ := nlsb_;
			mfo_  := mfob_;
          ELSIF nls_= nlsb_ and kv_=kv2s_ and kvs_=kv2s_ and
	          (tt_d=tt_m OR (fli_m>0)) THEN
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
              userid, ref, tt,ostf,osti,sk,dapp,isp,kv,nls,nms,
			  ostfq,ostiq,dosq,kosq,dospq,kospq,deb_pere,crd_pere)
            VALUES (id_,fdat_,acc_, cur_rate_, sum_sign*ABS(s_),nd_,mfo_,nazn_,vdat_,nlsk_,nms_d,
              userid_,ref_,tt_d,ostf_,osti_,sk_,dapp_,isp_,kv_,nls_,nms_,
			  ostfq_,ostiq_,dosq_,kosq_,dospq_,kospq_,deb_pere_,crd_pere_);

            move_count_ := move_count_ + 1;
			day_count_ := day_count_ + 1;
		  ELSE
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,osti,sk,dapp,isp,kv,nls,nms,
			  ostfq,ostiq,dosq,kosq,dospq,kospq,deb_pere,crd_pere)
            VALUES (id_,fdat_,acc_,cur_rate_, sum_sign*ABS(s1_k),nd_,mfo_,nazn_,vdat_,nls1_k,nms1_k,
              userid_,ref_,tt_d,ostf_,osti_,sk_,dapp_,isp_,kv_,nls_,nms_,
			  ostfq_,ostiq_,dosq_,kosq_,dospq_,kospq_,deb_pere_,crd_pere_);
            INSERT INTO tmp_lic (id,fdat, acc, wd,s, nd, mfo,nazn,vdat,nlsk,namk,
              userid, ref, tt,ostf,osti,sk,dapp,isp,kv,nls,nms,
			  ostfq,ostiq,dosq,kosq,dospq,kospq,deb_pere,crd_pere)
            VALUES (id_,fdat_,acc_,cur_rate_, sum_sign*ABS(s2_k),nd_,mfo_,nazn_,vdat_,nls2_k,nms2_k,
              userid_,ref_,tt_d,ostf_,osti_,sk_,dapp_,isp_,kv_,nls_,nms_,
			  ostfq_,ostiq_,dosq_,kosq_,dospq_,kospq_,deb_pere_,crd_pere_);

            move_count_ := move_count_ + 2;
			day_count_ := day_count_ + 2;
		  END IF;

        END LOOP;
		CLOSE OPER1;
      END LOOP;
	  CLOSE OPLDOK1;
    END IF;

    IF day_count_ = 0  AND (deb_pere_ IS NOT NULL OR crd_pere_ IS NOT NULL) THEN
      --DBMS_OUTPUT.PUT_LINE('Включаем в выписку пустые обороты только с переоценкой');
      --DBMS_OUTPUT.PUT_LINE('move_count_='||day_count_);
      --DBMS_OUTPUT.PUT_LINE('deb_pere_='||deb_pere_);
      --DBMS_OUTPUT.PUT_LINE('crd_pere_='||crd_pere_);
      --Включаем в выписку только переоценочные обороты
      INSERT INTO tmp_lic (id,acc,ostf,osti,fdat,dapp,isp,kv,nls,nms,
	    ostfq,ostiq,dosq,kosq,dospq,kospq,deb_pere,crd_pere,wd)
      VALUES (id_,acc_,ostf_,osti_,fdat_,dapp_,isp_,kv_,nls_,nms_,
	    ostfq_,ostiq_,dosq_,kosq_,dospq_,kospq_,deb_pere_,crd_pere_,cur_rate_);
      move_count_ := move_count_ + 1;
      day_count_ := day_count_ + 1;
	END IF;
    prev_acc_ := acc_;
	prev_ostf_ := ostf_;
	prev_osti_ := osti_;
    prev_dapp_:=dapp_;
    prev_isp_:=isp_;
    prev_kv_:=kv_;
    prev_nls_:=nls_;
    prev_nms_:=nms_;
    prev_ostfq_:=ostfq_;
    prev_ostiq_:=ostiq_;
    prev_dosq_:=dosq_;
    prev_kosq_:=kosq_;
    prev_dospq_:=dospq_;
    prev_kospq_:=kospq_;
    prev_deb_pere_:=deb_pere_;
    prev_crd_pere_:=crd_pere_;
    prev_fdat_:=fdat_;
    prev_cur_rate_:=cur_rate_;
  END LOOP;
  IF day_count_ + move_count_ = 0 THEN
	--Включаем в выписку пустые обороты по последнему счету, если их не было
    INSERT INTO tmp_lic (id,acc,ostf,osti,dapp,isp,kv,nls,nms,
	  ostfq,ostiq,dosq,kosq,dospq,kospq,wd)
    VALUES (id_,acc_,ostf_,osti_,dapp_,isp_,kv_,nls_,nms_,
	  ostfq_,ostiq_,dosq_,kosq_,dospq_,kospq_,cur_rate_);
    --DBMS_OUTPUT.PUT_LINE('Включаем в выписку пустые обороты по последнему счету, если их не было');
  END IF;

  IF kvl_ IS NOT NULL AND kvl_<>0 THEN
    CLOSE SALDOA1V;
  ELSE
    CLOSE SALDOA1;
  END IF;

END p_lic4;
/
show err;

PROMPT *** Create  grants  P_LIC4 ***
grant EXECUTE                                                                on P_LIC4          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_LIC4          to PYOD001;
grant EXECUTE                                                                on P_LIC4          to RPBN001;
grant EXECUTE                                                                on P_LIC4          to START1;
grant EXECUTE                                                                on P_LIC4          to WR_ALL_RIGHTS;
grant EXECUTE                                                                on P_LIC4          to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_LIC4.sql =========*** End *** ==
PROMPT ===================================================================================== 
