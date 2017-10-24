

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_SPM1.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_SPM1 ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_SPM1 
 (flg_ SMALLINT,  -- флаг оплаты
  ref_ INTEGER,   -- референция
  DATV_ DATE,      -- дата валютировния
  tt_ CHAR,      -- тип транзакции
  dk0_ NUMBER,    -- признак дебет-кредит
  kva_ SMALLINT,  -- код валюты А
  nls1_ VARCHAR2,  -- номер счета А
  sa_ DECIMAL,   -- сумма в валюте А
  kvb_ SMALLINT,  -- код валюты Б
  nls2_ VARCHAR2,  -- номер счета Б
  sb_ DECIMAL    -- сумма в валюте Б
 ) IS

  KV_PRD int    :=gl.baseval;
  SPROD_ number :=0;
  SVYRU_ number :=0; -- сумма прд вал и выручка в грн за продажу
  KV_KUP int    :=gl.baseval;
  SKUPL_ number :=0;
  SZATR_ number :=0; -- сумма пок вал и затраты в грн на покупку
  DK_ int;
  nls_NR_kup varchar2(15);  nls_RR_prd varchar2(15);
  nls_NR_prd varchar2(15);  nls_RR_kup varchar2(15);
  VX_prd number; VX_kup number; ACC_PRD int; ACC_KUP int; MM_ number;
  K980 int :=gl.baseval;

L_3800   varchar2(155);
Nls_3800 varchar2(15);
F1_      varchar2(155);
C1_      int;
i1_      int;
nTmp_    int;

  ern    CONSTANT POSITIVE := 203;  erm    VARCHAR2(80);  err    EXCEPTION;

  tag_ operw.tag%type;
--------------------
begin


  If L_3800 is null then

    begin                              /* найти счет ВАЛ ПОЗ   */
      select trim(s3800) into L_3800 from tts where tt=tt_ and s3800 is not null;
    EXCEPTION WHEN NO_DATA_FOUND THEN  return;
    END;

    if substr(L_3800,1,2)='#(' then    /* Формула счета вал поз */
       begin
         f1_:='SELECT '||SUBSTR(L_3800,3,LENGTH(L_3800)-3)||' FROM DUAL';
         c1_:=DBMS_SQL.OPEN_CURSOR;                   --открыть курсор
         DBMS_SQL.PARSE(c1_, f1_, DBMS_SQL.NATIVE)  ; --приготовить дин.SQL
         DBMS_SQL.DEFINE_COLUMN(c1_,1,nls_3800,15 ) ; --установить знач колонки в SELECT
         i1_:=DBMS_SQL.EXECUTE(c1_);                  --вып приготовл SQL
         IF DBMS_SQL.FETCH_ROWS(c1_)>0 THEN           --прочитать
            DBMS_SQL.COLUMN_VALUE(c1_,1,nls_3800);    --снять результ переменную
         end if;
         DBMS_SQL.CLOSE_CURSOR(c1_);                  -- закрыть курсор
       EXCEPTION  WHEN OTHERS THEN return;
       END;
    else
       nls_3800:=L_3800;
    end if;
  end if;
  -----------------
 logger.info('SPM 3 '|| nls_3800 );

  begin
    If kva_ <>k980 then
       begin
         select 1 into nTmp_ from spot s, accounts a
         where a.kv=s.kv and a.kv=kva_ and a.acc=s.acc and a.nls=nls_3800
           and rownum=1;
       EXCEPTION WHEN NO_DATA_FOUND THEN  return;
       end;
    end if;

    If kvb_ <>k980 then
       begin
         select 1 into nTmp_ from spot s, accounts a
         where a.kv=s.kv and a.kv=kvb_ and a.acc=s.acc and a.nls=nls_3800
           and rownum=1;
       EXCEPTION WHEN NO_DATA_FOUND THEN  return;
       end;
    end if;

  end;

