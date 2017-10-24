
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/an2.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.AN2 IS
---------------------------------
/*
 04.05.2007 Sta Новая функция для использования в отчетах и др.
    "Суммарный начальный лимит в грн по КД клиента, действующих на дату"
    CC_SLIM(RNK_,DAT_)

 18.04.2006 Sta Суммирование дох только при N1_>0
 17.03.2006 Sta Сложные маски дох из нескольких подкодов
    1) Доход от пок-прод вал учитывался в двойном размере. Исправлено.
    2) корреспонденция с 2902,2603 считается чистым оборотом
    3) Оперативный расчет выполняется ВСЕГДА с фильтром,
      архивный - ВСЕГДА без фильтра (независимо, что там в визуальном приложении)
 11.05.2005 - (для "АЖИО" и всех !)
    Этот вариант работает ТОЛЬКО ДЛЯ СЧЕТОВ КЛИЕНТА 2600, 2650 !
*/
----------------------------------------
FUNCTION CC_SLIM (RNK_ int, DAT_ date)  RETURN number ;
 --Суммарный начальный лимит в грн по КД клиента, действующих на дату
------------------------
PROCEDURE PC_KOS
(RNK_ int, NLS_ VARCHAR2, KV_ int, ACC_ int, DAT1_ date, DAT2_ date) ;
-- накопление документов - кредитовых оборотов ( в т.ч. чистых)
-- по одному RNK  + ACC
-- испoльзуем в Bars001  окно AN1, AN2
-----------------------------
FUNCTION C_KOS
(RNK_ int, NLS_ VARCHAR2, KV_ int, ACC_ int, DAT1_ date, DAT2_ date)
  RETURN varchar2 ;
-- расчет чистых кред оборотов
-- испoльзуем в Bars001  окно AN1
---------------------
PROCEDURE an_kl_p
 (id_    int,
  DAT11_ date,
  DAT22_ date,
  RNK1_  int,
  RNK2_  int,
  MNLS_  varchar2,
  VIP_   int,
  MODE_  int,
  sFilt_ varchar2) ;
--Для модуля АНАЛИЗ клиентов ( по версии АЖИО- Рябоштан)

--MODE_ - режимы (все работают в учетом параметра-фильтра):
-- = 0  - ИГРОВОЙ пр всем клиентам
------    = 2  - ПЕРЕнакопления по всем клиентам
-- = 1  - ДОнакопления по ненакопленным в пред.сеансах клиентам
------------
PROCEDURE an_kl_p1
 (idU_   int,
  DAT1_ date,
  DAT2_ date,
  RNK1_ int,
  RNK2_ int,
  MNLS_ varchar2,
  VIP_  int,
  MODE_ int,
  sFilt_ varchar2,
  pC_EQV_ char,
  YYYYMM  char,
  In_COUNT_      int,
  Out_COUNT_ OUT int,
  PROT_      OUT varchar2);
--------------
PROCEDURE it_day ( CUSTTYPE_ int, DAT_ date ) ;
--Для модуля АНАЛИЗ клиентов ( по версии СУХОВА)
----------------------------------

END AN2;
/
CREATE OR REPLACE PACKAGE BODY BARS.AN2 IS
--------------------------------------
FUNCTION CC_SLIM (RNK_ int, DAT_ date)  RETURN number is
 --Суммарный начальный лимит в грн по КД клиента, действующих на дату
 nS_ number:=0;
begin
 begin
   select nvl( SUM(gl.p_icurval(a.kv,l.lim2,DAT_)) ,0)
   into nS_
   from cc_lim l, cc_deal d, accounts a
   where l.nd=d.nd and d.rnk=RNK_  and d.sdate<=DAT_
     and (a.dazs is null or a.dazs > DAT_)
     and d.sos>=10 and l.acc=a.acc and (l.nd,l.fdat) =
      (select nd,min(fdat) from cc_lim where nd=l.ND group by nd);
 exception when NO_DATA_FOUND THEN null ;
 end;
 return nS_;

end CC_SLIM;

PROCEDURE PC_KOS
(RNK_ int, NLS_ VARCHAR2, KV_ int, ACC_ int, DAT1_ date, DAT2_ date) is
  RNKD_ int;
-- накопление документов - кредитовых оборотов ( в т.ч. чистых)
-- по одному RNK  + ACC
-- испoльзуем в Bars001  окно AN1, AN2

