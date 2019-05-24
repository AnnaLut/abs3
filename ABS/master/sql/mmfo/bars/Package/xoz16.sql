CREATE OR REPLACE PACKAGE XOZ16 IS g_header_version   CONSTANT VARCHAR2 (64) := 'version 2  02.05.2019';
-----------------------------------------------
procedure put ;
procedure KROK19 ; --   = opr  p_Mode in (61, 62, 63, 64,65 ) 
procedure Get_XLS(p_MODE int, p_file_name varchar2, p_Zdate date, p_clob clob ) ;
procedure VISA   (p_MODE int) ;
procedure CHK1   ( oo IN OUT oper%rowtype, p_sideA  varchar2, p_sideB  varchar2) ;  -- Проверка перед оплатой на счета
procedure OPL1   ( oo IN OUT oper%rowtype) ;  -- опрлата
procedure UPD1   ( p_ND cc_deal.ND%type, p_CC_ID cc_deal.CC_ID%type, p_SDATE date,  p_PROD cc_deal.PROD%type, p_ACC accounts.ACC%type )   ;
procedure OPR    ( p_ND cc_deal.ND%type, p_Mode int , p_S number, p_Txt varchar2 ) ;
procedure ADD1   ( p_RNK cc_Deal.RNK%type, p_CC_ID cc_deal.CC_ID%type, p_SDATE date, p_PROD cc_deal.PROD%type )  ;
FUNCTION NLS     (ND_ int, RNK_ int, NBS_ varchar2, ob22_ varchar2)  RETURN  varchar2 ; -- Получение лиц счета
FUNCTION header_version   RETURN VARCHAR2;
FUNCTION body_version     RETURN VARCHAR2;
-------------------
END XOZ16;
/

GRANT execute on XOZ16 TO BARS_ACCESS_DEFROLE;


CREATE OR REPLACE PACKAGE BODY XOZ16 IS   g_body_version   CONSTANT VARCHAR2 (64) := 'version 2.1  23.05.2019';
/*
23.05.2019 Sta  Демкович Марія Степанівна <DemkovichMS@oschadbank.ua> МСФЗ16_помилки наші
   CY	3615/04 => 4600/4609**	2.2) Переоцінка активу з права користування та зобов`язань з оренди за місяць
   Якщо >0, то Дт 4600  Кт 3615
   Якщо <0, то Дт 3615  Кт 4609

26.04.2019 Работа с 3739. Импорт полпнок Крок-19.
*/
-------------------------------------
  nlchr char(2) := chr(13)||chr(10) ;
  p4_ int ;
--------------------------------------------
procedure put  is -- установка контекстных переменных модуля
begin
   PUl.PUT('R020','4600') ;
---PUL.put('WACC',' a.nbs=''4600'' '); 
   PUL.put('WACC','a.nbs=''4600'' OR A.acc in (select n.acc from nd_acc n , cc_deal d where d.vidd=351 and d.nd= n.nd)'); 
end put;

procedure KROK19 is 
begin 
    XOZ16.OPR ( 0, 61, null, null ) ;
    XOZ16.OPR ( 0, 62, null, null ) ;
    XOZ16.OPR ( 0, 63, null, null ) ;
    XOZ16.OPR ( 0, 64, null, null ) ;
    XOZ16.OPR ( 0, 65, null, null ) ;
end KROK19 ;

procedure Get_XLS (p_MODE int, p_file_name varchar2, p_Zdate date, p_clob clob )  IS 
    g_numb_mask varchar2(100) := '9999999999999999999999999D99999999';
    g_nls_mask  varchar2(100) := 'NLS_NUMERIC_CHARACTERS = ''.,''';

--переменные для считывания строки
    MX TMP_XOZ16_XLS%rowtype;
--  dd cc_deal%rowtype  ;
    aa accounts%rowtype ;
    l_clob     clob ;
    I_ INT;
    sTmp_ VARCHAR2(500);
    n_ int := 0 ;
    D_ date ;
    Dubl_ int ;

  ---- Вычитка колонки с суммой
  Procedure Get_COLS(x_Col IN varchar2, x_Val OUT number ) is
  begin
     I_ := INSTR(L_CLOB,'<Column><Tag>'||x_Col||'</Tag><Value>',1); 
     If I_ > 0 then 
        i_ := I_ +28 ;
        l_clob :=  Substr(l_clob, i_);
        I_     := LEAST( 40, INSTR(L_CLOB, '</Value>', 1 ) ) - 1 ; 
        sTmp_  := Substr(l_clob, 1, i_) ;
        sTmp_  := REPLACE ( Substr(L_CLOB,1,I_ ), ' ','') ;  
        sTmp_  := REPLACE ( Substr(L_CLOB,1,I_ ), ',','') ;  

        Begin  x_Val := to_number(sTmp_, g_numb_mask, g_nls_mask) ;
        exception when others then  raise_application_error(-20000,'Рядок № '|| n_ || ' , колонка "'||x_Col||'" НЕ ЧИСЛО :'||sTmp_ );
        end;
     end if;
  end ;

