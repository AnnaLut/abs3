

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KD_P.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KD_P ***

  CREATE OR REPLACE PROCEDURE BARS.KD_P (mod_ int, id_ int, RNK_ int, NAZN_ varchar2 ) IS

 ACC1_ INT; ACCC1_ INT ; NMS1_ VARCHAR2(38)  ; NLS1_ VARCHAR2(15)  ;
 ACC2_ INT; ACCC2_ INT ; NMS2_ VARCHAR2(38)  ; NLS2_ VARCHAR2(15)  ;
 ACC6_ INT; ACCC6_ INT ; NMS6_ varchar2(38)  ; NLS6_ VARCHAR2(15)  ;
 ACC7_ INT; ACCC7_ INT ; NMS7_ varchar2(38)  ; NLS7_ VARCHAR2(15)  ;
 MMS_  varchar2(30)    ; NMST_ VARCHAR2(38)  ; NLST_ VARCHAR2(15)  ;
 nls81_ varchar2(15)   ; nls82_ varchar2(15) ; nls_  varchar2(15)  ;
 mf5_   varchar2(5)    ; S1_    number       ; S2_   number        ;
 REF_   int            ; ret1_ int           ; SNAZN_ varchar2(160);
 accd_  int            ; nlsd_ varchar2(15)  ; pr_d_ number(10,5)  ;
 accr_  int            ; nlsr_ varchar2(15)  ; pr_k_ number(10,5)  ;
 KOL_   int            ; MM_   int           ; YYYY_ int           ;
 FIO_   varchar2(38)   ;

 ern CONSTANT POSITIVE := 208; err EXCEPTION; erm VARCHAR2(80);

BEGIN

   if gl.AMFO = '300465' then
      NLS1_:= '220348881'      ;  -- Счет кредита
      NLS2_:= '263508882'      ;  -- Счет депозита
      NLS6_:= '220848886'      ;  -- Счет нач.% по кредиту
      NLS7_:= '263888887'      ;  -- Счет нач.% по депозиту
      NLST_:= '290995001147'   ;  -- Транз.Счет для проводок кредит-депозит
      nlsd_:= '60427010106059' ;  -- Счет дох  по кредиту
      nlsr_:= '70411010102059' ;  -- Счет расх по депозиту
elsif gl.AMFO = '300175' then
      NLS1_:= '220568881' ;       -- Счет кредита
      NLS2_:= '263508882' ;       -- Счет депозита
      NLS6_:= '220848886' ;       -- Счет нач.% по кредиту
      NLS7_:= '263888887' ;       -- Счет нач.% по депозиту
      NLST_:= '290968880' ;       -- Транзитный Счет для проводок кредит-депозит
      nlsd_:= '604208880' ;       -- Счет дох  по кредиту
      nlsr_:= '704108880' ;       -- Счет расх по депозиту
end if ;
----------
IF deb.debug THEN      deb.trace( ern, 'gl.AMFO ', gl.AMFO  );END IF;

  begin
    select to_number(val) into KOL_ from params where par='KD_888';
  EXCEPTION WHEN OTHERS THEN   KOL_:=1;
  end;

  MM_  := to_number(to_char( add_months(GL.BDATE, -KOL_), 'MM'));
  YYYY_:= to_number(to_char( add_months(GL.BDATE, -KOL_), 'YYYY'));

  begin
    select NAME_PLAIN into MMS_ from META_MONTH where n=MM_;
  exception when NO_DATA_FOUND THEN  MMS_:='мiсяць '|| MM_ ;
  end;
  MMS_:=MMS_ || ' '||YYYY_||' року';

IF deb.debug THEN      deb.trace( ern, 'MMS_', MMS_ );END IF;

  mf5_:=substr( gl.AMFO , 1, 5 );
  BEGIN
   SELECT A1.ACC, A2.ACC, A6.ACC, A7.ACC, d.acc, r.acc,
          SUBSTR(A1.NMS, 38), SUBSTR(A2.NMS,1,38), SUBSTR(T.NMS,1,38),
          SUBSTR(A6.NMS, 38), SUBSTR(A7.NMS,1,38)
   INTO ACCC1_, ACCC2_, ACCC6_, ACCC7_, accd_, accr_,
        NMS1_, NMS2_, NMST_, NMS6_, NMS7_
   FROM ACCOUNTS A1, ACCOUNTS A2, ACCOUNTS A6, ACCOUNTS A7, ACCOUNTS T,
        accounts d, accounts r
   WHERE A1.NLS=NLS1_ AND A1.KV=980 AND
         A2.NLS=NLS2_ AND A2.KV=980 AND
         A6.NLS=NLS6_ AND A6.KV=980 AND
         A7.NLS=NLS7_ AND A7.KV=980 AND
          T.NLS=NLST_ and  t.kv=980 and
          d.nls=nlsd_ and  d.kv=980 and
          r.nls=nlsr_ and  r.kv=980;
  exception when NO_DATA_FOUND THEN    return;
  END;

