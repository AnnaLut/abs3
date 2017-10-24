
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/z2014.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.Z2014 IS

  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1 29.12.2015';


  GNLS_5031  varchar2(15); 
  GNLS_2400  varchar2(15);   
  GNLS_7702  varchar2(15);  
  GNLS_3690  varchar2(15); 
  GNLS_7706  varchar2(15); 
  GNLS_1592  varchar2(15); 
  GNLS_7701  varchar2(15); 
  GNLS_3190  varchar2(15); 
  GNLS_7703  varchar2(15);
  GNLS_2401  varchar2(15);
  GNLS_6026  varchar2(15);
  GNLS_6042  varchar2(15);


/*
[JIRA] (COBUSUPABS-4024) Формування трансформаційних проводок за невизнаними доходами та резервами
На вимоги НБУ листа від 27.11.2015 №60-09012/93262, 
просимо забезпечити технічне разове доопрацювання в АБС 
по вирівнюванні даних в балансах РУ та ЦА
на основі трансформаційних таблиць за МСФЗ.
Зокрема :
1) виконання трансформаційних коригувань 
2) формування бухгалтерських проводок за невизнаними доходами 
3) формування бухгалтерських проводок за резервами станом на 01.01.2015 та  01.07.2015, 
 що складалися для подання фінансової звітності у форматі xls.

Формування бухгалтерських проводок на основі трансформаційних таблиць за сумами резервів та невизнаних доходів 
згідно вимог МСФЗ станом на 01.01.2015 здійснювати в кореспонденції з рахунком 5031. 
За півріччя поточного року формування бухгалтерських проводок на підставі трансформаційних таблиць 
здійснювати в кореспонденції рахунків 6 та 7 класів.

Просимо забезпечити виконання зазначених технічних доопрацювань в АБС«БАРС-MILLENNIUM» 
в найкоротші терміни із можливістю проведення трансформаційних коригувань в грудні п.р. 
*/
---===========================================================
procedure pay_rez_null ( p_mode int              )           ;  -- повне розформування резерву
PROCEDURE SNA   ( p_ND number, p_nls varchar2, p_kv int, p_acc  OUT number );  ---- відкриття  та/або повернення  рахунку типу SNA 
PROCEDURE opl   ( OO IN OUT oper%rowtype                   ) ; 
procedure opn1  (p_nbs varchar2, p_kv int, p_ob22 varchar2, p_nms varchar2 );
PROCEDURE ALLX  ( p_mod int                                ) ;  
PROCEDURE DEL1  ( p_RI varchar2                            ) ;  -- Виконати "БЕК" всіх сформованих трансф.проводок  
PROCEDURE ALL1  ( p_mod int, p_RI varchar2                 ) ;  -- Виконати планове формування всіх  трансф.проводок 
PROCEDURE R14_15 (p_mod int, rr in out REZ14%rowtype  )      ;   --------------------------------- 
PROCEDURE p152 ( p_ND number, p_kv number  )                 ; 
PROCEDURE p153 ( p_ND number, p_kv number  )                 ; 
PROCEDURE I15_2 ( rr IN OUT rez14%rowtype, P_period int    ) ;
PROCEDURE GNLS                                               ;  -- Виконати відкриття потрібних рах та налаштування  для обліку трансф.проводок за 2014 рік ?
-----=========================================================
function header_version return varchar2;
function body_version   return varchar2;
 
end z2014;
/
CREATE OR REPLACE PACKAGE BODY BARS.Z2014 IS
 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1.5 06.01.2016';
 oo oper%rowtype;
---================================================================
-- добавлен ключ - номер осн счета
procedure pay_rez_null ( p_mode int ) IS    -- = 0 окремими реф, =1 ОДНИМ реф-- повне розформування резерву
  oo oper%rowtype;  l_dat01 date   ;  l_dat31 date   ;
begin
  oo.nazn  := 'Повне Розформування резерву по в зв"язку з переходом на міжнародний стандарт';
  oo.tt    := 'ARE';  oo.vob   := 6 ;  oo.dk    := 1 ;  oo.pdat  := SYSDATE ;  l_dat01  := trunc (gl.bdate, 'MM')  ;
  l_dat31  := Dat_last (l_dat01 -4 , l_dat01 -1 );
  oo.vdat  := l_dat31 ;  oo.datd  := gl.bdate;  oo.datp  := gl.bdate;  oo.mfoa  := gl.aMfo ;  oo.mfob  := gl.aMfo ;
  ---------------------
  oo.ref := null ;
  SREZERV_OB22_INSERT ( p_mode => 0) ; -- восстановить старый справочник
  for xx in (select * from accounts
             where nbs in ('1490','1492','3190','3191','1491','1493','3290','3291','1590','1592','3690','1890','2890','3590','3599','2400','2401')
               and ostc>0  and ostc=ostb
            )
  LOOP
        If p_mode = 0 then oo.ref := null ; end if;
        oo.nam_a := substr(xx.nms,1,38) ; oo.nlsa := xx.nls ;  oo.kv := xx.kv ;  oo.kv2 := gl.baseVal;
        oo.s     := xx.ostc             ; oo.s2   := gl.p_icurval (xx.kv, oo.s, l_dat31) ;
        begin
           select nls, substr(nms,1,38)           into oo.nlsb, oo.nam_b           from accounts
           where (nbs,ob22) = (select nbs_7r,ob22_7r from srezerv_ob22 s, accounts  where nbs_rez=xx.nbs and ob22_rez = xx.ob22 and rownum=1 )
             and branch = xx.branch          and dazs is null ;

          If oo.ref is null then
             gl.REF (oo.ref);
             oo.nd  := substr( to_char(oo.ref),1,10);
             gl.in_doc3
                ( ref_  => oo.REF  , tt_   => oo.tt   , vob_   => oo.vob  , nd_   => oo.nd  , pdat_ => SYSDATE , vdat_  =>gl.bdate ,
                  dk_   => oo.dk   , kv_   => oo.kv   , s_     => oo.s    , kv2_  => oo.kv2 , s2_   => oo.s2   , sk_    =>null     ,
                  data_ => gl.BDATE, datp_ => gl.bdate, nam_a_ => oo.nam_a, nlsa_ => oo.nlsa, mfoa_ => gl.aMfo , nam_b_ => oo.nam_b,
                  nlsb_ => oo.nlsb , mfob_ => gl.aMfo , nazn_  => oo.nazn , d_rec_=> null   , id_a_ => gl.aOKPO, id_b_  => gl.aOkpo,
                  id_o_ => null    , sign_ => null    , sos_   => 1       , prty_ => null   , uid_  => null ) ;
          end if;
          gl.payv(0, oo.ref, oo.vdat,oo.tt, oo.dk,oo.kv,oo.nlsa, oo.s, oo.kv2, oo.nlsb, oo.s2);
      EXCEPTION WHEN NO_DATA_FOUND THEN  null;
      end;
   end loop;
  SREZERV_OB22_INSERT ( p_mode => 1) ; -- восстановить новый справочник
end pay_rez_null ;
--------------------------
PROCEDURE SNA   ( p_ND number, p_nls varchar2, p_kv int, p_acc  OUT number ) is   ----------------- відкриття  та/або повернення  рахунку типу SNA
  sn2 accounts%rowtype;  sn1 accounts%rowtype;  p4_ int ;
begin p_acc := null;
  begin select * into SN2 
        from accounts  
        where tip ='SNA' 
          and ( nbs like '___8'  or nbs like '___9' )  
          and kv = p_KV    
          and acc in (select acc from nd_acc where nd = p_ND )
          AND ROWNUM = 1 ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     begin select * into SN1 from accounts
           where ( nbs like '___8' or nbs like '___9')
             and dazs is null and kv=p_KV and acc in (select acc from nd_acc where nd=p_ND)
             and tip not in ('LIM','SK0','SK9')      and substr(nbs,1,1) < '3'      
             and rownum = 1 ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
           begin select a8.* into SN1 from accounts a8, int_accn i, accounts a2   where  a2.nls = p_nls and a2.kv = p_kv and a2.acc = i.acc and i.id = 0 and i.acra = a8.acc ;
           EXCEPTION WHEN NO_DATA_FOUND THEN sn2.acc := null ;
           end;
     end;
     If sn1.acc is not null then
        SN2.nls   := F_NEWNLS ( SN1.acc, SN1.tip, SN1.nbs );
        SN2.nms   := 'Нараховані/невизнані дох.угода='|| p_nd;
        SN2.kv    := SN1.kv ;

        If    sn1.nls like '2%' and p_nd is not null then  CCK.cc_op_nls (p_ND, SN2.kv , SN2.nls, 'SNA', SN1.isp, SN1.grp, null, SN1.mdate, SN2.acc);
        elsIf p_nd is not null  then  op_reg (1, p_nd, 0, 0, p4_, sn1.Rnk, sn2.nls, p_kv, sn2.nms, 'SNA', SN1.isp,     SN2.acc);
        else                          op_reg (99,   0, 0, 0, p4_, sn1.Rnk, sn2.nls, p_kv, sn2.nms, 'SNA', SN1.isp,     SN2.acc);
        end if ;
        Accreg.setAccountSParam(SN2.Acc, 'OB22', SN1.OB22);
        update accounts set pap = 3, tobo = sn1.branch  where acc = SN2.acc;
     end if;
  end;
  p_acc := sn2.acc;