begin
   If p_MODE = 0  then
      delete from TMP_RI_CLOB where namef = gl.aMfo ;
      insert into TMP_RI_CLOB (  C, NAMEF ) values (p_clob, gl.aMfo);
      Commit ;
   end if ;

   If p_MODE = 1  then -- для отладки ЭТОЙ процедуры парсинга
      begin select c into l_clob from TMP_RI_CLOB where namef = gl.aMfo ;    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN ;   end ;
   else                   l_clob := p_clob ;     
   end if;

   MX.KF := sys_context('bars_context','user_mfo') ;
   MX.DAT01 := TRUNC( gl.BDATE, 'MM');
   delete from TMP_XOZ16_XLS where kf = MX.KF ; ---- and dat01 = MX.DAT01 ; 

   WHILE 1 = 1   -- вечный цикл, выход по EXIT 
   LOOP
     <<Row_>> mx := null ;

     -- B = Номер договору
     I_ := INSTR(L_CLOB, '<Column><Tag>B</Tag><Value>',1) ;
     If I_ > 0 then
        I_ := I_ + 27 ;
        l_clob :=  Substr(l_clob, i_);
        I_       := LEAST( 25, INSTR(L_CLOB, '</Value>', 1 ) ) - 1 ; 
        MX.CC_ID := Substr(l_clob, 1, i_) ; 
        n_ := n_+1 ;
        MX.NPP  := n_ ;
        If n_ < 6 and MX.CC_ID like '%січень%2019%' then  d_ := to_date('01-01-2019','dd-mm-yyyy') ; end if ;
     Else 
        EXIT ;
     end if  ;

     -- С = Дата укладання договору
     I_ := INSTR(L_CLOB, '<Column><Tag>C</Tag><Value>',1) ;
     If I_ > 0 then
        I_ := I_ + 27 ;
        l_clob :=  Substr(l_clob, i_);
        I_     := LEAST( 10, INSTR(L_CLOB, '</Value>', 1 ) ) - 1 ; 
        Begin  MX.SDATE := To_Date( Substr(l_clob, 1, 10), 'dd.mm.yyyy')  ;     exception when others then  null;      end;
     end if ;

     -- G = Номер 14-ти значного аналітичного рахунку балансового рахунку 3519*26
     I_ := INSTR(L_CLOB, '<Column><Tag>G</Tag><Value>',1) ;
     If I_ > 0 then 
        I_ := I_ + 27 ;  
        l_clob :=  Substr(l_clob, i_);
        If  Substr(l_Clob,1,4) <> '3519' then goto Row_; end if;
        -------------------------------------------------------
        I_     := LEAST( 15, INSTR(L_CLOB, '</Value>', 1 ) ) - 1 ; 
        MX.NLS_3519 := Substr(l_clob, 1, i_) ; 
     End If;

     -- V = Вид базового активу :
     I_ := INSTR(L_CLOB, '<Column><Tag>V</Tag><Value>',1) ;
     If I_ > 0 then 
        I_ := I_ + 27 ;  
        l_clob :=  Substr(l_clob, i_);
        -------------------------------------------------------
        I_     := INSTR(L_CLOB, '</Value>', 1 )  - 1 ; 
        sTmp_  := Substr(l_clob, 1, i_) ;

        If    upper(sTmp_) like '%ОСНОВНОГО%'   then mx.prod := '460001';
        ElsIf upper(sTmp_) like '%ДОДАТКОВОГО%' then mx.prod := '460002';
        else                                         mx.prod := '460003';
        end if;

     End If;

     Get_COLS('BH', MX.S_BH ) ;  --COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S_BH  IS 'BH.Закриття зобовязань з оренди:3615->3739';
     Get_COLS('BI', MX.S_BI ) ;  --COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S_BI  IS 'BI.Закриття нарахованих процентів:3618->3739';
     Get_COLS('BJ', MX.S_BJ ) ;  --COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S_BJ  IS 'BJ.Закриття активів у формі права користування:3739->4600';
     Get_COLS('BK', MX.S_BK ) ;  --COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S_BK  IS 'BK.Закриття накопиченої амортизації:4609->3739';
     Get_COLS('BL', MX.S_BL ) ;  --COMMENT ON COLUMN BARS.TMP_XOZ16_XLS.S_BL  IS 'BL.Результат від припинення визнання модифікованих договорів:7499<->3739' ;
     --------------------------
     Get_COLS('BW', MX.S11 )  ;  --1.1) BW = Визнання зобов`язань з оренди та права користування активу:4600/**=>3615/*КРЕД.заборг -----------------------
     Get_COLS('CB', MX.S12 )  ;  --1.2) CB = Визнання активу з права користування на суму гарантійного платежу :4600/**=>3500/04  --- ,3519/26*ДЕБІТ.заборг
     Get_COLS('CG', MX.S21 )  ;  --2.1) CG = Нарахування % витрат за зобов`язанням з оренди  за місяць:7028/01=>3618/01
     Get_COLS('CM', MX.S33 )  ;  --3.3) CM = Закриття ДЕБ заборг на суму  ПДВ: 7399*67__ => 3519/26
     Get_COLS('CO', MX.S31 )  ;  --3.1) CO = Закриття нарахованих витрат на ДЕБ заборг.:3618/01=>3519/26
     Get_COLS('CP', MX.S32 )  ;  --3.2) CP = Закриття ДЕБ заборг.:3615=>3519/26
     Get_COLS('CY', MX.S22 )  ;  --2.2) CY = Переоцінка активу з права користування та зобов`язань з оренди за місяць:3615<=>4600 

     MX.KF := sys_context('bars_context','user_mfo') ;
     MX.DAT01 := TRUNC( gl.BDATE, 'MM');

--logger.info('XXX-1*'|| MX.npp||'*'||  MX.S_BH ||'*'|| MX.S_BI||'*'|| MX.S_BJ||'*'||MX.S_BK ||'*'||  MX.S_BL ||'*') ; 
 
     begin select a.* into aa FROM accounts a where a.kv = gl.baseval and a.nls = MX.NLS_3519 ;
           If aa.ob22 <> '26' then raise_application_error(-20000,'Рядок № '|| n_ || ' , колонка G, рах.'||MX.NLS_3519|| ' ob22='||aa.ob22 || ' HE 26 !' );   end if ;
           MX.RNKA := aa.RNK ;        

           begin select d.ND into mx.ND from cc_deal d, nd_acc n where n.acc = aa.acc and n.nd = d.nd and d.vidd =351 and rownum = 1;     
                 ---счет уже привязан к договору -------------------------------------------------------------------------------------------------------

                 -- А был ли он уже в этом XLS ?
                 begin select 1 into Dubl_ from TMP_XOZ16_XLS where NLS_3519 = MX.NLS_3519;

                       -- Да, был. Но это первый просчет за янв 2019. Допускаем
                       If D_ = to_date('01-01-2019', 'dd-mm-yyyy') then 
                          -- 01.01.2019  
                          -- По устной договоренности остановились на таком варианте, просьба к банку согласовать :
                          --    - при первом приема данных из XLS - обрабатываем все строки с учетом задублированных счетов 3519/26
                          --    - строки с задублированными счетами 3519/26  помечаются зеленым цветом
                          --    - при этом автоматически для задублированных счетов 3519/26  открываются новые счета 3519/26, которые должны быть использованы для последующих приемов XLS
                          MX.NLS_3519_OLD := MX.NLS_3519 ;
                          MX.NLS_3519     := Get_NLS( aa.kv, aa.nbs );
                          aa.NLS          := MX.NLS_3519 ;
                          op_reg( mod_=> 99, p1_=> 0, p2_=>0, p3_=>aa.GRP, p4_=>p4_, rnk_=>aa.RNK, nls_=>MX.NLS_3519, kv_=> aa.KV, nms_=> aa.NMS,  tip_=> 'XOZ',  isp_=> gl.aUid, accR_=> aa.acc );
                          Accreg.setAccountSParam(aa.ACC, 'OB22', '26' ) ;
                          XOZ16.UPD1 ( p_ND => null, p_CC_ID => mx.cc_id,  p_SDATE => NVL(mx.SDATE, aa.daos),  p_PROD  => mx.PROD, p_ACC => aa.ACC ) ;   
                       else
                           --    - при последующих приемах XLS в файле не должно быть повторяющихся счетов  3519/26 (при нахождении таких записей - будет выдаваться сообщение об ошибке)
                           raise_application_error(-20000,'Рядок № '|| n_ || ' , Дубль рахунку '||aa.NLS );
                       end if;  
                EXCEPTION WHEN NO_DATA_FOUND THEN  null ; -- нет, не был в этом XLS. все ОК
                       XOZ16.UPD1  ( p_ND => mx.ND, p_CC_ID => mx.cc_id,  p_SDATE => NVL(mx.SDATE, aa.daos),  p_PROD  => mx.PROD, p_ACC => aa.ACC ) ;   
                end  ;

           EXCEPTION WHEN NO_DATA_FOUND THEN   
                -- Новый договор = счет 3519  еще не привязан ни к одному дог 
                XOZ16.UPD1  ( p_ND => null, p_CC_ID => mx.cc_id,  p_SDATE => NVL(mx.SDATE, aa.daos),  p_PROD  => mx.PROD, p_ACC => aa.ACC ) ;   
           end ;

           select d.ND into mx.ND from cc_deal d, nd_acc n where n.acc = aa.acc and n.nd = d.nd and d.vidd =351 ;    

           If MX.S_BH <>0 or  MX.S_BI <>0 or MX.S_BJ <>0  or MX.S_BK <>0 or MX.S_BL <>0 then
              --Проверить/Открыть 3739

              begin select * into aa from accounts where rnk=rnk and nbs='3739' and ob22='17' and dazs is null and kv=980 and acc in (select acc from nd_acc where nd = MX.nd);
              EXCEPTION WHEN NO_DATA_FOUND THEN  
                 aa.NLS := Get_NLS( gl.baseval, '3739' );
                 op_reg( mod_=> 99, p1_=> 0, p2_=>0, p3_=>29, p4_=>p4_, rnk_=>aa.RNK, nls_=>aa.nls, kv_=> aa.KV, nms_=> aa.NMS,  tip_=> 'ODB', isp_=> aa.isp, accR_=> aa.acc );
                 Accreg.setAccountSParam(aa.ACC, 'OB22', '17' ) ;
                 insert into nd_acc( nd,acc) values ( MX.nd, aa.acc) ;  --3615
              end ;
           end if;   

     EXCEPTION WHEN NO_DATA_FOUND THEN  null ;
   end  ;

     insert into TMP_XOZ16_XLS  values MX ;
   end loop ;

   commit;
   return;
end Get_XLS ;  

procedure VISA   (p_MODE int) is 
begin
  If p_mode = 0 then 
     for k in (select REF from oper where OPER.ref>=to_number(Pul.Get('X1'))  and OPER.REF<=to_number(Pul.Get('X2'))  and OPER.USERID = gl.aUid and sos = 1)
     loop  gl.pay( 2, k.REF, gl.bdate); end loop;
  end if ;
end visa;

procedure CHK1   ( oo IN OUT oper%rowtype, p_sideA  varchar2, p_sideB  varchar2) is
 -- Проверка перед оплатой на счета
 txt_ varchar2 (20) := 'Рядок '|| oo.nd|| ':';
 code_   NUMBER;
 erm_    VARCHAR2(2048);
 status_ VARCHAR2(10);
begin
  if oo.nlsa is null and  p_sideA is not null then raise_application_error(-20000, txt_ || 'Не знайдено рах.'|| p_sideA   ); End if;
  if oo.nlsB is null and  p_sideB is not null then raise_application_error(-20000, txt_ || 'Не знайдено рах.'|| p_sideB   ); End if;

  begin   XOZ16.OPL1(oo);
  exception when others then  deb.trap(SQLERRM, code_, erm_, status_);  IF code_ <= -20000 THEN  raise_application_error(-20000, txt_||erm_ );     END IF;
  end ;

end CHK1 ;

procedure OPL1   ( oo IN OUT oper%rowtype) is  -- опрлата
  --nbsa_ accounts.NBS%type ; nbsb_ accounts.NBS%type ;
  NLS_ accounts.NLS%type ; 
begin
  oo.vdat := NVL ( oo.vdat,gl.bdate); 
  oo.vob  := NVL ( oo.vob, 6   );
  oo.KV   := NVL ( oo.kv, gl.baseval); 
  oo.kv2  := NVL ( oo.kv2,oo.kv); 

  If oo.kv <> gl.Baseval then   oo.s2   := NVL ( oo.s2, gl.p_icurval(oo.kv,oo.s,oo.vdat) ) ; 
  else oo.s2 := oo.s;
  end if;


  If oo.ref is null then

     If oo.nam_a is null then  begin select substr(nms,1,38) into oo.nam_A from accounts where kv = oo.kv   and nls = oo.nlsA; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;  end if;

     If oo.id_A  is null then 
        If Substr(oo.nlsA,1,1) in ('4','5','6','7') then oo.id_A := gl.aOkpo;
        else begin select c.okpo into oo.id_A from accounts a, customer c where a.kv=oo.kv  and a.nls=oo.nlsA and a.rnk=c.rnk; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;
        end if;   
     end if;
 
     If oo.nam_B is null then  begin select substr(nms,1,38) into oo.nam_B from accounts where kv = oo.kv2  and nls = oo.nlsB; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;  end if;

     If oo.id_B  is null then 
        If Substr(oo.nlsB,1,1) in ('4','5','6','7') then oo.id_B := gl.aOkpo;
        else begin select c.okpo into oo.id_B from accounts a, customer c where a.kv=oo.kv2 and a.nls=oo.nlsB and a.rnk=c.rnk; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;
        end if;   
     end if;

     oo.mfoa := NVL ( oo.mfoa, gl.aMfo);
     oo.mfoB := NVL ( oo.mfoB, gl.aMfo) ;

     gl.ref (oo.REF);
     If oo.nd is null then     oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ; end if;
     gl.in_doc3 (ref_=>oo.REF  ,  tt_ =>oo.tt  , vob_=>oo.vob , nd_  =>oo.nd   ,pdat_=>SYSDATE, vdat_=>oo.vdat , dk_ =>oo.dk,
                  kv_=>oo.kv   ,  s_  =>oo.S   , kv2_=>oo.kv2 , s2_  =>oo.S2   ,sk_  => null  , data_=>gl.BDATE,datp_=>gl.bdate,
               nam_a_=>oo.nam_a, nlsa_=>oo.nlsa,mfoa_=>oo.mfoa,nam_b_=>oo.nam_b,nlsb_=>oo.nlsb, mfob_=>oo.mfob,
                nazn_=>oo.nazn ,d_rec_=>null   ,id_a_=>oo.id_a,id_b_=>oo.id_b  ,id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
  end if;
--logger.info ('XXX-1*'|| oo.ref||'*'|| oo.vdat||'*'|| oo.tt||'*'|| oo.dk||'*'|| oo.kv||'*'|| oo.nlsa||'*'|| oo.s||'*'|| oo.kv2||'*'||  oo.nlsb||'*'|| oo.s2 ||'*');
  gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2,  oo.nlsb, oo.s2);

end OPL1;
-------------

procedure UPD1 ( p_ND cc_deal.ND%type, p_CC_ID cc_deal.CC_ID%type, p_SDATE date,  p_PROD cc_deal.PROD%type, p_ACC accounts.ACC%type )   IS 
  dd cc_deal%rowtype;
  aa accounts%rowtype; 
begin

  If p_ND > 0 then      

     begin select * into dd from cc_deal where nd = p_ND and vidd = 351 and sos = 10;
           update cc_deal set cc_id = p_cc_id , prod = p_Prod where nd = p_ND ; 
     EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-20000,'Не знайдено nd='|| p_ND );
     end ;
     -- Добавим потерянные счета 3500.04 ( !!!) 
     begin select * into aa from accounts X where rnk = DD.rnk and nbs = '3500' and ob22='04' and dazs is null and kv = 980 and NOT exists (select 1 from nd_acc where acc = x.ACC) and rownum = 1;
           insert into nd_acc( nd,acc) values ( dd.nd, aa.acc) ;  --3500
     EXCEPTION WHEN NO_DATA_FOUND THEN  null ;
     end ;

     RETURN ; 
  end if;
  -------------------------
  begin select * into aa from accounts where acc = p_acc ;
  EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-20000,'Не знайдено 3519*26 для nd='|| p_ND );
  end ;

  dd.ND    := bars_sqnc.get_nextval('s_cc_deal') ;  ---- s_cc_deal.NEXTVAL ;
  dd.PROD  := p_PROD ; 
  dd.sdate := NVL(p_SDATE, aa.DAOS );
  dd.wdate := aa.Mdate ;
  dd.limit := 0 ; 
  dd.sos   := 10       ;  
  dd.cc_id := p_CC_ID   ;
  dd.rnk   := aa.rnk   ;  
  dd.vidd  := 351  ;
  dd.branch:= aa.branch;
  dd.kf    := aa.KF ;
  dd.user_id := aa.Isp ;
  INSERT INTO cc_deal values dd;
  insert into nd_acc( nd,acc) values ( dd.nd, aa.acc) ;  --3519
  ----
  begin select * into aa from accounts X  where rnk = aa.rnk and nbs = '3615' and ob22='04' and dazs is null and kv = 980 and NOT exists (select 1 from nd_acc where acc = x.ACC) and rownum = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN  
     aa.NLS := Get_NLS( gl.baseval, '3615' );
     op_reg( mod_=> 99, p1_=> 0, p2_=>0, p3_=>29, p4_=>p4_, rnk_=>aa.RNK, nls_=>aa.nls, kv_=> aa.KV, nms_=> aa.NMS,  tip_=> 'ODB', isp_=> aa.isp, accR_=> aa.acc );
     Accreg.setAccountSParam(aa.ACC, 'OB22', '04' ) ;
  end ;
  insert into nd_acc( nd,acc) values ( dd.nd, aa.acc) ;  --3615

  begin select * into aa from accounts X  where rnk = aa.rnk and nbs = '3618' and ob22='01' and dazs is null and kv = 980 and NOT exists (select 1 from nd_acc where acc = x.ACC) and rownum = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN  
     aa.NLS := Get_NLS( gl.baseval, '3618' );
     op_reg( mod_=> 99, p1_=> 0, p2_=>0, p3_=>29, p4_=>p4_, rnk_=>aa.RNK, nls_=>aa.nls, kv_=> aa.KV, nms_=> aa.NMS,  tip_=> 'ODB', isp_=> aa.isp, accR_=> aa.acc );
     Accreg.setAccountSParam(aa.ACC, 'OB22', '01' ) ;
  end ;
  insert into nd_acc( nd,acc) values ( dd.nd, aa.acc) ;  --3619

  begin select * into aa from accounts X where rnk = aa.rnk and nbs = '3500' and ob22='04' and dazs is null and kv = 980 and NOT exists (select 1 from nd_acc where acc = x.ACC) and rownum = 1;
        insert into nd_acc( nd,acc) values ( dd.nd, aa.acc) ;  --3500
  EXCEPTION WHEN NO_DATA_FOUND THEN  null;
  end ;


end UPD1;
----------------------
procedure OPR  ( p_ND cc_deal.ND%type, p_Mode int , p_S number, p_Txt varchar2 ) is 
-- p_Mode = 0 -- -- 0.Зберегти суми для проводок
-- p_Mode = 1 -- -- Визнання активу:4600 => 3615,3519,3500
-- p_mode = 2 -- -- Нарахування витрат за місяць: 7028 => 3618
-- p_mode = 3 -- -- Закриття КРЕД/ДЕБ заборгованості: 3615,3618 => 3519
-- p_mode = 4 -- -- Закриття ДЕБ заборгованості з ПДВ: 7410*09  => 3519
  oo oper%rowtype;
  dd cc_deal%rowtype;
  AA ACCOUNTS%rowtype;
  l_Branch ACCOUNTS.BRANCH%type;
  l_Side varchar2(7);
  txt_ varchar2(20);
  PROCEDURE CL_xoz (OO OPER%ROWTYPE) IS    AA ACCOUNTS%ROWTYPE;    l_SP number ;
  BEGIN
    begin select * into aa from accounts where nls = oo.NLSB and kv = oo.kv2 and tip ='XOZ';
    EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN ;
    end ;

    -- Часткове(повне)  Ручне закриття (без породження проводок)
    l_SP := oo.S2/100  ;
    for x in (select * from xoz_ref where acc = aa.acc and ref2 is null order by FDAT, REF1, S )
    loop  If l_SP = 0 then EXIT; end if;
          x.S  := x.S /100 ; 
          x.S0 := LEAST ( x.S, l_SP);
          If x.S0 > 0 then 
             XOZ.OPL_REF_H2( p_acc=>x.ACC,  p_ref1 =>x.Ref1,   p_stmt1 => x.stmt1,   p_DV1 => x.FDAT,   p_S => x.S,   p_REF2  => oo.ref, p_ZO=> 0,  p_SP => x.S0,  p_DV2 => null  ) ;
             l_SP := l_SP - x.S0 ;
          end if ;
    end loop;  -- x
  END ;
 
begin 
  If p_Mode = 0  then   
     If p_ND > 0 then
        delete from TMP_XOZ16 where isp= gl.aUid and nd = p_ND ;
        insert into TMP_XOZ16( isp, nd, S ) values ( gl.aUid, p_nd, p_S*100);
     end if;

     Return ;

  End if ;
  -----------
  oo.DK := 1;
  oo.tt := 'PS1'; 

  If p_ND = 0 then
     If p_Mode in ( 11, 12, 21, 22, 31, 32, 33, 61)  then
        pul.Put('X1', Null ) ; 
        pul.Put('X2', Null ) ;   
     end if ;

     delete from TMP_XOZ16 where isp= gl.aUid ;
     insert into TMP_XOZ16( isp, nd, S , npp ) 
                select  gl.aUid, nd, decode ( p_mode, 11,S11 ,  12,S12 ,  21,S21 ,  22,S22 ,  31,S31 ,   32,S32,  33, S33, 
                                                      61,S_BH,  62,S_BI,  63,S_BJ,  64,S_BK,  65,S_BL, 
                                                         0   ) *100, npp
                from TMP_XOZ16_XLS 
                where kf = gl.aMFO and nd > 0 ;
     commit;
  end if;

  l_Branch := '/'||gl.aMfo ||'/000000/' ;

  FOR x in ( select * from TMP_XOZ16 t where p_ND in ( 0, t.ND)  and t.S <> 0 and isp = gl.aUid order by npp ) 
  LOOP  
     If p_ND = 0 then txt_ := 'Рядок № '|| x.npp||':' ;  end if ;

     oo    := null ;
     oo.Nd := x.npp ;
     oo.DK := 1    ;
     oo.tt := 'PS1' ; 
     oo.S  := x.S  ;

     begin select * into dd from cc_deal where nd = x.ND and vidd = 351 and sos = 10;
     EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-20000, txt_||'Не знайдено nd='|| x.ND );
     end ;

     l_Side := Substr(dd.prod,1,4) ||'*'|| Substr(dd.prod,5,2) ;
----------------------------------------------------------------------------------------------------------------
     If p_Mode in (61, 62, 63, 64,65 )  then   
        oo.nlsB := XOZ16.NLS( dd.ND, dd.rnk, '3739', null ) ; 

        If p_Mode = 61 then   
           oo.dk := 1 ;
           oo.nazn := Substr( 'Закриття зобовязань з оренди згідно дог. №'  ||dd.cc_id||'. '||p_Txt ,1,160) ;
           oo.nlsA := XOZ16.NLS( dd.ND, dd.rnk, '3615', null ) ;       
           XOZ16.CHK1( oo, '3615*04', '3739*17' ) ;  
        
        ElsIf p_Mode = 62 then
           oo.dk := 1 ;
           oo.nazn := Substr( 'Закриття нарахованих процентів згідно дог. №'  ||dd.cc_id||'. '||p_Txt ,1,160) ;
           oo.nlsA := XOZ16.NLS( dd.ND, dd.rnk, '3618', null ) ; 
           XOZ16.CHK1( oo, '3618*01', '3739*17' ) ;  

        ElsIf p_Mode = 63 then  
           oo.dk := 0 ;
           oo.nazn := Substr( 'Закриття активів у формі права користування згідно дог. №'  ||dd.cc_id||'. '||p_Txt ,1,160) ;
           oo.nlsa := nbs_ob22_NULL (Substr(dd.prod,1,4),  Substr(dd.prod,5,2), l_Branch );       -- найти 4600
           XOZ16.CHK1( oo, l_Side, '3739*17' ) ;  

        ElsIf p_Mode = 64 then  
           oo.dk := 1 ;
           oo.nazn := Substr( 'Закриття накопиченої амортизації згідно дог. №'  ||dd.cc_id||'. '||p_Txt ,1,160) ;
           aa.nbs  := Substr(dd.prod,1,3)||'9';
           aa.ob22 := Substr(dd.prod,5,2) ;
           oo.nlsa := nbs_ob22_NULL (aa.nbs, aa.ob22, l_Branch );       -- найти 4609
           If oo.nlsa is null then  
              OP_BS_OB1( PP_BRANCH => l_Branch, P_BBBOO => aa.nbs||aa.ob22 ) ;  
              oo.nlsa := nbs_ob22_NULL ( aa.nbs,  aa.ob22, l_Branch );     
           end if;
           l_Side  := aa.nbs||'*'||aa.ob22  ;
           XOZ16.CHK1( oo, l_Side, '3739*17' ) ;  

        ElsIf p_Mode = 65 then             
           oo.nazn := Substr( 'Результат від припинення визнання модифікованих договорів згідно дог. №' ||dd.cc_id||'. '||p_Txt ,1,160) ;
           If oo.S > 0 then        oo.DK := 0 ; aa.nbs := '6360' ; aa.ob22 := '01' ;  
           Else  oo.s := - oo.S ;  oo.DK := 1 ; aa.nbs := '7360' ; aa.ob22 := '01' ;
           End if; 
           oo.nlsa := nbs_ob22_NULL ( aa.nbs,  aa.ob22, l_Branch );       -- найти 6360.7360
           l_Side := aa.nbs||'*'|| aa.ob22 ;
           If oo.nlsa is null then  
              OP_BS_OB1( PP_BRANCH => l_Branch, P_BBBOO => aa.nbs||aa.ob22 ) ;  
              oo.nlsa := nbs_ob22_NULL ( aa.nbs,  aa.ob22, l_Branch );       -- найти 6360.7360
           end if;
           XOZ16.CHK1( oo, l_Side, '3739*17' ) ;  
        end if ;

---------------------------------------------------------------------------------------------------------------

     ElsIf p_Mode in (11,12)   then   

        oo.nlsa := nbs_ob22_NULL (Substr(dd.prod,1,4),  Substr(dd.prod,5,2), l_Branch );       -- найти 4600

        If oo.nlsa is null then  
           -- 4600.XX
           OP_BS_OB1( PP_BRANCH => l_Branch, P_BBBOO => dd.prod ) ;  
           oo.nlsa := nbs_ob22_null ( Substr(dd.prod,1,4),  Substr(dd.prod,5,2) ,l_Branch ); 
           begin select * into aa from accounts where kv = gl.baseval and nls = oo.NLSA ; -- открыть партный 4609.ххххххххх
                 update accounts set grp = 20 where acc= aa.acc ;
                 Accreg.setAccountSParam(aa.ACC, 'R011', '2'  ) ;

                 ----4609.XX ---------------------------------------------
                 aa.NLS := Vkrzn( substr(gl.aMfo,1,5), substr (aa.nls,1,3)||'9_'||Substr(aa.nls,6,9) ) ;
                 op_reg( 99, 0, 0, aa.GRP, p4_, aa.RNK, aa.nls, aa.KV, aa.NMS,'ODB', aa.isp,  aa.acc );
                 Accreg.setAccountSParam(aa.ACC, 'OB22', aa.ob22  ) ;
                 Accreg.setAccountSParam(aa.ACC, 'R011', '2'  ) ;
                 update accounts set grp = 20 where acc= aa.acc ;

                 ----7424.XX ---------------------------------------------
                 aa.NLS := Vkrzn( substr(gl.aMfo,1,5), '7424_'||Substr(aa.nls,6,9) ) ;
                 op_reg( 99, 0, 0, aa.GRP, p4_, aa.RNK, aa.nls, aa.KV, aa.NMS,'ODB', aa.isp,  aa.acc );
                 Accreg.setAccountSParam(aa.ACC, 'OB22', aa.ob22  ) ;
--               Accreg.setAccountSParam(aa.ACC, 'R011', '2'  ) ;
                 update accounts set grp = 20 where acc= aa.acc ;

           EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-20000, txt_||'Не знайдено рах.4600' );
           end ;

        end if ;

        oo.nazn := Substr( 'Визнання на балансі активу з права користування та зобов’язання з оренди згідно дог. №'||dd.cc_id||'. '||p_Txt ,1,160) ;
        oo.TT   := CASE WHEN dd.sdate < to_date ('01.01.2019', 'dd.mm.yyyy') THEN 'IF0' else 'PS1' END ;

       --Виконати проводки <br>BW=1.1)Визнання зобов`язань<br>4600/**=>3615/04<br> ?
        If p_Mode = 11 then  
           oo.nlsB :=  XOZ16.NLS( dd.ND, dd.rnk, '3615', null ) ; 
           XOZ16.CHK1( oo, l_Side, '3615*04' ) ;  
        end if ;

        ---Виконати проводки <br>CB=1.2)Визнання активу<br>4600/**=>3500/04<br> ?
        If p_Mode = 12 then  
           oo.nlsB :=  XOZ16.NLS( dd.ND, dd.rnk, '3500', null ) ; 
           If oo.nlsb is not null then   
              XOZ16.CHK1( oo, l_Side,  '3500*04' ) ;  
           Else       NULL ; 
           end if ;
        End If ;
---------------------------------------------------------------------------------------------------------------
        --Виконати проводки <br>CG=2.1)Нарахування витрат<br>7028/01=>3618/01<br> ?
     ElsIf p_Mode = 21 Then 
        oo.nazn := Substr( 'Нарахування процентних витрат з оренди за місяць згідно дог. №' ||dd.cc_id||'. '||p_Txt ,1,160) ;
        oo.nlsa := nbs_ob22_NULL ('7028', '01', l_Branch );    -- найти 7028*01

        If oo.nlsa is null then  
           OP_BS_OB1( PP_BRANCH => l_Branch, P_BBBOO =>'702801' ) ;    
           oo.nlsa := nbs_ob22_NULL ('7028', '01',l_Branch );  
        end if;
        oo.nlsB := XOZ16.NLS( dd.ND, dd.rnk, '3618', null ) ; 
        XOZ16.CHK1( oo, '7028*01', '3618*01' ) ;  

     ----------------------------------------------------------------------------------
     ---Виконати проводки <br>CY=2.2)Переоцінка активу<br>3615/04<=>4600/**<br> ?
     ElsIf p_Mode = 22 then
        --23.05.2019 Sta  Демкович Марія Степанівна <DemkovichMS@oschadbank.ua> МСФЗ16_помилки наші
        oo.nazn := Substr( 'Переоцінка активу з права користування та зобов`язань з оренди за місяць згідно дог. №' ||dd.cc_id||'. '||p_Txt ,1,160) ;
         oo.nlsB := XOZ16.NLS( dd.ND, dd.rnk, '3615', null ) ; 
        If oo.S > 0 then        oo.DK := 1 ;    --            Якщо >0, то Дт 4600  Кт 3615   
           oo.nlsa := nbs_ob22_NULL (Substr(dd.prod,1,4),     Substr(dd.prod,5,2) );       -- найти 4600
        Else  oo.s := - oo.S ;  oo.DK := 0 ;    --            Якщо <0, то Дт 3615  Кт 4609   
           oo.nlsa := nbs_ob22_NULL (Substr(dd.prod,1,3)||'9',Substr(dd.prod,5,2) );       -- найти 4609   
        End if; 
        XOZ16.CHK1( oo, l_Side, '3615*04' ) ;  
---------------------------------------------------------------------------------------------------------------
     ---Закриття XOZ 3519/26----------------------------------------------------------------------------------
     ElsIf  p_Mode  in ( 31, 32, 33 )  then   

        If p_ND = 0 then
           Begin select NVL ( t.NLS_3519_OLD, t.NLS_3519) into oo.nlsB from TMP_XOZ16_XLS t where t.kf = gl.aMFO and t.nd = x.ND ;
           exception when NO_DATA_FOUND THEN                   oo.nlsB := XOZ16.NLS( dd.ND, dd.rnk, '3519', null ) ;
           end;
        Else  oo.nlsB := XOZ16.NLS( dd.ND, dd.rnk, '3519', null ) ;
        End If;

        ---Виконати проводки <br>CO=3.1)Закриття нар/витрат<br>3618/01=>3519/26<br> ?
        If p_Mode = 31 then 
           oo.nazn := Substr( 'Закриття нарахованих процентних витрат з оренди на ДЕБ.заборг. за послуги згідно дог. №'  ||dd.cc_id||'. '||p_Txt ,1,160) ;
           oo.nlsA := XOZ16.NLS( dd.ND, dd.rnk, '3618', null ) ; 
           XOZ16.CHK1( oo, '3618*01', '3519*26' ) ;  
        END IF;

        -- Виконати проводки <br>CP=3.2)Закриття ДЗ<br>3615/04=>3519/26<br> ?
        If p_Mode = 32 then
           oo.nazn := Substr( 'Закриття КРЕД.заборг. за фінансовим лізингом (орендою) на ДЕБ.заборг. за послуги згідно дог. №'  ||dd.cc_id||'. '||p_Txt ,1,160) ;
           oo.nlsA := XOZ16.NLS( dd.ND, dd.rnk, '3615', null ) ; 
           XOZ16.CHK1( oo, '3615*04', '3519*26' ) ;  
        END IF ;

        --- Виконати проводки <br>CM=3.3)Закриття ДЗ(ПДВ)<br>7399/67=>3519/26<br> ?
        If p_Mode = 33 then  
           oo.nazn := Substr( 'Визнання витрат на суму сплаченого ПДВ, який не входить до складу ВВ, за попередній звітний період  згідно дог. №'  ||dd.cc_id||'. '||p_Txt ,1,160) ;
           oo.nlsa := nbs_ob22_NULL ('7399', '67' , l_Branch );    -- найти 7399/67
           If oo.nlsa is null then  
              OP_BS_OB1( PP_BRANCH => l_Branch, P_BBBOO =>'739967' ) ; 
              oo.nlsa := nbs_ob22_NULL ('7399','67', l_Branch ); 
           end if;
           XOZ16.CHK1( oo, '7399*67', '3519*26' ) ;  
        end if ;

        cl_xoz (OO) ;
---------------------------------------------------------------------------------------------------------------
     end if ;

     delete from TMP_XOZ16 where isp= gl.aUid and nd = dd.ND ;
     If oo.ref is NOT null then   
        If pul.Get('X1') is null then     pul.Put('X1', oo.Ref) ;     end if;       
        pul.Put('X2', oo.Ref) ;   
--      gl.pay2 ( 2, oo.ref,  gl.Bdate );  -- 21.03.2019 С Визированием !!!!
     end if ;

  end loop  ;  --- X

end OPR;
-----------------
procedure ADD1 ( p_RNK cc_Deal.RNK%type, p_CC_ID cc_deal.CC_ID%type, p_SDATE date, p_PROD cc_deal.PROD%type )  IS
  -- НОВА угода оренди
  aa accounts%rowtype ;
begin
  begin select Substr( 'Дог.оренди '|| nmk ,1,50) into  aa.nms from customer where rnk = p_RNK;
  exception when NO_DATA_FOUND THEN  raise_application_error(-20000,'Не знайдено Кл.РНК='|| p_RNK );
  end;

  aa.NBS  :='3519';
  aa.ob22 := '26';
  aa.kv   := gl.Baseval;
  aa.grp  := 16 ;
  aa.NLS  := Get_NLS( aa.kv, aa.nbs );
  op_reg( mod_=> 99, p1_=> 0, p2_=>0, p3_=>aa.GRP, p4_=>p4_, rnk_=>p_RNK, nls_=>aa.nls, kv_=> aa.KV, nms_=> aa.NMS,  tip_=> 'XOZ',  isp_=> gl.aUid, accR_=> aa.acc );
  Accreg.setAccountSParam(aa.ACC, 'OB22', '26' ) ;
  XOZ16.UPD1 ( p_ND => null, p_CC_ID => p_CC_ID, p_SDATE => NVL(p_SDATE, gl.bdate ), p_PROD => p_PROD, p_ACC => aa.acc ) ;

end ADD1 ;

--------------------
FUNCTION NLS(ND_ int, RNK_ int, NBS_ varchar2, ob22_ varchar2)  RETURN varchar2 IS NLS_  VARCHAR2(15); -- Получение лиц счета
begin
 begin select nls into NLS_ 
       from accounts a, nd_acc n 
       where n.nd   = ND_ and a.rnk=RNK_ and a.acc=n.acc and NBS_ = ( CASE WHEN length (NBS_)>3 THEN a.NBS else a.tip END ) 
         and a.ob22 = NVL (OB22_, a.ob22 )  and rownum = 1 ;
 exception when NO_DATA_FOUND THEN NLS_:=null;
 end;
 Return NLS_;
end NLS;
---------

   FUNCTION header_version RETURN VARCHAR2 is BEGIN RETURN 'Package header XOZ16'|| g_header_version; END header_version;
   FUNCTION body_version   RETURN VARCHAR2 is BEGIN RETURN 'Package body XOZ16 ' || g_body_version;   END body_version;

--------------
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION  : Anonymous block
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

BEGIN
 null; ----  param;
END XOZ16;
/
