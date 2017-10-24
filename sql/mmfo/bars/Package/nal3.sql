
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nal3.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NAL3 IS
/* OLGA+QWA версия 2.0 от 29-12-2005
   в соотв с указом 473 от 24.10.2005
*/


 K1_A_     number;
 K1_V_     number;
 K1_01_1_  number;
 K1_D_     number;
 K1_J_     number;
 K1_04_1_  number;
 K1_04_13_ number;  --new

 K2_1_     number;
 K2_2_     number;
 K2_3_     number;
 K2_4_     number;
 K2_5_     number;
 K2_6_     number;
 K2_7_     number;
 K2_01_4_  number;

 K3_02_3_  number;
 K3_05_3_  number;
 K3_22_    number;

 K4_A1_    number;
 K4_A2_    number;
 K4_10_1_  number;
 K4_B1_    number;
 K4_B2_    number;
 K4_10_2_  number;
 K4_10_    number;

 K5_13_    number;
 K5_13_1_  number;
 K5_A4_    number;
 K5_A5_    number;
 K5_A_     number;
 K5_B4_    number;
 K5_B5_    number;
 K5_B_     number;

 K6_B_     number;
 K6_19_1_  number;

 P1_A_3_     NUMBER;
 P1_A_4_     NUMBER;
 P1_A_5_     NUMBER;
 P1_A_6_     NUMBER;
 P1_A1_6_    NUMBER;
 P1_A2_6_    NUMBER;
 P1_A3_6_    NUMBER;
-- блок только СБЕР
 P1_B1_3_    NUMBER;
 P1_B1_5_    NUMBER;
 P1_B1_7_    NUMBER;
 P1_B2_3_    NUMBER;
 P1_B2_4_    NUMBER;
 P1_B2_5_    NUMBER;
 P1_B2_6_    NUMBER;
 P1_B2_7_    NUMBER;
 P1_B3_3_    NUMBER;
 P1_B3_4_    NUMBER;
 P1_B3_5_    NUMBER;
 P1_B3_6_    NUMBER;
 P1_B3_7_    NUMBER;
-- конец блока только СБЕР
 P1_07_      NUMBER;
 P1_4_11_3_  NUMBER;
 P1_4_11_4_  NUMBER;
 P1_4_11_5_  NUMBER;
 P1_4_11_6_  NUMBER;
 P1_4_11_7_  NUMBER;
 P1_4_11_8_  NUMBER;
 P1_01_6_    NUMBER;

 P2_04_8_  number;

 P3_04_9_  number;
 P3_01_    number;
 P3_05_    number;
 P3_V_     number;

 P_01_     number;
 P_01_7_     number;
 P_02_     number;
 P_03_     number;
 P_04_     number;
 P_04_11_P1_  number;
 P_05_     number;
 P_06_     number;
 P_08_     number;
 P_11_     number;
 P_11_1_   number;
 P_11_2_   number;
 P_12_     number;
 P_12_1_   number;
 P_12_2_   number;
 P_14_     number;
 P_17_     number;
 P_19_     number;
 P_P1_01_3_ number;
 P_P1_04_4_ number;
 P_P1_04_11_ number;
 P_P4_04_12_ number;

 H_08_     number;

--------------------------
PROCEDURE NAL_PRN (ID_ int, N_ INT, DD_ char, FDAT_ date );

FUNCTION NAL_NULL RETURN number;
FUNCTION nal1(N_ number,DD_ VARCHAR2,RR_ VARCHAR2,FDAT_ date) RETURN number;
---==============
FUNCTION  K1_A(N_ int,fdat_ date) RETURN number;
FUNCTION  K1_V(N_ int,fdat_ date) RETURN number;
FUNCTION  K1_01_1(N_ int,fdat_ date) RETURN number;
FUNCTION  K1_D(N_ int,fdat_ date) RETURN number;
FUNCTION  K1_J(N_ int,fdat_ date) RETURN number;
FUNCTION  K1_04_1(N_ int,fdat_ date) RETURN number;
FUNCTION  K1_04_13(N_ int,fdat_ date) RETURN number;  -- new
---==============
FUNCTION  K2_1(N_ int,fdat_ date) RETURN number;
FUNCTION  K2_2(N_ int,fdat_ date) RETURN number;
FUNCTION  K2_3(N_ int,fdat_ date) RETURN number;
FUNCTION  K2_4(N_ int,fdat_ date) RETURN number;
FUNCTION  K2_5(N_ int,fdat_ date) RETURN number;
FUNCTION  K2_6(N_ int,fdat_ date) RETURN number;
FUNCTION  K2_7(N_ int,fdat_ date) RETURN number;
FUNCTION  K2_01_4(N_ int,fdat_ date) RETURN number;
---==============
FUNCTION  K3_02_3(N_ int,fdat_ date) RETURN number;
FUNCTION  K3_05_3(N_ int,fdat_ date) RETURN number;
FUNCTION  K3_22(N_ int,fdat_ date) RETURN number;
---==============
FUNCTION  K4_A1(N_ int,fdat_ date) RETURN number;
FUNCTION  K4_A2(N_ int,fdat_ date) RETURN number;
FUNCTION  K4_10_1(N_ int,fdat_ date) RETURN number;
FUNCTION  K4_B1(N_ int,fdat_ date) RETURN number;
FUNCTION  K4_B2(N_ int,fdat_ date) RETURN number;
FUNCTION  K4_10_2(N_ int,fdat_ date) RETURN number;
FUNCTION  K4_10(N_ int,fdat_ date) RETURN number;
---==============
FUNCTION  K5_13(N_ int,fdat_ date) RETURN number;
FUNCTION  K5_13_1(N_ int,fdat_ date) RETURN number;
FUNCTION  K5_A4(N_ int,fdat_ date) RETURN number;
FUNCTION  K5_A5(N_ int,fdat_ date) RETURN number;
FUNCTION  K5_A(N_ int,fdat_ date) RETURN number;
FUNCTION  K5_B4(N_ int,fdat_ date) RETURN number;
FUNCTION  K5_B5(N_ int,fdat_ date) RETURN number;
FUNCTION  K5_B(N_ int,fdat_ date) RETURN number;
---==============
FUNCTION K6_19_1(N_ int, fdat_ date) RETURN number;
FUNCTION K6_B(N_ int, fdat_ date) RETURN number;
---==============
FUNCTION P1_A_3     (N_ int, fdat_ date) RETURN number;
FUNCTION P1_A_4    (N_ int, fdat_ date) RETURN number;
FUNCTION P1_A_5    (N_ int, fdat_ date) RETURN number;
FUNCTION P1_A_6    (N_ int, fdat_ date) RETURN number;
FUNCTION P1_A1_6   (N_ int, fdat_ date) RETURN number;
FUNCTION P1_A2_6   (N_ int, fdat_ date) RETURN number;
FUNCTION P1_A3_6   (N_ int, fdat_ date) RETURN number;
-- Сбер
FUNCTION P1_B1_3  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B1_5  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B1_7  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B2_3  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B2_4  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B2_5  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B2_6  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B2_7  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B3_3  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B3_4  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B3_5  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B3_6  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_B3_7  (N_ int, fdat_ date) RETURN number;
--- Сбер
FUNCTION P1_07     (N_ int, fdat_ date) RETURN number;
FUNCTION P1_01_6  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_4_11_3  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_4_11_4  (N_ INT, FDAT_ DATE) RETURN NUMBER;
FUNCTION P1_4_11_5  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_4_11_6  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_4_11_7  (N_ int, fdat_ date) RETURN number;
FUNCTION P1_4_11_8  (N_ int, fdat_ date) RETURN number;
---===============
FUNCTION P2_04_8  (N_ int, fdat_ date) RETURN number;
---===============
FUNCTION P3_04_9  (N_ int, fdat_ date) RETURN number;
FUNCTION P3_01  (N_ int, fdat_ date) RETURN number;
FUNCTION P3_05  (N_ int, fdat_ date) RETURN number;
FUNCTION P3_V     (N_ int, fdat_ date) RETURN number;
---===============
FUNCTION P_01    (N_ int, fdat_ date) RETURN number;
FUNCTION P_01_7    (N_ int, fdat_ date) RETURN number;
FUNCTION P_02    (N_ int, fdat_ date) RETURN number;
FUNCTION P_03    (N_ int, fdat_ date) RETURN number;
FUNCTION P_04    (N_ int, fdat_ date) RETURN number;
FUNCTION P_05    (N_ int, fdat_ date) RETURN number;
FUNCTION P_06    (N_ int, fdat_ date) RETURN number;
FUNCTION P_08    (N_ int, fdat_ date) RETURN number;
FUNCTION P_11    (N_ int, fdat_ date) RETURN number;
FUNCTION P_11_1  (N_ int, fdat_ date) RETURN number;
FUNCTION P_11_2  (N_ int, fdat_ date) RETURN number;
FUNCTION P_12    (N_ int, fdat_ date) RETURN number;
FUNCTION P_12_1  (N_ int, fdat_ date) RETURN number;
FUNCTION P_12_2  (N_ int, fdat_ date) RETURN number;
FUNCTION P_14    (N_ int, fdat_ date) RETURN number;
FUNCTION P_17    (N_ int, fdat_ date) RETURN number;
FUNCTION P_19    (N_ int, fdat_ date) RETURN number;
FUNCTION P_P1_01_3    (N_ int, fdat_ date) RETURN number;
FUNCTION P_P1_04_4    (N_ int, fdat_ date) RETURN number;
FUNCTION P_P1_04_11    (N_ int, fdat_ date) RETURN number;
FUNCTION P_P4_04_12 (N_ int, fdat_ date) RETURN number;
---===============
END NAL3;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.NAL3 IS
--------     версия Сбербанка   -----------
/* OLGA+QWA версия 2.0 от 24-01-2006
   в соотв с указом 473 от 24.10.2005
   описание см. nal6_kb.doc
-- версия 2.1 от 02-02-2006
-- версии 2.1-2.4 от 06-07-2006 (приведено в соотв. КБ в тех частях,
--                                 которые не отличаются)
   1. Доработка P1_07 (вместе с заготовкой по счету P1_Б5_7,
         P1_4_11_5,P1_4_11_6,P1_4_11_7,P1_4_11_8
   2. Декларация Р 12 коэфф. вместо 0.3 - 0.25
   3. Декларация Р 04   не все строки "в том числе"
                            отражались (04.14, 04.7). Исправлено.
   4. Додаток К1 04.13 - реализован через формулу
          K1_04_13 ( в предыдущей версии был счет).
    На  эту же формулу ссылается Декларация Р 04.13.K1
    Замена счета на формулу - в патче по замене пакета
   5. 	Додаток Р1 04.11=Б1+Б2+Б3+Б4+Б5+Б6+Б7+Б8 (табл 2)
                            (P1_4_11_3)
*/

