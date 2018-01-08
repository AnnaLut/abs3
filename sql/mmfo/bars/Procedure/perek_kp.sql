

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PEREK_KP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PEREK_KP ***

  CREATE OR REPLACE PROCEDURE BARS.PEREK_KP (mode_ Number ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура перекрытия корр/ 6,7 классов за декабрь на 5040
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1998.  All Rights Reserved.
% VERSION     : 18.01.2011 (22.12.2005)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 18.01.2011  для облуправлений Сбербанка (кроме ОПЕРУ)
%             дату валютирования будем формировать как "0101YYYY"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
 ref_       Int          ;
 ntemp1_    Number       ;
 ostf_      Number(24)   ;
 nam_a_     Varchar2(38) ;
 nam_b_     Varchar2(38) ;
 nam1_      Varchar2(70) ;
 nam2_      Varchar2(70) ;
 nlsd_      Varchar2(15) ;
 nlsk_      Varchar2(15) ;
 nls5040_   Varchar2(15) ;
 okpo_a_    Varchar2(14) ;
 okpo_b_    Varchar2(14) ;
 id_        Int          ;
 nazn_      Varchar2(160);
 okpo1_     Varchar2(14) ;
 okpo2_     Varchar2(14) ;
 datv_      Date         ;
 tt_        Char(3)      ;
 errmes_    Char(100)    ;
 vob_       Number(38)   ;
 firstday_  Date         ;
 mfo_       NUMBER;
 mfou_      NUMBER;

BEGIN
------ инициализация переменных ------------------
 nam_a_:='';
 nam_b_:='';
---  nazn_:='Перекриття 2003 ф_нансового року';
 nazn_:='Перекриття '||to_char(TRUNC(BANKDATE,'YYYY')-1)||' ф_нансового року';
--- операция перекрытия
 tt_:='ZG9';
 --------------------------------------------------
--- DELETE FROM TMP_6_7;
--- COMMIT;

-- свой МФО
   mfo_ := F_Ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT NVL(trim(mfou), mfo_)
        INTO mfou_
      FROM BANKS
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   SELECT COUNT(*)
      INTO ntemp1_
   FROM tts WHERE tt=tt_;

  IF ntemp1_ = 1 THEN

--- дата валютирования
    BEGIN
       SELECT MAX(fdat) INTO datv_
       FROM fdat WHERE TRUNC(fdat,'YYYY') < TRUNC(BANKDATE,'YYYY');
    EXCEPTION WHEN OTHERS THEN
       datv_:=BANKDATE;
    END;

--- первый рабочий день года
    BEGIN
       SELECT MIN(fdat) INTO firstday_
       FROM fdat WHERE TRUNC(fdat,'YYYY') = TRUNC(BANKDATE,'YYYY');
    EXCEPTION WHEN OTHERS THEN
       firstday_:=BANKDATE;
    END;

--- для всех облуправлений Сбербанка (кроме ОПЕРУ) дату валютирования в операции ZG9
--- устанавливаем 0101ГГГГ т.к. перекрытие 6,7 классов на 5040(5041) выполняется 0101ГГГГ
    if mfou_ = 300465 and mfo_ != mfou_ then
      datv_ := to_date('0101' || to_char(bankdate,'YYYY'),'ddmmyyyy');
    end if;

--- вид оборотов из настроек операции
    BEGIN
       SELECT vob
          INTO vob_
       FROM tts_vob
       WHERE tt=tt_;
    EXCEPTION WHEN OTHERS THEN
       vob_:=6;
    END;

    FOR k in (SELECT p.nls NLSA, p.nlsb NLSB, p.NAZN NAZN,
                     substr(a.nms,1,38) NMSA, c.okpo OKPO,
                     NVL(p.ostf,0) OST
               FROM per6_7kp p, accounts a, customer c
               WHERE   p.nls  is not null
                 AND   p.nlsb is not null
                 AND   p.nls =  a.nls
                 AND   a.kv  =  980
                  --AND   a.ostc = a.ostb      -- 12.01.2011
                 AND   a.rnk =  c.rnk )
    LOOP

--- остаток по документам с vob=96
    BEGIN
       SELECT SUM(DECODE(p.dk,0,-p.s,1,p.s,0))
          INTO ostf_
       FROM accounts a, opldok p, oper o
       WHERE a.acc  =  p.acc
         AND p.fdat <= bankdate
         AND p.fdat >= firstday_
         AND p.ref  =  o.ref
         AND o.sos  =  5
         AND o.vob  =  96
         AND substr(a.nbs,1,1) in ('6','7')
         AND a.kv   =  980
         AND a.nls  =  k.nlsa
         AND a.dazs is null ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        ostf_:=0;
    END;

    nazn_:=nvl(k.nazn,nazn_);
    IF nvl(nls5040_,' ') <> k.nlsb THEN
       BEGIN
          SELECT a.nls, substr(a.nms,1,38), c.okpo
          INTO nls5040_, nam_b_, okpo_b_
          FROM accounts a, customer c
          WHERE   a.nls=k.nlsb
   	    AND  a.kv=980
            AND  a.rnk=c.rnk ;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          INSERT INTO TMP_6_7 (NLSA, NLSB, S, ERR) VALUES
                 ('', 'ERROR', '','Ошибка. Отсутствует счет перекрытия (980)'||k.nlsb);
       END ;
    END IF;

--- Возвращает код тек. пользователя STAFF.ID
    BEGIN
       --SELECT id INTO id_ FROM STAFF WHERE UPPER(logname)=UPPER(USER);
       id_ := user_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       id_ := 1;
    END;

    IF ostf_ > 0 THEN
       nlsd_ :=k.nlsa  ;
       nlsk_ :=k.nlsb  ;
       nam1_ :=k.nmsa  ;
       nam2_ :=nam_b_  ;
       okpo1_:=k.okpo  ;
       okpo2_:=okpo_b_ ;
    ELSE
       nlsd_ :=k.nlsb  ;
       nlsk_ :=k.nlsa  ;
       nam1_ :=nam_b_  ;
       nam2_ :=k.nmsa  ;
       okpo2_:=k.okpo  ;
       okpo1_:=okpo_b_ ;
    END IF ;

--- проводка по перекрытию счета
    savepoint sp;
    IF ABS(ostf_) > 0 THEN
       BEGIN
          GL.REF (ref_);
         /* INSERT INTO oper (ref , tt , vob , nd  , dk, pdat   , vdat , datd    ,
                            datp    , nam_a, nlsa , mfoa   , id_a  , nam_b, nlsb,
                            mfob   , id_b  , kv , s         , kv2, s2        ,
                            nazn , userid, sign)
          VALUES           (ref_, tt_, vob_, ref_,  1, sysdate, datv_, BANKDATE,
                            BANKDATE, nam1_, nlsd_, gl.AMFO, okpo1_, nam2_, nlsk_,
                            gl.AMFO, okpo2_, 980, ABS(ostf_), 980, ABS(ostf_),
                            NAZN_, id_   ,HEXTORAW('4155544F5452414E53414354494F4E'));
		*/
		 gl.in_doc3(ref_=> ref_  , 
                    tt_  =>tt_, 
                    vob_=> vob_, 
                    nd_ => ref_, 
                    pdat_=> SYSDATE, 
                    vdat_=> datv_,
                    dk_ => 1   , 
                    kv_  =>980, 
                    s_  => ABS(ostf_), 
                    kv2_=> 980, 
                    s2_  => ABS(ostf_), 
                    sk_  => null, 
                    data_=> bankdate, 
                    datp_=> bankdate,
                    nam_a_=> nam1_, 
                    nlsa_=> nlsd_,
                    mfoa_=> gl.amfo, 
                    nam_b_=> nam2_, 
                    nlsb_=> nlsk_, 
                    mfob_=> gl.amfo,
                    nazn_ => nazn_,
                    d_rec_=> null,
                    id_a_=> okpo1_, 
                    id_b_=> okpo2_, 
                    id_o_ => null, 
                    sign_=> HEXTORAW ('4155544F5452414E53414354494F4E'), 
                    sos_=>1, 
                    prty_=>null, 
                    uid_=>id_) ;
          PAYTT(0,ref_,BANKDATE,tt_,1,980,nlsd_,ABS(ostf_),980,nlsk_,ABS(ostf_));
       EXCEPTION WHEN OTHERS THEN
          BEGIN
           rollback to sp;
           errmes_:=SUBSTR(SQLERRM,1,100);
           INSERT INTO TMP_6_7 (REF, NLSA,  NLSB,  S,     ERR)
  		     VALUES            (REF_, NLSD_, NLSK_, OSTF_,errmes_);
  	       GOTO final;
          END;
       END;
    END IF ;
    <<final>> NULL;
    END LOOP;
  ELSE
     INSERT INTO TMP_6_7 (NLSA, NLSB, S, ERR) VALUES
         ('', 'ERROR', '','Ошибка. Отсутствует операция автоперекрытия ZG9');

  END IF;
END perek_kp ;
/
show err;

PROMPT *** Create  grants  PEREK_KP ***
grant EXECUTE                                                                on PEREK_KP        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PEREK_KP        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PEREK_KP.sql =========*** End *** 
PROMPT ===================================================================================== 
