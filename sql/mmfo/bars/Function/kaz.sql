
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kaz.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KAZ ( sps_ int, -- способ
              acc_ INTEGER -- № счета
             ) RETURN DECIMAL IS
---------------- функция вычисления суммы для перекрытия
 ost1_ NUMBER;
 ost2_ NUMBER;
 OST3_ NUMBER;
 pap_  NUMBER;
 nbs_  VARCHAR2(4);
 kv_   NUMBER;
 ldate_ DATE;
 nd_   NUMBER;
 koef_  number;
  ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);
--***************************************************************--
--             Точка пользователя для программы .....
--                    Version 7 (09/07/2015)
--                    Для ОщадБанка и Надра
--***************************************************************--

BEGIN

-- 763 - перекрытие по исходящему остатку (возможно и в локальном банк дне)
-- с контролем равенства факт и план остатка
-- использ в форексах
 if sps_ = 763 then
     BEGIN
        SELECT ost
          INTO ost1_
        FROM   sal
        WHERE  acc=acc_
        AND fdat=bankdate()
        and acc in (select acc from accounts where ostc=ostb) ;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
     END;
   RETURN ost1_;

-- 1 ------------------ C проверкой признака А/П по NBS:
elsif sps_ =1 then
     BEGIN
        SELECT ost,nbs INTO ost1_,nbs_ FROM sal WHERE acc=acc_
                  AND fdat=bankdate() ;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
     END;
     BEGIN
        SELECT pap INTO pap_ FROM ps WHERE nbs=nbs_;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
     END;
     IF pap_=1 AND ost1_<0 THEN     RETURN ost1_;
  ELSIF pap_=2 AND ost1_>0 THEN     RETURN ost1_;
  ELSIF pap_=3 THEN                 RETURN ost1_;
  ELSE                              RETURN 0;
  END IF;

-- 2 ----------------------------------------------
elsif sps_ =2 then
  BEGIN
     SELECT ostc INTO ost2_ FROM accounts WHERE ostc<0 AND acc=acc_;
     EXCEPTION  WHEN NO_DATA_FOUND THEN ost2_ := 0;
  END;
  BEGIN
     SELECT SUM(ostc) INTO ost1_ FROM accounts
     WHERE ostc>0
           and acc IN (SELECT acc FROM perekr_j WHERE accs=acc_);
     EXCEPTION WHEN NO_DATA_FOUND THEN ost1_ := 0;
  END;
  IF ost1_+ost2_ > 0 THEN RETURN ost1_+ost2_;  ELSE  RETURN 0; END IF;

-- 112 ---------------- Перекр. только Дебетовых остатков:
elsif sps_ =112 then
     BEGIN
        SELECT ost INTO ost1_ FROM sal WHERE acc=acc_
                  AND fdat=bankdate() ;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
     END;

     IF ost1_<0 THEN
        RETURN ost1_;
     ELSE
        RETURN 0;
     END IF;

---40--milionov------  NBU ----------------------------
elsif sps_ =40 then
  SELECT ostc INTO ost2_ FROM accounts WHERE acc=acc_;
  IF ost2_>4000000000 THEN RETURN ost2_-4000000000;  ELSE  RETURN 0; END IF;

---5 тыс.грн.------ Надра ----------------------------
elsif sps_ =5  then
 SELECT ostc INTO ost2_ FROM accounts WHERE acc=acc_;
 IF ost2_>500000 THEN RETURN ost2_-500000; ELSE RETURN 0; END IF;


-----------------------------------------------------------------
-- sps=3
--Для теплопостачальникив (Ощад)
-- Поки що не закинчено так як Ощадбанк так и не дав повнистю постановку
-----------------------------------------------------------------
/* elsif sps_=3 then
	select ostc, ostc - nvl(lim, 0) into ost1_, ost2_ from accounts where acc=acc_ and blkd=0;
	select koef into koef_ from perekr_b where ids=(select nls from accounts where acc=acc_) and rownum=1;
  if ost2_< ost1_*koef_ then return ost2_;
                        else return ost1_*koef_;
  end if; */