IF deb.debug THEN
   deb.trace( ern, 'mod_',  mod_  );
   deb.trace( ern, 'NLS1_', NLS1_ );
   deb.trace( ern, 'NLS2_', NLS2_ );
   deb.trace( ern, 'NLS6_', NLS6_ );
   deb.trace( ern, 'NLS7_', NLS7_ );
   deb.trace( ern, 'NLST_', NLST_ );
   deb.trace( ern, 'nlsd_', nlsd_ );
   deb.trace( ern, 'nlsr_', nlsr_ );
END IF;

IF mod_ = 0 then
-- раскрытие кредита на депозит
-- Set sTip[3] = '3. ВЕСЬ ПОРТФЕЛЬ - Обновление  '
-- Set sTip[4] = '4. ОДИН ДОГОВОР  - Обновление  '

   FOR K IN (SELECT a.RNK,  c.NMK,
                    a.kol_okl*a.OKLAD*100 S,
                    a.PR_K,   a.PR_D,
                    a.KOL_OKL,a.TIP,
                    a.S_PR,   a.N_KART,
                    nvl(a.ACC1,0) ACC1,
                    nvl(a.ACC2,0) ACC2,
                    nvl(a.ACC6,0) ACC6,
                    nvl(a.ACC7,0) ACC7,
                    nvl(a.DATPR , GL.BDATE ) DATPR  ,
                    nvl(a.DATPR2, GL.BDATE ) DATPR2
             FROM KD_888 a, customer c
             WHERE (RNK_=0 OR a.RNK=RNK_) and a.rnk=c.rnk
             ORDER BY a.RNK )
   LOOP

IF deb.debug THEN      deb.trace( ern, 'RNK', k.RNK );END IF;

     --открыть счет нач % по КР
     if k.ACC6= 0 then
        nls_:=vkrzn(mf5_,'88860'||k.rnk);
        OP_REG(99,0,0,0,ret1_,k.rnk,nls_,980,'Нач % К '||k.rnk,'ODB',id_,acc6_);
        UPdate accounts set accc=accc6_ where acc=acc6_;
        update kd_888 set acc6=acc6_ where rnk=k.rnk;
     else
        acc6_:=k.acc6;
     end if;

     -- открыть счет нач % по деп
     if k.ACC7=0 then
        nls_:=vkrzn(mf5_,'88870'||k.rnk);
        OP_REG(99,0,0,0,ret1_,k.rnk,nls_,980,'Нач % Д '||k.rnk,'ODB',id_,acc7_);
        UPdate accounts set accc=accc7_ where acc=acc7_;
        update kd_888 set acc7=acc7_ where rnk=k.rnk;
     else
        acc7_:=k.acc7;
     end if;

     -- открыть счет   Кредита
     If k.ACC1=0 then
        nls81_:=vkrzn(mf5_,'88810'||k.rnk);
        OP_REG(99,0,0,0,ret1_,k.rnk,nls81_,980,'Кредит '||k.rnk,'ODB',id_,acc1_);
        UPdate accounts set accc=accc1_ where acc=acc1_;
        update kd_888 set acc1=acc1_ where rnk=k.rnk;
        begin
          select acc into acc1_ from int_accn where acc=acc1_ and id=0;
        exception when NO_DATA_FOUND THEN
          insert into int_accN (ACC,ID, METR,BASEM,BASEY,FREQ, TT,ACRA,ACRB)
          values  (acc1_,0, 0,0,0,1, 'KD%', acc6_, accd_);
        end;
     else
        acc1_:=k.acc1;
     end if;

     select nls,nvl(-ostb,0) into nls81_,S1_ from accounts where acc=acc1_;
     -- обновить-установить % ставку по кредиту
     begin
       SELECT ir INTO pr_k_ FROM int_ratn
       WHERE id=0 and acc=acc1_ and bdat=k.DATPR;
       UPDATE int_ratn set ir=k.pr_k
       WHERE id=0 and acc=acc1_ and bdat=k.DATPR;

IF deb.debug THEN
   deb.trace( ern, 'Было    pr_k_', pr_k_ );
   deb.trace( ern, 'UPDATE k.pr_k', k.pr_k );
END IF;

     exception when NO_DATA_FOUND THEN
       insert into int_ratn (ACC,ID,BDAT,IR) values (acc1_,0,k.DATPR,k.pr_k);

IF deb.debug THEN
   deb.trace( ern, 'INSERT k.pr_k', k.pr_k );
