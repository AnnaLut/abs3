CREATE OR REPLACE PACKAGE BARS.Trans39 IS   g_header_version   constant varchar2 (64) := 'version 0  12.06.2018';   g_trace     constant varchar2 (64) := 'Trans39:';
--============ Перехід з МСФЗ39 на МСФЗ9=======================
procedure ADD_OB22 ( p_NBS varchar2, p_ob22 varchar2 ) ; -- проверка и пополнение на лету SB_ob22
procedure opn5     ;
procedure DEFORM   ( p_acc accounts.ACC%type ) ; -- расформирование на 01.01.2018 по всем (p_acc=0) или по одному счету (p_acc = АСС)
procedure REFORM   (                 p_dat01 date, p_nd TEST_PRVN_OSA.ND%type, p_tip TEST_PRVN_OSA.TIP%type) ;  
procedure REFORM1  (  p_dat01 date, x_RI varchar2, XX In OUT TEST_PRVN_OSA%ROWtype, OO in out OPER%ROWtype) ;
procedure ACC1  (dd  IN OUT cc_deal%rowtype, 
                 p_dat01 date, 
                 p_mode int, 
                 p_Err OUT varchar2, 
                 kk  in out cck_ob22%rowtype  ,  
                 kk9 in out cck_ob22_9%rowtype, 
                 XX  in OUT TEST_PRVN_OSA%ROWtype, 
                 aa  IN OUT accounts%rowtype,  
                 a6     OUT accounts%rowtype 
               ) ;

procedure opl   ( oo IN OUT oper%rowtype ) ;
--procedure FROM_SRR_XLS ;
procedure snap9 ( P_DAT01 DATE, P_bdat  DATE ) ;  -- пОДГОТОВКА МЕСЯЧНОГО СНИМКА С УСЕТОМ ПЕРЕХОДНЫХ ПРОВОДОК
end Trans39;
/

show err;

grant execute on Trans39 to BARS_ACCESS_DEFROLE ;

CREATE OR REPLACE PACKAGE BODY BARS.Trans39  IS
  g_body_version   CONSTANT VARCHAR2(64) := 'version 1 19.06.2018 '; --  14.06.2018';

/* 
 --безусловный вход в отк 5031.хх, 3739*8
 -- Снимки и КФ
 -- Расчетное S1 = 0 - comm not null
 -- По таблице-постановке
*/

--------------------
  g_errN number  := -20203;
  nlchr  char(2) := chr(13)||chr(10);
  G_Dat01 date := to_date ('01.01.2018', 'dd.mm.yyyy');
  G_Dat31 date := to_date ('29.12.2017', 'dd.mm.yyyy');

  V_Dat06 date := to_date ('01.03.2018', 'dd.mm.yyyy'); -- = для теста на Полтаве  --- Для реальной рпботы to_date ('01.06.2018', 'dd.mm.yyyy');
  R_Dat05 date := to_date ('28/02/2018', 'dd.mm.yyyy'); -- = для теста на Полтаве  --- Для реальной рпботы to_date ('31/05/2018', 'dd.mm.yyyy');
  ---------------
  code_   NUMBER;
  status_ VARCHAR2(10);
  erm_    VARCHAR2(2048);
  trm_    VARCHAR2(2048);

---=================================================================
    a53 accounts%rowtype; --в кореспонденції з відповідним аналітичним  рахунком капіталу їх відкриття в автоматизованому режимі АП  5031*03- дисконти/премії SDF
    a52 accounts%rowtype; --в кореспонденції з відповідним аналітичним  рахунком капіталу їх відкриття в автоматизованому режимі АП  5031*02- резерви; 
    NLS_3739 accounts.NLS%type ;   
    NMS_3739 accounts.NMS%type := 'МСФЗ-9.Обнулення REZ+SNA+SDI 01.01.18';
--------------------------------------------------------------------
/*
function FN_K9 ( p_IFRS    k9.IFRS%type,     p_POCI  K9.POCI%type )  return      K9.K9%type        IS    l_k9 K9.K9%type := null;
begin
  begin select x.K9 into l_K9 from k9 x where  x.IFRS = p_IFRS and x.POCI = p_POCI ;  
  EXCEPTION WHEN NO_DATA_FOUND THEN  null ;  
  end;
  Return l_K9 ;
end     FN_K9 ;
*/
------------------
procedure ADD_OB22 ( p_NBS varchar2, p_ob22 varchar2 ) IS  -- проверка и пополнение на лету SB_ob22
   sb sb_ob22%rowtype;   kf_ varchar2 (6) ;
begin 
   kf_  := gl.aMfo ;
   BC.go ('/') ;
   begin select * into sb from sb_ob22 where  r020||ob22 = p_NBS||p_ob22 ;
         If sb.d_close is not null then update sb_ob22 set d_close = null, txt = (select name from ps where nbs = p_NBS )  where  r020||ob22 = p_NBS||p_ob22 ;     end if ;
   exception when no_data_found    then insert into sb_ob22 (r020, ob22, txt )    select nbs, p_ob22, name from ps where nbs = p_NBS;
   end;
   BC.go (KF_)  ;
end ADD_ob22;
-----------------------------------------


