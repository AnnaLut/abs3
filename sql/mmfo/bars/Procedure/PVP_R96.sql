CREATE OR REPLACE PROCEDURE BARS.PVP_R96 ( dat_ IN DATE DEFAULT NULL)
   IS
/*
   17-01-2018 в CURSOR c0 v.acc_RRR замінили на v.acc6204
   12-01-2015 Наконечний В. Процедура виконує переоцінку 
      вал. позицій коригуючими проводками і під одним РЕФ
   
   14-01-2010 Sta. Особое назн.пл для отличия от обычных PVP.
    Finis/Реал.Курс.Рiзниця для рах.3800090310/840
    (Подсказка Таскалина)

   Процедура, которая делает все ту же  переоценку ВАЛ.ПОЗ !

   но вместо счета vp_list.acc6204  - в  GL.p_pvp
   использует счет vp_list.acc_RRR  -    RU_p_pvp - см.ниже
   внизу, после процедуры RU_p_pvp, - курсор по валютам
*/

l_ref number := null;

PROCEDURE RU_p_pvp ( kv_ NUMBER DEFAULT NULL, dat_  DATE DEFAULT NULL, p_ref in out number) IS

fdat_    DATE;
acc3801_ NUMBER;       -- sch EKV VAL POZ
acc_RRR_ NUMBER;       -- sch PER VAL POZ
s1_      DECIMAL(24);  -- VAL POZ tek kurs
s2_      DECIMAL(24);  -- na sch EKV VAL POZ
dk_      INTEGER;
ref_     INTEGER;
name_    VARCHAR2(70);  -- PVP Transaction name
nam_a_   VARCHAR2(70);
nam_b_   VARCHAR2(70);
nls3801_ VARCHAR2(15);   -- sch EKV VAL POZ
nls3800_ VARCHAR2(15);   -- sch VAL POZ
nls6204_ VARCHAR2(15);   -- sch PER VAL POZ
L_DAT01  date;
l_dat31  date;
l_vdat   date;
l_kv_base number := nvl(gl.baseval, 980);

CURSOR c0 IS
SELECT v.acc3801, v.acc6204, a.nls,
       SUM(OSTQ_KORR(a.acc, l_dat31, null, a.nbs))
FROM accounts a,  vp_list v
WHERE a.acc=v.acc3800  
  AND (a.kv=kv_ OR kv_ is NULL)
GROUP BY v.acc3801,v.acc6204, a.nls
ORDER BY 1, 2;

ern         CONSTANT POSITIVE := 205;
err         EXCEPTION;
erm         VARCHAR2(80);

BEGIN

fdat_ := NVL(dat_,gl.bDATE);

   L_DAT01:= TRUNC(gl.bdate,'MM'); 
   select max(fdat) into l_vdat from fdat where fdat<trunc(gl.bdate,'MM');
   l_dat31 := Dat_last (L_dat01-19, L_dat01-1) ;

BEGIN
   SELECT name INTO name_ FROM tts WHERE tt='PVP';
EXCEPTION  WHEN NO_DATA_FOUND THEN name_ := 'NO_DATA_FOUND tts.TT=PVP';
END;


FOR d IN ( SELECT gl.bDATE fdat FROM dual
     UNION SELECT fdat          FROM fdat WHERE fdat >= fdat_
           GROUP BY fdat ORDER BY 1 )
LOOP
   gl.bDATE := d.fdat;

   OPEN c0;
   LOOP <<MET>>

      FETCH c0 INTO acc3801_,acc_RRR_,nls3800_, s1_;
      EXIT WHEN c0%NOTFOUND;

      IF acc3801_ IS NULL OR acc_RRR_ IS NULL THEN  GOTO MET;   END IF;

      BEGIN
         SELECT OST_KORR(acc, l_dat31, null, nbs)  INTO s2_
         FROM accounts a
         WHERE a.acc = acc3801_;
      EXCEPTION  WHEN NO_DATA_FOUND THEN s2_ := 0;
      END;

      s2_ := s1_ + s2_;
      IF s2_ = 0 THEN  GOTO MET;                     END IF;  -- est ravenstvo
      IF s2_ > 0 THEN  dk_ := 0;  ELSE    dk_ := 1;  END IF;

      BEGIN
         SELECT nls,nms INTO nls3801_,nam_a_  FROM accounts WHERE acc=acc3801_;
      EXCEPTION  WHEN NO_DATA_FOUND THEN nam_a_ := 'NO_DATA_FOUND 3801';
      END;

      BEGIN
         SELECT nls,nms INTO nls6204_,nam_b_ FROM accounts WHERE acc=acc_RRR_;
      EXCEPTION WHEN NO_DATA_FOUND THEN nam_b_ := 'NO_DATA_FOUND 6204/2';
      END;


      if p_ref is null then
          gl.ref (ref_);
          p_ref := ref_;
          
          INSERT INTO oper (ref,tt,vob,nd,dk,pdat,vdat,datd,userid,
                          nam_a,nlsa,mfoa,nam_b,nlsb,mfob,kv,kv2,s,nazn)
          VALUES  (ref_,'PVP',96,substr(ref_,3,10),1-dk_,SYSDATE,l_vdat,gl.bDATE,gl.aUID,
           SUBSTR(nam_a_,1,38),nls3801_,gl.aMFO,
           SUBSTR(nam_b_,1,38),nls6204_,gl.aMFO,
           l_kv_base,l_kv_base,ABS(s2_),
           'Finis/Реал.Курс.Рiзниця для рах.'||nls3800_ ||'/'||kv_);
      else 
          ref_ := p_ref;
      end if; 

      gl.pay2( NULL,ref_,gl.bDATE,'PVP',l_kv_base,  dk_,acc3801_,ABS(s2_),0,1,name_);
      gl.pay2( NULL,ref_,gl.bDATE,'PVP',l_kv_base,1-dk_,acc_RRR_,ABS(s2_),0,0,name_);
      --gl.pay2( 2,   ref_,gl.bDATE);

   END LOOP;
   CLOSE c0;

END LOOP;

gl.param;

EXCEPTION WHEN err    THEN gl.param;
               raise_application_error(-(20000+ern),'\'||erm,TRUE);
--          WHEN OTHERS THEN gl.param;
--               raise_application_error(-(20000+ern),SQLERRM,TRUE);
END RU_p_pvp;
------------------------------------

begin
  for k  in (select kv from tabval where d_close is null)
  loop
     RU_p_pvp ( k.kv, dat_, l_ref ) ;
  end loop;

  gl.pay2( 2,   l_ref, gl.bDATE);
end PVP_R96;
/