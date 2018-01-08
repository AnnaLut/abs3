
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/repo.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.REPO IS
 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1 17.06.2015' ;
/*
D:\SVN\Products\Bars\Modules\MBK\Sql\Package\Бух.модель (БАРС).doc
*/
------------------------------------------------------------------
procedure add_cp ( P_ND_MBK IN NUMBER, -- реф сделки МБК
                   p_ID_cp  IN NUMBER, -- Ид ЦБ в Абс
                   P_KOL_cp IN INT   , -- Кол ЦБ переданных в залог
                   P_sasin  IN INT     -- с правом собственности = 1. Иначе без права собственнорсти
                 )  ;
-- Добавляет информацию о ЦБ к сделке МБК=1622/1522
---==================================================================
function header_version return varchar2;
function body_version   return varchar2;
-------------------

END REPO;
/
CREATE OR REPLACE PACKAGE BODY BARS.REPO IS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=   'ver.1.1.  24.06.2015';

/*
24.06.2015 уТОЧНЕННЯ ПАРАМ РАХ 9500.09

D:\SVN\Products\Bars\Modules\MBK\Sql\Package\Бух.модель (БАРС).doc
*/
------------------------------------------------------------------
procedure add_cp ( P_ND_MBK IN NUMBER, -- реф сделки МБК
                   p_ID_cp  IN NUMBER, -- Ид ЦБ в Абс
                   P_KOL_cp IN INT   , -- Кол ЦБ переданных в залог
                   P_sasin  IN INT     -- с правом собственности = 1. Иначе без права собственнорсти
                 )  is
--Добавляет информацию о ЦБ к сделке МБК=1622/1522
  nTmp_  number;
  dd1 cc_deal%rowtype  ; ad1 cc_add%rowtype ;  vv1 CC_VIDD%rowtype  ;  ck1 cp_kod%rowtype   ;
  l_nlsm tts.nlsm%type ; oo1 oper%rowtype   ;  aa1 accounts%rowtype ;  l_kol number ;
  l_pawn CC_PAWN.pawn%type := 231  ;