procedure opn5 is  p4_ int;  acc_ number;
begin  -- предварительное открытие общих нужных счетов
    --безусловный вход в отк 5031.хх, 3739*8

    -- Для обнуления от ручных проводок
    Trans39.NLS_3739 := Vkrzn( substr( gl.aMfo, 1,5), '373908' );  
    for  kk in (select distinct kv from accounts where tip in ('REZ', 'SNA', 'SDI' )  )
    loop begin  select acc into acc_ from accounts where kv = kk.kv and nls = Trans39.NLS_3739 ;
         exception when no_data_found then  
                op_reg(99,0,0,0,p4_,gl.aRnk, Trans39.NLS_3739, kk.kv, Trans39.NMS_3739, 'ODB', gl.auid,acc_ ); 
                Accreg.setAccountSParam(acc_, 'OB22', '03') ; 
         end ;
    end loop;

    -- разовое открытие сч.АП  5031*03- дисконти/премії SNA+SDI+
 -- If a53.nls is null then -- --в кореспонденції з відповідним аналітичним  рахунком капіталу їх відкриття в автоматизованому режимі АП  5031*03- дисконти/премії SDF
       a53.nls := Vkrzn ( Substr( gl.aMfo ,1,5), '5031_03');

       begin select * into a53 from accounts where nls  = a53.nls and kv =980 and dazs is null;
       exception when no_data_found then        a53.NMS:= 'ДОФормув.ДИСК/нЕВИЗН.ДОХ до спр.варт. МСФЗ_9';
          op_reg ( 99, 0, 0, 20,  p4_, gl.aRNK, a53.nls, gl.BaseVal, a53.NMS, 'ODB', gl.aUid, a53.acc );  
          select * into a53 from accounts where acc = a53.acc ;
       end;  
       If nvl(a53.ob22,'**') <>'03' then  Accreg.setAccountSParam(a53.acc, 'OB22', '03') ; end if;
       If a53.pap <> 3 then update accounts set pap = 3 where acc = a53.acc; end if;
 -- end if;     
    
   --  разовое открытие сч.АП  5031*02- REZ; 
 -- If a52.nls is null then -- --в кореспонденції з відповідним аналітичним  рахунком капіталу їх відкриття в автоматизованому режимі АП  5031*02- резерви; 
       a52.nls := Vkrzn ( Substr( gl.aMfo ,1,5), '5031_02');

       begin select * into a52 from accounts where nls  = a52.nls and kv =980 and dazs is null;
       exception when no_data_found then        a52.NMS:= 'Доформування резервів за МСФЗ_9';
          op_reg ( 99, 0, 0, 20,  p4_, gl.aRNK, a52.nls, gl.BaseVal, a52.NMS, 'ODB', gl.aUid, a52.acc );   select * into a52 from accounts where acc = a52.acc ;
       end;  
       If nvl(a52.ob22,'**') <>'02' then  Accreg.setAccountSParam(a52.acc, 'OB22', '02') ; end if;
       If a52.pap <> 3 then update accounts set pap = 3 where acc = a52.acc; end if;
 -- end if;

end opn5 ;
---=================================================================
  

procedure DEFORM ( p_acc accounts.ACC%type ) Is  -- расформирование на 01.01.2018 по всем (p_acc=0) или по одному счету (p_acc = АСС)
  p4_ int;  aa accounts%rowtype;   oo oper%rowtype;
  ----------------------------------------------------
  procedure DEF1 is   l_nazn1 varchar2 (160) ; l_nazn2 varchar2 (160) ;  x_dat01 date;
  begin 
    oo.Kv := aa.Kv ;  oo.nam_a:= Substr(aa.nms,1,38) ;  oo.nlsa := aa.nls; oo.kv2  := gl.baseval; 
    update accounts set pap = 3 where acc = aa.acc   ;
    
    If AA.Tip ='REZ' then  oo.tt    := 'ARE' ; 
    Else                   oo.tt    := 'IRR' ; 
    end if; 

    if aa.dazs is not null then update accounts set dazs = null where acc= aa.acc; end if;

    oo.ref  := null ; 
    oo.vdat := G_Dat31 ; ----- G_Dat01   ;

    IF aa.OSTF <> 0 then -- расформировать по остатку 31 числа
       oo.nazn := 'Розформування '|| CASE  WHEN AA.tip ='REZ' THEN 'Резерву'   WHEN AA.tip ='SDI' THEN 'Дисконту'  WHEN AA.tip ='SNA' THEN 'Невизн.проц.дох.'  else null end 
                                  || '('||AA.tip||') за МСФЗ_39 станом на 01.01.2018 до НУЛЯ - для переходу на МСФЗ_9';                                          
       If AA.tip ='REZ' then oo.nlsb := a52.nls;  oo.nam_b := Substr(a52.nms,1,38);   
       Else                  oo.nlsb := a53.nls;  oo.nam_b := Substr(a53.nms,1,38);   
       end if; 
       If aa.ostf < 0 then         oo.dk := 0   ;  Else  oo.dk  := 1 ;   end if ;       oo.S := ABS (aa.ostf)  ;
       If aa.kv = gl.baseval then  oo.s2 := oo.S;  Else  oo.s2  := gl.p_icurval( aa.kv, oo.S, oo.vdat); end if ;
       oo.ref  := null ; 
       oo.ND   := 'FRS9_DG' ;  

       If aa.TIP = 'SNA' and  aa.nbs is null and aa.accc > 0 then  -- разорвать и восстановит связь с род.счетом 
          update accounts set accc = null    where acc = aa.acc ;
          Trans39.OPL(oo) ; 
          update accounts set accc = aa.accc where acc = aa.acc ;
       else  
          Trans39.OPL(oo) ; 
       end if;
    end if ;

    -- расформировать по Текущему остатку 
    l_nazn1 :=  CASE WHEN AA.tip ='REZ' THEN 'Резерву' WHEN AA.tip ='SDI' THEN 'Дисконту' WHEN AA.tip ='SNA' THEN 'Невизн.проц.дох.' else null end 
                  ||'('||AA.tip||') за МСФЗ_39 для переходу на МСФЗ_9. Період ' ; 