--logger.info('SPM-0 dk0_='||dk0_||' kva_='||kva_||' sa_='||sa_||' kvb_='||kvb_||' sb_='||sb_ );

  If    dk0_=1 and kva_=K980  and kvb_ not in (K980,960) then /* продажа HE 960*/
     SPROD_:=sb_; SVYRU_:=sa_; SKUPL_:=0  ; SZATR_:=0  ; KV_PRD:=kvb_;

  elsIf dk0_=0 and kvb_=K980  and kva_ not in (K980,960) then /* продажа HE 960*/
     SPROD_:=sa_; SVYRU_:=sb_; SKUPL_:=0  ; SZATR_:=0  ; KV_PRD:=kva_;

  ElsIf dk0_=0 and kva_=K980  and kvb_ not in (K980,960) then /* покупка HE 960*/
     SPROD_:=0  ; SVYRU_:=0  ; SKUPL_:=sb_; SZATR_:=sa_; KV_KUP:=kvb_;

  elsIf dk0_=1 and kvb_=K980  and kva_ not in (K980,960) then /* покупка HE 960*/
     SPROD_:=0  ; SVYRU_:=0  ; SKUPL_:=sa_; SZATR_:=sb_; KV_KUP:=kva_;

  elsIf dk0_=1 and kva_<>K980 and kvb_ not in (K980) then /* конв по кр.не 960*/
     SPROD_:=sb_; SVYRU_:=gl.p_icurval(kva_,sa_, DATV_); KV_PRD:=kvb_;
     SKUPL_:=sa_; SZATR_:=gl.p_icurval(kvb_,sb_, DATV_); KV_KUP:=kva_;


  elsIf dk0_=0 and kvb_<>K980 and kva_ not in (K980) then /* конв по кр.не 960*/
     SPROD_:=sa_; SVYRU_:=gl.p_icurval(kvb_,sb_, DATV_); KV_PRD:=kva_;
     SKUPL_:=sb_; SZATR_:=gl.p_icurval(kva_,sa_, DATV_); KV_KUP:=kvb_;

  end if;
  ----------------------------------------------

  If SPROD_>0 and SKUPL_>0 and KV_PRD        in(     960) then /* конверсия */
     -- специфическая конверсия

     select N.nls, s.ost+s.dos-s.kos, p.acc,  R.nls
     INTO   nls_NR_kup, VX_kup, acc_kup, nls_RR_kup
     from  sal s, accounts p, vp_list v, accounts N,accounts R
     WHERE nls_3800= p.nls and p.kv = KV_kup
       and p.acc= s.acc and s.fdat  = GL.BDATE
       AND p.acc= v.acc3800
       AND N.acc= v.acc_rrD  AND R.acc=v.ACC_RRS;

       If VX_kup <0 then /* вал.покупки -  поз кор */
          select round( SKUPL_*c.RATE_P - gl.p_icurval(KV_kup,SKUPL_,DATV_),0)
          INTO MM_  FROM  SPOT c
          where c.acc=acc_kup and c.kv=KV_kup and (c.kv,c.acc,c.vdate)=
           (select kv,acc, max(vdate) from SPOT
            where kv=c.kv and acc=c.acc AND vdate<DATV_ group by kv,acc);
          If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);

--          gl.payv(flg_,ref_,DATV_,'SPM',      DK_,nls_NR_kup,nls_RR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_kup,nls_RR_kup,MM_,REF_);

       End if;
  --------------------------------------------------------------------------

  ElsIf SPROD_>0 and SKUPL_>0 and KV_KUP not in(k980,960) then
     -- оьычная конверсия
begin
     --Сч.Нереа.ПРОД, Вх.поз.ПРОД,              Сч.Реал.ПРОД
     select N.nls,    s.ost+s.dos-s.kos, p.acc, R.nls
     INTO   nls_NR_prd, VX_prd, acc_PRD, nls_RR_prd
     from sal s, accounts p, vp_list v, accounts N,accounts R
     WHERE nls_3800= p.nls and p.kv = KV_PRD
       and p.acc= s.acc and s.fdat  = GL.BDATE AND p.acc= v.acc3800
       AND N.acc=v.acc_rrD  AND R.acc=v.ACC_RRS ;
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-1 '||nls_3800,
      TRUE);

end;
     --Сч.Нереа.ПОКУП,  Вх.поз.ПОКУП,         Сч.Реал.ПОКУП
begin
     select N.nls, s.ost+s.dos-s.kos, p.acc,  R.nls
     INTO   nls_NR_kup, VX_kup, acc_KUP, nls_RR_kup
     from sal s, accounts p, vp_list v, accounts N,accounts R
     WHERE nls_3800 = p.nls and p.kv = KV_KUP
       and p.acc= s.acc and s.fdat  = GL.BDATE AND p.acc= v.acc3800
       AND N.acc=v.acc_rrD  AND R.acc=v.ACC_RRS ;
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-2 '||nls_3800,
      TRUE);

end;

     If VX_kup > 0 and VX_prd > 0 then

        -- 1) Вх.поз.ПОКУП - длин, Вх.поз.ПРОД - длин

        MM_ := gl.p_icurval(KV_KUP,SKUPL_,DATV_) -  gl.p_icurval(KV_PRD,SPROD_,DATV_);
        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--        gl.payv(flg_,ref_,DATV_,'SPM',        DK_,nls_NR_prd,nls_NR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_prd,nls_NR_kup,MM_,REF_);

