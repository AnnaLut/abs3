
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/msfz9.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MSFZ9 IS
  -- Sta 22.02.2017
------------------------------------
  function Get_NLS  ( p_KV int, p_B4 varchar2) return varchar2 ;
  procedure opl (oo IN OUT oper%rowtype ) ;
  procedure REGU   ( p_nd number, p_KV int ) ;   --  Урегулювати (Об`єднати/Розділити )
  procedure step_1 ( DD   v_MSFZ9%rowtype  ) ;   --  Власне бізнес-логіка Об`єднання  для 1 КД = dd.ND
  procedure step_2 ( dd   v_MSFZ91%rowtype  ) ;   -- Власне бізнес-логіка Роз`єднання  для 1 КД = dd.ND

END msfz9;
/
CREATE OR REPLACE PACKAGE BODY BARS.MSFZ9 is
  -- Sta+Vlka S/. 07.04.2017- 1
--------------------------------------------------------
/*
тест ND=72675501 , KV=840.
Неправильно распределились суммы по SPN и SNA.

3.2 Алгоритм  одноразового розподілу рахунків кредитних ліній
Тип SP       - в питомій вазі до SS.
Тип SN ,SPN  – в питомій вазі зважені на номінальну ставку до SS+SP
Тип SNO      - до першого з рахунків основної заборгованості, з можливістю подальшого коригування.
Тип SNA      - в питомій вазі зважені на номінальну ставку до балансової вартості кожного з окремих субдоговорів.
Тип SDI, SPI - розподіляємо пропорційно до залишків на рахунках SS+SP (якщо рахунок один для випадку мультивалютної лінії, розділяється в єквіваленті).

Балансові рахунки  3578/3579/8999/9129 необхідно залишити без розподілу, прив’язаними до генеральної угоди.
-    для продукту відновлювальні кредитні лінії, залишки по рахункам типу S36 повинні залишитися в незмінному стані прив'язані до генеральної угоди без розподілу по субдоговорах;
-    для продукту невідновлювальні кредитні лінії сума залишку на рахунку з типом S36, розподіляється пропорційно сумі залишків на рахунках основної заборгованості (тип рахунку SS) та  залишку на рахунку невикористаного лімиту (тип рахунку CR9). Частина, що пропорційна до рахунків SS,  розподіляється по рахункам неамортизованого дисконту (тип рахунку SDI) кожного субдоговору пропорційно до залишку основної заборгованості кожного з субдоговорів, а частина, що пропорційна до невикористаного лімиту, залишається на рахунку типу S36 , який повинен бути прив'язаний до генерального договору.

S36 (доходи майбутніх періодів ) БР 3600  (ОБ 22 09, 10).
- для відновлювальнї   КЛ залишки по S36 повинні залишитися прив'язані  до генеральної угоди без розподілу по субдоговорах (аналог комісій);
- для НЕвідновлювальні КЛ залишки по  S36 
  розподіляється пропорційно сумі залишків SS+CR9. 
    Частина, що пропорційна до рахунків SS, розкидається по рахункам SDI 
             кожного субдоговору пропорційно до залишку основної заборгованості кожного з субдоговорів, 
    а частина, що пропорційна CR9, залишається на рахунку типу S36,  який повинен бути прив'язаний до генерального договору.
*/
----------------------------
function Get_NLS  ( p_KV int, p_B4 varchar2) return varchar2 is     nTmp_ number;     l_NLS accounts.nls%type;
begin 
   While 1<2     
   loop  nTmp_ := trunc(dbms_random.value(1, 999999999));       l_NLS :=p_B4||'_'||nTmp_ ;  
         begin select 1 into nTmp_ from accounts where nls like l_NLS and kv = p_KV ;
         EXCEPTION WHEN NO_DATA_FOUND THEN  return vkrzn ( substr(gl.aMfo,1,5) , l_NLS ) ;
         end ;
   end loop  ;
end Get_Nls  ;
--------------
procedure insN (p_nd number, p_acc number) is
begin
   begin  insert into nd_acc_old (nd,acc) values ( p_nd, p_acc ) ; 
   exception when others then   if SQLCODE = -00001 then null ; else raise; end if;  
   end;
end insN;

procedure opl (oo IN OUT oper%rowtype ) is
begin If oo.s = 0 then RETURN; end if;
   If oo.ref is null then gl.ref (oo.REF);
      gl.in_doc3 (ref_ => oo.REF  , tt_  => oo.tt  , vob_ => oo.vob ,   nd_ =>oo.nd   , pdat_=>SYSDATE, vdat_ =>oo.vdat , dk_ =>oo.dk,
                   kv_ => oo.kv   , s_   => oo.S   , kv2_ => oo.kv2 ,   s2_ =>oo.S2   , sk_  => null  , data_ =>gl.BDATE,datp_=>gl.bdate,
                nam_a_ => oo.nam_a,nlsa_ => oo.nlsa,mfoa_ => oo.Mfoa, nam_b_=>oo.nam_b,nlsb_ =>oo.nlsb, mfob_ =>oo.Mfob ,
                 nazn_ => oo.nazn ,d_rec_=> null   ,id_a_ => oo.id_a, id_b_ =>oo.id_b ,id_o_ =>null   , sign_ =>null,sos_=>1,prty_=>null,uid_=>null);
   end if; 
   gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa , oo.s, oo.kv2    ,oo.nlsb, oo.s2);
   update opldok set txt = oo.d_rec where ref = oo.ref and stmt = gl.aStmt;
   gl.pay (2, oo.ref, oo.vdat);  -- по фапкту
end opl ;
----------------
procedure REGU ( p_nd number, p_KV INT ) is   -- Урегулювати (Об`єднати/Розділити )
  l_txt varchar2 (250);
  kol_SS  int ;
  l_val params$global.val%type := '1' ;  l_par params$global.par%type := 'MSFZ9' ;