--  V_Dat06 date := to_date ('01.03.2018', 'dd.mm.yyyy'); -- = для теста на Полтаве  --- Для реальной рпботы to_date ('01.06.2018', 'dd.mm.yyyy');
--  R_Dat05 date := to_date ('28/02/2018', 'dd.mm.yyyy'); -- = для теста на Полтаве  --- Для реальной рпботы to_date ('31/05/2018', 'dd.mm.yyyy');

    For xx in (select  trunc( p.vdat,'MM')  dat01,  p.tt, 
                       CASE  WHEN (AA.tip ='SDI' and (p.nlsb like '60%' OR P.NLSB LIKE '70%') ) THEN 'A' else 'R' end AR, 
                       Sum  ( decode(o.dk,0,+1,-1)*o.s)     S    ,
                       Sum  ( decode(o.dk,0,+1,-1) * gl.p_icurval(aa.kv,o.S,p.vdat)) S2, 
                       max( p.ref )   xref
              from opldok o, saldoa s, oper p  
              where s.acc = AA.acc and  s.fdat = o.fdat and s.acc = o.acc and o.ref = p.ref 
                and o.sos = 5 
                and s.fdat > G_Dat01    and   s.fdat < GL.bDAte   ---- s.fdat <  V_Dat06 +5       --  ФАКТИЧ дата   > 01.01.2018  и   < 06/06/2018
                and p.vdat > G_Dat01    and   P.VDat < GL.bDAte   ---- p.vdat <  V_Dat06          --  дата ВАЛЮТИР  > 01.01.2018  и   < 01/06/2018
                and  (   AA.tip =  'SDI' and o.dk = 0 AND AA.NBS NOT LIKE '2706' AND AA.NBS NOT LIKE '16_6'  and aa.nbs not like '3666'
                      or AA.tip =  'SDI' and o.dk = 1 AND AA.NBS     LIKE '2706' 
                      OR AA.tip =  'SDI' and o.dk = 1 AND AA.NBS     LIKE '16_6' 
                      OR AA.tip =  'SDI' and o.dk = 1 AND AA.NBS     LIKE '3666' 
                      or AA.tip <> 'SDI'
                      )     -- проводки по приращению денежного дисконта не трогаем --- 29.05.2018
                and p.REF <> nvl( oo.ref, 0) 
              group by trunc ( p.vdat,'MM'),  p.tt,   
                       CASE  WHEN (AA.tip ='SDI' and (p.nlsb like '60%' OR P.NLSB LIKE '70%') ) THEN 'A' else 'R' end
              having Sum  ( decode(o.dk,0,+1,-1)*o.s) <> 0
              order by 1, 2 
              )  
    loop 
       x_dat01 := add_months( xx.dat01, +1) ;

       l_nazn2  :=  l_nazn1 ||  to_char (xx.dat01, 'dd.mm.yy') ||' - '|| to_char( (x_dat01-1) ,'dd.mm.yy') ;
       If xx.s < 0 then   oo.dk := 1 ; 
       Else               oo.dk := 0 ; 
       end if;   
       oo.s    := ABS(xx.S );
       oo.s2   := ABS(xx.S2);
       oo.ref  := null ; 
       oo.vdat := LEAST (x_dat01, trunc ( gl.Bdate,'MM')) ;
       oo.vdat := DAT_NEXT_U ( oo.vdat , -1) ;  
       -----------------------------------------
       If xx.tt in ('ARE', 'IRR', '%%1') OR xx.AR ='A'  then  
          oo.nazn := 'Розформування АВТО-пров '|| l_nazn2;   -- штатные проводки
          select CASE WHEN nlsb   like '6%' or nlsb like '7%' THEN nlsb else NLSA end, CASE WHEN nlsb like '6%' or nlsb like '7%' THEN nam_b else nam_a end  
          into oo.nlsB, oo.nam_b   FROM OPER where ref = xx.xRef;
          oo.ND   := 'FRS9dA'||xx.tt ;  

       else oo.s2 := oo.S ;    
          oo.nazn := 'Розформування Ручн-пров '|| l_nazn2;  ---- обнуление  от нештатных проводок 
          oo.ND   := 'FRS9dR'||xx.tt ;    
          oo.NLSB := Trans39.NLS_3739 ;    oo.nam_b:= Substr( Trans39.NMS_3739, 1, 38) ;
       end if; 
       Trans39.OPL(oo) ;

    end loop ; -- xx
--  update accounts set pap = aa.pap, dazs = aa.dazs   where acc = aa.acc   ;
    update accounts set pap = aa.pap                   where acc = aa.acc   ;
  end DEF1 ;
  --------------
begin Trans39.OPN5;   oo.vob := 6;  oo.DATD := gl.Bdate;    oo.mfoa := gl.aMfo ;     oo.mfob := gl.aMfo ;

      For x in (select A.acc, A.KV, A.NLS, a.NBS, a.ACCC, A.NMS, A.tip, A.pap, A.DAZS, OST_KORR(A.acc,G_Dat31,null, SubStr(A.nLs,1,4) ) OST31, A.OSTC     --- расформирование ро ТЕКУЩИЙ остаток ---OOST_KORR(A.acc,R_Dat05,null,A.nbs) OSTC  
                from accounts A
                where (    A.tip  = 'SDI' and  A.nls  < '3'    -- КП + МБД (В Т.Ч.2700)
                        OR A.NBS  = '2706' 
                        OR A.NBS  = '1616' 
                        OR A.NBS  = '1626' 
                        OR A.NBS  = '3666' 
                        or A.tip  = 'SNA'                      -- КП + ЦБ
                        OR A.TIP  = 'REZ' ANd A.NBS <> '3950'  -- ВСЕ - ХОЗ
                       ) 
                  AND ( OST_KORR (A.acc,G_Dat31,null, SubStr(A.nLs,1,4) ) <> 0  OR A.OSTC <> 0    )
                  and p_ACC IN ( 0, A.ACC)
                )
      loop  SELECT * INTO AA FROM ACCOUNTS WHERE ACC = X.ACC ;
            aa.ostf := x.OST31 ;   

            iF X.NBS IN ( '2706', '1616', '1626', '3666' ) THEN AA.TIP :=  'SDI' ; UPDATE ACCOUNTS SET TIP = AA.TIP  WHERE ACC  = X.ACC;
            ELSE                                                aa.tip := X.tip  ; 
            END IF;
  
            DEF1 ;
      end   loop ; -- x

end DEFORM ;
--------------------------------------------------------------
procedure REFORM ( p_dat01 date, p_nd TEST_PRVN_OSA.ND%type, p_tip TEST_PRVN_OSA.TIP%type) Is
   x_RI varchar2 (100);   X1 TEST_PRVN_OSA%ROWtype ;   p4_ int;   OO OPER%ROWTYPE ;
begin Trans39.OPN5;  

      oo.ND   := 'FRS9_R' ;  
      oo.vdat := DAT_NEXT_U(p_dat01, -1);  
      oo.tt   := 'IRR'    ;
      oo.DATD := gl.Bdate ; oo.kv2  := gl.baseval;  oo.mfoa := gl.aMfo ;     oo.mfob := gl.aMfo ;   oo.vob  := 6 ; 

      For x in (select RowId RI  from TEST_PRVN_OSA where comm is null and tip = p_Tip and p_ND in (0, ND)   )
      loop      select * into X1 from TEST_PRVN_OSA where  RowId = x.RI;  
                Trans39.REFORM1  ( p_dat01, x.RI, X1, OO ) ;    
      end loop; -- x

      begin EXECUTE IMMEDIATE 'drop table TEST_PRVN_OSAQ_'|| to_char(p_dat01,'ddmmyyyy') ;
      exception when others then   if SQLCODE = -00942 then null;   else raise; end if;   -- ORA-00942: table or view does not exist
      end;

      EXECUTE IMMEDIATE '    create table TEST_PRVN_OSAQ_'|| to_char(p_dat01,'ddmmyyyy') || ' AS select * from TEST_PRVN_OSA '; 

end REFORM;
------------  