END IF;

     end;

     -- открыть счет Депоз
     if k.ACC2=0 then
        nls82_:=vkrzn(mf5_,'88820'||k.rnk);
        OP_REG(99,0,0,0,ret1_,k.rnk,nls82_,980,'Депозит '||k.rnk,'ODB',id_,acc2_);
        UPdate accounts set accc=accc2_ where acc=acc2_;
        update kd_888 set acc2=acc2_ where rnk=k.rnk;
        begin
          select acc into acc2_ from int_accn where acc=acc2_ and id=1;
        exception when NO_DATA_FOUND THEN
          insert into int_accN (ACC,ID,METR,BASEM,BASEY,FREQ,TT,ACRA,ACRB)
          values  (acc2_,1, 0,0,0,1, 'KD%', acc7_, accr_);
        end;
     else
        acc2_:=k.acc2;
     end if;

     select nls,nvl(ostb,0) into nls82_,S2_ from accounts where acc=acc2_;
     -- обновить-установить % ставку по депозиту
     begin
       SELECT ir INTO pr_d_ FROM int_ratn
       WHERE id=1 and acc=acc2_ and bdat=k.DATPR2;
       UPDATE int_ratn set ir=k.pr_d
       WHERE id=1 and acc=acc2_ and bdat=k.DATPR2;
     exception when NO_DATA_FOUND THEN
       insert into int_ratn (ACC,ID,BDAT,IR) values (acc2_,1,k.DATPR2,k.pr_d);
     end;
     ------------------
     If k.s <> S1_ then
        If S1_>0 then
           gl.ref (ref_);
           INSERT INTO oper (REF,TT,VOB, ND, PDAT, VDAT, KV, DK, S, KV2, S2,
             DATD, DATP, NAM_A, NLSA, MFOA,NAM_B, NLSB, MFOB, NAZN, USERID)
           values (REF_,'KD8', 6 ,ref_,GL.BDATE , GL.BDATE , 980, 1, S1_, 980, S1_,
             GL.BDATE , GL.BDATE ,NMST_, NLST_, gl.AMFO , NMS1_, NLS1_, gl.AMFO ,
             substr(NAZN_||' Погашення кредиту '||k.NMK,1,160), id_);
           gl.payv(0,ref_,GL.BDATE ,'KD8',1,980,NLST_,S1_,980, nls81_,S1_ );
        end if;
        if k.s>0 then
           gl.ref (ref_);
           INSERT INTO oper(REF, TT, VOB, ND, PDAT, VDAT, KV, DK, S, KV2, S2,
             DATD, DATP, NAM_A, NLSA, MFOA,NAM_B, NLSB, MFOB, NAZN, USERID)
           values (REF_, 'KD8', 6,ref_, GL.BDATE , GL.BDATE , 980, 1, k.S , 980, k.S,
             GL.BDATE , GL.BDATE ,NMS1_, NLS1_, gl.AMFO , NMST_, NLST_, gl.AMFO ,
             substr(NAZN_||' Видача кредиту '||k.nmk,1,160), id_);
           gl.payv(0,ref_,GL.BDATE ,'KD8',1,980,NLS81_,k.S,980, nlst_,k.S );
        end if;
     end if;
     --------------------
     If k.s <> S2_ then
        If S2_>0 then
           gl.ref (ref_);
           INSERT INTO oper(REF, TT, VOB, ND, PDAT, VDAT, KV, DK, S, KV2, S2,
             DATD, DATP, NAM_A, NLSA, MFOA,NAM_B, NLSB, MFOB, NAZN, USERID)
           values (REF_, 'KD8', 6, ref_,GL.BDATE , GL.BDATE , 980, 1, S2_, 980, S2_,
             GL.BDATE , GL.BDATE ,NMS2_, NLS2_, gl.AMFO , NMST_, NLST_, gl.AMFO ,
             substr(NAZN_||' Повернення депозиту '||k.nmk,1,160), id_);
           gl.payv(0,ref_,GL.BDATE ,'KD8',1,980,NLS82_,S2_,980, nlsT_,S2_ );
        end if;
        if k.s>0 then
           gl.ref (ref_);
           INSERT INTO oper(REF, TT, VOB, ND, PDAT, VDAT, KV, DK, S, KV2, S2,
             DATD, DATP, NAM_A, NLSA, MFOA,NAM_B, NLSB, MFOB, NAZN, USERID)
           values (REF_, 'KD8', 6, ref_,GL.BDATE , GL.BDATE , 980, 1, k.S , 980, k.S,
             GL.BDATE , GL.BDATE ,NMST_, NLST_, gl.AMFO , NMS2_, NLS2_, gl.AMFO ,
             substr(NAZN_||' Депозитнi кошти '||k.nmk,1,160), id_);
           gl.payv(0,ref_,GL.BDATE ,'KD8',1,980,NLST_,k.S,980, nls82_,k.S );
        end if;
     end if;
     -------------
   END LOOP;