begin  

  begin select  val into l_val from params$global where par = l_par and val = l_val ;
  exception when no_data_found then raise_application_error(-20000, 'Глоб.парам *** ще не включено');
  end ;
  ------------------------------
  select count (*) into kol_ss from accounts where tip ='SS' and dazs is null and acc in (select acc from nd_acc where nd = p_nd);
  l_txt := 'MSFZ9:Не знайдено не-валідний КД='|| p_nd ;
  If kol_ss < 2 then 
     raise_application_error(-20333, l_txt );
--   bms.enqueue_msg( l_Txt, dbms_aq.no_delay, dbms_aq.never, gl.auid  );   bars_audit.info( l_Txt );   RETURN;
  end if ;
  
  For dd in (select * from v_MSFZ91 where nd = p_nd)
  loop 
     If FALSE then null ;
     elsIf dd.ss  > 1 and dd.ss1 = 0 then  raise_application_error(-20333,'MSFZ9:2. 0-сума тіла КД=' || dd.ND || ' вал.'|| dd.kv);
   --ElsIf dd.ss1 = 0 and dd.sp1 = 0 then  raise_application_error(-20333,'MSFZ9:2. 0-сума тіла КД=' || dd.ND || ' вал.'|| dd.kv);
   --ElsIf dd.ss <  2 then MSFZ9.step_1 ( DD ) ;  pul.put('ND',dd.nd);
     elsIf dd.ss >= 1 then MSFZ9.step_2 ( DD ) ;  pul.put('ND',dd.nd);
     else  null; -- raise_application_error(-20333,'MSFZ9.REGU:Відсутні рах.SS та SP в КД=' || dd.ND || ' вал.'|| dd.kv);
     end if ;
  end loop ;
end REGU ; 
--------------