end SNA;
----------------------------------------
PROCEDURE opl   ( OO IN OUT oper%rowtype                   ) is  l_st number;
begin
   If oo.ref is null then gl.ref (oo.REF);
      gl.in_doc3(ref_=> oo.REF ,  tt_   => oo.tt,   vob_  => 96,  nd_   => oo.nd,
              pdat_  => SYSDATE,  vdat_ => to_date('31-12-2015','dd-mm-yyyy'), dk_   => oo.dk,   kv_   => oo.kv,
              s_     => oo.S   ,  kv2_  => oo.kv2,  s2_   => oo.S2,   sk_   => null,    data_  => gl.BDATE, datp_ => gl.bdate,
              nam_a_ => oo.nam_a, nlsa_ => oo.nlsa, mfoa_ => gl.aMfo, nam_b_=> oo.nam_b, nlsb_ => oo.nlsb, mfob_ => gl.aMfo,
              nazn_  => oo.nazn,  d_rec_=> null,    id_a_ => gl.aOkpo,  id_b_ => gl.aOkpo,   id_o_ => null,
              sign_  => null,     sos_  => 1,       prty_ => null,    uid_  => null  );

   end if;
   select nvl(max(stmt),0) into l_st from opldok where ref = oo.ref;
   gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk,oo.kv, oo.nlsa,oo.s, oo.kv2,  oo.nlsb, oo.s2);
   update opldok set txt = oo.d_rec where ref = oo.ref and stmt > l_st and  stmt <= gl.aStmt;
end opl;
------------
procedure opn1  (p_nbs varchar2, p_kv int, p_ob22 varchar2, p_nms varchar2 ) is
  p4_   int; accR_  number; nls_ varchar2(15); par_ varchar2(10);
begin
  nls_ := vkrzn ( substr( gl.aMfo,1,5) , p_nbs||'02014') ;
  par_ := 'GNLS_' || p_nbs ;
  op_reg (99, 0, 0, 0, p4_, gl.aRnk, nls_, p_kv, p_nms, 'ODB', 20094, accr_);
  update accounts set pap = 3 where acc = accR_;
  update PARAMS$BASE set val = nls_ where par = par_  ;
  if SQL%rowcount=0 then insert into PARAMS$BASE(par,val)    values (par_ , nls_ ); end if;
  update specparam_int set ob22=p_ob22 where acc=accR_;
  if SQL%rowcount=0 then insert into specparam_int(acc,ob22) values (accr_,p_ob22); end if;
end opn1 ;

PROCEDURE ALLX  ( p_mod int)  is
 l_dat_01_01_15 date  := to_date ( '01-01-2015','dd-mm-yyyy');
 l_dat_30_06_15 date  := to_date ( '30-06-2015','dd-mm-yyyy');
 l_dat_01_07_15 date  := to_date ( '01-07-2015','dd-mm-yyyy');
 l_dat_30_11_15 date  := to_date ( '30-11-2015','dd-mm-yyyy');
 l_dat_01_12_15 date  := to_date ( '01-12-2015','dd-mm-yyyy');
 l_dat_01_01_16 date  := to_date ( '01-01-2016','dd-mm-yyyy');
 l_commit int := 0    ;