begin
  delete from CCK_AN_TMP;
  insert into CCK_AN_TMP (PR, PRS, KV, N1, N2, NAME, CC_ID, ACCL,ACC,ACRA, n5)
  select o.REF,
         decode(p.id_a,
                p.id_b,
                decode( substr(p.nlsa,1,4), '2603',0, '2902',0, RNK_ ),
                0),
         decode(p.nlsa,NLS_,nvl(p.kv2,p.kv),p.kv),
         to_number( to_char(o.fdat,'DD') ),    o.S,
         substr(p.nazn,1,30), substr(p.nazn,31,20),
         to_number( nvl(p.mfob,gl.aMFO) ),
         to_number( decode(p.nlsa,NLS_,p.nlsb,p.nlsa) ),
         to_number( nvl(p.mfoa,gl.aMFO) ),
         to_number( decode(p.nlsa,NLS_,p.ID_B,p.ID_A) )
  from opldok o, oper P
  where o.fdat>= DAT1_ and o.fdat<=DAT2_ and
  o.dk=1 and o.sos=5 and o.acc =ACC_ and o.ref=p.ref;
  commit;

end PC_KOS;

-----------------

FUNCTION C_KOS
(RNK_ int, NLS_ VARCHAR2, KV_ int, ACC_ int, DAT1_ date, DAT2_ date)
  RETURN varchar2 is

--расчет всех, чистых кред оборотов в ном и экв
--испoльзуем в Bars001  окно AN1
  N2_ number :=0 ; N3_ number :=0 ;
  Q2_ number :=0 ; Q3_ number :=0 ;
  RNKD_ int ;
  Q_ number ;
begin
  for k in (select o.S,
                   decode( KV_, gl.baseval, o.S, Nvl(o.SQ,0)) Q,
                   o.fdat,
                   substr(p.nlsa,1,4) NBSA,
                   p.id_A OKPOA,
                   p.id_b OKPOB
            from opldok o, oper P
            where o.fdat>= DAT1_ and o.fdat<=DAT2_
              and o.dk=1 and o.sos=5 and o.acc =ACC_ and o.ref=p.ref )
  loop

    if k.Q = 0 then  Q_ := gl.p_icurval(KV_,k.S,k.fdat);
    else             Q_ := k.Q ;
    end if;

    N2_:= N2_ + k.S;
    Q2_:= Q2_ + Q_ ;

    if k.OKPOA<>k.OKPOB or k.NBSA in ('2603','2902') then
       N3_:= N3_ + k.S ;
       Q3_:= Q3_ + Q_  ;
    end if;
  end loop;

  RETURN substr('0000000000000000'||N2_, -16) ||
         substr('0000000000000000'||Q2_, -16) ||
         substr('0000000000000000'||N3_, -16) ||
         substr('0000000000000000'||Q3_, -16) ;

end C_KOS;

-----------------
PROCEDURE an_kl_p
 (id_    int,
  DAT11_ date,
  DAT22_ date,
  RNK1_  int,
  RNK2_  int,
  MNLS_  varchar2,
  VIP_   int,
  MODE_  int,
  sFilt_  varchar2 ) is

--MODE_ - режимы (все работают в учетом параметра-фильтра):
-- = 0  - ИГРОВОЙ по клиентам из фильтра
---------- = 2  - ПЕРЕнакопления по всем клиентам (из фильтра ?)
-- = 1  - ДОнакопления по ненакопленным в пред.сеансах клиентам

  DAT1_ date;
  DAT2_ date;
  YYYYMM char(6);
  IDU_ int;
  pC_EQV_ char(1);
  In_COUNT_ int :=10;
  Out_COUNT_ int:=10;
  all_COUNT_ int:=0 ;

  PROT_  varchar2(1000);

BEGIN

 -- Start tracing
 -- dbms_session.set_sql_trace(true);

 if MODE_ = 0 then
    --режим игровой
    delete from TMP_an_kl where nmk is null ;
    DAT1_:=DAT11_;
    DAT2_:=DAT22_;
    IDU_ :=ID_   ;
    YYYYMM:=null ;

 elsIf MODE_ in (1,2) then
    --  режим накопления
    YYYYMM:= to_char(DAT11_,'YYYYMM');
    DAT1_:=to_date(YYYYMM||'01','YYYYMMDD' );
    DAT2_:=add_months(DAT1_, 1) - 1;
    IDU_ :=NULL;
 end if;

 begin
   select substr(val,1,1) into pC_EQV_ from params where par='C_EQV';
 exception when NO_DATA_FOUND THEN pC_EQV_ := '*' ;
 end;