-----------------------------------------------------------------
--Додано способ 6(sps=6) (Ощад+ Надра).
--Сума списання = Сума на рахунку м?нус значення поля Formula(PEREKR_B).
-----------------------------------------------------------------
elsif sps_ =6 then
 select a.ostc-(select nvl(formula,0) from perekr_b where ids=a.nls and rownum=1) into ost2_
   from accounts a WHERE a.acc=acc_;
 IF ost2_>=0 THEN RETURN ost2_;else RETURN 0; END IF;
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--Для Ощадбанка (робилося з Гудемчук Л.М.)  SPS=8
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 elsif sps_ =8 then
 select a.ostc,a2.ostc into  ost1_,  ost2_ from accounts a, accounts a2, perekr_b b
     where  a.acc=acc_
        and a.nls=b.ids
        and b.nlsb=a2.nls
        and b.kv=a2.kv
        and a.kf=a2.kf; --это остатки счетов 3522(ost2_) и 3653(ost1_)
     ost3_:=least(ost1_,-ost2_);
 IF ost2_>=0 THEN RETURN 0;else RETURN ost3_; END IF;

--- кратно 1 тыс.грн.------ Надра ----------------------------
elsif sps_ =7  then
 SELECT ostc INTO ost2_ FROM accounts WHERE acc=acc_;
 IF ost2_>=100000 THEN RETURN ost2_-MOD(ost2_,100000); ELSE RETURN 0; END IF;

-----------------------------------------------------
elsif sps_ =10 then
---- фикс. сумма 10 грн ----     для "УКООП"
 SELECT 1000 INTO ost1_ FROM dual;
 RETURN ost1_;
-----------------------------------------------------
elsif sps_ =101 then
----  сумма 55-го тарифа   ----     для "ДЕМАРКА"
 SELECT F_TARIF(55,KV,NLS,1) INTO ost1_ FROM accounts WHERE acc=acc_;
 RETURN ost1_;
-----------------------------------------------------
elsif sps_ =29 then             --- STL,KOO
-- 29 перекрытие по входящему остатку для списания по Дебету
  SELECT ostc +decode(dapp,bankdate, (dos-kos), 0)
  INTO ost2_ FROM accounts
  WHERE acc=acc_ and dos=decode(dapp,bankdate, 0, dos);
  IF ost2_>0  THEN RETURN ost2_;  ELSE  RETURN 0; END IF;
------------------------------------------------------
elsif sps_ =86 then   -- KOO,KYI,DEM
 ---86 перекрытие по входящему остатку для списания по кредиту (РКО 8600)
  SELECT ostc +decode(dapp,bankdate, (dos-kos), 0) into ost2_
   FROM accounts WHERE acc=acc_ and kos=decode(dapp,bankdate, 0, kos);
  IF ost2_<>0  THEN RETURN ost2_;  ELSE  RETURN 0; END IF;
-------------------------------------------------------
elsif sps_ =2900 then           --- AGI
---- маржа между ГОУ и Казначейством банка ---
---- копейка не достанется никому! -----
     BEGIN
        SELECT trunc(ost/2)*2, nbs INTO ost1_,nbs_
		FROM sal WHERE acc=acc_ AND  fdat = bankdate() ;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
     END;
     BEGIN
        SELECT pap INTO pap_ FROM ps WHERE nbs=nbs_;
        EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
     END;
     IF pap_=1 AND ost1_<0 THEN     RETURN ost1_;
  ELSIF pap_=2 AND ost1_>0 THEN     RETURN ost1_;
  ELSIF pap_=3 THEN                 RETURN ost1_;
  ELSE                              RETURN 0;
  END IF;

---------- Что-то по СберБанку   -- У кого используется - ??
elsif sps_ =3570 then
  begin
     SELECT -least (-a35.ostc,a26.ostc)
     INTO ost2_
     FROM accounts a35, accounts a26
     WHERE a35.acc=acc_ and a35.kv=980 and a26.kv=980 and a26.nbs=2600 and
           a35.ostc<0 and a26.ostc>0 and
           substr(a35.nls,6,9)=substr(a26.nls,6,9) ;
     EXCEPTION WHEN NO_DATA_FOUND THEN return 0;
  END;
  return ost2_;