begin

  If p_mod = 152 then 
     /*  Функція  «4.2) Обнулити «Розрах-Невизнані», що призупинені до 30.06.2015, 
         сторнує проводки  по невизнаним % за період з 01.07.2015 – 30.11.2015 
         по тим договорам, по яким прописана дата припинення нарахування % <= 30/06/2015
         Ця дата <= 30/06/2015 була озвучена в суботу і прописана розробником.
     */
     for x in (select rowid RI, ref152 from rez14  xx where exists 
              (select 1 from nd_acc n, int_accn i where n.nd = xX.ND and i.acc= n.acc and i.stp_dat <= to_date('30-06-2015','dd-mm-yyyy') ) )
     loop if x.ref152 is not null then ful_bak ( x.ref152) ; end if;
          update rez14 set p152 = 0, ref152 = null where rowid = x.RI ;
     end loop;
     RETURN ;
  end if;
  ---------------------------------------
  If p_mod in ( -23, -39, -2339)  then
     for k in (select * from oper   where  sos > 0 and tt in ( 'ARE', 'AR*' ) and pdat > sysdate -3
                and (   p_mod in ( -23, -2339) and nazn     like 'Повне Розформування резерву%' and tt ='ARE'
                  OR p_mod in ( -39, -2339) and nazn NOT like 'Повне Розформування резерву%' and vdat = l_dat_30_11_15   and nd <> ('Рез_2014')
                     )
               )
     loop FUL_BAK( k.ref);   end loop;
     RETURN ;
  end if;
  -------------------------------------
  If p_mod = 7 then  -- 5.2.) Корекція Резерву МСФЗ станом на 01.12.2015 ( ?????? )
     RETURN ;
  end if ;
  -------------------------------------------
  for rr in (select r.ROWID RI, r.* from rez14 r where mfo = gl.aMfo )
  loop   l_commit := l_commit + 1;

    If    p_mod in ( 1, 2, 3, 4, 9, 5   )  then  z2014.GNLS; z2014.ALL1( p_mod, rr.RI ) ; -- Виконати планове формування всіх  трансф.проводок
    ElsIf p_mod in (-1                  )  then   z2014.DEL1  ( rr.RI ) ; -- Виконати "БЕК" всіх сформованих трансф.проводок
    ElsIf p_mod in (-11 ,-12,-13, -14, -15 ) then   

       If    p_mod = -11 then ful_bak( rr.ref    ); update rez14 set ref    = null where rowid = rr.RI; -- -11) Відміна трансформ.проводок РЕЗЕРВ-2014 (REF) 
       ElsIf p_mod = -12 then ful_bak( rr.refp14 ); update rez14 set refp14 = null where rowid = rr.RI; ---- -12) Відміна трансформ.проводок НЕВИЗНАНІ-2014  (REFP14 )
       ElsIf p_mod = -13 then ful_bak( rr.refp15 ); update rez14 set refp15 = null where rowid = rr.RI; -- -13) Відміна трансформ.проводок НЕВИЗНАНІ-2015(по 30.06.2015)( REFP15
       ElsIf p_mod = -14 then ful_bak( rr.ref152 ); update rez14 set ref152 = null where rowid = rr.RI; -- -14) Відміна трансформ.проводок НЕВИЗНАНІ-2015(по 30.11.2015)( REF152)

       ElsIf p_mod = -15 then 
             ful_bak( rr.ref153 ); 
             update rez14 set ref153 = null, 
                              p153   = NULL
                          where rowid = rr.RI; -- -15) Відміна трансформ.проводок НЕВИЗНАНІ-2015.3(по 31.12.2015)( REF153)

       end if; 

    ElsIf p_mod = 10                        then    z2014.p152 ( rr.ND , rr.kv ) ;
    ElsIf p_mod = 11                        then    z2014.p153 ( rr.ND , rr.kv ) ; --- Розрахувати та зберегти НЕвизнані проц.дох за період  01.12.2015 - 31.12.2015

    ElsIf p_mod =  77                       then   -------------------------------------- Виконати фактичне візування всіх  трансф.проводок
          If  rr.ref    is NOT null then  gl.pay  ( 2, rr.ref   , gl.bdate) ; end if ;   --Реф проводки~ в АБС~Рез-2014
          If  rr.ref15  is NOT null then  gl.pay  ( 2, rr.ref15 , gl.bdate) ; end if ;   --Реф проводки~ в АБС~Рез-2015
          If  rr.REFp14 is NOT null then  gl.pay  ( 2, rr.REFp14, gl.bdate) ; end if ;   --Реф АБС~НЕвизн~дох~31.12.2014~REFP14
          If  rr.REFp15 is NOT null then  gl.pay  ( 2, rr.REFp15, gl.bdate) ; end if ;   --Реф АБС~НЕвизн~дох~30.06.2015~REFP15
          If  rr.REF152 is NOT null then  gl.pay  ( 2, rr.REF152, gl.bdate) ; end if ;   --Реф АБС~НЕвизн~дох~30.11.2015~REF152
          If  rr.REF153 is NOT null then  gl.pay  ( 2, rr.REF153, gl.bdate) ; end if ;   --Реф АБС~НЕвизн~дох~31.12.2015~REF153

    ElsIf p_mod = -2                        then  --------------------------------------- Виконати повну очистка розрахункових даних
        If rr.ref    is not null then    ful_bak (rr.ref    ) ; end if;   --Реф проводки~ в АБС~Рез-2014
        If rr.ref15  is not null then    ful_bak (rr.ref15  ) ; end if;   --Реф проводки~ в АБС~Рез-2015
        If rr.REFp14 is not null then    ful_bak (rr.REFp14 ) ; end if;   --Реф АБС~НЕвизн~дох~31.12.2014~REFP14
        If rr.REFp15 is not null then    ful_bak (rr.REFp15 ) ; end if;   --Реф АБС~НЕвизн~дох~30.06.2015~REFP15
        If rr.REF152 is not null then    ful_bak (rr.REF152 ) ; end if;   --Реф АБС~НЕвизн~дох~30.11.2015~REF152
        If rr.REF153 is not null then    ful_bak (rr.REF153 ) ; end if;   --Реф АБС~НЕвизн~дох~31.12.2015~REF153

        update rez14 set   RNK    = null,  REF    = null,  P152   = null,  Z14N   = null,   Z15N   = null,   V14N   = null,   V15N   = null,   NZ15   = null,
                           NV15   = null,  QZ15   = null,  QV15   = null,  VIDD   = null,   NZ15U  = null,   NV15U  = null,   QZ15U  = null,   QV15U  = null,
                           Z14U   = null,  V14U   = null,  REF15  = null,  BVQ14  = null,   BVQ15  = null,   B9Q14  = null,   B9Q15  = null,   REFP14 = null,
                           REFP15 = null,  REF152 = null,  P153   = null,  REF153 = null,   ID     = null    where rowid = rr.RI ;

    ElsIf p_mod =  0                        then                                      -- Виконати перенесення даних з протоколу НБУ-23

          rr.z15  := nvl(rr.z15,0) ;  -- COMMENT ON COLUMN BARS.REZ14.Z15 IS 'Резрв(бал)-39 30.06.2015,екв';
          rr.v15  := nvl(rr.v15,0) ;  -- COMMENT ON COLUMN BARS.REZ14.V15 IS 'Резрв(9кл)-39 30.06.2015,екв';
          rr.z14  := nvl(rr.z14,0) ;  -- COMMENT ON COLUMN BARS.REZ14.Z14 IS 'Резрв(бал)-39 31.12.2014,екв';
          rr.v14  := nvl(rr.v14,0) ;  -- COMMENT ON COLUMN BARS.REZ14.V14 IS 'Резрв(9кл)-39 31.12.2014,екв';

          rr.nz15 := Round ( gl.p_Ncurval( rr.kv, rr.z15 *100, l_dat_30_06_15 ) /100 , 2 ) ; -- COMMENT ON COLUMN BARS.REZ14.NZ15 IS 'Резрв(бал)-39 30.06.2015,ном';
          rr.qz15 := Round ( gl.p_Icurval( rr.kv, rr.nz15*100, l_dat_30_11_15 ) /100 , 2 ) ; -- COMMENT ON COLUMN BARS.REZ14.QZ15 IS 'Резрв(бал)-39 30.11.2015,екв';
          rr.nv15 := Round ( gl.p_Ncurval( rr.kv, rr.v15 *100, l_dat_30_06_15 ) /100 , 2 ) ; -- COMMENT ON COLUMN BARS.REZ14.NV15 IS 'Резрв(9кл)-39 30.06.2015,ном';
          rr.qv15 := Round ( gl.p_Icurval( rr.kv, rr.nv15*100, l_dat_30_11_15 ) /100 , 2 ) ; -- COMMENT ON COLUMN BARS.REZ14.QV15 IS 'Резрв(9кл)-39 30.11.2015,екв';

          If rr.nls is null and rr.tipa is null and rr.nd is not null then rr.tipa := 3 ; end if;


          begin
             If rr.tipa = 3 and rr.nd is not null   then
                select rnk, vidd into rr.rnk, rr.vidd from cc_deal where nd = rr.ND  ;
                If rr.vidd > 1500 and rr.vidd <1600      then  rr.id := 'MBDK';
                ElsIf rr.vidd in ( 1, 2, 3, 11, 12, 13 ) then  rr.id := 'CCK2';
                end if ;
             elsIf rr.tipa = 4         then        rr.id  := 'W4';
             elsIf rr.nls is not null  then        rr.nls := trim (rr.nls) ;
                 select rnk into rr.rnk from accounts where kv= rr.kv and nls= rr.nls ;
                 select nd, substr(id,1,4) into rr.nd, rr.id from nbu23_rez
                 where  fdat in ( l_dat_01_01_15 , l_dat_01_07_15 ) and kv = rr.kv and nls = rr.nls and rownum = 1 ;
             end if;

          EXCEPTION WHEN NO_DATA_FOUND THEN null ;
          end;

          rr.z14u  :=  rr.z14 ; --- COMMENT ON COLUMN BARS.REZ14.Z14u  IS 'Врах.Резрв(бал)-39 31.12.2014,екв';000
          rr.v14u  :=  rr.v14 ; --- COMMENT ON COLUMN BARS.REZ14.V14u IS 'Врах.Резрв(9кл)-39 31.12.2014,екв';

          declare nn SYS_REFCURSOR;  kk nbu23_rez%rowtype;
          begin
            If  rr.tipa = 4 then OPEN nn FOR
                                      SELECT fdat, decode (substr(nls,1,1), '9', 'CCK9','W4') ID,
                                      sum (BV) BV, sum(BVQ) BVQ,  sum (REZ23) REZ, sum(REZQ23) REZQ
                                      from NBU23_rez
                                      where fdat in ( l_dat_01_01_15                   ) and kv = rr.KV and bv > 0
                                        and (id like 'W4%' or id like 'BPK%')
                                      group by  fdat , decode (substr(nls,1,1), '9', 'CCK9','W4') ;

             else                OPEN nn FOR
                                      select fdat, decode (substr(nls,1,1), '9', 'CCK9', substr(id,1,4) )  ID, 
                                            sum (BV) BV, sum(BVQ) BVQ,  sum (REZ23) REZ, sum(REZQ23) REZQ
                                      from NBU23_rez
                                      where fdat in ( l_dat_01_01_15 ,  l_dat_01_12_15 ) and nd = rr.nd and kv = rr.KV and bv > 0
                                        and ( id like substr( rr.id,1,3) ||'%'  or 
                                              id like '9%'
                                             ) 
                                      group by  fdat, decode (substr(nls,1,1), '9', 'CCK9', substr(id,1,4) ) ;
            end if;

            LOOP FETCH nn into kk.FDAT, kk.Id, kk.bv, kk.bvq, kk.rez, kk.rezq;  EXIT WHEN nn%NOTFOUND;

                 If kk.fdat   = l_dat_01_01_15 and  kk.id in ( 'CCK9'         ) then
                        rr.B9Q14 := kk.BvQ  ;
                        rr.V14N  := kk.REZQ ;                   --- COMMENT ON COLUMN BARS.REZ14.V14N IS 'Резрв(9кл)-23      31.12.2014,екв';

                 ElsIf kk.fdat   = l_dat_01_01_15                               then
                       rr.BVQ14 := kk.bvq  ;
                       rr.z14n  := kk.rezq ;                   --- COMMENT ON COLUMN BARS.REZ14.Z14N  IS 'Резрв(бал)-23      31.12.2014,екв';

                 ElsIf kk.fdat   = l_dat_01_12_15 and  kk.id in ( 'CCK9'         ) then
                       rr.B9q15 := kk.Bvq  ;
                       rr.v15N  := kk.rezq ;                  --- COMMENT ON COLUMN BARS.REZ14.V15N IS 'Резрв(9кл)-23       30.11.2015,екв';
                       rr.Nv15U := least ( rr.Nv15, kk.BV)  ; --- COMMENT ON COLUMN BARS.REZ14.NV15U IS 'Врах.Резрв(9кл)-39 30.11.2015,ном';
                       rr.Qv15U := least ( rr.Qv15, kk.bvq) ; --- COMMENT ON COLUMN BARS.REZ14.QV15U IS 'Врах.Резрв(9кл)-39 30.11.2015,екв';

                 Else
                       rr.BVQ15 := kk.BVQ  ;
                       rr.z15n  := kk.rezq ;                  --- COMMENT ON COLUMN BARS.REZ14.Z15N  IS 'Резрв(бал)-23      30.11.2015,екв';
                       rr.NZ15U := least ( rr.NZ15, kk.BV)  ; --- COMMENT ON COLUMN BARS.REZ14.NZ15U IS 'Врах.Резрв(бал)-39 30.11.2015,ном';
                       rr.QZ15U := least ( rr.QZ15, kk.bvq) ; --- COMMENT ON COLUMN BARS.REZ14.QZ15U IS 'Врах.Резрв(бал)-39 30.11.2015,екв';

                 end if ;

            end loop;   --- kk
            CLOSE nn;
          end ;

          update rez14 set
             id    = rr.id   ,
             nd    = rr.nd   ,
             rnk   = rr.rnk  , -- COMMENT ON COLUMN BARS.REZ14.RNK IS 'РНК кл';
             vidd  = rr.vidd , -- COMMENT ON COLUMN BARS.REZ14.VIDD IS 'cc_deal.vidd';
             tipa  = rr.tipa ,
             v15   = rr.v15  ,
             z15   = rr.z15  ,
             v14   = rr.v14  ,
             z14   = rr.z14  ,
            nz15   = rr.nz15 ,
            qz15   = rr.qz15 ,
            nv15   = rr.nv15 ,
            qv15   = rr.qv15 ,
             event = nvl ( rr.event , 0 ) ,
              p14  = nvl ( rr.p14   , 0 ) ,
              p15  = nvl ( rr.p15   , 0 ) ,
             z14u  = nvl ( rr.z14u  , 0 ) ,
             z14n  = nvl ( rr.z14n  , 0 ) ,
             v14u  = nvl ( rr.V14u  , 0 ) ,
             v14n  = nvl ( rr.v14n  , 0 ) ,
             z15n  = nvl ( rr.z15n  , 0 ) ,
             v15n  = nvl ( rr.v15N  , 0 ) ,
            NZ15U  = nvl ( rr.NZ15U , 0 ) ,
            QZ15U  = nvl ( rr.QZ15U , 0 ) ,
            Nv15U  = nvl ( rr.Nv15U , 0 ) ,
            Qv15U  = nvl ( rr.Qv15U , 0 ) ,
            BVQ14  = nvl ( rr.BVQ14 , 0 ) ,
            B9Q14  = nvl ( rr.B9Q14 , 0 ) ,
            BVQ15  = nvl ( rr.BVQ15 , 0 ) ,
            B9q15  = nvl ( rr.B9q15 , 0 )
       where rowid = rr.RI ;

    end if;

    If l_commit  > 200 then commit;  l_commit := 0;  end if;
    ---------------------------------------------------------
  end loop;  -- rr

  If p_mod = 10 then update rez14 set p152 = 0 where p152 is null; end if;
  If p_mod = 11 then update rez14 set p153 = 0 where p153 is null; end if;