logger.info('AN2.Накоп.: Start, Mode='||MODE_ );

 if MODE_ = 1 then
    WHILE In_COUNT_ = Out_COUNT_
    LOOP
       AN2.an_kl_p1(
           IDU_,DAT1_,DAT2_,RNK1_,RNK2_,MNLS_,VIP_,MODE_,sFilt_,pC_EQV_,YYYYMM,
           In_COUNT_ ,Out_COUNT_ ,PROT_);
       commit;
       all_COUNT_ :=  all_COUNT_ + Out_COUNT_;

       logger.info('AN2.Commit:'|| PROT_ );

    END LOOP;
 else
    AN2.an_kl_p1(
        IDU_,DAT1_,DAT2_,RNK1_,RNK2_,MNLS_,VIP_,MODE_,sFilt_,pC_EQV_,YYYYMM,
        In_COUNT_ ,Out_COUNT_ ,PROT_);
    commit;
 end if;

 -- Stop tracing
 dbms_session.set_sql_trace(false);


logger.info('AN2.Накоп.: Finish, Mode='||MODE_ );

END an_kl_p;
-----------------

PROCEDURE an_kl_p1
 (idU_   int,
  DAT1_ date,
  DAT2_ date,
  RNK1_ int,
  RNK2_ int,
  MNLS_ varchar2,
  VIP_  int,
  MODE_ int,
  sFilt_ varchar2,
  pC_EQV_ char,
  YYYYMM  char,
  In_COUNT_      int,
  Out_COUNT_ OUT int,
  PROT_      OUT varchar2 ) is

  dny_ int     ; dny1_ int    ; kols_ int;
  i_   int     ; S_VIP char(1); dat_ date     ;
  n1_  number  ;  NN1_ NUMBER ; q1_ number    ;
  n2_  number  ;  NN2_ NUMBER ; n3_ number :=0;

  D_980_ int   ; D_840_ int   ; D_978_ int   ; D_810_ int   ;
  S_980_ number; S_840_ number; S_978_ number; S_810_ number; S_EQV_ number;
                 Q_840_ number; Q_978_ number; Q_810_ number; RNKD_  int;
  K_980_ number; K_840_ number; K_978_ number; K_810_ number; C_EQV_ number;
  NNK_   int   ; NYK_   int   ; NMB_   int   ; OMB_   int   ; dTmp_  date;
  D1_    number; D2_    number; D3_    number; D4_    number;
  D5_    number; D6_    number; D7_    number; D8_    number;
  D9_    number; D10_   number; D11_   number; D12_   number;
  D13_   number; D14_   number; D15_   number; D16_   number;
  D17_   number; D18_   number; D19_   number; D20_   number;
  D21_   number; D22_   number; D23_   number; D24_   number;
  R1_    number; R2_    number; R3_    number; R4_    number;

  ID_DOX_ int;
  REF_dok_ int; sTmp_ varchar2(100);