begin
        select round(gl.p_icurval(KV_PRD,SPROD_,DATV_) - SPROD_*c.RATE_k,0)
        INTO MM_  FROM  SPOT c
        where c.acc=acc_PRD and c.kv=KV_PRD and (c.kv,c.acc,c.vdate)=
           (select kv,acc, max(vdate) from SPOT
            where kv=c.kv and acc=c.acc AND vdate<DATV_ group by kv,acc);
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-3 '||nls_3800,
      TRUE);

end;

        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--    gl.payv(flg_,ref_,DATV_,'SPM',            DK_,nls_NR_prd,nls_NR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_prd,nls_NR_kup,MM_,REF_);

     ElsIf VX_kup >= 0 and VX_prd <=0 then

        -- 2,3,5,6) Вх.поз.ПОКУП - длин(0), Вх.поз.ПРОД - корот(0)

        MM_ := gl.p_icurval(KV_KUP,SKUPL_,DATV_) -  gl.p_icurval(KV_PRD,SPROD_,DATV_);

        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--      gl.payv(flg_,ref_,DATV_,'SPM',          DK_,nls_NR_prd,nls_NR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_prd,nls_NR_kup,MM_,REF_);

     ElsIf VX_kup < 0 and VX_prd > 0  then

        -- 7) Вх.поз.ПОКУП - корот, Вх.поз.ПРОД - длин

        MM_ := gl.p_icurval(KV_KUP,SKUPL_,DATV_) -  gl.p_icurval(KV_PRD,SPROD_,DATV_);
        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--      gl.payv(flg_,ref_,DATV_,'SPM',          DK_,nls_NR_prd,nls_NR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_prd,nls_NR_kup,MM_,REF_);
begin
        select round(SKUPL_*c.RATE_p - SVYRU_, 0)
        INTO MM_  FROM  SPOT c
        where c.acc=acc_kup and c.kv=KV_kup and (c.kv,c.acc,c.vdate)=
           (select kv,acc, max(vdate) from SPOT
            where kv=c.kv and acc=c.acc AND vdate<DATV_ group by kv,acc);
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-4 '||nls_3800,
      TRUE);

end;

        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--      gl.payv(flg_,ref_,DATV_,'SPM',          DK_,nls_NR_kup,nls_RR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_kup,nls_RR_kup,MM_,REF_);
begin
        select round(SZATR_ - SPROD_*c.RATE_k , 0)
        INTO MM_  FROM  SPOT c
        where c.acc=acc_prd and c.kv=KV_prd and (c.kv,c.acc,c.vdate)=
           (select kv,acc, max(vdate) from SPOT
            where kv=c.kv and acc=c.acc AND vdate< DATV_ group by kv,acc);
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-5 '||nls_3800,
      TRUE);

end;

        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--      gl.payv(flg_,ref_,DATV_,'SPM',          DK_,nls_NR_prd, nls_RR_prd, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_prd, nls_RR_prd, MM_,REF_);
     ElsIf VX_kup < 0 and VX_prd <=0 then

        -- 8,9) Вх.поз.ПОКУП - корот, Вх.поз.ПРОД - крот(0)

        MM_:= SVYRU_ - SZATR_;
        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--       gl.payv(flg_,ref_,DATV_,'SPM',         DK_,nls_NR_prd, nls_NR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_prd, nls_NR_kup, MM_,REF_);
begin
        select round(SKUPL_* c.RATE_p -SVYRU_ , 0)
        INTO MM_  FROM  SPOT c
        where c.acc=acc_kup and c.kv=KV_kup and (c.kv,c.acc,c.vdate)=
           (select kv,acc, max(vdate) from SPOT
            where kv=c.kv and acc=c.acc AND vdate< DATV_ group by kv,acc);
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-6 '||nls_3800,
      TRUE);

end;

        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--      gl.payv(flg_,ref_,DATV_,'SPM',          DK_,nls_NR_kup, nls_RR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_kup, nls_RR_kup, MM_,REF_);

     ElsIf VX_kup = 0 and VX_prd > 0 then

        -- 4) Вх.поз.ПОКУП - 0, Вх.поз.ПРОД - длин

        MM_:= SVYRU_ - SZATR_;
        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--      gl.payv(flg_,ref_,DATV_,'SPM',          DK_,nls_NR_prd, nls_NR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_prd, nls_NR_kup, MM_,REF_);