procedure REFORM1 (  p_dat01 date, x_RI varchar2, XX In OUT TEST_PRVN_OSA%ROWtype, OO in out OPER%ROWtype)  iS    aa accounts%rowtype  ;   a6 accounts%rowtype  ;
  l_comm varchar2(100)  ;
  dd  cc_deal%rowtype   ;
  kk  cck_ob22%rowtype  ;  
  kk9 cck_ob22_9%rowtype; 
  L_ACC number ;
  I_CR9 varchar2(1) := '0'; -- признак транш КЛ. Відновлювана КЛ = 0, 1= НЕвідновлювана
  --------------------

  procedure PROVODKA (x_RI varchar2, XX in out TEST_PRVN_OSA%ROWtype, OO in out OPER%ROWtype) is 
  begin  oo.ref := null ;

    iF OO.S <> 0 and l_comm is null then
       oo.kv   := xx.kv;
       If oo.S < 0 then oo.dk := 1 - oo.DK ; oo.S := - oo.S ; end if;

       If xx.kv <> gl.BaseVal then oo.s2   := gl.p_icurval( xx.kv, oo.s, OO.VDAT ); else oo.s2 := oo.s; end if;
       oo.nlsa := aa.nls; oo.nam_a := Substr(aa.nms,1,38) ;
       If p_dat01 =  g_dat01 then  oo.nlsB := a53.nls; oo.nam_a :=  Substr(a53.nms,1,38) ; -- стартовое значение, 
       else                        oo.nlsB := a6.nls ; oo.nam_a :=  Substr(a6.nms,1,38)  ; -- рабочее значение
       end if ;
       SAVEPOINT do_XXX;
       BEGIN Trans39.OPL(oo) ;
       EXCEPTION WHEN OTHERS THEN ROLLBACK TO do_XXX;  
             erm_ := null;  deb.trap(SQLERRM, code_, erm_, status_);       l_comm  := 'Рах.'||aa.tip||'*'||Substr (erm_, 1,90) ; 
       END;

       If l_Comm is not null then  update TEST_PRVN_OSA  set comm = l_comm            where rowid = x_RI ; RETURN ; end if ;
       If oo.ref is not null then  update TEST_PRVN_OSA  set comm = comm||aa.tip||',' where rowid = x_RI ;          end if ;
    end if ;  -- OO.S <> 0 ....

  end ;  --- procedure PROVODKA 
  ---------------------------------------------
begin
   update TEST_PRVN_OSA  set comm = null  where rowid = x_RI; 

   If xx.tip = 3 and xx.Irr > 0 then
      begin select d.* into dd from cc_deal  d where  d.nd = xx.nd ; xx.Irr := xx.Irr * 100 ;
            select a.acc into L_ACC from accounts a, nd_acc n where n.ND = DD.ND and n.acc = a.acc and a.tip = decode ( Substr(dd.prod,1,1) , '2', 'LIM', 'SS ') ;
            Update int_accn set acr_dat = gl.bdate where acc = l_ACC and id = - 2;      
            IF SQL%ROWCOUNT=0 THEN   insert into int_accn(acc,id,acr_dat, METR, BASEM ,BASEY,FREQ ) values ( L_ACC, -2, gl.bdate,0,0,0,5);         end if;
            Update int_ratn set ir= xx.Irr where acc=L_ACC and id= -2 and bdat=gl.Bdate; 
            IF SQL%ROWCOUNT=0 THEN insert into int_ratn(acc,id,ir,bdat) values (L_ACC,-2,xx.irr, gl.bdate ); end if ;
      EXCEPTION WHEN NO_DATA_FOUND THEN update TEST_PRVN_OSA  set comm ='НЕ знайдено для збереження IRR' where rowid = x_RI ; RETURN ; 
      end ; 
   end if ;

   xx.s1 := NVL( xx.s1,0);    xx.s2 := NVL( xx.s2,0);     
   xx.s3 := NVL( xx.s3,0);    xx.s4 := NVL( xx.s4,0);
   xx.s5 := NVL( xx.s5,0);    xx.s6 := NVL( xx.s6,0);
   xx.s7 := NVL( xx.s7,0);    xx.s8 := NVL( xx.s8,0); 

   For t in ( select * from tips where tip in ( 'SDI', 'SDF', 'SDM', 'SDA', 'SNA', 'SRR' ) )
   loop 
       begin select a.* into aa from accounts a, nd_acc n where n.nd = xx.nd and n.acc = a.acc and a.tip = t.tip and a.kv = xx.kv and a.dazs is null and rownum = 1;
       exception when no_data_found then     aa.OSTC := 0; aa.ACC := null ; aa.tip := t.tip ; -- счета еще нет
       end;

       -- балансировка дисконтов и оплата
       oo.nazn := 'Доформування по МСФЗ-9'|| t.name || ' Дог.'|| xx.ND ;

       If    t.tip = 'SDF' then        xx.s1 := NVL( xx.b1, aa.ostc/100 ) + xx.s2 - aa.ostc/100 ;  -- Неамортиз.Д/П~за кориг.BV.~до справедливої~B1
          If xx.s1 <> 0 OR xx.S2 <> 0  then   Trans39.ACC1 ( dd, p_dat01, 0, l_comm, kk, kk9, xx, aa, a6 );
             If xx.s1 <> 0             then   Trans39.ACC1 ( dd, p_dat01, 1, l_comm, kk, kk9, xx, aa, a6 ); oo.dk := 0 ; oo.s := xx.s1 *100 ; PROVODKA (x_RI, XX, OO) ; end if;
             If xx.s2 <> 0             then   Trans39.ACC1 ( dd, p_dat01, 2, l_comm, kk, kk9, xx, aa, a6 ); oo.dk := 1 ; oo.s := xx.s2 *100 ; PROVODKA (x_RI, XX, OO) ; end if;
          Else  update TEST_PRVN_OSA   set    comm = comm||t.tip||'-' where rowid = x_RI ;    -- Расчетное S1=0  и S2=0 => comm not null
          end if;

       ElsIf t.tip = 'SDM' then        xx.s3 := NVL( xx.b3, aa.ostc/100 ) + xx.s4 - aa.ostc/100 ;  -- Неамортиз.Д/П~за модиф.договору           ~B3

          If xx.s3 <> 0 OR xx.S4 <> 0  then   Trans39.ACC1 ( dd, p_dat01, 0, l_comm, kk, kk9, xx, aa, a6 );
             If xx.s3 <> 0             then   Trans39.ACC1 ( dd, p_dat01, 1, l_comm, kk, kk9, xx, aa, a6 ); oo.dk := 0 ; oo.s := xx.s3 *100 ; PROVODKA (x_RI, XX, OO) ; end if;
             If xx.s4 <> 0             then   Trans39.ACC1 ( dd, p_dat01, 2, l_comm, kk, kk9, xx, aa, a6 ); oo.dk := 1 ; oo.s := xx.s4 *100 ; PROVODKA (x_RI, XX, OO) ; end if;
          else  update TEST_PRVN_OSA   set    comm = comm||t.tip||'-' where rowid = x_RI ;    -- Расчетное S3=0  и S4=0 => comm not null
          end if;

       ElsIf t.tip = 'SDI' then        xx.s5 := NVL( xx.b5, aa.ostc/100 ) + xx.s6 - aa.ostc/100 ;  -- Неамортиз.Д/П~"грошовий"                  ~B5
          If xx.s5 <> 0 OR xx.S6 <> 0  then   