--------------------- 3579 для перекрытия счетов 3579...
 elsif sps_=3579 then           --- PET,UPB,STL
	               begin
SELECT
       -least (-s35.ost,s26.ost) into ost2_
FROM   sal s35, sal s26,
       specparam sp, perekr_b pr
WHERE  acc_= s35.acc
       and s35.fdat=bankdate()
       and s26.fdat=bankdate()
       and s35.acc=sp.acc
       and s26.ost>0 and s35.ost<0
       and s26.kv=s35.kv and s26.nls=pr.nlsb and pr.ids=sp.ids;
  EXCEPTION WHEN NO_DATA_FOUND THEN
           return 0;
                       end;
 return ost2_;

---------------- 39 Для Сбербанка. Перекрытие с учетом блокированной суммы  --------
---------------- 139  То же. но без лимита в течение дня.
 elsif sps_=9 then
   SELECT nvl(sum(s.kos),0) into ost2_ from saldoa s, accounts a where s.acc=acc_ and s.acc=a.acc and s.fdat=DAT_NEXT_U(bankdate, -1) and a.kv=980;
  RETURN ost2_;

 elsif sps_ =39 then ---
-- 39 перекрытие с учетом неснижаемого остатка для списания по Дебету
   SELECT ostc +nvl(lim, 0)
     INTO ost2_ FROM accounts
    WHERE acc=acc_ and lim<0;
   IF ost2_>0  THEN RETURN ost2_;
               ELSE RETURN 0;
   END IF;

 elsif sps_ =139 then ---
-- 02-07-2012 Сухова
-- Исп в Киев-город ОБ
-- 139 перекрытие с учетом неснижаемого остатка для списания по Дебету
-- по споравочнику NIGHT_LIM    'Ночной лимит';
   SELECT greatest (a.ostc - nvl(n.lim, 0),0)
   INTO ost2_
   FROM accounts a, NIGHT_LIM n
   WHERE a.acc = ACC_ and a.nls = n.nls (+) and a.kv = n.kv (+) ;
   RETURN ost2_;
---------------- 260 для перекрытия счетов 3570... по ELT  --------



  elsif sps_ = 260  then        --- PET,UPB,STL
     IF BANKDATE = DAT_LAST(BANKDATE)
        then BEGIN
             SELECT -least (-a35.ostc,a26.ostc)
             INTO ost2_
             FROM accounts a35, accounts a26,
      			   cust_acc cu35
             WHERE a35.acc=acc_ and a35.kv=980
                   and cu35.acc=a35.acc
	           and a35.ostc<0 and a26.ostc>0
                   and a35.ostc=a35.ostb
	       and a26.ACC=
	          (select max(a.acc) from accounts a, cust_acc cu
	           where a.kv=a35.kv and a.dazs is NULL
                     and (a.nls like '2600%' or a.nls like '2650%' or a.nls like '2620%')
			         and cu.rnk=cu35.rnk and a.ACC=cu.acc);
             EXCEPTION WHEN NO_DATA_FOUND THEN return 0;
             END;
             return ost2_;
     ELSE begin
	    BEGIN
              SELECT ost,nbs INTO ost1_,nbs_
              FROM sal WHERE acc=acc_
                             AND fdat=bankdate() ;
              EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
            END;
            BEGIN
               SELECT pap INTO pap_ FROM ps WHERE nbs=nbs_;
               EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
            END;

            IF pap_=1 AND ost1_<0 THEN      RETURN ost1_;
               ELSIF pap_=2 AND ost1_>0 THEN   RETURN ost1_;
               ELSIF pap_=3 THEN               RETURN ost1_;
               ELSE                            RETURN 0;
               END IF;
           end;
     END IF;  -- 260
 end if;  -- для всех SPS


RETURN 0;
END;  -- KAZ
/
 show err;
 
PROMPT *** Create  grants  KAZ ***
grant EXECUTE                                                                on KAZ             to BARS015;
grant EXECUTE                                                                on KAZ             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KAZ             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kaz.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 