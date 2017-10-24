

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_KPK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_KPK ***

  CREATE OR REPLACE PROCEDURE BARS.CC_KPK ( bdat_ date DEFAULT BANKDATE) IS
fdat_   date;
id_     INT;
refP_   INT;
s_      NUMBER(24);
ref_    INT;
ost_    NUMBER(24);
Lim_    NUMBER(24);
kv_     INT;
fact_   INT;
acc_SP  INT;
nam_SP  VARCHAR(38);
nls_SP  VARCHAR(14);
acc_SS  INT;
nam_SS  VARCHAR(38);
nls_SS  VARCHAR(14);
ttn_    CONSTANT VARCHAR(70):= '─юёЁюўэюх яюур°хэшх ъЁхфшЄр';
tt_     CONSTANT CHAR(3)    := 'OVR';
ern     CONSTANT POSITIVE   := 208;
err     EXCEPTION;
erm     VARCHAR2(80);
CURSOR acc0 IS
  SELECT SP.acc, SP.ostc, AD.refp, AD.accs, SP.nls, substr(SP.nms ,1,38),
         SS.nls, substr(SS.nms ,1,38), SP.kv
  FROM accounts SP,  cc_add AD, accounts SS
  WHERE SP.tip='SP '   AND
        AD.accp=SP.acc AND AD.accs=SS.acc AND AD.adds=0  ;
--AND SP.ostc>0
-- OST_ - ресурс для гашения
CURSOR opl0 IS
  SELECT fdat,sum(s * (1-2*dk) )   FROM opldok
  WHERE tt='KPK' AND ref=refP_ AND acc = acc_SP AND sos=3 AND
        fdat = (select MIN(fdat) from opldok
                where fdat> bdat_ and sos=3 and ref=refP_)
  GROUP BY fdat ;
-- S_   - ожидает в календаре на гашение
BEGIN
   BEGIN
      SELECT SUBSTR(flags,38,1) INTO fact_ FROM tts WHERE tt=tt_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
      erm := '8012 - No transaction defined # '||tt_; RAISE err;
   END;
   BEGIN
      SELECT id INTO id_ FROM staff WHERE LTRIM(RTRIM(UPPER(logname)))=USER;
      EXCEPTION  WHEN NO_DATA_FOUND THEN  erm := '8012 - Unregistered user';
      RAISE err;
   END;
   OPEN acc0;
   LOOP FETCH acc0 INTO acc_SP, ost_, refP_, acc_SS, nls_SP, nam_SP,
                        nls_SS, nam_SS, kv_;
        EXIT WHEN acc0%NOTFOUND;
     OPEN opl0;
     LOOP FETCH opl0 INTO fdat_, s_ ; EXIT WHEN opl0%NOTFOUND;
       IF s_ > 0 THEN Lim_:= -S_; ELSE Lim_:=0; END IF;

       If s_ > 0 AND ost_ >0 THEN

          S_:= LEAST( S_, OST_); -- сумма гашения
          Lim_:= Lim_ + S_;
          gl.ref (ref_);         -- ref для текущего гашения
          INSERT INTO oper
            (ref   ,tt    ,vob    ,nd    ,dk     ,pdat   ,vdat    ,datd    ,
             nam_a ,nlsa  ,mfoa   ,nam_b ,nlsb   ,mfob   ,kv      ,s       ,
             nazn  ,userid)
          VALUES
            (ref_  , tt_  ,6      ,ref_  ,1      ,SYSDATE,gl.bDATE,gl.bDATE,
             nam_SP,nls_SP,gl.aMFO,nam_SS, nls_SS,gl.aMFO,kv_     , s_     ,
             ttn_  ,id_   );
          gl.pay(null,ref_,gl.bDATE,tt_,kv_,0,acc_SP,s_,0,ttn_);
          gl.pay(null,ref_,gl.bDATE,tt_,kv_,1,acc_SS,s_,0,ttn_);
          IF fact_=1 THEN gl.pay(2,ref_,gl.bDATE); END IF;
          gl.pay(null,refP_,fdat_,'KPK',kv_,1,acc_SP,s_,0,ttn_);
          gl.pay(null,refP_,fdat_,'KPK',kv_,0,acc_SS,s_,0,ttn_);
       end if;
       UPDATE accounts SET lim=Lim_ WHERE acc=ACC_SP;
     END LOOP; close opl0;
   END LOOP;   close acc0;
END CC_KPK;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_KPK.sql =========*** End *** ==
PROMPT ===================================================================================== 