end ALLX  ;
------------------------
PROCEDURE DEL1  ( p_RI varchar2  )   is
 -- Виконати "БЕК" всіх сформованих трансф.проводок
begin
  for rr in ( select * from rez14 where rowid = p_RI )
  LOOP
     If rr.ref    is not null  then    ful_bak (rr.ref    ) ;  end if ;   --- Реф проводки~ в АБС~Рез-2014';
     If rr.ref15  is not null  then    ful_bak (rr.ref15  ) ;  end if ;   --- Реф проводки~ в АБС~Рез-2015';
     If rr.refp15 is not null  then    ful_bak (rr.refp15 ) ;  end if ;   --- Реф АБС~НЕвизн~дох~31.12.2014~REFP14
     If rr.refp14 is not null  then    ful_bak (rr.refp14 ) ;  end if ;   --- Реф АБС~НЕвизн~дох~30.06.2015~REFP15
     If rr.ref152 is not null  then    ful_bak (rr.ref152 ) ;  end if ;   --- Реф АБС~НЕвизн~дох~30.11.2015~REF152
     If rr.ref153 is not null  then    ful_bak (rr.ref153 ) ;  end if ;   --- Реф АБС~НЕвизн~дох~31.12.2015~REF153
     update rez14 set ref    = null,
                      ref15  = null,
                      refp14 = null,
                      refp15 = null,
                      ref152 = null,
                      ref153 = null
       where ROWID = p_RI ;
  end loop ;
end DEL1;
--------------------
PROCEDURE ALL1  ( p_mod int, p_RI varchar2                 ) is  -- Виконати планове формування всіх  трансф.проводок
  rr REZ14%rowtype;
begin
  begin
    select * into rr from rez14 where rowid = p_RI;
    If       rr.ref    is not null  -- Реф проводки~ в АБС~Рез-2014';
        and  rr.REF15  is not null  -- Реф проводки~ в АБС~Рез-2015';
        and  rr.REFp14 is not null  -- Реф АБС~НЕвизн~дох~31.12.2014~REFP14
        and  rr.REFp15 is not null  -- Реф АБС~НЕвизн~дох~30.06.2015~REFP15
        and  rr.REF152 is not null  -- Реф АБС~НЕвизн~дох~30.11.2015~REF152
        and  rr.REF153 is not null  -- Реф АБС~НЕвизн~дох~31.12.2015~REF153
     then        RETURN ;
     end if ;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN ;
  end;
  --------------------------------------------------------
  z2014.R14_15 (p_mod, rr ) ; -- залить рез и сделать проводку на разницу
end ALL1  ;
--------------------

PROCEDURE R14_15 ( p_mod int, rr in out REZ14%rowtype) is
  l_dat01 date    ;  l_dat31 date ; l_acc number ;    p1_ varchar2(15); l_tmp int ;
 ------------------
 PROCEDURE ZALIVKA (P_dat01 date, P_dat31 date, P_id varchar2, P_nd number, P_kv int, P_pf int, p_Q number, q_Del OUT number, n_Del OUT number, p1_ OUT varchar2) is
    l_Q39 number ;
    l_Q23 number := 0 ;
    l_id varchar2(15);
 begin

    if    p_id ='CCK9'     then l_id := p_id ||'%' ;
    ElsIf p_id like 'CCK%' then l_Id := 'CCK2%'    ;
    else                        l_Id := p_id ||'%' ;
    end if;

    for s in (select rowid RI,  rezq23*100 Q23, nls,  Div0 ( bv, sum(bv) over (partition by 1) ) K
              from nbu23_rez
              where fdat = p_dat01 and kv = p_kv and BV > 0 AND nd = p_ND and id   like l_id
             )
    loop l_Q39 := round( p_Q * s.K, 0 ) ;
         L_Q23 := L_Q23 + S.q23;
         update nbu23_rez set  s250_39=p_PF, rezq39 = l_Q39/100,  rez39= Round ( gl.p_Ncurval( p_kv, l_Q39, p_dat31) /100 , 2 )  where rowid = s.RI;
         p1_   := s.nls ;
    end loop;

    q_Del := p_Q - L_Q23 ;
    n_Del := gl.p_Ncurval( p_kv, q_Del, p_dat31);

 end ZALIVKA ;
 --------------