BEGIN
 Out_COUNT_:=0; PROT_:='';

   --C0 - цикл по счетам
   for c0 in
 (SELECT RNK, NLS, KOL, ISP
   from  (SELECT U.RNK, a.NLS, count(*) KOL, min(a.isp) ISP
          FROM cust_acc u, accounts a
          WHERE u.acc=a.acc
--and u.rnk=1280
            and a.NBS in (Select NBS From AN_KL_NBS)
            and a.kv in (980,840,978,643 )
            and a.daos<=DAT2_ and NVL(a.dazs,DAT2_+1 ) > DAT1_
            and not exists
  (select 1 from arc_an_kl where nmk=YYYYMM and rnk=U.rnk AND NLS=A.NLS)
      GROUP BY U.RNK, a.NLS
      ORDER BY U.RNK, a.NLS
      )
   where (MODE_=1 and rownum <= In_COUNT_ or MODE_=0 and rnk in (select rnk from tmp_rnk)
          )
         )

   LOOP

   if VIP_ = 1 then
      begin
        select substr(value,1,1) INTO S_VIP from CUSTOMERW
        where rnk=C0.rnk and tag='VIP_K';
      exception when NO_DATA_FOUND THEN goto KIN_;
      end;
   end if;

      -- обнуление переменных в начале цикла по дням
      S_980_:=0; S_840_:=0; S_978_:=0; S_810_:=0; KOLS_ :=0;
                 Q_840_:=0; Q_978_:=0; Q_810_:=0;
      K_980_:=0; K_840_:=0; K_978_:=0; K_810_:=0; C_EQV_:=0;
      D_980_:=0; D_840_:=0; D_978_:=0; D_810_:=0;

      NNK_  :=0; NYK_  :=0; NMB_  :=0; OMB_  :=0;

      D1_ :=0; D2_ :=0; D3_ :=0; D4_ :=0; D5_ :=0; D6_ :=0; D7_ :=0; D8_ :=0;
      D9_ :=0; D10_:=0; D11_:=0; D12_:=0; D13_:=0; D14_:=0; D15_:=0; D16_:=0;
      D17_:=0; D18_:=0; D19_:=0; D20_:=0; D21_:=0; D22_:=0; D23_:=0; D24_:=0;
      R1_ :=0; R2_ :=0; R3_ :=0; R4_ :=0;

      dny_ :=DAT2_ - DAT1_ ;
      dny1_:=dny_ + 1;

      ------I-цикл по дням месяца
      FOR i_ in 0..dny_
      LOOP
         dTmp_ := DAT1_ + i_;
         ------- календарный день в т.ч. выходной

         select max(fdat) into DAT_ from fdat where fdat <= dTmp_ ;
         ------- раб.день <= календарный день

         ----C1-цикл по мультивалютным счетам
         FOR c1 in (select KV, acc,NVL(dazs,DAT2_+1) DAZS, DAOS
                    from accounts
                    where nls=c0.NLS  and NVL(dazs,DAT2_+1)>DAT1_ and
                          daos<=DAT2_ and kv in (980,840,978,643) )
         LOOP

            -- Остатки (без отрицательных сумм)
            begin
               SELECT ostf-dos+kos INTO n1_ FROM saldoa  WHERE acc=c1.ACC and
                 (acc,fdat)=(SELECT acc,max(fdat)  FROM saldoa
                             WHERE acc=c1.ACC AND fdat <=dat_ GROUP BY acc );
               IF N1_<0 THEN N1_:=0; END IF;
            exception when NO_DATA_FOUND THEN n1_:=0;
            end ;

            -- кредитовые обороты ОБЩИЕ  ---- и ЧИСТЫЕ
            sTmp_:= an2.C_KOS(c0.rnk,c0.nls, c1.KV, c1.ACC, dTmp_,dTmp_);
            N2_  := To_NUMBER(substr(sTmp_,1 ,16));
            N3_  := To_NUMBER(substr(sTmp_,33,16));

            if    n3_>0 and c1.kv<>980 then
                  C_EQV_:=C_EQV_+gl.P_icurval(c1.kv, n3_, dTmp_ ) ;
            elsif n3_>0 and c1.kv =980 then  C_EQV_:=C_EQV_ + n3_ ;
            end if;

            if i_=0 then kols_:=kols_+1; end if;

            if c1.kv<>980 then q1_:=gl.p_icurval(c1.kv,n1_,DAT2_);
            else               q1_:=n1_; end if;

            if    c1.kv=980 then S_980_:=S_980_+ n1_; K_980_:=K_980_+ n2_ ;
                  if c1.DAZS>DAT_ and c1.DAOS<=DAT_ then D_980_:=D_980_+1 ;
                  end if;
            elsif c1.kv=840 then S_840_:=S_840_+ n1_; K_840_:=K_840_+ n2_ ;
                                 Q_840_:=Q_840_+ q1_;
                  if c1.DAZS>DAT_ and c1.DAOS<=DAT_ then D_840_:=D_840_+1 ;
                  end if;
            elsif c1.kv=978 then S_978_:=S_978_+ n1_; K_978_:=K_978_+ n2_ ;
                                 Q_978_:=Q_978_+ q1_;
                  if c1.DAZS>DAT_ and c1.DAOS<=DAT_ then D_978_:=D_978_+1 ;
                  end if;
            elsif c1.kv=643 then S_810_:=S_810_+n1_ ; K_810_:=K_810_+ n2_ ;
                                 Q_810_:=Q_810_+q1_ ;
                  if c1.DAZS>DAT_ and c1.DAOS<=DAT_ then D_810_:=D_810_+ 1;
                  end if;
            end if;

         END LOOP;  ---конец цикла C1 по мультивалютным счетам

         -- за один день dTmp_
         if dTmp_ = DAT_ then