/*
Радіонов Володимир Олександрович <RadionovVO@oschadbank.ua> Вт 19.06.2018 12:33
-----------------------------------------------------------------------------------
Сч.SDI   |VIDD 	     |I_CR9         |ОткрытьSDI + Проводки 
---------|-----------|------------------------------------------------------
Есть/НЕТ |2, 3       |Не анализируем| Нет 
---------|-----------|------------------------------------------------------
Есть/НЕТ |12, 13     |= 0	    | Нет
---------|-----------|------------------------------------------------------
Есть/НЕТ |        Все иное          | Да   
-----------------------------------------------------------------------------------
*/

             If xx.VIDD in ( 2,3 ) then -- КЛ ЮЛ
                update TEST_PRVN_OSA  set  comm = comm||'S36-' where rowid = x_RI ;   -- -- SDI Не делаем, т.к. это скорее всего 3600
                GOTO OK_; 

             ElsIf xx.VIDD in ( 12,13 ) then -- КЛ ФЛ

                begin select substr(trim(txt),1,1) into I_CR9 from nd_txt where tag='I_CR9' and nd= xx.ND ;  
                exception     when no_data_found   then I_CR9 := '0'  ;
                end ;
                If I_CR9 = '0' then 
                   update TEST_PRVN_OSA  set  comm = comm||'S36-' where rowid = x_RI ;   -- -- SDI Не делаем, т.к. это скорее всего 3600
                   GOTO OK_; 
                end if ; 

             end if ;

             Trans39.ACC1 ( dd, p_dat01, 0, l_comm, kk, kk9, xx, aa, a6 );
             If xx.s5 <> 0             then   Trans39.ACC1 ( dd, p_dat01, 1, l_comm, kk, kk9, xx, aa, a6 ); oo.dk := 0 ; oo.s := xx.s5 *100 ; PROVODKA (x_RI, XX, OO) ; end if;
             If xx.s6 <> 0             then   Trans39.ACC1 ( dd, p_dat01, 2, l_comm, kk, kk9, xx, aa, a6 ); oo.dk := 1 ; oo.s := xx.s6 *100 ; PROVODKA (x_RI, XX, OO) ; end if;

          else  update TEST_PRVN_OSA   set    comm = comm||t.tip||'-' where rowid = x_RI ;    -- Расчетное S5=0  и S6=0 => comm not null
          end if;

       ElsIf t.tip = 'SDA' then        xx.s7 := NVL( xx.b7, aa.ostc/100 ) + xx.s8 - aa.ostc/100 ;  -- Неамортиз.Д/П~"технічний"                 ~B7
          If xx.s7 <> 0 OR xx.S8 <> 0  then   Trans39.ACC1 ( dd, p_dat01, 0, l_comm, kk, kk9, xx, aa, a6 );
             If xx.s7 <> 0             then   Trans39.ACC1 ( dd, p_dat01, 1, l_comm, kk, kk9, xx, aa, a6 ); oo.dk := 0 ; oo.s := xx.s7 *100 ; PROVODKA (x_RI, XX, OO) ; end if;
             If xx.s8 <> 0             then   Trans39.ACC1 ( dd, p_dat01, 2, l_comm, kk, kk9, xx, aa, a6 ); oo.dk := 1 ; oo.s := xx.s8 *100 ; PROVODKA (x_RI, XX, OO) ; end if;
          else  update TEST_PRVN_OSA   set    comm = comm||t.tip||'-' where rowid = x_RI ;    -- Расчетное S7=0  и S8=0 => comm not null
          end if;

       ElsIf t.tip = 'SNA' and aa.ostc <> XX.AIRC_CCY  then  
          Trans39.ACC1 ( dd, p_dat01, 0, l_comm, kk, kk9, xx, aa, a6 ) ; 
          Trans39.ACC1 ( dd, p_dat01, 1, l_comm, kk, kk9, xx, aa, a6 ) ; 
          oo.DK := 1 ;
          oo.S := XX.AIRC_CCY *100 - aa.OSTC ; 
          PROVODKA (x_RI, XX, OO) ;  -- AIRC_CCY~Итого~НЕприз.дох
       ElsIf t.tip = 'SRR' and aa.ostc <> XX.FV_CCY    Then  
          Trans39.ACC1 ( dd, p_dat01, 0, l_comm, kk, kk9, xx, aa, a6 ); 
          Trans39.ACC1 ( dd, p_dat01, 1, l_comm, kk, kk9, xx, aa, a6 ); 
          oo.DK := 1 ;
          oo.S := XX.FV_CCY  *100  - aa.OSTC ; 
          PROVODKA (x_RI, XX, OO) ;  -- Переоценка, остаток
                                                                                                    
       end if;

       <<OK_>> null ;

   END LOOP ; -- T

end REFORM1;
--------------------------------------------------

procedure ACC1  (dd  IN OUT cc_deal%rowtype, 
                 p_dat01 date, 
                 p_mode int, 
                 p_Err OUT varchar2, 
                 kk  in out cck_ob22%rowtype  ,  
                 kk9 in out cck_ob22_9%rowtype, 
                 XX  in OUT TEST_PRVN_OSA%ROWtype, 
                 aa  IN OUT accounts%rowtype,  
                 a6     OUT accounts%rowtype 
               ) is 
  p4_ int;  
  b3_ char(3); b4_ char(1);
  acc_old number ;
  SPC specparam%rowtype;
 