begin
  begin select 1 into  nTmp_  from mbk_cp where nd = p_nd_mbk and id = p_id_cp;
        raise_application_error(-(20203), 'Укода МБК (nd='||p_ND_mbk||') вже пов`язана з ЦП (id='||p_id_cp||')' ) ;
  exception when no_data_found then null;
  end;

  begin  select * into dd1 from cc_deal where nd=p_nd_mbk;  select * into ad1 from cc_add where nd= p_nd_mbk and adds = 0;
  exception when no_data_found then raise_application_error(-(20203), 'Укода МБК (nd='||p_ND_mbk||') Не знайдена ' ) ;
  end;

  begin select * into ck1 from cp_kod where id = p_id_cp ;
  exception when no_data_found then raise_application_error(-(20203), 'Не описано ЦП  (id='||p_id_cp ||')' ) ;
  end;

  begin select * into vv1 from cc_vidd where vidd = dd1.vidd;
  exception when no_data_found then raise_application_error(-(20203), 'Не описано вид угоди  (vidd='||dd1.vidd||')' ) ;
  end;

  If ck1.datp < dd1.wdate then   raise_application_error(-(20203),
     'Дата заверш.РЕПО=' || to_char(dd1.wdate,'dd/mm/yyyy') || ' більша дати погаш.ЦП=' || to_char(ck1.datp ,'dd/mm/yyyy') ) ;
  end if;

  oo1.s := (ad1.INT_AMOUNT + ad1.S ) * 100; --На суму справедливой стоимости  ЦБ = тело кредита + проценты
  If ck1.kv <> ad1.kv then   oo1.s := gl.p_Ncurval( ck1.kv, gl.p_Icurval ( ad1.kv , oo1.s, gl.bdate ) , gl.bdate ) ;  end if;

  -- ищем контр счет для обеспечения
  begin select nls, substr(nms,1,38) into oo1.nlsb, oo1.nam_b from accounts where nbs = '9900' and kv = ck1.kv and dazs is null and rownum=1;
  exception when no_data_found then raise_application_error(-(20203), 'Не знайдено контр.рах.9900/'|| ck1.kv  ) ;
  end;

  -- параметры контр/агента
  select substr(nmk,1,38), okpo into oo1.nam_a, oo1.id_a from customer where rnk = dd1.rnk;
  oo1.nazn := 'Зарахування застави згiдно РЕПО-угоди ' || dd1.cc_id  ||  ' вiд ' || to_char(dd1.sdate, 'dd/mm/yyyy');

  -- открываем счет обеспечения
  aa1.nbs  :=  case when vv1.tipd = 1 then '9500'  else '9510' end;
  oo1.nlsa := f_newnls2( ad1.accs,  'ZAL', aa1.nbs,  dd1.rnk, null);
  Op_Reg (99, 0, 0, 0, nTmp_, dd1.rnk, oo1.nlsa, ck1.kv, oo1.nam_a, 'ZAL', gl.aUid,  aa1.acc);

  If vv1.tipd =  1 then  oo1.dk := 1 ;  -- Розмiщення 1522/01 =Кредити наданi репо. 9500/09=	отримана застава за операціями РЕПО

     -- 231	57.Державні цінні папери за операціями репо
     update PAWN_ACC set PAWN = 231,
                        MPAWN = nvl(P_sasin,0)+1 ,
                           sv = oo1.s/100 ,
                          IDZ = gl.aUid,
                          NDZ = dd1.nd,
                        SDATZ = dd1.sdate
                    where acc = aa1.acc ;

     if SQL%rowcount=0 then INSERT INTO PAWN_ACC(ACC,PAWN,MPAWN,IDZ,NDZ, SV,SDATZ) VALUES (aa1.acc, 231, nvl(P_sasin,0)+1, gl.aUid, dd1.nd, oo1.s/100,dd1.sdate); END IF;
     UPDATE cc_accp SET ND = DD1.ND WHERE acc = aa1.acc AND accs = ad1.accs ;
     if SQL%rowcount=0 then    insert into cc_accp   (acc, accs, nd) values (aa1.acc, ad1.accs, dd1.nd ); END IF;

     aa1.ob22 := '09';

  ElsIf vv1.tipd =  2 then  oo1.dk := 0 ;  -- Залучення  1622/01 =Кредити залученi репо. 9510/01=надана застава за операціями РЕПО
     aa1.ob22 := '01';
     -- а есть ли эти ЦБ ?
     select nvl( sum(a.kol), 0) into l_kol
     from (select -ostb/(ck1.cena*100) kol
           from accounts where ostb< 0 and nbs is null and acc in (select acc from cp_deal where id= p_id_cp and dazs is null ) -- это всего
           union all
           select -nvl(to_number(GET_ACCW (acc,0,null,0,'CP_ZAL',gl.bdate)),0) from cp_deal where id= p_id_cp and dazs is null   -- это уже в залоге
          ) a ;
      If l_kol < p_kol_cp then  raise_application_error(-(20203), 'Недостатня кількість ЦП '|| l_kol || ' < ' || p_kol_cp  ) ;    end if;
  else return ;
  end if;

  update specparam_int set ob22 = aa1.ob22 where acc = aa1.acc;
  if SQL%rowcount = 0 then  insert into specparam_int (acc, ob22) values (aa1.acc, aa1.ob22);  end if ;
  insert into nd_acc (nd,acc) values (dd1.nd, aa1.acc);

  gl.ref( oo1.ref);
  gl.in_doc3 (oo1.ref, 'ZAL', 6, substr(dd1.cc_id,1,10) , sysdate, gl.bdate, oo1.dk, ck1.kv, oo1.s, ck1.kv, oo1.s, null , gl.bdate, gl.bdate,
              oo1.nam_a, oo1.nlsa, gl.amfo, oo1.nam_b, oo1.nlsb, gl.amfo, oo1.nazn, null, oo1.id_a, gl.aOkpo, null,null, 0,null, null);
  gl.payv( 0, oo1.ref, gl.bdate , 'ZAL', oo1.dk, ck1.kv, oo1.nlsA, oo1.s, ck1.kv, oo1.nlsB, oo1.s);
  gl.payv( 0, oo1.ref, dd1.wdate, 'ZAL', oo1.dk, ck1.kv, oo1.nlsB, oo1.s, ck1.kv, oo1.nlsA, oo1.s);

  insert into mbk_cp (ND, ID, KOL, sasin, ref, acc, tipd) values ( P_ND_MBK, p_ID_cp, P_KOL_cp, P_sasin, oo1.ref, aa1.acc, vv1.tipd  ) ;

  If vv1.tipd =  2 then
     l_kol := p_kol_cp;
     for k in ( select a.acc, a.ostc, nvl( GET_ACCW (a.acc,0,null,0,'CP_ZAL',gl.bdate), 0) zal, d.ref
                from accounts a, cp_deal d  where a.ostc< 0 and a.acc= d.acc and d.id = p_id_cp
                order by d.ref  )
     loop
        If l_kol = 0 then EXIT;  end if;
        ---------------------------------
        -- надо еще заложить 12 шт
        nTmp_ := -k.ostc/(ck1.cena*100) - k.zal;  -- 10 - 3 = 7
        If nTmp_ >= 1 then
           nTmp_ := least ( nTmp_, l_kol); -- least ( 7, 12) = 7
           l_kol := l_kol - nTmp_;         -- 12 -7 = 5
           nTmp_ := k.zal + nTmp_;         -- 3 + 7 =100
           -- блокировать ЦБ  с сегодняшней даты
           SET_ACCW (p_acc =>k.acc,  ----Счет        :  Приоритетный ключ поиска
                     p_kv  => null,  --\             :  Альтернативный ключ поиска
                     p_nls => null,  --/
                   p_PARID => 0 ,  ---Доп.реквизит :  Приоритетный ключ поиска
                     p_tag =>'CP_ZAL',  ---             :   Альтернативный ключ поиска
                     p_dat => gl.bdate,  ---дата Применения
                     p_val => to_char(nTmp_)   -- Значение доп.рекв
                   ) ;

           -- Разблокировать ЦБ после завершения репо МБК
           SET_ACCW (p_acc =>k.acc,  ----Счет        :  Приоритетный ключ поиска
                     p_kv  => null,  --\             :  Альтернативный ключ поиска
                     p_nls => null,  --/
                   p_PARID => 0 ,  ---Доп.реквизит :  Приоритетный ключ поиска
                     p_tag =>'CP_ZAL',  ---             :   Альтернативный ключ поиска
                     p_dat => dd1.wdate + 1 ,  ---дата Применения
                     p_val => to_char(k.zal)   -- Значение доп.рекв
                    ) ;

           update operW set value = dd1.nd where ref = k.ref and tag = 'ND'; if SQL%rowcount=0 then insert into operW (ref,tag,value) values (k.ref,'ND',dd1.ND);  end if;

           If P_sasin = 1 then
               null ;        -- жду уточнения бух/мод из ОБ. Через ДИ Кавчак
           end if;
        end if;
     end loop;  -- k

  end if; --   If vv1.tipd =  2 then

end add_cp;

---==================================================================
function header_version return varchar2 is begin  return 'Package header REPO '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body REPO '  ||G_BODY_VERSION  ; end body_version;
--------------

---Аномимный блок --------------
begin
  null;
END REPO;
/
 show err;
 
PROMPT *** Create  grants  REPO ***
grant EXECUTE                                                                on REPO            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REPO            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/repo.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 