REF_dok_:=-1000;
            --- S-цикл по разным операциям клиента только в раб дни
            FOR S in (select o.ref, o.dk, o.tt from opldok o, accounts a
                      where a.acc=o.acc and o.fdat=DAT_ and o.sos=5
                        and a.nls=c0.NLS
                      order by o.ref )
            LOOP

               ----накопим количество документов
               if S.dk=0 then
                  if S.tt in ('KL1','KL2','KL3','KL4') then NYK_:=NYK_+1;
                  else                                      NNK_:=NNK_+1;end if;
                     SELECT t.fli INTO N1_ FROM tts t, oper o
                     WHERE t.tt=o.tt and o.ref=S.ref;
                     if n1_ = 1                        then NMB_:=NMB_+1;end if;
               else  if S.tt='R01'                     then OMB_:=OMB_+1;end if;
               end if;
if REF_dok_ <> s.REF then
   ID_DOX_:=-10000;
end if;
               ----D-цикл по видам доходности-расходности (дк обратен к клиенту)
               FOR D in (select id*1000 + idp ID_DOX,
                                id, dk, NLS,     KV    from an_kl
                         where dk in (0,1) and NLS is not null and dk=1-S.DK
                         order BY 1
                         )
               LOOP

if d.ID_DOX>id_dox_  then
                 BEGIN
                    ------ + Маска только на включение
                    -- Если валюта источника дохода указана явно (напр. KV=980),
                    -- то будет рассматриваться счет счет, принесший этот доход,
                    -- только с этим кодом валюты.

                    SELECT nvl(SUM(gl.p_icurval(a.kv,o.S,o.fdat)),0)  INTO N1_
                    FROM OPLdok o,accounts a
                    WHERE o.DK=D.DK AND o.acc=a.acc
                                       AND a.NLS like D.NLS  AND o.REF=S.REF ;
                 if n1_>0 then
                    If    D.id= 1  then D1_ :=D1_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id= 2  then D2_ :=D2_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id= 3  then D3_ :=D3_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id= 4  then D4_ :=D4_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id= 5  then D5_ :=D5_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id= 6  then D6_ :=D6_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id= 7  then D7_ :=D7_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id= 8  then D8_ :=D8_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id= 9  then D9_ :=D9_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=10  then D10_:=D10_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=11  then D11_:=D11_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=12  then D12_:=D12_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=13  then D13_:=D13_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=14  then D14_:=D14_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=15  then D15_:=D15_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=16  then D16_:=D16_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=17  then D17_:=D17_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=18  then D18_:=D18_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=19  then D19_:=D19_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=20  then D20_:=D20_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=21  then D21_:=D21_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=22  then D22_:=D22_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=23  then D23_:=D23_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=24  then D24_:=D24_+ n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=101 then R1_ :=R1_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=102 then R2_ :=R2_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=103 then R3_ :=R3_ + n1_; id_DOX_:=d.id_DOX ;
                    elsIf D.id=104 then R4_ :=R4_ + n1_; id_DOX_:=d.id_DOX ;
                    end if ;
                 end if;

                 EXCEPTION WHEN NO_DATA_FOUND THEN N1_:=0;
                 END ;
end if;
               END LOOP;  --конец цикла D