begin  p_Err := null;

  If p_mode = 0 then   ------------------------  Определение/Открытие  счета SDF + SDM + SDI + SDA .... + SRR + SNA 

     begin dd.prod := substr(dd.prod,1,6) ;
           select k.* into kk from cck_ob22 k where  nbs||ob22  = dd.prod;
           If kk.d_close is not null then
              select r020_new||ob_new into dd.prod from TRANSFER_2017 where r020_old||ob_old =  dd.prod ;
              update cc_deal set prod  = dd.prod where nd = dd.nd ;
           end if ;
           select k.* into kk from cck_ob22 k where  nbs||ob22  = dd.prod;
     EXCEPTION WHEN NO_DATA_FOUND THEN  p_Err := 'НЕ знайдено cck_ob22.PROD='|| dd.prod ; goto RET_ ;
     end;

     If AA.TIP in ('SRR', 'SDF' , 'SDM' )  then 
        begin  select k.* into kk9 from cck_ob22_9 k where nbs||ob22 = dd.prod ;
        EXCEPTION WHEN NO_DATA_FOUND THEN  p_Err := 'НЕ знайдено cck_ob22_9.PROD='|| dd.prod ; goto RET_ ;
        end;
     end if; 

     begin select a.* into aa from accounts a, nd_acc n  where n.nd = dd.nd and n.acc= a.acc and a.tip = aa.tip and a.dazs is null and a.kv = xx.kv and rownum = 1 ;
     EXCEPTION WHEN NO_DATA_FOUND THEN 
        SAVEPOINT do_op;
        BEGIN b3_ := substr(dd.prod,1,3) ;
              aa.ob22 := null ;    
              If AA.TIP = 'SNA' THEN b4_:= '9' ;  aa.nms := 'НЕвизн.дох.'  ;
                 If    b3_ = '150' then aa.ob22 := '07' ;   ElsIf b3_ = '152' then aa.ob22 := '15' ;   elsIf b3_ = '202' then aa.ob22 := '15' ;   elsIf b3_ = '203' then aa.ob22 := '11' ;
                 elsIf b3_ = '206' then aa.ob22 := '73' ;   elsIf b3_ = '207' then aa.ob22 := '36' ;   elsIf b3_ = '208' then aa.ob22 := '39' ;   elsIf b3_ = '210' then aa.ob22 := '23' ;
                 elsIf b3_ = '211' then aa.ob22 := '24' ;   elsIf b3_ = '212' then aa.ob22 := '39' ;   elsIf b3_ = '213' then aa.ob22 := '39' ;   elsIf b3_ = '220' then aa.ob22 := 'J1' ;
                 elsIf b3_ = '223' then aa.ob22 := '70' ;
                 end if ;
              ELSiF AA.TIP = 'SRR' THEN b4_:= '7' ;  aa.nms := 'Переоцінка.'  ; a6.ob22 := Substr (kk9.SRR,5,2); --COMMENT ON COLUMN BARS.CCK_OB22_9.SRR IS 'БС+Об22~Переоц.~XLS';
              ELSiF AA.TIP = 'SDF' THEN b4_:= '6' ;  aa.nms := 'Д/П кориг.BV.'; aa.ob22 := kk.SDI ;              -- Все дисконты с одним и тем же об22 как и SDI
              ELSiF AA.TIP = 'SDM' THEN b4_:= '6' ;  aa.nms := 'Д/П модифік.' ; aa.ob22 := kk.SDI ;
              ELSiF AA.TIP = 'SDI' THEN b4_:= '6' ;  aa.nms := 'Д/П початков.'; aa.ob22 := kk.SDI ;
              ELSiF AA.TIP = 'SDA' THEN b4_:= '6' ;  aa.nms := 'Д/П технічний'; aa.ob22 := kk.SDI ;
              else RETURN ;
              end if;   
             
              aa.NBS := B3_ || b4_ ;
              aa.nls := Get_NLS( xx.KV, aa.NBS );
              aa.nms := Substr ( aa.nms||'Угода='|| dd.cc_id || ' від '|| to_char(dd.sdate, 'dd.mm.yyyy'), 1,50);
              op_reg (1, XX.nd, 0, 0, p4_, dd.Rnk, aa.nls, xx.kv, aa.nms, aa.tip, gl.auid, aa.acc);
              update accounts set pap = 3, tobo = dd.branch,  mdate = dd.wdate where acc = aa.acc;

              If aa.ob22 is not null then Accreg.setAccountSParam(aa.Acc, 'OB22', aa.ob22 ); end if;

              select * into aa from accounts where acc= aa.acc;
              --спецпарам ------------------------------------------------------
              If AA.tip in ( 'SDM' , 'SDA' ,  'SDF') then           -- Все дисконты с одним и тем же об22 как и SDI
                 begin select s.*  into spc   from specparam s, accounts a, nd_acc n  where n.nd = XX.nd and n.acc = a.acc and a.tip ='SDI' and rownum = 1 ;
                       Delete from accountsW where acc = aa.acc ;  insert into accountsw (acc,tag,value) select aa.acc,tag,value from accountsw where acc = spc.acc ;
                       Delete from specparam where acc = aa.acc ;  spc.acc := aa.acc ;    insert into specparam values spc;
                 EXCEPTION WHEN NO_DATA_FOUND THEN null ;
                 end;
              end if ; 
             
        EXCEPTION WHEN OTHERS THEN ROLLBACK TO do_op;  erm_ := null;  deb.trap(SQLERRM, code_, erm_, status_); p_Err := 'Рах.'||aa.tip||'*'||Substr (erm_, 1,90) ;   goto RET_ ;
        end ; 
     END;  --    SAVEPOINT do_op;

  ElsIf p_dat01 = G_Dat01 then     -- Определение счета 5031*

     If aa.TIP = 'SRR ' then a6 := a52 ;    
     Else                    a6 := a53 ;
     end if;
  Else  -- Определение счета 6/7  кл для -- возникновение 'SDF' + 'SDM' + переоценка SRR

     If aa.tip = 'SDF' or aa.tip = 'SDM' or aa.tip = 'SRR' then 

         If aa.tip = 'SDF' and (xx.b1 <> 0 OR xx.s1 <> 0 ) then  
           If    xx.s1 > 0 and xx.kv  = gl.baseVal then a6.nbs := Substr (kk9.S1NP,1,4);  a6.ob22 := Substr (kk9.S1NP,5,2); -- IS 'БС+Об22~NEW_FEE~плюс S1 грн~до спрв~FV_ADJ';
           ElsIf xx.s1 < 0 and xx.kv  = gl.baseVal then a6.nbs := Substr (kk9.S1NM,1,4);  a6.ob22 := Substr (kk9.S1NM,5,2); -- IS 'БС+Об22~NEW_FEE~мінус S1 грн~до спрв~FV_ADJ';
           ElsIf xx.s1 > 0 and xx.kv != gl.baseVal then a6.nbs := Substr (kk9.S1VP,1,4);  a6.ob22 := Substr (kk9.S1VP,5,2); -- IS 'БС+Об22~NEW_FEE~плюс S1 вал~до спрв~FV_ADJ';
           ElsIf xx.s1 < 0 and xx.kv != gl.baseVal then a6.nbs := Substr (kk9.S1VM,1,4);  a6.ob22 := Substr (kk9.S1VM,5,2); -- IS 'БС+Об22~NEW_FEE~мінус S1 вал~до спрв~FV_ADJ';
           end if;
        end if;

        If aa.tip = 'SDM' and ( xx.b3 <> 0 OR xx.s3 <> 0 ) then  

           If    xx.s3 > 0 and xx.kv  = gl.baseVal then a6.nbs := Substr (kk9.S3NP,1,4);  a6.ob22 := Substr (kk9.S3NP,5,2); -- IS 'БС+Об22~NEW_FEE~плюс S3 грн~від модф~MODIF'
           ElsIf xx.s3 < 0 and xx.kv  = gl.baseVal then a6.nbs := Substr (kk9.S3NM,1,4);  a6.ob22 := Substr (kk9.S3NM,5,2); -- IS 'БС+Об22~NEW_FEE~мінус S3 грн~від модф~MODIF
           ElsIf xx.s3 > 0 and xx.kv != gl.baseVal then a6.nbs := Substr (kk9.S3VP,1,4);  a6.ob22 := Substr (kk9.S3VP,5,2); -- IS 'БС+Об22~NEW_FEE~плюс S3 вал~від модф~MODIF'
           ElsIf xx.s3 < 0 and xx.kv != gl.baseVal then a6.nbs := Substr (kk9.S3VM,1,4);  a6.ob22 := Substr (kk9.S3VM,5,2); -- IS 'БС+Об22~NEW_FEE~мінус S3 вал~від модф~MODIF'
           end if;
        end if;
      
        If aa.tip = 'SRR' and xx.FV_CCY <> 0   then  
           a6.nbs := Substr (kk9.R6R,1,4);  a6.ob22 := Substr (kk9.R6R,5,2); -- IS 'БС+Об22~6 кл.Переоц.~XLS' ??? R7R IS 'БС+Об22~7 кл.Переоц.~XLS';
        end if;

        If a6.nbs is NOT null and a6.ob22 is NOT null then

           a6.nls := nbs_ob22_null (nbs_  => a6.nbs,  ob22_ => a6.ob22,  p_branch => substr( aa.branch,1,15) );
           If a6.nls is null then  -- открыть сче 6/7 кл
              logger.info('XXXX*'||dd.ND||'*'|| dd.PROD|| ' Рах(6/7)'||aa.tip||'*'||aa.KV||' для '|| kk9.nbs||'.'|| kk9.ob22 || ':' ||a6.nbs||'.'||a6.ob22||'*' );
              ADD_OB22 ( p_NBS => a6.NBS, p_ob22 => a6.OB22 ) ;
              OP_BS_OB1( PP_BRANCH => substr( aa.branch,1,15), P_BBBOO => a6.nbs||a6.ob22) ;
              a6.nls := nbs_ob22_null (nbs_  => a6.nbs,  ob22_ => a6.ob22,  p_branch => substr( aa.branch,1,15) );
              If a6.nls is not null then select * into a6 from accounts where kv = gl.baseval and nls = a6.nls;     end if;
           end if;
        end if;
     end if ;
      
     If a6.nls is null then -- амортизация всех SD* 
        begin select a.* into a6 from accounts a, int_accn i, nd_acc n where n.nd = xx.nd and n.acc= i.acc and i.id = 0 and i.acrb = a.acc and a.kv = gl.baseval and a.dazs is null and rownum = 1;
        EXCEPTION WHEN NO_DATA_FOUND THEN  p_Err := 'НЕ знайдено рах. 6/7 кл' ; goto RET_ ;
        end;
     End if;

  end if; ---  p_mode 

  <<RET_>> null ; If p_Err is not null then aa.nls := null ; end if;  RETURN;
  ------------------------------------------