PROCEDURE NAL_PRN (ID_ int, N_ INT, DD_ char, FDAT_ date ) is
 YYYY_ int;
 K_ int;
 OKPO_ varchar2(8);    NMK_ varchar2 (70) ;
 ADR_  VARCHAR2(70);   TEL_   VARCHAR2(30);
 RUK_  VARCHAR2(70);   BUH_  VARCHAR2(70);
 sPar_ varchar2(120);  sSQL_ varchar2(250);
 c INTEGER;
 i INTEGER;
 S_ number;
 ern  CONSTANT POSITIVE := 021; erm  VARCHAR2(80); err  EXCEPTION;
begin
deb.trace(ern, '1', ID_ ||' '|| N_||' '|| DD_ ||' '||FDAT_ );
  S_:= nal3.NAL_null;
deb.trace(ern, '2', S_) ;
  delete from nal_tmp where id=id_ ;
--  logger.info('0nal3  старт ');
  K_   :=to_number(to_char(FDAT_,'Q'));
  YYYY_:=to_number(to_char(FDAT_,'YYYY'));
  sPar_:='(' || N_ || ', to_date(''' || to_char(FDAT_,'DDMMYYYY') ||
         ''',''DDMMYYYY'')) FROM dual ';
deb.trace(ern, '3', sPar_) ;
---logger.info('1nal3   sPar_= '||sPar_ );
OKPO_:='';
NMK_:='';
ADR_:='';
TEL_:='';
RUK_:='';
BUH_:='';
  begin
---logger.info('2nal3   N_= '||N_ );
     if N_ = 0 then
       begin
        select val  into OKPO_ from params where par='OKPO';
        EXCEPTION WHEN NO_DATA_FOUND THEN OKPO_:='';
       end;
       begin
        select val  into NMK_  from params where par='NAME';
        EXCEPTION WHEN NO_DATA_FOUND THEN NMK_:='';
       end;
       begin
        select val  into ADR_  from params where par='ADDRESS';
        EXCEPTION WHEN NO_DATA_FOUND THEN ADR_:='';
       end;
       begin
        select val  into TEL_  from params where par='PHONES';
        EXCEPTION WHEN NO_DATA_FOUND THEN TEL_:='';
       end;
       begin
        select val  into RUK_  from params where par='BOSS';
        EXCEPTION WHEN NO_DATA_FOUND THEN RUK_:='';
       end;
       begin
        select val  into BUH_  from params where par='ACCMAN';
        EXCEPTION WHEN NO_DATA_FOUND THEN BUH_:='';
       end;
      else
        select C.okpo, C.nmk, C.adr, CC.RUK, CC.BUH
        into OKPO_ , NMK_, ADR_, RUK_, BUH_
        from customer C, corps CC where C.rnk=N_ and cc.RNK=C.rnk;
     end if;
   end;
deb.trace(ern, '4', OKPO_ || ' ' || NMK_ ) ;
---logger.info('3 nal3_начало цикла');
  for k in (select RR, NLS, FORMULA , ord , nms, nms1
            from nal_dec3 where dd=DD_ and
                 (nls is not null or formula is not null) and RR<>'04.12.P5' )   --- !!!!! потом убрать  and RR<>'04.12.P5'
  loop
     deb.trace(ern, '5', k.RR ||' '|| k.FORMULA ) ;
---logger.info('4 nal3_rr='||k.RR||' '|| k.FORMULA);
     if k.NLS is not null then       -- простой показатель
          S_:=nal3.nal1(N_,DD_ ,k.RR ,FDAT_);
        deb.trace(ern, '6', S_ ) ;
---logger.info('5 nal3_простой='||k.RR||' '|| k.FORMULA);
     else                            -- сложный показатель
        -- текст динамич SQL
        sSQL_:='SELECT nal3.' || k.FORMULA || sPar_ ;
        deb.trace(ern, '7.1', sSQL_ ) ;
---logger.info('6 nal3_сложный='||sSQL_||'  '||k.RR||' '|| k.FORMULA);
        -- открыть курсор
        c := DBMS_SQL.OPEN_CURSOR;
        -- приготовить дин.SQL
        DBMS_SQL.PARSE(c, sSQL_, DBMS_SQL.NATIVE);
        -- установить знач колонки в SELECT
        DBMS_SQL.DEFINE_COLUMN(c, 1, S_);
        -- выполнить приготовленный SQL
        i:= DBMS_SQL.EXECUTE(c);
        -- прочитать
        IF DBMS_SQL.FETCH_ROWS(c)>0 THEN
           -- снять результирующую переменную
           DBMS_SQL.COLUMN_VALUE(c, 1, S_);
        end if;
        -- закрыть курсор
        DBMS_SQL.CLOSE_CURSOR(c);
        deb.trace(ern, '7.2', S_ ) ;
     end if;
     insert into nal_tmp (ID, DD, OKPO, YYYY, K, NMS, RR, S, ord, nmk, adr, tel, ruk, buh )
       values (ID_,DD_,OKPO_,YYYY_,K_,k.nms||nvl(k.nms1,' '), k.RR, S_, k.ORD, NMK_, ADR_, TEL_, RUK_, BUH_);
     commit;
     deb.trace(ern, '8', YYYY_ ) ;
--  logger.info('7nal3_запись_tmp='||k.RR||' '|| DD_||'S='||S_);
  end loop;
end nal_prn;
----------------------
FUNCTION NAL_null RETURN NUMBER IS
BEGIN
 K1_A_      :=null;
 K1_V_      :=null;
 K1_01_1_   :=null;
 K1_D_      :=null;
 K1_J_      :=null;
 K1_04_1_   :=null;
 K1_04_13_  :=null; -- new

 K2_1_      :=null;
 K2_2_      :=null;
 K2_3_      :=null;
 K2_4_      :=null;
 K2_5_      :=null;
 K2_6_      :=null;
 K2_7_      :=null;
 K2_01_4_   :=null;

 K3_02_3_   :=null;
 K3_05_3_   :=null;
 K3_22_     :=null;

 K4_A1_     :=null;
 K4_A2_     :=null;
 K4_10_1_   :=null;
 K4_B1_     :=null;
 K4_B2_     :=null;
 K4_10_2_   :=null;
 K4_10_     :=null;

 K5_13_     :=null;
 K5_13_1_   :=null;
 K5_A4_     :=null;
 K5_A5_     :=null;
 K5_A_      :=null;
 K5_B4_     :=null;
 K5_B5_     :=null;
 K5_B_      :=null;

 K6_B_      :=null;
 K6_19_1_   :=null;

 P1_A_3_    :=null;
 P1_A_4_    :=null;
 P1_A_5_    :=null;
 P1_A_6_    :=null;
 P1_A1_6_   :=null;
 P1_A2_6_   :=null;
 P1_A3_6_   :=null;
-- Сбер
 P1_B1_3_   :=null;
 P1_B1_5_   :=null;
 P1_B1_7_   :=null;
 P1_B2_3_   :=null;
 P1_B2_4_   :=null;
 P1_B2_5_   :=null;
 P1_B2_6_   :=null;
 P1_B2_7_   :=null;
 P1_B3_3_   :=null;
 P1_B3_4_   :=null;
 P1_B3_5_   :=null;
 P1_B3_6_   :=null;
 P1_B3_7_   :=null;
--- Сбер
 P1_4_11_7_ :=null;
 P1_4_11_8_ :=null;
 P1_4_11_3_ :=null;

 P2_04_8_   :=null;

 P3_04_9_   :=null;
 P3_01_     :=null;
 P3_05_     :=null;
 P3_V_      :=null;

 P_01_      :=null;
 P_01_7_      :=null;
 P_02_      :=null;
 P_03_      :=null;
 P_04_      :=null;
 P_05_      :=null;
 P_06_      :=null;
 P_08_      :=null;
 P_11_      :=null;
 P_11_1_    :=null;
 P_11_2_    :=null;
 P_12_      :=null;
 P_12_1_    :=null;
 P_12_2_    :=null;
 P_14_      :=null;
 P_17_      :=null;
 P_19_      :=null;
 P_P1_01_3_  :=null;
 P_P1_04_4_  :=null;
 P_P1_04_11_  :=null;
 P_P4_04_12_  :=null;
 H_08_      :=null;

 return 0;
END NAL_null;

------------Простой показатель
FUNCTION nal1 (N_ number, DD_ VARCHAR2, RR_ VARCHAR2, FDAT_ date)
 RETURN number IS
  nn_  number;
BEGIN
   begin
     if N_ = 0 then
        -- сальдо верхнего счета NLS (Центр НУ НБУ или КБ)
        SELECT s.OSTF - s.DOS + s.KOS
        INTO nn_
        FROM accounts A, nal_dec3 N, saldoa S
        WHERE A.nls=N.NLS and A.kv=980 and
              N.dd =DD_   and N.rr=RR_ and
              A.acc=S.acc and rownum=1 and
             (A.acc,S.fdat)= (select acc,max(fdat) from saldoa
                              where acc=A.acc and fdat<=FDAT_
                              group by acc );
     else
        --- сальдо подчиненных счетов от NLS (Обл.НБУ или по исп или ???)
        SELECT s.OSTF - s.DOS + s.KOS
        INTO nn_
        FROM accounts A,accounts b, nal_dec3 N, cust_acc U, saldoa S
        WHERE A.nls=N.NLS and A.kv  =980   and
              N.dd =DD_   and N.rr  =RR_   and
              U.rnk=N_    and b.accc=a.acc and b.acc=U.acc and
              U.acc=S.acc and rownum=1     and
             (U.acc,S.fdat)= (select acc,max(fdat) from saldoa
                              where acc=U.acc and fdat<=FDAT_
                              group by acc );
     end if;
   exception when no_data_found then nn_:=0;
   End;
   if dd_='@' and rr_  in ('05.1','05.2') then
      nn_:=-nn_;
   else
      nn_:=abs(nn_);
   end if;
   return nn_;
END NAL1;
---===============       K1
FUNCTION K1_A(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K1_A_ is null then
     K1_A_:=NAL3.nal1( N_ , 'K1', 'А1.26', fdat_) +
	 		NAL3.nal1( N_ , 'K1', 'А1.29', fdat_) +
			NAL3.nal1( N_ , 'K1', 'А1.129', fdat_) +
            NAL3.nal1( N_ , 'K1', 'А2', fdat_) +
            NAL3.nal1( N_ , 'K1', 'А3', fdat_) +
            NAL3.nal1( N_ , 'K1', 'А4', fdat_) +
            NAL3.nal1( N_ , 'K1', 'А5', fdat_) +
            NAL3.nal1( N_ , 'K1', 'А6', fdat_) ;
  end if;
  return K1_A_;
END K1_A;
----------
FUNCTION K1_V(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K1_V_ is null then
     K1_V_:=NAL3.nal1( N_ , 'K1', 'В1.037', fdat_) +
	 		NAL3.nal1( N_ , 'K1', 'В1.038', fdat_) +
			NAL3.nal1( N_ , 'K1', 'В1.039', fdat_) +
            NAL3.nal1( N_ , 'K1', 'В2', fdat_) ;
  end if;
  return K1_V_;
END K1_V;
-----------
FUNCTION K1_01_1(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K1_01_1_ is null then
     K1_01_1_:=NAL3.K1_A( N_,             fdat_) +
               NAL3.nal1( N_ , 'K1', 'Б', fdat_) +
               NAL3.K1_V( N_,             fdat_) +
               NAL3.nal1( N_ , 'K1', 'Г', fdat_) ;
  end if;
  return K1_01_1_;
END K1_01_1;
---------------------
FUNCTION K1_D(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K1_D_ is null then
     K1_D_:=NAL3.nal1( N_ , 'K1', 'Д1', fdat_) +
            NAL3.nal1( N_ , 'K1', 'Д2.078', fdat_) +
			NAL3.nal1( N_ , 'K1', 'Д2.051', fdat_) +
            NAL3.nal1( N_ , 'K1', 'Д3', fdat_) +
            NAL3.nal1( N_ , 'K1', 'Д4', fdat_) -
            NAL3.nal1( N_ , 'K1', 'Д5', fdat_) ;
  end if;
  return K1_D_;
END K1_D;
----------
FUNCTION K1_J(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K1_J_ is null then
     K1_J_:=NAL3.nal1( N_ , 'K1', 'Ж1.085', fdat_) +
	 		NAL3.nal1( N_ , 'K1', 'Ж1.086', fdat_) +
			NAL3.nal1( N_ , 'K1', 'Ж1.087', fdat_) -        --??? -или+
            NAL3.nal1( N_ , 'K1', 'Ж2', fdat_) ;
  end if;
  return K1_J_;
END K1_J;
-----------
FUNCTION K1_04_1(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K1_04_1_ is null then
     K1_04_1_:=NAL3.K1_D( N_,             fdat_) +
               NAL3.K1_J( N_,             fdat_) +
               NAL3.nal1( N_ , 'K1', 'З', fdat_) ;
  end if;
  return K1_04_1_;
END K1_04_1;
-----------
FUNCTION K1_04_13(N_ int, fdat_ date) RETURN number IS  -- new
BEGIN
  if K1_04_13_ is null then
     K1_04_13_:=NAL3.nal1( N_ , 'K1', '04.13.1', fdat_) +
	        NAL3.nal1( N_ , 'K1', '04.13.2', fdat_)  ;
  end if;
  return K1_04_13_;
END K1_04_13;
---===============       K2
FUNCTION K2_1(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K2_1_ is null then
     K2_1_:=NAL3.nal1( N_ , 'K2', '1.1', fdat_) -
            NAL3.nal1( N_ , 'K2', '1.2', fdat_) -
            NAL3.nal1( N_ , 'K2', '1.3', fdat_) ;
  end if;
  return K2_1_;
END K2_1;
----------
FUNCTION K2_2(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K2_2_ is null then
     K2_2_:=NAL3.nal1( N_ , 'K2', '2.1', fdat_) -
            NAL3.nal1( N_ , 'K2', '2.2', fdat_) -
            NAL3.nal1( N_ , 'K2', '2.3', fdat_) ;
  end if;
  return K2_2_;
END K2_2;
----------
FUNCTION K2_3(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K2_3_ is null then
     K2_3_:=NAL3.nal1( N_ , 'K2', '3.1', fdat_) -
            NAL3.nal1( N_ , 'K2', '3.2', fdat_) -
            NAL3.nal1( N_ , 'K2', '3.3', fdat_) ;
  end if;
  return K2_3_;
END K2_3;
----------
FUNCTION K2_4(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K2_4_ is null then
     K2_4_:=NAL3.nal1( N_ , 'K2', '4.1', fdat_) -
            NAL3.nal1( N_ , 'K2', '4.2', fdat_) -
            NAL3.nal1( N_ , 'K2', '4.3', fdat_) ;
  end if;
  return K2_4_;
END K2_4;
----------
FUNCTION K2_5(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K2_5_ is null then
     K2_5_:=NAL3.nal1( N_ , 'K2', '5.1', fdat_) -
            NAL3.nal1( N_ , 'K2', '5.2', fdat_) -
            NAL3.nal1( N_ , 'K2', '5.3', fdat_) ;
  end if;
  return K2_5_;
END K2_5;
----------
FUNCTION K2_6(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K2_6_ is null then
     K2_6_:=NAL3.nal1( N_ , 'K2', '6.1', fdat_) -
            NAL3.nal1( N_ , 'K2', '6.2', fdat_) -
            NAL3.nal1( N_ , 'K2', '6.3', fdat_) ;
  end if;
  return K2_6_;
END K2_6;
----------
FUNCTION K2_7(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K2_7_ is null then
     K2_7_:=NAL3.nal1( N_ , 'K2', '7.1', fdat_) -
            NAL3.nal1( N_ , 'K2', '7.2', fdat_) -
            NAL3.nal1( N_ , 'K2', '7.3', fdat_) ;
  end if;
  return K2_7_;
END K2_7;
----------
FUNCTION K2_01_4(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K2_01_4_ is null then
     K2_01_4_:=GREATEST(0,NAL3.K2_1( N_,fdat_)) +
               GREATEST(0,NAL3.K2_2( N_,fdat_)) +
               GREATEST(0,NAL3.K2_3( N_,fdat_)) +
               GREATEST(0,NAL3.K2_4( N_,fdat_)) +
               GREATEST(0,NAL3.K2_5( N_,fdat_)) ;
  end if;
  return K2_01_4_;
END K2_01_4;
---===============       K3 - исп. в @
FUNCTION K3_02_3(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K3_02_3_ is null then
     K3_02_3_:=NAL3.nal1( N_ , 'K3', '02.3.031', fdat_)+
	           NAL3.nal1( N_ , 'K3', '02.3.057', fdat_);
  end if;
  return K3_02_3_;
END K3_02_3;
-----------  - исп. в @
FUNCTION K3_05_3(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K3_05_3_ is null then
     K3_05_3_:=NAL3.nal1( N_ , 'K3', '05.3.282', fdat_) +
	 NAL3.nal1( N_ , 'K3', '05.3.284', fdat_);
  end if;
  return K3_05_3_;
END K3_05_3;
-----------   - исп. в @
FUNCTION K3_22(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K3_22_ is null then
     K3_22_:=NAL3.nal1( N_ , 'K3', '22', fdat_) ;
  end if;
  return K3_22_;
END K3_22;
---===============      K4
FUNCTION K4_A1(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K4_A1_ is null then
     K4_A1_:=NAL3.nal1( N_ , 'K4', 'А1.1', fdat_) ;
  end if;
  return K4_A1_;
END K4_A1;
-----------
FUNCTION K4_A2(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K4_A2_ is null then
     K4_A2_:=NAL3.nal1( N_ , 'K4', 'А2.1', fdat_) ;
  end if;
  return K4_A2_;
END K4_A2;
-----------
FUNCTION K4_10_1(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K4_10_1_ is null then
     K4_10_1_:=NAL3.K4_A1( N_,fdat_) -
               NAL3.K4_A2( N_,fdat_) -
               NAL3.nal1( N_,'K4','А3', fdat_) ;
  end if;
  return K4_10_1_;
END K4_10_1;
---------
FUNCTION K4_B1(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K4_B1_ is null then
     K4_B1_:=NAL3.nal1( N_ , 'K4', 'Б1.1', fdat_) ;
  end if;
  return K4_B1_;
END K4_B1;
-----------
FUNCTION K4_B2(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K4_B2_ is null then
     K4_B2_:=NAL3.nal1( N_ , 'K4', 'Б2.1', fdat_) ;
  end if;
  return K4_B2_;
END K4_B2;
-----------
FUNCTION K4_10_2(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K4_10_2_ is null then
     K4_10_2_:=NAL3.K4_B1( N_,fdat_) -
               NAL3.K4_B2( N_,fdat_) -
               NAL3.nal1( N_, 'K4','Б3', fdat_) ;
  end if;
  return K4_10_2_;
END K4_10_2;
---------
FUNCTION K4_10(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K4_10_ is null then
     K4_10_:=NAL3.K4_10_1( N_,             fdat_) +
             NAL3.K4_10_2( N_,             fdat_) +
             NAL3.nal1   ( N_, 'K4', 'Б3', fdat_) ;
  end if;
  return K4_10_;
END K4_10;
---===============       K5
FUNCTION K5_13(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K5_13_ is null then
     K5_13_:=NAL3.nal1( N_, 'K5', '13.1', fdat_) +
             NAL3.nal1( N_, 'K5', '13.2', fdat_) +
             NAL3.nal1( N_, 'K5', '13.3', fdat_) +
             NAL3.nal1( N_, 'K5', '13.4', fdat_) +
             NAL3.nal1( N_, 'K5', '13.5.1', fdat_) ;
  end if;
  return K5_13_;
END K5_13;
---------
FUNCTION K5_A4(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K5_A4_ is null then
     K5_A4_:=NAL3.nal1( N_, 'K5', 'A1', fdat_) -
             NAL3.nal1( N_, 'K5', 'A2', fdat_) -
             NAL3.nal1( N_, 'K5', 'A3', fdat_);
  end if;
  return K5_A4_;
END K5_A4;
---------
FUNCTION K5_A5(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K5_A5_ is null then
     K5_A5_:=abs(NAL3.K5_A4( N_, fdat_))*0.25;
  end if;
  return K5_A5_;
END K5_A5;
---------
FUNCTION K5_A(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K5_A_ is null then
     K5_A_:=TO_NUMBER(iif_n(NAL3.nal1( N_, 'K5', 'A6', fdat_),NAL3.K5_A5( N_, fdat_),TO_CHAR(NAL3.nal1( N_, 'K5', 'A6', fdat_)),
	 		TO_CHAR(NAL3.nal1( N_, 'K5', 'A6', fdat_)),TO_CHAR(NAL3.K5_A5( N_, fdat_))));
  end if;
  return K5_A_;
END K5_A;
---------
FUNCTION K5_B4(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K5_B4_ is null then
     K5_B4_:=NAL3.nal1( N_, 'K5', 'Б1', fdat_) -
             NAL3.nal1( N_, 'K5', 'Б2', fdat_) -
             NAL3.nal1( N_, 'K5', 'Б3', fdat_);
  end if;
  return K5_B4_;
END K5_B4;
---------
FUNCTION K5_B5(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K5_B5_ is null then
     K5_B5_:=abs(NAL3.K5_B4( N_, fdat_))*0.25;
  end if;
  return K5_B5_;
END K5_B5;
---------
FUNCTION K5_B(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K5_B_ is null then
     K5_B_:=TO_NUMBER(iif_n(NAL3.nal1( N_, 'K5', 'Б6', fdat_),NAL3.K5_B5( N_, fdat_),TO_CHAR(NAL3.nal1( N_, 'K5', 'Б6', fdat_)),
	TO_CHAR(NAL3.nal1( N_, 'K5', 'Б6', fdat_)),TO_CHAR(NAL3.K5_B5( N_, fdat_))));
  end if;
  return K5_B_;
END K5_B;
---------
FUNCTION K5_13_1(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K5_13_1_ is null then
     K5_13_1_:=NAL3.K5_A( N_,             fdat_) +
               NAL3.K5_B( N_,             fdat_);
  end if;
  return K5_13_1_;
END K5_13_1;
---===============       K6
FUNCTION K6_19_1(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K6_19_1_ is null then
     K6_19_1_:=NAL3.nal1( N_, 'K6', 'А1', fdat_)*0;
  end if;
  return K6_19_1_;
END K6_19_1;
---------
FUNCTION K6_B(N_ int, fdat_ date) RETURN number IS
BEGIN
  if K6_B_ is null then
     K6_B_:=TO_NUMBER(iif_n(
NAL3.nal1( N_, 'K6', 'Б1', fdat_)*NAL3.nal1( N_, 'K6', 'Б3', fdat_),
(NAL3.nal1( N_, 'K6', 'Б1', fdat_)-NAL3.nal1( N_, 'K6', 'Б2', fdat_))*0.25,
to_char((NAL3.nal1( N_, 'K6', 'Б1', fdat_)-NAL3.nal1( N_, 'K6', 'Б2', fdat_))*0.25),
to_char((NAL3.nal1( N_, 'K6', 'Б1', fdat_)-NAL3.nal1( N_, 'K6', 'Б2', fdat_))*0.25),
to_char(NAL3.nal1( N_, 'K6', 'Б1', fdat_)*NAL3.nal1( N_, 'K6', 'Б3', fdat_))));
  end if;
  return K6_B_;
END K6_B;
---===============       P1
---------------------------------------------                     (tab1)
FUNCTION P1_A_3    (N_ int, fdat_ date) RETURN number is
begin
  if P1_A_3_ is null then
     P1_A_3_:=NAL3.nal1( N_, 'P1', 'А1.3', fdat_) +
              NAL3.nal1( N_, 'P1', 'А2.3', fdat_) +
              NAL3.nal1( N_, 'P1', 'А3.3', fdat_) ;
  end if;
   return P1_A_3_;
END P1_A_3;
---------
FUNCTION P1_A_4    (N_ int, fdat_ date) RETURN number is
begin
  if P1_A_4_ is null then
     P1_A_4_:=NAL3.nal1( N_, 'P1', 'А1.4', fdat_) +
              NAL3.nal1( N_, 'P1', 'А2.4', fdat_) +
              NAL3.nal1( N_, 'P1', 'А3.4', fdat_) ;
  end if;
   return P1_A_4_;
END P1_A_4;
---------
FUNCTION P1_A_5    (N_ int, fdat_ date) RETURN number is
begin
  if P1_A_5_ is null then
     P1_A_5_:=NAL3.nal1( N_, 'P1', 'А1.5', fdat_) +
              NAL3.nal1( N_, 'P1', 'А2.5', fdat_) +
              NAL3.nal1( N_, 'P1', 'А3.5', fdat_) ;
  end if;
   return P1_A_5_;
END P1_A_5;
---------
FUNCTION P1_A_6    (N_ int, fdat_ date) RETURN number is
begin
  if P1_A_6_ is null then
     P1_A_6_:=NAL3.P1_A_3( N_,          fdat_) -
              NAL3.P1_A_4( N_,          fdat_) -
              NAL3.P1_A_5( N_,          fdat_) ;
  end if;
   return P1_A_6_;
END P1_A_6;
---------
FUNCTION P1_A1_6    (N_ int, fdat_ date) RETURN number is
begin
  if P1_A1_6_ is null then
     P1_A1_6_:=NAL3.nal1( N_, 'P1', 'А1.3', fdat_) -
               NAL3.nal1( N_, 'P1', 'А1.4', fdat_) -
               NAL3.nal1( N_, 'P1', 'А1.5', fdat_) ;
  end if;
   return P1_A1_6_;
END P1_A1_6;
---------
FUNCTION P1_A2_6    (N_ int, fdat_ date) RETURN number is
begin
  if P1_A2_6_ is null then
     P1_A2_6_:=NAL3.nal1( N_, 'P1', 'А2.3', fdat_) -
               NAL3.nal1( N_, 'P1', 'А2.4', fdat_) -
               NAL3.nal1( N_, 'P1', 'А2.5', fdat_) ;
  end if;
   return P1_A2_6_;
END P1_A2_6;
---------
FUNCTION P1_A3_6    (N_ int, fdat_ date) RETURN number is
begin
  if P1_A3_6_ is null then
     P1_A3_6_:=NAL3.nal1( N_, 'P1', 'А3.3', fdat_) -
               NAL3.nal1( N_, 'P1', 'А3.4', fdat_) -
               NAL3.nal1( N_, 'P1', 'А3.5', fdat_) ;
  end if;
   return P1_A3_6_;
END P1_A3_6;
----------Сбер
----------------------------------------------------------     (tab 2)
FUNCTION P1_B1_3    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B1_3_ is null then
     P1_B1_3_:=NAL3.nal1( N_, 'P1', 'Б1.3.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б1.3.294', fdat_) ;
  end if;
   return P1_B1_3_;
END P1_B1_3;
------
FUNCTION P1_B1_5    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B1_5_ is null then
     P1_B1_5_:=NAL3.nal1( N_, 'P1', 'Б1.5.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б1.5.296', fdat_) ;
  end if;
   return P1_B1_5_;
END P1_B1_5;
------
FUNCTION P1_B1_7    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B1_7_ is null then
     P1_B1_7_:=NAL3.nal1( N_, 'P1', 'Б1.7.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б1.7.306', fdat_) ;
  end if;
   return P1_B1_7_;
END P1_B1_7;
--------
FUNCTION P1_B2_3    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B2_3_ is null then
     P1_B2_3_:=NAL3.nal1( N_, 'P1', 'Б2.3.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б2.3.298', fdat_) ;
  end if;
   return P1_B2_3_;
END P1_B2_3;
------
FUNCTION P1_B2_4    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B2_4_ is null then
     P1_B2_4_:=NAL3.nal1( N_, 'P1', 'Б2.4.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б2.4.295', fdat_) +
			   NAL3.nal1( N_, 'P1', 'Б2.4.299', fdat_);
  end if;
   return P1_B2_4_;
END P1_B2_4;
------
FUNCTION P1_B2_5    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B2_5_ is null then
     P1_B2_5_:=NAL3.nal1( N_, 'P1', 'Б2.5.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б2.5.300', fdat_);
  end if;
   return P1_B2_5_;
END P1_B2_5;
------
FUNCTION P1_B2_6    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B2_6_ is null then
     P1_B2_6_:=NAL3.nal1( N_, 'P1', 'Б2.6.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б2.6.301', fdat_);
  end if;
   return P1_B2_6_;
END P1_B2_6;
------
FUNCTION P1_B2_7    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B2_7_ is null then
     P1_B2_7_:=NAL3.nal1( N_, 'P1', 'Б2.7.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б2.7.307', fdat_);
  end if;
   return P1_B2_7_;
END P1_B2_7;
-------
FUNCTION P1_B3_3    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B3_3_ is null then
     P1_B3_3_:=NAL3.nal1( N_, 'P1', 'Б3.3.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б3.3.302', fdat_);
  end if;
   return P1_B3_3_;
END P1_B3_3;
-------
FUNCTION P1_B3_4    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B3_4_ is null then
     P1_B3_4_:=NAL3.nal1( N_, 'P1', 'Б3.4.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б3.4.303', fdat_);
  end if;
   return P1_B3_4_;
END P1_B3_4;
-------
FUNCTION P1_B3_5    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B3_5_ is null then
     P1_B3_5_:=NAL3.nal1( N_, 'P1', 'Б3.5.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б3.5.304', fdat_);
  end if;
   return P1_B3_5_;
END P1_B3_5;
-------
FUNCTION P1_B3_6    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B3_6_ is null then
     P1_B3_6_:=NAL3.nal1( N_, 'P1', 'Б3.6.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б3.6.305', fdat_);
  end if;
   return P1_B3_6_;
END P1_B3_6;

-------
FUNCTION P1_B3_7    (N_ int, fdat_ date) RETURN number is
begin
  if P1_B3_7_ is null then
     P1_B3_7_:=NAL3.nal1( N_, 'P1', 'Б3.7.0', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б3.7.308', fdat_);
  end if;
   return P1_B3_7_;
END P1_B3_7;

---------------продолж. Сбер

FUNCTION P1_07    (N_ int, fdat_ date) RETURN number is
begin
  if P1_07_ is null then
       P1_07_:=	     nvl(NAL3.P1_B1_7( N_,             fdat_),0) +
		 nvl(NAL3.P1_B2_7( N_,             fdat_),0) +
         nvl(NAL3.P1_B3_7( N_,             fdat_),0) +
         nvl(NAL3.nal1( N_, 'P1', 'Б4.7', fdat_),0) +
         nvl(NAL3.nal1( N_, 'P1', 'Б5.7', fdat_),0) +
         nvl(NAL3.nal1( N_, 'P1', 'Б6.7', fdat_),0) +
         nvl(NAL3.nal1( N_, 'P1', 'Б7.7', fdat_),0) +
         nvl(NAL3.nal1( N_, 'P1', 'Б8.7', fdat_),0) +
         nvl(NAL3.nal1( N_, 'P1', 'В.7', fdat_),0) ;
  end if;
   return P1_07_;
END P1_07;
---------     (tab 4)
FUNCTION P1_01_6    (N_ int, fdat_ date) RETURN number is
begin
  if P1_01_6_ is null then
     P1_01_6_:=NAL3.nal1( N_, 'P1', '01.6.1', fdat_) -
               NAL3.nal1( N_, 'P1', '01.6.2', fdat_) *
               NAL3.nal1( N_, 'P1', '01.6.3', fdat_) ;
  end if;
   return P1_01_6_;
END P1_01_6;
--------- (tab 3)
FUNCTION P1_4_11_3  (N_ int, fdat_ date) RETURN number is
begin
  P1_4_11_3_:= NAL3.P1_B1_3( N_,             fdat_) +
               NAL3.P1_B2_3( N_,             fdat_) +
               NAL3.P1_B3_3( N_,             fdat_) +
               NAL3.nal1( N_, 'P1', 'Б4.3', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б5.3', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б6.3', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б7.3', fdat_) +
               NAL3.nal1( N_, 'P1', 'Б8.3', fdat_)  ;
    return P1_4_11_3_;
END P1_4_11_3;
--===============
FUNCTION P1_4_11_4  (N_ int, fdat_ date) RETURN number is
begin
  P1_4_11_4_:=NAL3.P1_4_11_3( N_,  fdat_)*0.1;
     return P1_4_11_4_;
END P1_4_11_4;
--===============
-- чет?ре следующих влияют на P_P1_04_11
-- в Сбербанке не используются   P1_4_11_5,P1_4_11_6,P1_4_11_7,P1_4_11_8
-- а работает через простые показатели
-- то есть в заготовке нет формул, но есть счета
FUNCTION P1_4_11_5  (N_ int, fdat_ date) RETURN number is
dat_  date;
nn_   number;
YYYY_ number;
YYBD_ number;
begin
--   YYYY_:=to_number(to_char(FDAT_,'YYYY'));
   YYBD_:=to_number(to_char(FDAT_,'YYYY'));
   nn_:=1;
   -- фактичн_ обсяги пол_пшень нарост п_дсумком за 1 кв
   begin
     select max(f.fdat) into dat_ from fdat f,
       (select fdat,to_number(to_char(fdat,'Q')) QQ,
                    to_number(to_char(fdat,'YYYY')) YYYY from fdat) d
     where f.fdat=d.fdat and d.qq=1 and f.fdat<=fdat_ and d.YYYY=YYBD_;
     exception when NO_DATA_FOUND then nn_:=0;
   end;
   if nn_<>0 then
    P1_4_11_5_:=NAL3.nal1( N_, 'P1', '4.11', dat_);
   else P1_4_11_5_:=0;
   end if;
   return P1_4_11_5_;
END P1_4_11_5;
--===============
FUNCTION P1_4_11_6  (N_ INT, FDAT_ DATE) RETURN NUMBER IS
dat_  date;
nn_   number;
YYYY_ number;
YYBD_ number;
begin
--   YYYY_:=to_number(to_char(FDAT_,'YYYY'));
   YYBD_:=to_number(to_char(FDAT_,'YYYY')); -- текущий год
   nn_:=1;
   -- фактичн_ обсяги пол_пшень нарост п_дсумком за 2 кв
   begin
     select max(f.fdat) into dat_ from fdat f,
       (select fdat,to_number(to_char(fdat,'Q')) QQ,
                    to_number(to_char(fdat,'YYYY')) YYYY from fdat) d
     where f.fdat=d.fdat and d.qq=2 and f.fdat<=fdat_ and d.YYYY=YYBD_;
     exception when NO_DATA_FOUND then nn_:=0;
   end;
   if nn_<>0 then
    P1_4_11_6_:=NAL3.nal1( N_, 'P1', '4.11', dat_);
   else P1_4_11_6_:=0;
   end if;
   return P1_4_11_6_;
END P1_4_11_6;
--===============
FUNCTION P1_4_11_7  (N_ INT, FDAT_ DATE) RETURN NUMBER IS
dat_  date;
nn_   number;
YYYY_ number;
YYBD_ number;
begin
--   YYYY_:=to_number(to_char(FDAT_,'YYYY'));
   YYBD_:=to_number(to_char(FDAT_,'YYYY'));
   nn_:=1;
   -- фактичн_ обсяги пол_пшень нарост п_дсумком за 3 кв
   begin
     select max(f.fdat) into dat_ from fdat f,
       (select fdat,to_number(to_char(fdat,'Q')) QQ,
                    to_number(to_char(fdat,'YYYY')) YYYY from fdat) d
     where f.fdat=d.fdat and d.qq=3 and f.fdat<=fdat_ and d.YYYY=YYBD_;
     exception when NO_DATA_FOUND then nn_:=0;
   end;
   if nn_<>0 then
    P1_4_11_7_:=NAL3.nal1( N_, 'P1', '4.11', dat_);
   else P1_4_11_7_:=0;
   end if;
   return P1_4_11_7_;
END P1_4_11_7;
--===============
FUNCTION P1_4_11_8  (N_ INT, FDAT_ DATE) RETURN NUMBER IS
dat_  date;
nn_   number;
YYYY_ number;
YYBD_ number;
begin
--   YYYY_:=to_number(to_char(FDAT_,'YYYY'));
   YYBD_:=to_number(to_char(FDAT_,'YYYY'));
   nn_:=1;
   -- фактичн_ обсяги пол_пшень нарост п_дсумком за 4 кв
   begin
     select max(f.fdat) into dat_ from fdat f,
       (select fdat,to_number(to_char(fdat,'Q')) QQ,
                    to_number(to_char(fdat,'YYYY')) YYYY from fdat) d
     where f.fdat=d.fdat and d.qq=4 and f.fdat<=fdat_ and d.YYYY=YYBD_;
     exception when NO_DATA_FOUND then nn_:=0;
   end;
   if nn_<>0 then
    P1_4_11_8_:=NAL3.nal1( N_, 'P1', '4.11', dat_);
   else P1_4_11_8_:=0;
   end if;
   return P1_4_11_8_;
END P1_4_11_8;
---===============       P2
FUNCTION P2_04_8  (N_ int, fdat_ date) RETURN number is
begin
  if P2_04_8_ is null then
   P2_04_8_:= NAL3.nal1( N_, 'P2', '4.8.1', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.2', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.3', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.4', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.5', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.6', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.7', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.8', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.9', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.10', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.11', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.12', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.13', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.14', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.15', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.16', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.17', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.18', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.19', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.20', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.21', fdat_)+
              NAL3.nal1( N_, 'P2', '4.8.22', fdat_);
  end if;
   return P2_04_8_;
END P2_04_8;
---===============       P3
FUNCTION P3_V     (N_ int, fdat_ date) RETURN number is
begin
  if P3_V_ is null then
   P3_V_:= NAL3.nal1( N_, 'P3', 'В1', fdat_)+
           NAL3.nal1( N_, 'P3', 'В2', fdat_);
  end if;
   return P3_V_;
END P3_V;
-------------
FUNCTION P3_04_9  (N_ int, fdat_ date) RETURN number is
begin
  if P3_04_9_ is null then
   P3_04_9_:= NAL3.P3_01( N_,           fdat_)+
              NAL3.nal1( N_, 'P3', '2', fdat_)+
              NAL3.nal1( N_, 'P3', '3', fdat_)+
              NAL3.nal1( N_, 'P3', '4', fdat_)+
              NAL3.P3_05( N_,           fdat_);
  end if;
   return P3_04_9_;
END P3_04_9;
-------------
FUNCTION P3_01  (N_ int, fdat_ date) RETURN number is
begin
  if P3_01_ is null or NAL3.P3_V( N_, fdat_)<(NAL3.nal1( N_, 'P3', 'А', fdat_)*0.05) then
   P3_01_:= NAL3.P3_V( N_,             fdat_)-
            NAL3.nal1( N_, 'P3', 'А', fdat_)*0.02;
  else
   P3_01_:= NAL3.nal1( N_, 'P3', 'А', fdat_)*0.05-
            NAL3.nal1( N_, 'P3', 'А', fdat_)*0.02;
  end if;
   return P3_01_;
END P3_01;
-------------
FUNCTION P3_05  (N_ int, fdat_ date) RETURN number is
begin
  if P3_05_ is null or NAL3.nal1( N_, 'P3', 'Г', fdat_)<(NAL3.nal1( N_, 'P3', 'А', fdat_)*0.1) then
   P3_05_:= NAL3.nal1( N_, 'P3', 'Г', fdat_)-
            NAL3.nal1( N_, 'P3', 'А', fdat_)*0.02;
  else
   P3_05_:= NAL3.nal1( N_, 'P3', 'А', fdat_)*0.1-
            NAL3.nal1( N_, 'P3', 'А', fdat_)*0.02;
  end if;
   return P3_05_;
END P3_05;
---===============       P декларация
FUNCTION P_P1_01_3    (N_ int, fdat_ date) RETURN number  is
begin
  if NAL3.P1_A_6( N_, fdat_ )<0 then
         P_P1_01_3_:= abs(NAL3.P1_A_6( N_, fdat_ ));
  else   P_P1_01_3_:=0;
  end if;
   return  P_P1_01_3_;
END  P_P1_01_3;
--------------
FUNCTION P_P1_04_4    (N_ int, fdat_ date) RETURN number  is
begin
  if NAL3.P1_A_6( N_, fdat_ )>=0 then
         P_P1_04_4_:= abs(NAL3.P1_A_6( N_, fdat_ ));
  else   P_P1_04_4_:=0;
  end if;
   return  P_P1_04_4_;
END  P_P1_04_4;
--------------
FUNCTION P_P1_04_11   (N_ int, fdat_ date) RETURN number  is
kk_ number(16,1);
begin
  KK_:=to_number(to_char(fdat_,'Q'));
if  f_ourmfo='300465' then
   if KK_=1  then
     P_P1_04_11_:= NAL3.nal1( N_, 'P1', '4.11.5', fdat_);
    elsif KK_=2 then
     P_P1_04_11_:= NAL3.nal1( N_, 'P1', '4.11.6', fdat_);
    elsif KK_=3 then
     P_P1_04_11_:= NAL3.nal1( N_, 'P1', '4.11.7', fdat_);
    elsif KK_=4 then
     P_P1_04_11_:= NAL3.nal1( N_, 'P1', '4.11.8', fdat_);
   end if;
else
  if KK_=1  then
--   если для каждого квартала свой счет
--    P_P1_04_11_:= NAL3.nal1( N_, 'P1', '4.11.5', fdat_)
-- один счет нарастающим итогом каждый квартал  рассчетный
   P_P1_04_11_:=NAL3.P1_4_11_5 (N_,fdat_);
   elsif KK_=2 then
--   если для каждого квартала свой счет
--     P_P1_04_11_:= NAL3.nal1( N_, 'P1', '4.11.6', fdat_);
    P_P1_04_11_:=NAL3.P1_4_11_6 (N_,fdat_);
    elsif KK_=3 then
--   если для каждого квартала свой счет
--     P_P1_04_11_:= NAL3.nal1( N_, 'P1', '4.11.7', fdat_);
    P_P1_04_11_:=NAL3.P1_4_11_7 (N_,fdat_);
    elsif KK_=4 then
--   если для каждого квартала свой счет
--     P_P1_04_11_:= NAL3.nal1( N_, 'P1', '4.11.8', fdat_);
    P_P1_04_11_:=NAL3.P1_4_11_8 (N_,fdat_);
  end if;
end if;
   return  P_P1_04_11_;
END  P_P1_04_11;
--------------
FUNCTION P_01    (N_ int, fdat_ date) RETURN number  is
begin
  if P_01_ is null then
   P_01_:= NAL3.K1_01_1( N_,              fdat_)+
              NAL3.nal1( N_, '@', '01.2', fdat_)+
         NAL3.P_P1_01_3( N_,              fdat_)+
           NAL3.K2_01_4( N_,              fdat_)+
              NAL3.nal1( N_, '@', '01.5', fdat_)+
           NAL3.P1_01_6( N_,              fdat_)+
		   NAL3.P_01_7( N_,              fdat_);
  end if;
  return P_01_;
END P_01;
--------------
FUNCTION P_01_7    (N_ int, fdat_ date) RETURN number  is
begin
  if P_01_7_ is null then
   P_01_7_:=  NAL3.nal1( N_, '@', '01.7.003', fdat_)+
			  NAL3.nal1( N_, '@', '01.7.005', fdat_)+
			  NAL3.nal1( N_, '@', '01.7.006', fdat_)+
			  NAL3.nal1( N_, '@', '01.7.051', fdat_)+
			  NAL3.nal1( N_, '@', '01.7.053', fdat_)+
			  NAL3.nal1( N_, '@', '01.7.057', fdat_)+
			  NAL3.nal1( N_, '@', '01.7.130', fdat_)+
			  NAL3.nal1( N_, '@', '01.7.136', fdat_)+
			  NAL3.nal1( N_, '@', '01.7.138', fdat_);
  end if;
  return P_01_7_;
END P_01_7;
--------------
FUNCTION P_02    (N_ int, fdat_ date) RETURN number  is
begin
  if P_02_ is null then
   P_02_:= NAL3.nal1( N_, '@', '02.1', fdat_)+
           NAL3.nal1( N_, '@', '02.2', fdat_)+
		   NAL3.nal1( N_, '@', '02.2.152', fdat_)+
		   NAL3.nal1( N_, '@', '02.2.310', fdat_)+
		   NAL3.nal1( N_, '@', '02.2.311', fdat_)+
           NAL3.K3_02_3( N_,           fdat_);
  end if;
   return P_02_;
END P_02;
--------------
FUNCTION P_03    (N_ int, fdat_ date) RETURN number  is
begin
  if P_03_ is null then
   P_03_:= NAL3.P_01( N_,              fdat_)+
           NAL3.P_02( N_,              fdat_);
  end if;
   return P_03_;
END P_03;
-------------------
FUNCTION P_04    (N_ int, fdat_ date) RETURN number  is
begin
  if P_04_ is null then
   P_04_:= NAL3.nal1( N_, '@', '04.2',  fdat_)+
           NAL3.nal1( N_, '@', '04.3',  fdat_)+
           NAL3.nal1( N_, '@', '04.5',  fdat_)+
           NAL3.nal1( N_, '@', '04.6',  fdat_)+
		   NAL3.nal1( N_, '@', '04.7',  fdat_)+
           NAL3.nal1( N_, '@', '04.10', fdat_)+
           NAL3.nal1( N_, '@', '04.14', fdat_)+
           NAL3.P_P4_04_12( N_,  fdat_)+
           NAL3.K1_04_1  ( N_,  fdat_)+
           NAL3.P_P1_04_4( N_,  fdat_)+
           NAL3.P2_04_8  ( N_,  fdat_)+
           NAL3.P3_04_9  ( N_,  fdat_)+
           NAL3.P_P1_04_11( N_,  fdat_)+
		   NAL3.K1_04_13 ( N_,  fdat_);
  end if;
   return P_04_;
END P_04;
--------------
FUNCTION P_05    (N_ int, fdat_ date) RETURN number  is
begin
  if P_05_ is null then
   P_05_:= NAL3.nal1( N_, '@', '05.1',  fdat_)+
           NAL3.nal1( N_, '@', '05.2',  fdat_)+
		   NAL3.nal1( N_, '@', '05.2.147',  fdat_)+
		   NAL3.nal1( N_, '@', '05.2.153',  fdat_)+
           NAL3.K3_05_3( N_,            fdat_);
  end if;
   return P_05_;
END P_05;
--------------
FUNCTION P_06    (N_ int, fdat_ date) RETURN number  is
begin
  if P_06_ is null then
   P_06_:= NAL3.P_04( N_,            fdat_)+
           NAL3.P_05( N_,            fdat_);
  end if;
   return P_06_;
END P_06;
--------------
FUNCTION P_08    (N_ int, fdat_ date) RETURN number  is
begin
  if P_08_ is null then
   P_08_:= NAL3.P_03 ( N_,            fdat_)-
           NAL3.P_06 ( N_,            fdat_)-
           NAL3.P1_07( N_,            fdat_);
  end if;
   return P_08_;
END P_08;
--------------
FUNCTION P_11    (N_ int, fdat_ date) RETURN number  is
begin
  if  NAL3.P_08 ( N_,fdat_)>0 then
   P_11_:= NAL3.P_08 ( N_,             fdat_)-
           NAL3.nal1 ( N_, '@', '09',  fdat_)-
           NAL3.K4_10( N_,             fdat_);
  else P_11_:=0;
  end if;
   return P_11_;
END P_11;
--------------
FUNCTION P_11_1    (N_ int, fdat_ date) RETURN number  is
begin
  if  NAL3.P_08 ( N_,fdat_)>0 then
   P_11_1_:= NAL3.P_08 ( N_,             fdat_)-
             NAL3.nal1 ( N_, '@', '09',  fdat_)-
             NAL3.K4_10( N_,             fdat_);
  else P_11_1_:=0;
  end if;
   return P_11_1_;
END P_11_1;
--------------
FUNCTION P_11_2    (N_ int, fdat_ date) RETURN number  is
begin
   P_11_2_:=0;
return P_11_2_;
END P_11_2;
--------------
FUNCTION P_12    (N_ int, fdat_ date) RETURN number  is
begin
  P_12_:= NAL3.P_11( N_,fdat_)*0.25;
  return P_12_;
END P_12;
--------------
FUNCTION P_12_1    (N_ int, fdat_ date) RETURN number  is
begin
   P_12_1_:= NAL3.P_11_1( N_,fdat_)*0.3;
   return P_12_1_;
END P_12_1;
--------------
FUNCTION P_12_2    (N_ int, fdat_ date) RETURN number  is
begin
   P_12_2_:=0;
return P_12_2_;
END P_12_2;
--------------
FUNCTION P_14    (N_ int, fdat_ date) RETURN number is
begin
  if P_14_ is null then
   P_14_:= NAL3.P_12 ( N_,             fdat_)-
           NAL3.K5_13( N_,             fdat_);
  end if;
   return P_14_;
END P_14;
--------------
FUNCTION P_17    (N_ int, fdat_ date) RETURN number is
begin
  if P_17_ is null then
   P_17_:= NAL3.P_14 ( N_,             fdat_)-
           NAL3.nal1 ( N_, '@', '15',  fdat_)-
           NAL3.nal1 ( N_, '@', '16.288',  fdat_);
  end if;
   return P_17_;
END P_17;
--------------
FUNCTION P_19    (N_ int, fdat_ date) RETURN number is
begin
  if P_19_ is null then
   P_19_:= NAL3.K6_19_1( N_,             fdat_)+
           NAL3.nal1 ( N_, '@', '20',    fdat_)+
           NAL3.nal1 ( N_, '@', '21',    fdat_)+
           NAL3.K3_22( N_,               fdat_)+
           NAL3.nal1 ( N_, '@', '19.2',  fdat_);
  end if;
   return P_19_;
END P_19;
---===============
FUNCTION P_P4_04_12 (N_ int, fdat_ date) RETURN number is
Begin
   P_P4_04_12_:=0;
   return P_P4_04_12_;
END P_P4_04_12;
---===============       H
FUNCTION H_08(N_ int, fdat_ date) RETURN number IS
BEGIN
  if H_08_ is null then
     H_08_:=NAL3.nal1( N_ , 'H', '01', fdat_) +
            NAL3.nal1( N_ , 'H', '02', fdat_) +
            NAL3.nal1( N_ , 'H', '03', fdat_) +
            NAL3.nal1( N_ , 'H', '04', fdat_) +
            NAL3.nal1( N_ , 'H', '05', fdat_) +
            NAL3.nal1( N_ , 'H', '06', fdat_) +
            NAL3.nal1( N_ , 'H', '07', fdat_) ;
  end if;
  return H_08_;
END H_08;
---===============
END NAL3;
/
 show err;
 
PROMPT *** Create  grants  NAL3 ***
grant EXECUTE                                                                on NAL3            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NAL3            to NALOG;
grant EXECUTE                                                                on NAL3            to RPBN001;
grant EXECUTE                                                                on NAL3            to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nal3.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 