begin
 oo.tt   := 'ARE';
 oo.vob  :=  6 ;
 oo.vdat := gl.bdate;

 If p_mod in ( 1, 8) AND rr.REF is null then --Реф проводки~ в АБС~Рез-2014

    --------------------------РЕЗЕРВ----БАЛАНС--- 2014
    oo.ref  := null      ;
    oo.Nazn := 'Трансформаційнi проводки по МСФЗ за 2014 р.';
    oo.nd   := 'Рез_2014';
    oo.kv   := rr.kv     ;
    oo.nam_a:= '2014:Трансформ.резерв На Бал.Акт.';
    oo.kv2  := gl.baseval;
    l_dat31 := to_date ('31-12-2014','dd-mm-yyyy');
    l_dat01 := to_date ('01-01-2015','dd-mm-yyyy');
    oo.nlsb := z2014.GNLS_5031 ;
    oo.nam_b:= 'Технічний 5031';
    oo.d_rec:= 'Формування Дельти Рез-39 станом на '|| to_char(l_dat01, 'dd.mm.yyyy')|| ' p.';

    oo.s    := 0;
    oo.s2   := 0;

    If rr.tipa = 4 then
        oo.nlsa:=  z2014.GNLS_2401 ;
    Else
       ZALIVKA ( l_dat01 , l_dat31 , rr.id, rr.nd, rr.kv, rr.PF, rr.Z14u*100, oo.s2, oo.S , p1_ ) ;
       If    p1_ like '1%' then oo.nlsa :=  z2014.GNLS_1592 ;
       ElsIf p1_ like '3%' then oo.nlsa :=  z2014.GNLS_3190 ;
       ElsIf p1_ like '9%' then oo.nlsa :=  z2014.GNLS_3690 ;
       Else                     oo.nlsa :=  z2014.GNLS_2400 ;
       end if;
    end if;

    oo.s2  := rr.Z14u* 100 - rr.Z14n*100 ;
    oo.s   := gl.p_Ncurval( rr.kv, oo.s2, l_dat31);

    If OO.S  <> 0  THEN
       iF OO.S > 0 THEN OO.DK   := 0 ;
       ELSE             OO.DK   := 1 ; oo.s := - oo.s ; oo.s2    := - oo.s2;
       end if  ;
       z2014.opl(oo);
       l_dat01 := to_date ('01-07-2015','dd-mm-yyyy');
       oo.dk   := 1 - oo.dk;
       If    p1_ like '2%' or rr.tipa = 4 then oo.nlsb :=  z2014.GNLS_7702 ;
       ElsIf p1_ like '1%' then oo.nlsb :=  z2014.GNLS_7701 ;
       ElsIf p1_ like '3%' then oo.nlsb :=  z2014.GNLS_7703 ;
       ElsIf p1_ like '9%' then oo.nlsb :=  z2014.GNLS_7706 ;
       Else                     oo.nlsb :=  z2014.GNLS_7702 ;
       end if;

       oo.d_rec:= 'РозФормування Дельти Рез-39 станом на '|| to_char(l_dat01, 'dd.mm.yyyy')|| ' p.';

       z2014.opl(oo);
    end if ;
    -------------------------РЕЗЕРВ----9 кл --- 2014
    oo.nlsb := z2014.GNLS_5031  ;
    oo.nam_b:= 'Технічний 5031';
    oo.nlsa :=  z2014.GNLS_3690 ;
    oo.nam_a:= '2014:Трансформ.резерв На 9 кл.Акт.';
    oo.d_rec:= 'Формування Дельти Рез-39 станом на '|| to_char(l_dat01, 'dd.mm.yyyy')|| ' p.';
    l_dat31 := to_date ('31-12-2014','dd-mm-yyyy');
    l_dat01 := to_date ('01-01-2015','dd-mm-yyyy');
    oo.s    := 0;
    oo.s2   := 0;
    If rr.tipa = 4   then  null;
    Else
        ZALIVKA ( l_dat01, l_dat31, 'CCK9', rr.nd, rr.kv, rr.PF, rr.V14u*100, oo.s2, oo.S, p1_ ) ;
    end if ;

    oo.s2  := rr.v14u* 100 - rr.v14n*100 ;
    oo.s   := gl.p_Ncurval( rr.kv, oo.s2, l_dat31);

    If OO.S  <> 0  THEN
       iF OO.S > 0 THEN OO.DK := 0 ;
       ELSE             OO.DK := 1 ; oo.s := - oo.s ; oo.s2    := - oo.s2;
       end if ;
       z2014.opl(oo);
       l_dat01 := to_date ('01-12-2015','dd-mm-yyyy');
       oo.dk   := 1 - oo.dk;
       oo.nlsb :=  z2014.GNLS_7706 ;
       oo.d_rec:= 'РозФормування Дельти Рез-39 станом на '|| to_char(l_dat01, 'dd.mm.yyyy')|| ' p.';
       z2014.opl(oo);
    end if ;

    If    rr.tipa = 4        then update rez14 set ref = oo.ref where tipa=4       and kv = rr.kv and mfo = gl.aMfo;
    ElsIf rr.nls is not null then update rez14 set ref = oo.ref where nls = rr.nls and kv = rr.kv and mfo = gl.aMfo;
    ElsIf rr.nd  is not null then update rez14 set ref = oo.ref where nd  = rr.nd  and kv = rr.kv and mfo = gl.aMfo;
    end if;

 end if;

 oo.s    := 0;
 oo.s2   := 0;
 If p_mod = 9 and nvl(rr.tipa,0) <> 4   AND  rr.ref15 is null then  --Реф проводки~ в АБС~Рез-2015
    -------------------------РЕЗЕРВ----- БАЛАНС ---- 2015
    l_dat31 := to_date ('30-11-2015','dd-mm-yyyy');
    l_dat01 := to_date ('01-12-2015','dd-mm-yyyy');
    ZALIVKA ( l_dat01, l_dat31, rr.id, rr.nd, rr.kv, rr.PF, rr.qZ15u*100 , oo.s2, oo.S , p1_ ) ;
    -------------------------РЕЗЕРВ----9 кл --- 2015
    l_dat31 := to_date ('30-11-2015','dd-mm-yyyy');
    l_dat01 := to_date ('01-12-2015','dd-mm-yyyy');
    ZALIVKA ( l_dat01, l_dat31, 'CCK9', rr.nd, rr.kv, rr.PF, rr.qV15u*100 , oo.s2, oo.S, p1_ ) ;
    update rez14 set ref15 = 0      where nd = rr.nd and kv = rr.kv and mfo = gl.aMfo;
 end if;

 oo.s    := 0;
 oo.s2   := 0;
 oo.tt:= 'IRR';

 If p_mod in ( 2, 8 ) AND rr.refp14 is null and rr.P14 <> 0 and nvl(rr.tipa,0) not in ( 4 ) then ------------Реф АБС~НЕвизн~дох~31.12.2014~REFP14
    l_dat01 := to_date ('01.01.2015','dd-mm-yyyy');
    l_dat31 := to_date ('31.12.2014','dd-mm-yyyy');
    oo.ref  := null    ;
    oo.Nazn := 'Невизнані процентні доходи по МСФЗ за 2014 р.';
    oo.nd   := 'НПД-2014';
    oo.s2:= - rr.P14 *100 ;
    oo.s    := gl.p_Ncurval( rr.kv, oo.s2, l_dat31);
    oo.kv   := rr.kv     ;
    oo.kv2  := gl.baseval;
    oo.d_rec:= 'Невизнані проценти станом по ' || to_char(l_dat31, 'dd.mm.yyyy')|| ' p. включно';
    oo.nlsb := z2014.GNLS_5031  ;
    iF OO.S > 0 THEN OO.DK := 0 ;
    ELSE             OO.DK := 1 ; oo.s := - oo.s; oo.s2 := - oo.s2;
    end if ;

    If rr.id like  'CACP%' and rr.Mfo = '300465' then                      l_acc := 474047 ;
    else                                 Z2014.SNA ( rr.nd, rr.nls, rr.kv, l_acc);
    end if;

    begin
       If l_acc is null then
          oo.s  := oo.s2  ;
          oo.kv := oo.kv2 ;
          If rr.vidd < 10 then select nls, substr(nms,1,38) into oo.nlsa, oo.nam_a from accounts where kv  = oo.kv2 and nls = z2014.GNLS_6026 ;
          Else                 select nls, substr(nms,1,38) into oo.nlsa, oo.nam_a from accounts where kv  = oo.kv2 and nls = z2014.GNLS_6042 ;
          end if;
       else                    select nls, substr(nms,1,38) into oo.nlsa, oo.nam_a from accounts where acc = l_acc ;
       end if ;
       z2014.opl(oo);
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end ;
    if rr.tipa =3 and rr.nd is not null then  update rez14 set refp14 = oo.ref where nd  = rr.nd  and kv = rr.kv and mfo = gl.aMfo and tipa=3;
    else                                      update rez14 set refp14 = oo.ref where nls = rr.nls and kv = rr.kv and mfo = gl.aMfo;
    end if ;
 end if ;

 oo.s    := 0;
 oo.s2   := 0;
 If p_mod in (3, 8) and rr.refp15 is null and rr.P15 <> 0 and nvl(rr.tipa,0) not in ( 4 ) then ----------Реф АБС~НЕвизн~дох~30.06.2015~REFP15
    oo.ref  := null    ; oo.Nazn := 'Невизнані процентні доходи по МСФЗ за період з 01.01.2015 по 30.06.2015 р.';  oo.nd   := 'НПД-2015.1';
    l_dat01 := to_date ('01.07.2015','dd-mm-yyyy');
    l_dat31 := to_date ('30.06.2015','dd-mm-yyyy');
    oo.s2   := - rr.P15 *100 ;
    oo.s    := gl.p_Ncurval( rr.kv, oo.s2, l_dat31);
    oo.kv   := rr.kv    ;
    oo.kv2  := gl.baseval;
    iF OO.S > 0 THEN OO.DK := 0 ;
    ELSE             OO.DK := 1 ; oo.s := - oo.s; oo.s2 := - oo.s2;
    end if  ;
    oo.d_rec:= 'Невизнані проценти станом по ' || to_char(l_dat31, 'dd.mm.yyyy')|| ' p. включно';
-- NLSA   
    If rr.tipa = 9 and rr.Mfo = '300465' then l_acc := 474047 ; 
    else       Z2014.SNA ( rr.nd, rr.nls, rr.kv, l_acc);
    end if;

    begin
       select nls, substr(nms,1,38) into oo.nlsa, oo.nam_a from accounts where acc =l_acc;
  
       If rr.nd is not null and rr.tipa = 3 then
          select a6.nls, substr(a6.nms,1,38) 
          into oo.nlsb, oo.nam_b 
          from accounts a6, int_accn i, accounts a2, (select * from nd_acc where nd=rr.nd) n2
          where  a6.kv=gl.baseval and a2.kv=rr.kv and a2.acc=n2.acc and a6.dazs is null 
            and a2.dazs is null and a2.acc=i.acc and i.id=0 and i.acrb=a6.acc 
            and a6.nbs like '60%'    and rownum=1;
          z2014.opl(oo);
          update rez14 set refp15 = oo.ref where nd = rr.nd and kv = rr.kv and mfo = gl.aMfo;
       else