procedure step_1 ( DD v_MSFZ9%rowtype ) is
  -- Власне бізнес-логіка Об`єднання  для 1 КД = dd.ND
  l_dazs date ;   aa accounts%rowtype;  cc customer%rowtype;  oo oper%rowtype ; 
begin oo.tt   := '024';  oo.vob  := 6 ;  oo.mfoa := gl.aMfo ;  oo.mfob := gl.aMfo  ;   l_dazs  := DAT_NEXT_U ( gl.bdate, 1) ; oo.vdat := gl.bdate ;
  l_dazs := DAT_NEXT_U (gl.bdate,1);
  -- поиск RNK
  begin select * into cc  from customer where rnk = dd.rnk ;
  exception when no_data_found then raise_application_error( -20333,'MSFZ9:1.Не знайдено Клієнта з РНК Д='|| dd.rnk);
  end;
  oo.nd   := substr(dd.cc_id,1,10);  oo.id_a := cc.okpo;   oo.id_b := cc.okpo;
  oo.nazn := 'Згортання однорідних рахунків по КД № '|| dd.cc_id; 

  for bb in (select a.* 
             from accounts a, nd_acc n   
             where n.nd = dd.ND and n.acc=a.acc and a.dazs is null  and a.kv = dd .KV  
               and (    a.tip in ('SP ', 'SN ','SPN','SNA','SDI','SPI')   
                     or a.nbs ='3600' and a.ob22  in  ('22','09','10') and a.tip = 'S36'
                    )
             order by a.tip
             )
  loop
     if NVL( aa.TIP, '***') = bb.TIP then  
        If bb.ostc <> 0 then
           if bb.ostc < 0 then oo.dk := 1    ;  oo.s    := - bb.ostc ;
           else                oo.dk := 0    ;  oo.s    :=   bb.ostc ;
           end if  ;           oo.s2 := oo.s ;  oo.nlsb :=   bb.nls  ; oo.nam_b := substr( bb.nms,1,38) ;
           MSFZ9.opl (oo) ;
        end if;
        Update accounts set dazs = l_dazs where acc = bb.acc ;
     else   aa  := bb  ;  oo.kv := aa.kv; oo.nlsa  := aa.nls ; oo.nam_a := substr( aa.nms,1,38) ;   oo.kv2  := aa.kv ; 
     end if ;
     insN ( dd.nd, bb.acc) ;
  end loop; -- bb
  update cc_deal set ndG = nd where nd = dd.nd ;
  update PRVN_FLOW_DEALS_CONST set NDo =dd.nd where nd = dd.nd and kv = dd.kv  ;
  if oo.ref is not null then gl.pay( 2, oo.ref, gl.bdate); end if ;

end step_1;
---------------
procedure step_2 ( DD v_MSFZ91%rowtype ) is  -- Власне бізнес-логіка Роз`єднання  для 1 КД = dd.ND
  a8_new accounts%rowtype ;  cc customer%rowtype ;  oo oper%rowtype    ; 
  a8_old accounts%rowtype ;
  DD_old cc_deal%rowtype ; 
  DD_new cc_deal%rowtype ; 
  rr  int_ratn%rowtype; 
  aa_old accounts%rowtype ; 
  aa_new accounts%rowtype ; 
  CA1 cc_add%rowtype ;
  z_Dat   date   ;  p4_ int ;
  min_id  number ;
  SUM_SP  NUMBER ;
  Sum_SN  number ;
  Sum_SPN number ;
  Sum_SNA number ;
  qum_SDI number ;
  qum_SPI number ;
  qum_LIM number ;
  ZNAM_SN number ; 
  ZNAM_SP number ; 
  ZNAM_BV number ;
  CHISLI  number ;
  L_KOEFF NUMBER ;
  x_acc   number ;
--------------------------------------
begin oo.tt   := '024';  oo.vob  := 6 ;  oo.mfoa := gl.aMfo ;  oo.mfob := gl.aMfo  ;    oo.vdat := gl.bdate ;
  -- поиск РНК
  begin select * into dd_old from cc_deal  where nd  = dd.nd      ;
        select * into cc     from customer where rnk = dd_old.rnk ;
        select * into CA1    from cc_add   where nd  = dd_old.nd and adds = 0 ;
        select * into A8_old from accounts where tip ='LIM' and acc in (select acc from nd_acc where nd = dd_old.ND );
        Update accounts set  pap = 3 where acc = A8_old.acc ;
  exception when no_data_found then raise_application_error( -20333,'MSFZ9:2.Не гол.реквізитів КД=' || dd.ND );
  end;
  -------------