ELSif mod_ = 1 then
-- сворачивание нач %
-- Set sTip [7] = '7. ВЕСЬ ПОРТФЕЛЬ - Выплата %   '
-- Set sTip [8] = '8. ОДИН ДОГОВОР  - Выплата %   '


   FOR K IN (SELECT s.S_PR, s.NAME, s.NLS,
                    a.NBS NBS8, ABS(sum(a.ostc)) S
             FROM KD_S_PR s, KD_888 c, accounts a
             WHERE c.S_PR=s.S_PR and
                   a.ostc=a.ostb and a.nbs in (8886,8887) and
                   substr(a.nls,6,6)+0=c.RNK  and
                  (RNK_=0 OR c.RNK=RNK_)
             GROUP BY s.S_PR, s.NAME, s.NLS, a.NBS
             HAVING sum(a.ostc)<>0
             ORDER BY s.S_PR
             )
   LOOP
IF deb.debug THEN
   deb.trace( ern, 'k.S_PR', k.S_PR );
   deb.trace( ern, 'k.NAME', k.NAME );
   deb.trace( ern, 'k.NLS',  k.NLS  );
   deb.trace( ern, 'k.NBS8', k.NBS8 );
   deb.trace( ern, 'k.S',    k.S    );
END IF;
      FIO_:='';
      IF RNK_ >0 then
         begin
           select substr(nmk,1,37) into FIO_ from customer where rnk=RNK_;
         EXCEPTION WHEN OTHERS THEN null ;
         end ;
      end if;
      gl.ref (ref_);
---------------------------
      if k.NBS8 = '8886' then
         -- кредиты '8886'
         SNAZN_:=substr('Сума нарахованих вiдсоткiв по кредитам'||
                        ' Фiз.Осiб за '|| MMS_ || ' ' ||FIO_ ,
                        1,160);
        INSERT INTO oper(REF, TT, VOB, ND, PDAT, VDAT, KV, DK, S, KV2, S2,
           DATD, DATP, NAM_A, NLSA, MFOA,NAM_B, NLSB, MFOB, NAZN, USERID)
        values (REF_, 'KDV', 6, ref_,GL.BDATE , GL.BDATE , 980, 1, k.S , 980, k.S,
           GL.BDATE , GL.BDATE ,k.NAME, k.NLS, gl.AMFO ,NMS6_, NLS6_, gl.AMFO ,
           SNAZN_, id_);
      else
         -- депозиты '8887'
         SNAZN_:=substr('Сума нарахованих витрат за строковими коштами'||
                        ' Фiз.Осiб за '||
                        MMS_||' для розподiлу за призначенням ' || FIO_,
                        1,160);
        INSERT INTO oper(REF, TT, VOB, ND, PDAT, VDAT, KV, DK, S, KV2, S2,
           DATD, DATP, NAM_A, NLSA, MFOA,NAM_B, NLSB, MFOB, NAZN, USERID)
        values (REF_, 'KDV', 6, ref_,GL.BDATE , GL.BDATE , 980, 1, k.S , 980, k.S,
           GL.BDATE , GL.BDATE ,NMS7_, NLS7_, gl.AMFO , k.NAME, k.NLS, gl.AMFO ,
           SNAZN_, id_);
      end if;

IF deb.debug THEN
   deb.trace( ern, 'SNAZN_', SNAZN_ );
END IF;

      FOR r in (select a.nls NLS, a.ostc S
                from accounts a, kd_888 c
                where a.ostc=a.ostb and  a.nbs=k.NBS8  and
                      substr(a.nls,6,6)+0=c.rnk        and
                      c.s_PR=k.S_PR and a.ostc<>0      and
                     (RNK_=0 OR c.RNK=RNK_)
                order by c.rnk
               )
      LOOP

IF deb.debug THEN
   deb.trace( ern, 'r.S', r.S );
   deb.trace( ern, 'r.NLS', r.NLS );
END IF;

        if r.S>0 then
           gl.payv(0,ref_,GL.BDATE ,'KDV',1,980,r.NLS, r.S, 980, k.NLS, r.S );
        else
           gl.payv(0,ref_,GL.BDATE ,'KDV',1,980,k.NLS,-r.S, 980, r.NLS,-r.S );
        end if;

      END LOOP;
   END LOOP;
END IF;
end kd_p;
/
show err;

PROMPT *** Create  grants  KD_P ***
grant EXECUTE                                                                on KD_P            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KD_P            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KD_P.sql =========*** End *** ====
PROMPT ===================================================================================== 