begin
        select round( SZATR_ - SPROD_ * c.RATE_k , 0)
        INTO MM_  FROM  SPOT c
        where c.acc=acc_prd and c.kv=KV_prd and (c.kv,c.acc,c.vdate)=
           (select kv,acc, max(vdate) from SPOT
            where kv=c.kv and acc=c.acc AND vdate< DATV_ group by kv,acc);
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-7 '||nls_3800,
      TRUE);

end;

        If MM_>0 then dk_:=1; else DK_:=0; end if; MM_:=Abs(MM_);
--      gl.payv(flg_,ref_,DATV_,'SPM',          DK_,nls_NR_prd, nls_RR_prd, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (DK_,nls_NR_prd, nls_RR_prd, MM_,REF_);

     end if;
  -------------------------------------------------------------

  ElsIf SPROD_ > 0 and KV_KUP in (k980,960) then
     -- продажа
begin
     select N.nls,R.nls,s.ost+s.dos-s.kos, p.acc
     INTO nls_NR_prd,nls_RR_prd,VX_prd, acc_PRD
     from sal s, accounts p, vp_list v, accounts N, accounts R
     WHERE nls_3800 = p.nls and p.kv = KV_PRD
       and p.acc= s.acc and s.fdat  = GL.BDATE AND p.acc= v.acc3800
       AND R.acc=v.acc_rrS and R.kv=K980 AND N.acc=v.acc_rrD and N.kv=K980;
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-8 '||nls_3800,
      TRUE);

end;

     If VX_prd > 0 then
        If KV_KUP =960 then  SVYRU_:= gl.p_icurval(KV_PRD,SPROD_, DATV_);
        end if;

--logger.info('SPM * SVYRU_='|| SVYRU_||' SPROD_ = '||SPROD_||' KV_PRD='||KV_PRD);
begin
        select round(SVYRU_- SPROD_*c.RATE_k,0)   INTO MM_
        FROM  SPOT c
        where c.acc=acc_PRD and c.kv=KV_PRD and (c.kv,c.acc,c.vdate)=
           (select kv,acc, max(vdate) from SPOT
            where kv=c.kv and acc=c.acc AND vdate< DATV_ group by kv,acc);
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-9 '||nls_3800,
      TRUE);

end;

        if MM_>0 then
--         gl.payv(flg_,ref_,DATV_,'SPM',       1,nls_NR_prd, nls_RR_prd, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (1,nls_NR_prd, nls_RR_prd, MM_,REF_);
        elsIf MM_<0 then
--         gl.payv(flg_,ref_,DATV_,'SPM',       0,nls_NR_prd, nls_RR_prd,-MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (0,nls_NR_prd, nls_RR_prd,-MM_,REF_);
        end if;
     end if;
  -------------------------------------------------------------------

  ElsIf SKUPL_ > 0 and KV_PRD in (k980) and KV_KUP not in (960) then
     --  покупка
begin
     select N.nls,R.nls,s.ost+s.dos-s.kos,p.acc
     INTO nls_NR_kup,nls_RR_kup,VX_kup,acc_KUP
     from sal s, accounts p, vp_list v, accounts N, accounts R
     WHERE nls_3800 = p.nls and p.kv = KV_KUP
       and p.acc= s.acc and s.fdat  = GL.BDATE AND p.acc= v.acc3800
       AND R.acc= v.acc_rrS and R.kv=K980 AND N.acc=v.acc_rrD and N.kv=K980;
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-91 '||nls_3800,
      TRUE);

end;

     If VX_kup < 0 then
begin
        select round(SKUPL_*c.RATE_p -SZATR_,0)  INTO MM_
        FROM  SPOT c
        where c.acc=acc_KUP and c.kv=KV_kup and (c.kv,c.acc,c.vdate)=
         (select kv,acc, max(vdate) from SPOT
          where kv=c.kv and acc=c.acc AND vdate< DATV_ group by kv,acc);
exception when no_data_found then
     raise_application_error(
      -(20000+333),
      '\' ||'     - SPM-92 '||nls_3800,
      TRUE);

end;

        if MM_>0 then
--           gl.payv(flg_,ref_,DATV_,'SPM',     1,nls_NR_kup, nls_RR_kup, MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (1,nls_NR_kup, nls_RR_kup, MM_,REF_);
        elsIf MM_<0 then
--           gl.payv(flg_,ref_,DATV_,'SPM',     0,nls_NR_kup, nls_RR_kup,-MM_);
insert into CCK_AN_TMP (N1,N2,N3,N4,n5) values (0,nls_NR_kup, nls_RR_kup,-MM_,REF_);
        end if;
     end if;
  --------------------------------------

  end if;

end PAY_SPM1;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_SPM1.sql =========*** End *** 
PROMPT ===================================================================================== 