/*
   begin select  val into l_val from params$global where par = l_par and val = l_val ;
   exception when no_data_found then raise_application_error(-20000, 'Глоб.парам *** ще не включено');
   end ;
*/
  ---------------------

  oo.nd   := substr(dd_old.cc_id,1,10) ;  oo.id_a := cc.okpo;   oo.id_b := cc.okpo;
  oo.tt    := '024';  oo.vob  := 6 ;  oo.mfoa := gl.aMfo ;  oo.mfob := gl.aMfo  ;  oo.vdat := gl.bdate ;  
  oo.nlsb  := '373959212006';
  oo.nam_b := 'xxxxxxxxxxxxxx';
 
 -- открытие и перепривязка всех счетов 
  z_dat    := add_months ( trunc(gl.bdate,'MM') , 1) ;
  for k in ( select * from PRVN_FLOW_DEALS_CONST where nd = dd_old.ND and kv = dd.kv )
  loop  PRVN_FLOW.add2 (20, k.id, z_dat, 0  ) ; end loop;
  ----------------

  -- 1) общие зaготовки по -----------------------------------------------------------------

  --    общий экв дисконта и премии по КД 
  select NVL ( sum (decode (a.tip, 'SDI', gl.p_icurval(a.kv,a.ostc,gl.bdate) , 0) )  , 0),      
         NVL ( sum (decode (a.tip, 'SPI', gl.p_icurval(a.kv,a.ostc,gl.bdate) , 0) )  , 0) 
  into qum_SDI, qum_SPI
  from  accounts a, nd_acc n  where n.nd = dd_old.ND and n.acc = a.acc and a.tip in ('SDI', 'SPI')  ;

  -- Бал.стоимость взвешенная но ном.ставку по КД + вал
  select min(v.id), NVL ( sum ( NVL(v.BV*v.IR,0) ), 0)    into min_id   , ZNAM_BV 
  from PRVN_FLOW_DEALS_CONST c, PRVN_FLOW_DEALS_VAR v 
  where c.nd = dd_old.ND  and c.kv = dd.kv and c.id = v.id and v.zdat = z_dat ;

  --Итог нач.проц. просроч.проц, 
  sum_SN  := dd.sn1  * 100 ;
  sum_spn := dd.spn1 * 100 ;
  SUM_SP  := DD.SP1  * 100 ;
  Sum_SNA := dd.SNA  * 100 ;
  select NVL(sum(a.ostc*acrn.fprocn (a.acc,0,gl.bdate)),0) into ZNAM_SN from  accounts a, nd_acc n where n.nd = dd_old.ND  and n.acc = a.acc and a.tip in ('SS ','SP ') and a.kv = dd.kv ;
  select gl.p_icurval(kv,ostc,gl.bdate) into qum_LIM from accounts a, nd_acc n where n.nd = dd_old.ND  and n.acc = a.acc and a.tip in ('LIM') ;
  select NVL(sum(a.ostc), 0)            into ZNAM_SP from accounts a, nd_acc n where n.nd = dd_old.ND  and n.acc = a.acc and a.tip in ('SS ') and a.kv = dd.kv ;

  update   cc_deal  set  ndG = nd where nd = dd_old.nd;

  oo.kv    := dd.kv ; oo.kv2 := oo.kv ;

   -- 2)  Згорнути всі зал супутніх рах -----------------------------------------------------
   for ss in (select a.*  from accounts a, nd_acc n   where  a.tip in ('SN ','SPN','SP ','SNA','SDI','SPI') 
                and a.acc= n.acc and n.nd = dd_old.ND  and dazs is null and  a.kv = dd.kv        )
   loop 
      oo.s := abs( ss.ostc);  oo.s2 := oo.s ;
      If ss.ostc < 0  then oo.dk := 0 ; 
      else                 oo.dk := 1 ; 
      end if; 
      oo.nlsa  := ss.nls;     oo.nam_a := substr(ss.nms,1,38)  ;
      oo.d_rec := 'Згорнення залишків' ; 
      opl (oo) ; -- згорнути
   end loop;
   oo.nazn    :='Розгорнення КЛ '|| dd_old.cc_id|| ' на декілька  Суб.дог по вал.'|| dd.KV ;      

   insN ( DD_old.nd, A8_old.acc);
   --3)   ---цикл по строкам КД и вал---------------------------------------------------------------------------------------
   for kk in ( select w.* , a.nls, a.ostc from PRVN_FLOW_DEALS_CONST W , accounts a where w.nd = dd_old.ND  and w.kv = dd.kv and w.acc = a.acc and a.dazs is null  
               order by  a.acc
      )
   loop
      -- открытие нового КД
      DD_new     := dd_old    ;      DD_new.ndG := dd_old.ND ;    DD_new.nd  := bars_sqnc.get_nextval('s_cc_deal')  ; 
      DD_new.vidd:= 1 ;
      INSERT INTO cc_deal values DD_new ; 
      update PRVN_FLOW_DEALS_CONST set ndo = DD_new.nd where id = kk.id ;
      CA1.nd  := DD_new.nd ;  CA1.accs := kk.acc ; CA1.kv := dd.kv ;

      If    ca1.aim < 62 then  ca1.aim :=  0 ;
      elsIf ca1.aim < 70 then  ca1.aim := 62 ;
      elsIf ca1.aim < 90 then  ca1.aim := 70 ;
      end if;

      INSERT INTO cc_add  values CA1 ;
      INSERT INTO nd_txt (nd,tag,txt) select DD_new.nd, tag, txt from nd_txt where nd = dd_old.ND  
         and tag not in  ('PR_TR' )  ;   -------------------------- Признак траншевости -----
      A8_new := A8_old;
      Op_Reg(99,0,0,0, p4_, dd_old.RNK, MSFZ9.Get_NLS(dd.KV,'8999'), dd.kv, A8_new.NMS, 'LIM', A8_new.isp, A8_new.acc);
      update accounts set nbs = null, tobo = dd_old.branch, mdate = dd_old.wdate where acc = A8_new.acc;
      cck.Ins_acc ( p_nd => DD_new.ND,  p_nls=> null, p_kv => null, p_acc=> A8_new.acc) ;
      INSERT INTO cc_sob (ND,FDAT,ISP,TXT ,otm) VALUES (DD_new.ND, gl.bDATE, gl.auid,'Вичленено в КД '|| dd_old.ND,6);
      kk.ostc :=  - kk.ostc ;
      INSERT INTO cc_lim (nd,fdat,acc,lim2,sumg, sumo ) VALUES (DD_new.ND, gl.bdate, a8_new.acc, kk.ostc, 0    , 0   ) ;
      INSERT INTO cc_lim (nd,fdat,acc,lim2,sumg, sumo ) VALUES (DD_new.nd, dd_old.WDATE, a8_new.acc, 0    , kk.ostc, kk.ostc ) ;

      update accounts set accc = A8_new.acc where acc = kk.acc   ;    insN ( DD_new.nd, A8_new.acc);

      -- 3.1) использовать основной счет SS один к одгому в КД
      insert into nd_acc(nd, acc) values ( DD_new.nd,  kk.acc ) ;   insN ( DD_new.nd, kk.acc);
      delete from nd_acc where nd = dd_old.nd and acc = kk.acc  ;   insN ( dd_old.nd, kk.acc);

      -- 3.2) SNO всегда привязываем к первому КД
      for ss in (select a.* from accounts a, nd_acc n where a.tip ='SNO' and a.acc= n.acc and n.nd = dd_old.ND  and dazs is null and  a.kv = dd.kv )
      loop  insert into nd_acc(nd, acc) values ( DD_new.nd,   ss.acc ) ;   insN ( DD_new.nd, ss.acc);
            delete from nd_acc where nd = dd_old.nd and acc = ss.acc   ;   insN ( dd_old.nd, ss.acc);
      end loop; -- SS

      -- 3.3) использовать/дооткрыть сопутствующие счета 
      for tt in (select distinct a.tip from accounts a, nd_acc n  where a.tip in ('SN ','SPN','SP ','SNA','SDI','SPI')  and a.acc = n.acc and n.nd = dd_old.ND and dazs is null and a.kv = dd.kv)
      loop
         BEGIN select a.* into aa_old from nd_acc n, accounts a where a.kv=dd.kv and n.nd=DD_old.nd and n.acc=a.acc and a.tip=tt.tip and a.dazs is null and rownum=1;
               select min (acc) into x_acc from ND_ACC_OLD WHERE  ACC = aa_old.ACC and nd <> DD_old.nd;

               If x_acc is null then  
                  -- использовать существующий 
                  insert into nd_acc(nd, acc) values  ( DD_new.nd,  aa_old.acc ) ;   insN ( DD_new.nd, aa_old.acc);
               else  ----в новом КД DD_new.nd такого типа счета еще нет 
                  -- Надо открывать новый aa.acc по образцу существующего acc
                  aa_new.nls := MSFZ9.Get_NLS(aa_old.KV,aa_old.nbs) ;
                  Op_Reg(99,0,0,0, p4_, aa_old.RNK, aa_new.nls, aa_old.kv, aa_old.NMS, aa_old.tip, aa_old.isp, aa_new.acc );
                  update accounts set tobo = dd_old.branch, mdate = aa_old.mdate, pap = aa_old.pap  where acc = aa_new.acc ;

                  Accreg.setAccountSParam(aa_new.acc, 'OB22', aa_old.ob22 ) ;
                  -- наследуем проц.карточки для новоно из существующего.
                  -- Внимание ! Их надо проверить. особенно % ставки 
                  for ii in (select * from int_accn where acc = aa_old.acc) 
                  loop begin ii.acc := aa_new.acc ;    insert into int_accn values ii;
                       exception when others then   if SQLCODE = -00001 then null ; else raise; end if;  
                       end;

                       select max(bdat) into rr.bdat from int_ratn where acc = aa_old.acc and id = ii.id and bdat <= gl.bdate ;

                       If rr.bdat is not null then 
                          select * into rr from int_ratn where acc = aa_old.acc and id = ii.id and bdat = rr.bdat ;
                          begin rr.acc := aa_new.acc ;   insert into int_ratn values rr ;
                          exception when others then   if SQLCODE = -00001 then null ; else raise; end if;  
                          end;
                       end if;

                  end loop ; -- ii по проц.карточкам счета

                  If aa_old.tip = 'SP ' then   update accounts set accc = A8_new.acc where acc = aa_new.acc ; end if ; 
                  -- надо бы заполнить доп.рекв Дата возн деб задолж
                  -- Связываем счет с новым КД DD_new.nd 
                  insert into nd_acc(nd, acc) values ( DD_new.nd,  aa_new.acc ) ; insN ( DD_new.nd , aa_new.acc);
               end if;

         EXCEPTION WHEN NO_DATA_FOUND THEN null ;
         end ;
      end loop  ; ---- TT 
   end loop ; -- kk
   -------------------------------

   for ff in ( select o.id, o.ndo, a.nls, a.kv, a.nms, a.acc ,a.tip, A.OSTC, v.BV, v.IR  
               from (select * from PRVN_FLOW_DEALS_CONST where nd = dd_old.ND and kv = dd.kv ) o,
                    (select * from PRVN_FLOW_DEALS_VAR   where ZDAT = z_dat             ) v,         nd_acc n, accounts a
               where o.id  = v.id  and a.kv  = dd.kv    and o.ndo = n.nd    and n.acc = a.acc 
                 and a.tip in  ('SN ','SPN','SP ','SNA','SDI','SPI', 'SS ', 'LIM' ) 
               order by decode( a.tip , 'SP ',1 , 'SN ',2, 'SPN', 3, 'SNA',4, 'LIM', 5, 9)              )
   loop 
      oo.nlsa  := ff.nls;  oo.nam_a := substr(ff.nms,1,38) ;  oo.kv := dd.kv; oo.kv2 := oo.kv ;
      ---1------------------------------------------------------------------------------------------
      If ff.tip = 'SP '  then oo.dk    := 1 ;  -- розгорнути  в питомій вазі до SS. Это уже посчитано в PRVN
         If   ZNAM_SP = 0   then   oo.s   := sum_sP;         sum_sP := 0 ;
         ELSE 
             select sum(a.ostc) into CHISLI from accounts a, nd_acc n  where n.nd = FF.NDO and n.acc= a.acc and a.tip in ('SS ') AND A.KV = DD.KV ;
             L_KOEFF  :=  NVL(CHISLI,0) / ZNAM_SP  ;
             oo.S     := Round (  sum_sP * L_KOEFF, 0 ) ; -- oo.s  := ff.SP; 
         END IF ;
         opl (oo) ; 
      ---2-----------------------------------------------------------------------------------------
      ElsIf ff.tip = 'SN '  then oo.dk := 1 ;  -- розгорнути  – в питомій вазі зважені на номінальну ставку до SS+SP
                                               -- Итог нач проц * (тело * % по нов.дог) / ( итог тел*% по старому дог)  
         If   ZNAM_SN = 0   then    oo.s   := sum_sn;    Sum_sn := 0 ;
         else select sum( a.ostc * acrn.fprocn(a.acc,0,gl.bdate) )     into CHISLI        from accounts a, nd_acc n  
              where n.nd = FF.NDO and n.acc= a.acc and a.tip in ('SS ','SP ') AND A.KV = DD.KV ;
              L_KOEFF  :=  NVL(CHISLI,0) / ZNAM_SN  ;
              oo.S := Round (  sum_sn * L_KOEFF, 0 ) ; 
         end if ;
         opl (oo) ;
      ---3------------------------------------------------------------------------------------------
      ElsIf ff.tip= 'SPN'  then oo.dk := 1 ; -- аналог SN
         If   ZNAM_SN = 0  then    oo.s   := sum_spn;         sum_spn:= 0 ;
         else select sum( a.ostc * acrn.fprocn(a.acc,0,gl.bdate) )    into CHISLI       from accounts a, nd_acc n  
              where n.nd = FF.NDO and n.acc= a.acc and a.tip in ('SS ','SP ') and A.KV = DD.KV ;
              L_KOEFF  :=  NVL(CHISLI,0) / ZNAM_SN  ;
              oo.S := Round (  sum_sPn * L_KOEFF, 0 ) ; 
         end if ;
         opl (oo) ;
      ---4------------------------------------------------------------------------------------------
      ElsIf ff.tip = 'SNA' and znam_BV > 0  then  oo.dk := 0 ;
         L_KOEFF  := ff.BV * ff.IR /ZNAM_BV ;
         oo.s     :=  round (Sum_SNA * L_KOEFF , 0)  ;
         opl (oo) ; -- розгорнути  – Тип SNA  - в питомій вазі зважені на ном ставку до BV кожного з окремих субдоговорів.
      ---5------------------------------------------------------------------------------------------
      ElsIf ff.tip = 'LIM' then  
         delete from saldoa where acc = ff.acc;  
         select NVL(sum(a.ostc),0) into CHISLI from accounts a, nd_acc n  where n.nd = FF.NDO and n.acc= a.acc and a.tip in ('SS ','SP ') and A.KV = DD.KV ;
         update accounts set ostc = CHISLI,  ostb = CHISLI, accc= a8_old.acc  where acc = ff.acc ; 
      ---------------------------------------------------------------------------------------------
      ElsIf ff.tip = 'SDI' then  