end ACC1 ;
-------------------------------------------------------------------------------------------------


procedure opl (oo IN OUT oper%rowtype ) is 
begin If oo.s  = 0 then RETURN ; end if ;
      If oo.ref is null then gl.ref (oo.REF);
         gl.in_doc3 (ref_ => oo.REF  , tt_  => oo.tt  , vob_ => oo.vob ,   nd_ =>oo.nd   , pdat_=>SYSDATE, vdat_ =>oo.vdat, dk_ =>oo.dk,
                      kv_ => oo.kv   , s_   => oo.S   , kv2_ => oo.kv2 ,   s2_ =>oo.S2   , sk_  => null  , data_ =>oo.DATD,datp_=>gl.bdate,
                   nam_a_ => oo.nam_a,nlsa_ => oo.nlsa,mfoa_ => gl.aMfo, nam_b_=>oo.nam_b,nlsb_ =>oo.nlsb, mfob_ =>gl.aMfo ,
                    nazn_ => oo.nazn ,d_rec_=> null   ,id_a_ => null   , id_b_ =>null    ,id_o_ =>null   , sign_ =>null,sos_=>1,prty_=>null,uid_=>null);
      end if;
      
      Update accounts set dazs = null where dazs is not null and kv = oo.kv and nls = oo.nlsa;
      Update accounts set dazs = null where dazs is not null and kv = oo.kv2 and nls = oo.nlsB;
       
      gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa , oo.s, oo.kv2    ,oo.nlsb, oo.s2);
      gl.pay (2, oo.ref, gl.bdate);  -- по факту
end opl ;
--------------------------------------------------------------
/*
procedure FROM_SRR_XLS  is 
begin
  for xls in (select x.Rowid RI,   x.* from SRR_XLS x where x.comm is null)
  loop 
     update PRVN_FV_REZ_IFRS9  fv set  fv.FV_CCY = xls.FV_CCY 
      where fv.ID_CALC_SET = xls.ID_CALC_SET and fv.UNIQUE_BARS_Is= xls.UNIQUE_BARS_Is and fv.ID_BRANCH= xls.ID_BRANCH and fv.ID_CURRENCY= xls.ID_CURRENCY ;
     IF SQL%ROWCOUNT = 0 THEN  update SRR_XLS set comm = 'Не знайдено по ключам' where rowid = xls.RI; end if;

  end loop ;

end FROM_SRR_XLS;
*/