REF_dok_:=s.REF;
            END LOOP; ----  конец цикла S по разным операциям клиента
         end if;  --- конец раб дня.
      END LOOP;   --- конец цикла I по дням месяца

      if   D_980_>0 then  S_980_:=round(S_980_/D_980_,0);
      else                S_980_:=0;
      end if;

      if D_840_>0 then S_840_:=round(S_840_/D_840_,0); Q_840_:=round(Q_840_/D_840_,0);
      else             S_840_:=0;                      Q_840_:=0;
      end if;

      if D_978_>0 then S_978_:=round(S_978_/D_978_,0); Q_978_:=round(Q_978_/D_978_,0);
      else             S_978_:=0;                      Q_978_:=0;
      end if;

      if D_810_>0 then S_810_:=round(S_810_/D_810_,0); Q_810_:=round(Q_810_/D_810_,0);
      else             S_810_:=0;                      Q_810_:=0;
      end if;
      -------------------вставка записи по клиенту
      if MODE_ = 0 then
         --режим игровой
         insert into TMP_an_kl
           (NMK   , id    , RNK   , NLS   , KOL   , ISP,
            S_980 , S_840 , S_978 , S_810 , Q_840 , Q_978 , Q_810 ,
            K_980 , K_840 , K_978 , K_810 , C_EQV ,
            NNK   , NYK   , NMB   , OMB   ,
            D1  ,D2  ,D3  ,D4  ,D5  ,D6  ,D7  ,D8  ,D9  ,D10 ,D11 ,D12 ,
            D13 ,D14 ,D15 ,D16 ,D17 ,D18 ,D19 ,D20 ,D21 ,D22 ,D23 ,D24 ,
            R1  ,R2  ,R3  ,R4  )
         values
           (YYYYMM, IDU_  , C0.rnk, c0.NLS, c0.KOL, c0.ISP,
            S_980_, S_840_, S_978_, S_810_, Q_840_, Q_978_, Q_810_,
            K_980_, K_840_, K_978_, K_810_, C_EQV_,
            NNK_  , NYK_  , NMB_  , OMB_  ,
            D1_ ,D2_ ,D3_ ,D4_ ,D5_ ,D6_ ,D7_ ,D8_ ,D9_ ,D10_,D11_,D12_,
            D13_,D14_,D15_,D16_,D17_,D18_,D19_,D20_,D21_,D22_,D23_,D24_,
            R1_ ,R2_ ,R3_ ,R4_ );

      elsIf MODE_ in (1,2) then
            PROT_ := PROT_ || C0.rnk || ' ' || c0.NLS || '*' ;
         If MODE_ =2 then
            -- режим (пере)накопления

            update ARC_an_kl SET
              id    = IDU_  , KOL   = c0.KOL, ISP   = C0.ISP,
              S_980 = S_980_, S_840 = S_840_, S_978 = S_978_, S_810 = S_810_,
              C_EQV = C_EQV_, Q_840 = Q_840_, Q_978 = Q_978_, Q_810 = Q_810_,
              K_980 = K_980_, K_840 = K_840_, K_978 = K_978_, K_810 = K_810_,
              NNK   = NNK_  , NYK   = NYK_  , NMB   = NMB_  , OMB   = OMB_  ,
              D1 =D1_ , D2 =D2_ , D3 =D3_ , D4 =D4_ , D5 =D5_ , D6  = D6_ ,
              D7 =D7_ , D8 =D8_ , D9 =D9_ , D10=D10_, D11=D11_, D12 = D12_,
              D13=D13_, D14=D14_, D15=D15_, D16=D16_, D17=D17_, D18 = D18_,
              D19=D19_, D20=D20_, D21=D21_, D22=D22_, D23=D23_, D24 = D24_,
              R1 =R1_ , R2 =R2_ , R3 =R3_ , R4 =R4_
           WHERE RNK=C0.rnk AND  NMK=YYYYMM AND  NLS= c0.NLS;
         end if;

         if MODE_=1 or MODE_=2 and SQL%rowcount = 0 then
            insert into ARC_an_kl
              (NMK   , id    , RNK   , NLS   , KOL   , ISP,
               S_980 , S_840 , S_978 , S_810 , Q_840 , Q_978 , Q_810 ,
               K_980 , K_840 , K_978 , K_810 , C_EQV ,
               NNK   , NYK   , NMB   , OMB   ,
               D1  ,D2  ,D3  ,D4  ,D5  ,D6  ,D7  ,D8  ,D9  ,D10 ,D11 ,D12 ,
               D13 ,D14 ,D15 ,D16 ,D17 ,D18 ,D19 ,D20 ,D21 ,D22 ,D23 ,D24 ,
               R1  ,R2  ,R3  ,R4  )
            values
              (YYYYMM, IDU_  , C0.rnk, c0.NLS, c0.KOL, c0.ISP,
               S_980_, S_840_, S_978_, S_810_, Q_840_, Q_978_, Q_810_,
               K_980_, K_840_, K_978_, K_810_, C_EQV_,
               NNK_  , NYK_  , NMB_  , OMB_  ,
               D1_ ,D2_ ,D3_ ,D4_ ,D5_ ,D6_ ,D7_ ,D8_ ,D9_ ,D10_,D11_,D12_,
               D13_,D14_,D15_,D16_,D17_,D18_,D19_,D20_,D21_,D22_,D23_,D24_,
               R1_ ,R2_ ,R3_ ,R4_ );

         end if;
      end if;

   If MODE_ = 1 then   Out_COUNT_    := Out_COUNT_ + 1;
      if Out_COUNT_ >= In_COUNT_  then return; end if;
   end if;


   <<KIN_>> NULL;

   END LOOP; --конец цикла C0 по счетам клиента