--    Else
         -- SDI, SPI -  пропорційно до  SS+SP (єкв).
         select sum( gl.p_icurval( a.kv, a.ostc, gl.bdate))    into CHISLI  from accounts a, nd_acc n  
         where n.nd = FF.NDO and n.acc= a.acc and a.tip in ('SS ','SP ') and A.KV = DD.KV ;

         L_KOEFF  :=  NVL(CHISLI,0) / Qum_LIM  ;


         If ff.tip = 'SDI' then oo.dk := 0 ; oo.s2 :=   qum_SDI * L_KOEFF ;
         Else                   oo.dk := 1 ; oo.s2 :=   qum_SPI * L_KOEFF ;
         end if ;

         oo.s := gl.p_Ncurval ( ff.kv, oo.s2, gl.bdate );

logger.info('ZZZ*'||  L_KOEFF  || ' := ' ||  NVL(CHISLI,0) || ' / '||  Qum_LIM || '*' || qum_SDI || '*' || oo.s2 || '*' || oo.s )  ;

         opl (oo) ; -- розгорнути -  пропорційно до  SS+SP (єкв).
      end if ; --- ff.tip = 'SP '

   end loop ; -- ff
   ---------------------------------------------------

   -- 3.4) Убрать неиспользованные сопутствующие счета 
   for ss in (select a.* from accounts a, nd_acc n where  a.tip in ('SS ', 'SN ','SPN','SP ','SNA','SDI','SPI') and a.acc=n.acc and n.nd=dd_old.ND and dazs is null and a.kv=dd.kv )
   loop   delete from nd_acc where nd = dd_old.ND and acc = ss.acc ; insN ( dd_old.nd , ss.acc); end loop;
   Update accounts set  pap = 1 where acc = a8_old.acc ;
  -----------------------

end step_2;

---Аномимный блок --------------
begin
  null;
end  ;
/
 show err;
 
PROMPT *** Create  grants  MSFZ9 ***
grant EXECUTE                                                                on MSFZ9           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MSFZ9           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/msfz9.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 