-- NLSB
          If rr.tipa = 9 and rr.Mfo = '300465' then 
             select a6.nls, substr(a6.nms,1,38)  into oo.nlsb, oo.nam_b    from accounts a6  where nls='60525018507013' ;
          else
             select a6.nls, substr(a6.nms,1,38)  into oo.nlsb, oo.nam_b    from accounts a6, int_accn i, accounts a2
             where a2.kv = rr.kv  and a2.nls = rr.nls and a2.acc = i.acc and i.id=0 and a6.kv= gl.baseval and a6.dazs is null and i.acrb=a6.acc;
          end if; 
   
          z2014.opl(oo);

          update rez14 set refp15 = oo.ref where nls = rr.nls and kv = rr.kv and mfo = gl.aMfo;
        end if;
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;
 end if;

 oo.s    := 0;
 oo.s2   := 0;
 if p_mod in ( 4, 8) and   rr.REF152  is null and rr.p152 <> 0 and nvl(rr.tipa,0) not in ( 4 ) then -----Реф АБС~НЕвизн~дох~30.11.2015~REF152
    oo.ref  := null    ;
    oo.Nazn := 'Невизнані процентні доходи по МСФЗ за період з 01.07.2015 по 30.11.2015 р.';
    oo.nd   := 'НПД:07-11';
    l_dat31 := to_date ('30.11.2015','dd-mm-yyyy');
    oo.kv   := rr.kv     ;
    oo.kv2  := gl.baseval;
    oo.s2   := - rr.P152 *100 ;
    oo.s    := gl.p_Ncurval( rr.kv, oo.s2, l_dat31);
    iF OO.S > 0 THEN OO.DK := 0 ;
    ELSE             OO.DK := 1 ; oo.s := - oo.s; oo.s2 := - oo.s2;
    end if  ;
    oo.d_rec:= 'Невизнані проценти станом по ' || to_char(l_dat31, 'dd.mm.yyyy')|| ' p. включно';

-- NLSA   
    If rr.tipa = 9 and rr.Mfo = '300465' then l_acc := 474047 ; 
    else       Z2014.SNA ( rr.nd, rr.nls, rr.kv, l_acc);
    end if;

    begin
       select nls, substr(nms,1,38) into oo.nlsa, oo.nam_a from accounts where acc =l_acc;
       If rr.nd is not null and rr.tipa = 3 then

          select a6.nls, substr(a6.nms,1,38) into oo.nlsb, oo.nam_b from accounts a6, int_accn i, accounts a2, (select * from nd_acc where nd=rr.nd) n2
          where  a6.kv=gl.baseval and a2.kv=rr.kv and a2.acc=n2.acc and a6.dazs is null and a2.dazs is null and a2.acc=i.acc and i.id=0 and i.acrb=a6.acc 
            and a6.nbs like '60%'    and rownum=1;
          z2014.opl(oo);
          update rez14 set ref152 = oo.ref where nd = rr.nd and kv = rr.kv and mfo = gl.aMfo;
       else
-- NLSB
          If rr.tipa = 9 and rr.Mfo = '300465' then 
             select a6.nls, substr(a6.nms,1,38)  into oo.nlsb, oo.nam_b    from accounts a6  where nls='60525018507013' ;
          else
             select a6.nls, substr(a6.nms,1,38)  into oo.nlsb, oo.nam_b    from accounts a6, int_accn i, accounts a2
             where a2.kv = rr.kv  and a2.nls = rr.nls and a2.acc = i.acc and i.id=0 and a6.kv= gl.baseval and a6.dazs is null and i.acrb=a6.acc;
          end if; 

          z2014.opl(oo);
          update rez14 set ref152 = oo.ref where nls = rr.nls and kv = rr.kv and mfo = gl.aMfo;
       end if;
    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;
 end if;

 oo.s    := 0;
 oo.s2   := 0;
 If p_mod in (5, 8)  AND rr.REF153  is null and rr.p153 <> 0 and nvl(rr.tipa,0) not in ( 4 ) then -----Реф АБС~НЕвизн~дох~31.12.2015~REF153
    oo.ref  := null    ;
    oo.Nazn := 'Невизнані процентні доходи по МСФЗ за період з 01.12.2015 по 31.12.2015 р.';
    oo.nd   := 'НПД:12-12';
    l_dat31 := to_date ('31.12.2015','dd-mm-yyyy');
    oo.kv   := rr.kv      ;
    oo.kv2  := gl.baseval;
    oo.s2   := - rr.P153 *100 ;
    oo.s    := gl.p_Ncurval( rr.kv, oo.s2, l_dat31);
    iF OO.S > 0 THEN OO.DK := 0 ;
    ELSE             OO.DK := 1 ; oo.s := - oo.s; oo.s2 := - oo.s2;
    end if  ;
    oo.d_rec:= 'Невизнані проценти станом по ' || to_char(l_dat31, 'dd.mm.yyyy')|| ' p. включно';

-- NLSA   
    If rr.tipa = 9 and rr.Mfo = '300465' then l_acc := 474047 ; 
    else       Z2014.SNA ( rr.nd, rr.nls, rr.kv, l_acc);
    end if;

    begin
       select nls, substr(nms,1,38) into oo.nlsa, oo.nam_a from accounts where acc =l_acc;
       If rr.nd is not null and rr.tipa = 3 then
          select a6.nls, substr(a6.nms,1,38) into oo.nlsb, oo.nam_b 
          from accounts a6, int_accn i, accounts a2, (select * from nd_acc where nd=rr.nd) n2
          where  a6.kv=gl.baseval and a2.kv=rr.kv and a2.acc=n2.acc and a6.dazs is null and a2.dazs is null and a2.acc=i.acc and i.id=0 and i.acrb=a6.acc 
            and a6.nbs like '60%'    and rownum=1;

          z2014.opl(oo);
          update rez14 set ref153 = oo.ref where nd = rr.nd and kv = rr.kv and mfo = gl.aMfo;
       else
-- NLSB
          If rr.tipa = 9 and rr.Mfo = '300465' then 
             select a6.nls, substr(a6.nms,1,38)  into oo.nlsb, oo.nam_b    from accounts a6  where nls='60525018507013' ;
          else
             select a6.nls, substr(a6.nms,1,38)  into oo.nlsb, oo.nam_b    from accounts a6, int_accn i, accounts a2
             where a2.kv = rr.kv  and a2.nls = rr.nls and a2.acc = i.acc and i.id=0 and a6.kv= gl.baseval and a6.dazs is null and i.acrb=a6.acc;
          end if; 

          z2014.opl(oo);
          update rez14 set ref153 = oo.ref where nls = rr.nls and kv = rr.kv and mfo = gl.aMfo;
       end if;

    EXCEPTION WHEN NO_DATA_FOUND THEN null;
    end;
 end if;

end R14_15   ;
-----------

PROCEDURE p152 ( p_ND number, p_kv number) is   rr REZ14%rowtype;
begin     ----   P_period=2 =>  01.07.2015  - 30.11.2015
  begin select * into rr from REZ14 where nd =p_nd and kv = p_kv and mfo = gl.aMfo ;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
  end; 
  execute immediate 
' create or replace view NVP_152 as select * from PRVN_BV_DETAILS where MDAT= to_date(''01.12.2015'',''dd.mm.yyyy'')  and ND='||p_ND||' and kv='||p_KV ;

  If rr.ref152 is null then
     delete from  PRVN_BV_DETAILS where mdat = to_date('01.12.2015','dd.mm.yyyy') and nd = p_nd and kv = p_kv ; 
     rr.p152 := null ;
     Z2014.I15_2 ( rr , 2 );
     update  REZ14 set p152 = nvl(rr.p152,0) where nd = rr.nd and kv = rr.kv and mfo = gl.aMfo;
  end if;

end p152;
------------
PROCEDURE p153 ( p_ND number, p_kv number) is   rr REZ14%rowtype;
  p152_ number ; p153_ number ;
begin     ----   P_period=3 =>  01.12.2015  - 31.12.2015
/*
При розрахунку суми «Невизнаних за грудень 2015 = Р153» ми враховумо:
•	Для признака знецінення  EVENT = 1 
 1)	«Власну» суму грудня Р153, Протокол її розрахунку можна переглянути подвійним клік мишкою 
 2)	Мінус стару фактично проведену суму  Р152 (вона може бути  невірною)
 3)	Плюс нову розрахункову суму  Р152 (вона уже розраховується вірно.
•	Якщо Ви виправили ( після  попереднього розрахунку )   признак знецінення EVENT  з 1 на 0  
 1)	«Власна» суму грудня Р153 = 0 . 
 2)	Мінус стару фактично проведену суму Р14 + Р15 + Р152 
*/
  begin select * into rr from REZ14 where nd =p_nd and kv = p_kv and mfo = gl.aMfo ;
        p152_  := nvl( rr.p152,0);