--------------------------------------------------------------
procedure snap9 ( P_DAT01 DATE, P_bdat  DATE )  IS  -- пОДГОТОВКА МЕСЯЧНОГО СНИМКА С УчЕТОМ ПЕРЕХОДНЫХ ПРОВОДОК
                  M_DAT01 DATE; I_DAT01 int  ;  Kol_ int ;   b_DAT  DATE ;  KF_ varchar2 (6) ;   AGG AGG_MONBALS9%rowtype;
BEGIN
 M_DAT01  := Trunc (P_DAT01 , 'MM' ) ;
 M_DAT01  := add_months(M_DAT01, -1) ;
 I_DAT01  := to_char ( M_DAT01, 'J' ) - 2447892 ;
 KF_      := gl.aMFO;
 ---------------------------------------------------------------------------------------
 select count(*) into kol_ from  mv_KF;
 begin EXECUTE IMMEDIATE ' DROP index AGG_MONBALS9_IDX ';
 exception when others then null; --  if SQLCODE = -01418 then null;   else raise; end if;   -- ORA-01418: specified index does not exist
 end;
 DELETE FROM AGG_MONBALS9  WHERE  FDAT = m_dat01 and kf = KF_ ;

 Insert into AGG_MONBALS9
       (FDAT,KF, ACC,RNK,OST,OSTQ,DOS,DOSQ,KOS,KOSQ,CRDOS,CRDOSQ,CRKOS,CRKOSQ,CUDOS,CUDOSQ,CUKOS,CUKOSQ,CALDT_ID, DOS9,DOSQ9,KOS9,KOSQ9)
 select FDAT,KF_,ACC,RNK,OST,OSTQ,DOS,DOSQ,KOS,KOSQ,CRDOS,CRDOSQ,CRKOS,CRKOSQ,CUDOS,CUDOSQ,CUKOS,CUKOSQ,CALDT_ID, 0   ,0    ,0   ,0    
        from AGG_MONBALS   
         where fdat = M_dat01  ;
begin  EXECUTE IMMEDIATE ' CREATE UNIQUE INDEX BARS.AGG_MONBALS9_IDX  ON BARS.AGG_MONBALS9 ( kf, fdat, ACC) ';
exception when others then null ; 
end;
 --------------------------------------------------------------
 AGG.KF       := gl.aMfo ;  --  -- Снимки и КФ
 AGG.FDAT     := M_DAT01 ;
 AGG.CALDT_ID := I_DAT01 ;
 AGG.CRDOS    :=  0  ;
 AGG.CRDOSQ   :=  0  ;
 AGG.CRKOS    :=  0  ;
 AGG.CRKOSQ   :=  0  ;
 AGG.CUDOS    :=  0  ;
 AGG.CUDOSQ   :=  0  ;
 AGG.CUKOS    :=  0  ;
 AGG.CUKOSQ   :=  0  ;

 FOR K IN (SELECT o.acc, P.vdat, a.kv, A.RNK,  O.DK, SUM(o.S) S, Sum(o.SQ)  SQ  
           FROM OPLDOK O, OPER P, accounts a 
           WHERE O.acc = a.ACC AND O.FDAT = p_Bdat  AND O.SOS = 5  AND O.REF  = P.REF  AND P.ND LIKE 'FRS9%' and p.vdat < p_dat01 
           GROUP BY      o.acc, P.vdat, a.kv, A.RNK,  O.DK
           )

 loop      iF k.kv <> GL.BASEVAL THEN K.SQ := GL.P_ICURVAL(  k.KV, K.s, K.vdat ) ; END IF;


     AGG.acc    := K.acc ;
     AGG.rnk    := K.rnk ;
     AGG.kv     := K.kv  ;
     AGG.ost    := (2*k.dk-1) * K.S  ;
     AGG.ostq   := (2*k.dk-1) * K.Sq ;
     -------------------------------
     AGG.DOS        := 0 ;
     AGG.DOSQ       := 0 ;
     AGG.KOS        := 0 ;
     AGG.KOSQ       := 0 ;
     AGG.DOS9       := 0 ;
     AGG.DOSQ9      := 0 ;
     AGG.KOS9       := 0 ;
     AGG.KOSQ9      := 0 ;

     If k.DK = 0 then   If TRUNC(k.VDAT,'MM')= m_DAT01 then  AGG.DOS := k.S ;  AGG.DOSq := k.SQ;  AGG.DOS9 := k.S ;  AGG.DOSq9 := k.SQ;  end if ;
     else               If TRUNC(k.VDAT,'MM')= m_DAT01 then  AGG.KOS := k.S ;  AGG.KOSq := k.SQ;  AGG.KOS9 := k.S ;  AGG.KOSq9 := k.SQ;  end if ;
     end if;
     
     update AGG_MONBALS9 set KV      = AGG.KV, 
                             OST     = OST  + AGG.OST,                      --\ Приращение остатка 
                             OSTq    = OSTq + AGG.OSTq,                     --/
                             DOS     = NVL(DOS, 0) + AGG.DOS,               --\ Приращение к месячним оборотам 
                             DOSq    = nvl(DOSq,0) + AGG.DOSq,              --/                               
                             DOS9    = NVL(DOS9, 0) + AGG.DOS9,             --\ Спец.обороты этого месяца
                             DOSq9   = nvl(DOSq9,0) + AGG.DOSq9,             --/                               
                             -------------------------------------------------
                             kOS     = NVL(kOS, 0) + AGG.kOS,               --\ Приращение к месячним оборотам 
                             kOSq    = nvl(kOSq,0) + AGG.kOSq,              --/                               
                             kOS9    = NVL(kOS9, 0) + AGG.kOS9,             --\ Спец.обороты этого месяца
                             kOSq9   = nvl(kOSq9,0) + AGG.kOSq9             --/                               
                       where fdat    = AGG.FDAT 
                         and acc     = AGG.acc  
                         and kf      = AGG.KF  ;

     IF SQL%ROWCOUNT = 0 THEN Insert into AGG_MONBALS9 values AGG  ; end if ;

 end loop;

logger.info('XXX-5*');

END snap9; 

--Анонимный блок----------------------------------------------
BEGIN  null ;
end Trans39 ;
/