END an_kl_p1 ;
----------------------------------

PROCEDURE it_day ( CUSTTYPE_ int, DAT_ date ) IS

 OSTA_ number;  ref_   int;
 REZ7_ number;  REZ71_ number;
 OSTP_ number;  OSTQ1_ number;
 DOSQ_ number;  DOSQ1_ number;
 KOSQ_ number;  KOSQ1_ number;
 SUM6_ number;  SUM61_ number;
 SUM7_ number;  SUM71_ number;
 TRCN_ int   ;  TRCN1_ int   ;

 ern  CONSTANT POSITIVE := 021; erm  VARCHAR2(80); err  EXCEPTION;
BEGIN
 delete from an2k where fdat=DAT_ and custtype = CUSTTYPE_;
 for k in (select rnk from customer where custtype = CUSTTYPE_)
 loop
    OSTA_ := 0;
    REZ7_ := 0;
    OSTP_ := 0;
    DOSQ_ := 0;
    KOSQ_ := 0;
    SUM6_ := 0;
    SUM7_ := 0;
    TRCN_ := 0;

    for k1 in (select a.acc, a.kv, a.tip
               from cust_acc c, accounts a
               where c.rnk=k.RNK and a.acc=c.acc AND
                     substr(a.nbs,1,1)<'4' )
    loop
       begin
         SELECT decode(fdat, DAT_, gl.p_icurval( k1.KV, dos, DAT_), 0),
                decode(fdat, DAT_, gl.p_icurval( k1.KV, kos, DAT_), 0),
                gl.p_icurval( k1.KV, ostf-dos+kos, DAT_), TRCN
         INTO DOSQ1_, KOSQ1_, OSTQ1_,  TRCN1_
         FROM saldoa
         WHERE k1.ACC= acc AND (acc,fdat) =
               (SELECT acc,max(fdat) FROM saldoa
                WHERE k1.ACC=acc AND fdat <= DAT_
                GROUP BY acc)  ;
         DOSQ_:= DOSQ_ + DOSQ1_;
         KOSQ_:= KOSQ_ + KOSQ1_;
         TRCN_:= TRCN_ + TRCN1_;
         if OSTQ1_ > 0    then
               OSTP_ := OSTP_ + OSTQ1_;
         elsif OSTQ1_ < 0 then
               OSTA_ := OSTA_ - OSTQ1_;
               if k1.TIP in ('SS ','SL ','SP ', 'SPN') then
                  REZ7_ := REZ7_ +
                  gl.p_icurval(k1.KV, rez.CA_F_REZERV( k1.ACC, DAT_),DAT_);
               end if;
         end if;
       exception when NO_DATA_FOUND THEN TRCN1_ :=0;
       end;
    end loop;
    ---------------------------------
    for k1 in (select o.ref, o.dk, o.s
               from opldok o, accounts a
               where o.sos=5 and o.fdat=DAT_ and o.acc=a.acc and
                     (a.nls like '6%' or a.nls like '7%') and a.kv=980
               )
    loop
       begin
          select ref
          into ref_
          from opldok o, cust_acc c
          where k1.REF=o.ref and o.sos=5 and o.fdat=DAT_ and o.dk=1-k1.DK and
                o.acc=c.acc AND c.rnk=k.RNK and rownum=1;
          if k1.DK=1 then
             SUM6_:=SUM6_ + k1.S;
          else
             SUM7_:=SUM7_ + k1.S;
          end if;
       exception when NO_DATA_FOUND THEN ref_ :=0;
       end;
    end loop;

    insert into an2k(rnk, fdat, OSTA, OSTP, DOSQ, KOSQ, SUM6, SUM7, TRCN,
                     REZ7 ,CUSTTYPE  )
           values (k.RNK, DAT_, OSTA_,OSTP_,DOSQ_,KOSQ_,SUM6_,SUM7_,TRCN_,
                     REZ7_,CUSTTYPE_ );
 end loop;
end it_day  ;
--------------------------------------
END AN2;
/
 show err;
 
PROMPT *** Create  grants  AN2 ***
grant EXECUTE                                                                on AN2             to AN_KL;
grant EXECUTE                                                                on AN2             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on AN2             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/an2.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 