--logger.info ('SNA- 0*' || rr.nd ||' * '|| p152_ ||' + '||nvl(rr.p15,0) ||' + '|| nvl(rr.p14,0) );
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
  end;  
  execute immediate 
'create or replace view bars.NVP_152 as select * from PRVN_BV_DETAILS 
 where MDAT= to_date(''01.01.2016'',''dd.mm.yyyy'') and ND='||p_ND||' and kv='||p_KV ;

  If rr.ref153 is null then 
     delete from  PRVN_BV_DETAILS where mdat = to_date('01.01.2016','dd.mm.yyyy') and nd = p_nd and kv = p_kv ;
     If rr.event = 1 then 

        rr.p153 :=  null   ;  
        Z2014.I15_2 ( rr   , 3 ) ;
        p153_   := nvl(rr.p153,0) ; -- чистый дек 
--logger.info ('SNA- 1*' || p153_ ||'* + '|| p152_ ||' + '||nvl(rr.p15,0) ||' + '|| nvl(rr.p14,0) );

        If rr.ref152 is not null then                                 -- корр ош расчета Р152 
           rr.p153 := nvl(rr.p153,0) - nvl(rr.p152,0) ;
           rr.p152 := null ;
           Z2014.I15_2 ( rr , 2 );
           rr.p153 := nvl(rr.p153,0) + nvl(rr.p152,0) ;  -- дек+ноябрь
        end if; 
     else 
        rr.p153 := - ( nvl(rr.p152,0) + nvl(rr.p15,0) + nvl(rr.p14,0) ) ;  -- коррекция EVENT
     end if;

     If (  nvl(rr.p153,0)  +  nvl(rr.p15,0) + nvl(rr.p14,0) )  > 0 then  -- корр превышения просроски над рез
           rr.p153  := - ( p152_ + nvl(rr.p15,0) + nvl(rr.p14,0) ) ;
--logger.info ('SNA- 2*' || rr.p153 );
     end if ;

     update  REZ14 set p153 = nvl(rr.p153,0) where nd = rr.nd and kv = rr.kv and mfo = gl.aMfo;
  end if;
end p153;
------------
PROCEDURE I15_2 ( rr IN OUT rez14%rowtype, P_period int ) is
  -- P_period=2 =>  01.07.2015  - 30.11.2015
  -- P_period=3 =>  01.12.2015  - 31.12.2015
  Wdate_  date  ;
  l_dat01 date  := to_date('01-07-2015','dd-mm-yyyy' );  --  Первый день отчетного ПЕРИОДА ( = 1 полугодию)
  l_dat31 date  := to_date('30-11-2015','dd-mm-yyyy' );  --  последний день этого же ПЕРИОДА
  z_Dat01 date  := to_date('01-12-2015','dd-mm-yyyy' );  --  отчетная дата
  n_ir  number  ; x_ir  number ;  l_ost number  ; n_SDI number ;  l_kolD int  := 0 ;
  l_rez number  ; l_SE  number := 0 ;  l_sna number   :=0 ;
  --------------------------------------------
  TYPE BVT  IS TABLE OF PRVN_BV_DETAILS%rowtype INDEX BY varchar2 (8)  ;  tmpD BVT  ;  d8  varchar2 (8)  ;
  TYPE ACCT IS TABLE OF accounts%rowtype        INDEX BY varchar2 (16) ;  tmpA ACCT ;  a20 varchar2 (16) ;
--------------------------------------------------------
begin
  if nvl( rr.tipa,0) <> 3 or rr.id not like 'CCK2%' then RETURN ; end if;
  ----------------------------------------------------------------------------------
  If P_period = 2 then
     l_dat01 := to_date('01-07-2015','dd-mm-yyyy' ) ;  --  Первый день отчетного ПЕРИОДА ( = 1 полугодию)
     l_dat31 := to_date('30-11-2015','dd-mm-yyyy' ) ;  --  последний день этого же ПЕРИОДА
     z_Dat01 := to_date('01-12-2015','dd-mm-yyyy' ) ;  --  отчетная дата
  else 
     l_dat01 := to_date('01-12-2015','dd-mm-yyyy' ) ;  --  Первый день отчетного ПЕРИОДА ( = 1 полугодию)
     l_dat31 := to_date('31-12-2015','dd-mm-yyyy' ) ;  --  последний день этого же ПЕРИОДА
     z_Dat01 := to_date('01-01-2016','dd-mm-yyyy' ) ;  --  отчетная дата
  end if;
  -- условия знецінення  или расрормирования, отсутствия 
  l_SNA := NULL;
  If    nvl(rr.event,0) = 0         then  l_SNA := 0; 
  ElsIf rr.z15  =0 and p_period = 2 then  l_SNA := 0;
  ElsIf rr.qz15u=0 and p_period = 3 then  l_SNA := 0;
  Else
     begin select 0 into l_SNA 
           from nd_acc n, int_accn i , accounts a 
           where n.nd = rr.ND and i.acc=n.acc and i.stp_dat <= to_date('30062015','ddmmyyyy') and id = 0 
             and i.acc= a.acc and a.tip in ('SS ', 'SP ') and dazs is null 
             and rownum =1;
     EXCEPTION WHEN NO_DATA_FOUND THEN null;
     end;
  end if ;

  If l_SNA = 0 then   If p_period = 2 then rr.p152 := 0 ;    else   rr.p153 := 0 ;  end if;   Return;  end if;
  -- найти НомПроцСт и ЕфПС
  select acrn.fprocn ( max(acc), 0, l_dat01 ),  acrn.fprocn ( max(ACCC), -2, l_dat01 ), max(mdate)
  into  n_IR, X_IR , Wdate_  from accounts
  where tip in ( 'SS ','SP ')   and acc in (select acc from nd_acc where nd= RR.nd)   and ostc < 0 and kv = RR.kv and mdate is not null ;

  If NVL(n_IR,0)  <= 0  then    If p_period = 2 then rr.p152 := 0 ;    Else  rr.p153 := 0 ;  end if;   RETURN;  end if ;

  -- Если ЕПС сотвутствует или сомнительна - заменяем ее на НСП
  If x_ir <= 0 or x_ir > 200 then x_ir := n_ir;   end if ;

  -- Преврацение НПС и ЕПС в днейной коефф
  x_ir := x_ir /100;
  x_ir := POWER (  (1 + x_ir), 1/365 ) -1 ;
  n_ir := n_ir / 36500 ;
  -- разметим даты  в таблицу   tmpD
  tmpD.delete;
  for d in (select (l_dat01 - 1 + c.num) CDAT from conductor c where (l_dat01 - 1 + c.num) < z_Dat01 )
  loop l_kolD  := l_kolD + 1 ;     d8 := to_char (  d.cdat , 'yyyymmdd' ) ;  tmpD(d8).cdat := d.cdat ; end loop  ;
  -- разметим  счета в таблицу   tmpA
  tmpA.delete;
  for k in (select acc, tip , ostB from accounts   where tip in ('SS ','SP ','SN ','SPI','SPN','SDI','SNO', 'SNA'  )
              and kv = rr.KV  and ( nls like '2%' or nls like '1%')  and acc in (select acc from nd_acc where nd = RR.nd )      )
  loop  A20 := to_char( k.acc)   ;  tmpA(A20).acc  := K.ACC  ;   tmpa(A20).TIP  := K.TIP  ;  tmpa(A20).OSTB := K.OSTB ;  end loop ;
  -------------------------------------------------------------------------------------------------------------------------------
  -- наполним полотно дат остатками/ ЦИКЛ -1 по датам. т.к. портиции по датам
  If  P_period =2 then  l_rez :=  gl.p_Ncurval( rr.kv, nvl(rr.Z15,0) * 100, l_dat01-1 ) ; -- Резрв(бал)-39 30.06.2015,ном
  else                  l_rez :=  nvl(rr.NZ15U,0) * 100 ;                                 -- Врах.Резрв(бал)-39 30.11.2015,ном
  end if ;

  l_SE := 0   ; l_sna := 0   ;
  d8   := tmpD.first         ; -- установить курсор на  первую запись (дату)
  while d8 is not null  loop
     tmpD(d8).BV   := -l_rez ; tmpD(d8).REZ  := -l_rez ; tmpD(d8).ND := rr.nd ; tmpD(d8).mdat := z_dat01 ;
     tmpD(d8).eps1 := x_ir   ; tmpD(d8).nom1 := n_ir   ; tmpD(d8).KV := rr.KV ; tmpD(d8).VIDD := rr.vidd ;

     A20   := tmpA.first     ; -- установить курсор на  первую запись
     while A20 is not null    loop
        If  tmpA(A20).tip = 'SNA'  then l_ost := - tmpA (A20).ostB ;
        else                            l_ost := - fost ( tmpA(A20).acc,  tmpD(d8).cdat ) ;
        end if;
        If    tmpA(A20).tip = 'SS ' then tmpD(d8).SS   := nvl( tmpD(d8).SS  , 0 ) + l_ost ;
        ElsIf tmpA(A20).tip = 'SP ' then tmpD(d8).SP   := nvl( tmpD(d8).SP  , 0 ) + l_ost ;
        ElsIf tmpA(A20).tip = 'SN ' then tmpD(d8).SN   := nvl( tmpD(d8).SN  , 0 ) + l_ost ;
        ElsIf tmpA(A20).tip = 'SPI' then tmpD(d8).SPI  := nvl( tmpD(d8).SPI , 0 ) + l_ost ;
        ElsIf tmpA(A20).tip = 'SPN' then tmpD(d8).SPN  := nvl( tmpD(d8).SPN , 0 ) + l_ost ;
        ElsIf tmpA(A20).tip = 'SDI' then tmpD(d8).SDI  := nvl( tmpD(d8).SDI , 0 ) + l_ost ;
        ElsIf tmpA(A20).tip = 'SNO' then tmpD(d8).SNO  := nvl( tmpD(d8).SNO , 0 ) + l_ost ;
        ElsIf tmpA(A20).tip = 'SNA' then tmpD(d8).SNA  := nvl( tmpD(d8).SNA , 0 ) + l_ost ;
        Else  null ;
        end if ;
        tmpD(d8).BV  :=  tmpD(d8).BV + l_ost ;
        A20 := tmpA.next(a20) ; -- установить курсор на след.вниз запись -счет
     end loop; -- A20

     tmpD(d8).SE   := l_SE ;
     tmpD(d8).BV   := GREATEST( 0, tmpD(d8).BV + tmpD(d8).SE ) ;          --- Бал.стоимость = База начисления
     tmpD(d8).IR   := ROUND   (    tmpD(d8).BV * x_ir    , 0 ) ;           --- Проц визнані
     l_SE          := l_SE + tmpD(d8).IR   ;                               --- Добавка на след день
     tmpD(d8).NR   := ( nvl(tmpD(d8).SS,0) + nvl(tmpD(d8).SP,0) ) * n_ir ; --- Проц нараховані
/*
     If tmpD(d8).cdat = l_dat31 and tmpD(d8).SDI is not null  then
        begin  n_SDI :=  NORM_SDI (rr.ND, l_dat31); tmpD(d8).AR  := - tmpD(d8).SDI - n_SDI   ;
        exception when others then                  tmpD(d8).AR  := - tmpD(d8).SDI * l_KolD / (Wdate_ - l_dat01 + 1 );
        end ;
        tmpD(d8).AR := round(tmpD(d8).AR,0) ;                            --- расчетная амортизация
     end if;
     tmpD(d8).AR := nvl(tmpD(d8).AR,0);
*/
     tmpD(d8).AR := 0 ;
     insert into PRVN_BV_DETAILS values tmpD(d8); 

    -- НеВизн  =              Д(Дисконт)  +         П(нач.проц)  -           В(визнані)
    -- SNA     =                   AR     +               NR     -                IR
     l_sna := l_sna + nvl(tmpD(d8).AR,0)  +  nvl(tmpD(d8).NR,0)  -   nvl(tmpD(d8).IR,0);
     d8    := tmpD.next(d8); -- установить курсор на след.вниз запись - дату
  end loop ;  -- D8

  --Это по отношениею в кредиту 2208 . Прирашение  +
  If rr.kv <> gl.baseval then  l_sna :=  gl.p_Icurval ( rr.kv, l_sna, l_dat31  ) ; end if ;
  --Это по отношениею в деббету 6042 . Уменьшение -
  l_sna := - l_sna /100 ;  
  If p_period = 2 then rr.p152 := l_sna ;
  else                 rr.p153 := l_sna ;
  end if;

end I15_2 ;

PROCEDURE GNLS    is  -- Виконати відкриття потрібних рах та налаштування  для обліку трансф.проводок за 2014 рік ?
begin
    z2014.opn1 ( '5031', 980, '02', 'ДOформування рез по  МСФЗ за 2014 р.'  );
    z2014.opn1 ( '2400', 980, '46', 'Дельта рез: НБУ/23 - МСФЗ КЛ 2014 р.' );
    z2014.opn1 ( '2400', 840, '46', 'Дельта рез: НБУ/23 - МСФЗ КЛ 2014 р.' );
    z2014.opn1 ( '2400', 978, '46', 'Дельта рез: НБУ/23 - МСФЗ КЛ 2014 р.' );
    z2014.opn1 ( '2400', 643, '46', 'Дельта рез: НБУ/23 - МСФЗ КЛ 2014 р.' );
    z2014.opn1 ( '2401', 980, '30', 'Дельта рез: НБУ/23 - МСФЗ ПК 2014 р.' );
    z2014.opn1 ( '2401', 840, '30', 'Дельта рез: НБУ/23 - МСФЗ ПК 2014 р.' );
    z2014.opn1 ( '2401', 978, '30', 'Дельта рез: НБУ/23 - МСФЗ ПК 2014 р.' );
    z2014.opn1 ( '2401', 643, '30', 'Дельта рез: НБУ/23 - МСФЗ ПК 2014 р.' );
    z2014.opn1 ( '7702', 980, '91', 'РОЗфор.дельти рез по МСФЗ КЛ 2014 р.' );
    z2014.opn1 ( '3690', 980, '16', 'Дельта рез: НБУ/23 - МСФЗ 9* 2014 р.' );
    z2014.opn1 ( '3690', 840, '16', 'Дельта рез: НБУ/23 - МСФЗ 9* 2014 р.' );
    z2014.opn1 ( '3690', 978, '16', 'Дельта рез: НБУ/23 - МСФЗ 9* 2014 р.' );
    z2014.opn1 ( '3690', 643, '16', 'Дельта рез: НБУ/23 - МСФЗ 9* 2014 р.' );
    z2014.opn1 ( '7706', 980, '21', 'РОЗфор.дельти рез по МСФЗ 9* 2014 р.' );

--  If gl.aMfo  in ( '300465','352457')  then
       z2014.opn1 ( '1592', 980, '06', 'Дельта рез: НБУ/23 - МСФЗ МБ 2014 р.' );
       z2014.opn1 ( '1592', 840, '06', 'Дельта рез: НБУ/23 - МСФЗ МБ 2014 р.' );
       z2014.opn1 ( '1592', 978, '06', 'Дельта рез: НБУ/23 - МСФЗ МБ 2014 р.' );
       z2014.opn1 ( '1592', 643, '06', 'Дельта рез: НБУ/23 - МСФЗ МБ 2014 р.' );
       z2014.opn1 ( '7701', 980, '28', 'РОЗфор.дельти рез по МСФЗ МБ 2014 р.' );

       z2014.opn1 ( '3190', 980, '08', 'Дельта рез: НБУ/23 - МСФЗ ЦП 2014 р.' );
       z2014.opn1 ( '3190', 840, '08', 'Дельта рез: НБУ/23 - МСФЗ ЦП 2014 р.' );
       z2014.opn1 ( '7703', 980, '24', 'РОЗфор.дельти рез по МСФЗ ЦП 2014 р.' );
--  end if;
    z2014.GNLS_5031 := F_Get_Params('GNLS_5031', NULL) ;
    z2014.GNLS_2400 := F_Get_Params('GNLS_2400', NULL) ;
    z2014.GNLS_2401 := F_Get_Params('GNLS_2401', NULL) ;
    z2014.GNLS_7702 := F_Get_Params('GNLS_7702', NULL) ;
    z2014.GNLS_3690 := F_Get_Params('GNLS_3690', NULL) ;
    z2014.GNLS_7706 := F_Get_Params('GNLS_7706', NULL) ;
    z2014.GNLS_1592 := F_Get_Params('GNLS_1592', NULL) ;
    z2014.GNLS_7701 := F_Get_Params('GNLS_7701', NULL) ;
    z2014.GNLS_3190 := F_Get_Params('GNLS_3190', NULL) ;
    z2014.GNLS_7703 := F_Get_Params('GNLS_7703', NULL) ;

    z2014.opn1 ( '6026', 980, '19', 'Невизнані %% 2014р. для КД, які було закрито в 2015 р.' );
    z2014.opn1 ( '6042', 980, '66', 'Невизнані %% 2014р. для КД, які було закрито в 2015 р.' );

    z2014.GNLS_6026 := F_Get_Params('GNLS_6026', NULL) ;
    z2014.GNLS_6042 := F_Get_Params('GNLS_6042', NULL) ;


end GNLS   ;
---================================================================
function header_version return varchar2 is begin return 'Package header Z2014 '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin return 'Package body Z2014 '  ||G_BODY_VERSION  ; end body_version;
---Аномимный блок --------------
begin z2014.GNLS ;
------------------
end z2014 ;
/
 show err;
 
PROMPT *** Create  grants  Z2014 ***
grant EXECUTE                                                                on Z2014           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on Z2014           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/z2014.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 