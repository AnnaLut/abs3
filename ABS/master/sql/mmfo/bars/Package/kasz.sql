
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/kasz.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.KASZ IS

 --17.02.2012 Sta Тестирование на Винн РУ
 --19.01.2012 Sta Вынесла в гл.пар кассу хранилища
 SX_BRN accounts.BRANCH%type ; --param('SX_BRN');
 SX_NBS accounts.NBS%type    ; --param('SX_NBS'=1001,1101);
--------- проверка на нерозменную монету

PROCEDURE CEL_MON ( KV_ accounts.kv%type, S_ oper.S%type);

--------- проверка на дату2 и сумму заявки
PROCEDURE PDAT2
(p_vid       kas_z.vid%type,
 p_DAT2s     varchar2,
 p_s         kas_z.s%type,
 p_DAT2d OUT kas_z.DAT2%type
) ;

--------- проверка на наличие счетов для заявок
PROCEDURE NLS1
 ( KV_   accounts.kv%type       ,
   Bran_ accounts.branch%type   ,
   NBS7_ accounts.nbs%type      ,
   OB7_  accounts.OB22%type,
   NBS1_ accounts.nbs%type      ,
   OB1_  accounts.OB22%type ,
   NBS2_ accounts.nbs%type      ,
   OB2_  accounts.OB22%type
  ) ;

--------- принять кассу в бранче. Записать реф-Б в заявку
PROCEDURE GET_K (p_idz kas_z.IDZ%type, p_REFA oper.REF%type ) ;

--------- Захватить заявки на рассмотрение.
PROCEDURE LOCK1 ( p_IDM kas_m.IDM%type, p_DAT2 kas_z.DAT2%type );

--------- Поменять статус заявки
procedure UPD_SOS (p_Sos kas_z.SOS%type, p_Idz kas_z.IDZ%type );

--------- Поменять реквизиты (сумма, кол, № сумки и сохранить промежуточно)
procedure UPD_KASZ
(p_Idz kas_z.IDZ%type,
 p_IDS kas_z.IDs%type,
 p_S   kas_z.s%type,
 p_Kol kas_z.kol%type
);

--------- Оплатить заявку в схoвище в дорогу
procedure OPL1
( p_DatF    date,
  P_IdZ     kas_z.idz%type ,
  p_IdS     kas_z.ids%type ,
  p_S1      kas_z.s%type   ,
  P_K2      kas_z.kol%type ,
  P_K3      kas_z.kol%type ,
  P_K4      kas_z.kol%type ,
  p_REF out kas_z.refa%type
  ) ;

--------- склеить инкасаторов одного маршрута в одну символьную строку
function list_collector (p_idm number) return varchar2;

function SX (tag_ varchar2 ) return varchar2;

--------------

END KASZ;
/
CREATE OR REPLACE PACKAGE BODY BARS.KASZ IS

NLS_1001 oper.NLSA%type ;
NMS_1001 oper.NAM_A%type;
NLS_1007 oper.NLSA%type ;
NMS_1007 oper.NAM_A%type;
NLS_1002 oper.NLSA%type ;
NMS_1002 oper.NAM_A%type;

--------- проверка на нерозменную монету
PROCEDURE CEL_MON ( KV_ accounts.kv%type,  S_  oper.S%type) is
  Mon_  int := 1;
  name_ tabval.name%type;
begin
  select nvl(coin,1), name into MON_,name_ from tabval where kv= KV_;

  If mod(S_,MON_) <>0 then
     raise_application_error(-20100,
     'Нерозмiнний залишок для '||KV_||'
      '|| name_|| '='||MON_/100 );
  end if;

end CEL_MON;

--------- проверка на дату2 и сумму( заявки
PROCEDURE PDAT2
(p_vid       kas_z.vid%type,
 p_DAT2s     varchar2,
 p_s         kas_z.s%type,
 p_DAT2d OUT kas_z.DAT2%type
) is

  l_date date;
begin

  p_DAT2d := nvl ( to_date(p_DAT2s,'dd/mm/yyyy'),  gl.bdate  + 1);
  l_date  := least(gl.bdate, trunc(sysdate));

If to_number( to_char (p_DAT2d,'yyyy')  ) < 2011 then
   p_DAT2d:= to_date ( '20'||to_char(p_DAT2d,'yymmdd'),'yyyymmdd');
end if;


  iF p_DAT2d < l_date THEN
     raise_application_error(-20100,
     'ПОМИЛКА !
      Дата поставки='          || TO_CHAR( P_DAT2d, 'DD.MM.YYYY' ) || '
      и д.б. БОЛЬШЕ или РАВНА реальной=' || TO_CHAR( l_date , 'DD.MM.YYYY' ) );
--      || '**'||P_DAT2S );
  END IF;


  iF Nvl(p_s,0) <=0 THEN
      raise_application_error(-20100,'Не указано суму !');
  END IF;

  RETURN;

end PDAT2;

--------- проверка на наличие счетов для заявок
PROCEDURE NLS1
 ( KV_   accounts.kv%type       ,
   Bran_ accounts.branch%type   ,
   NBS7_ accounts.nbs%type      ,
   OB7_  accounts.OB22%type,
   NBS1_ accounts.nbs%type      ,
   OB1_  accounts.OB22%type ,
   NBS2_ accounts.nbs%type      ,
   OB2_  accounts.OB22%type
  ) is
 sBr_ branch.branch%type;
BEGIN

  begin
    -- дорога
    sBr_ :=Substr(bran_,1,15);
    select  a.nls, substr(a.nms,1,38) into NLS_1007, NMS_1007
    from accounts a
    where a.nbs = NBS7_ and a.kv   = kv_  and a.branch=sBr_ and a.dazs is null
      and a.ob22 = OB7_ and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100,
     'Вiдсутнiй '||nbs7_||'/'||KV_||'('||OB7_||') '||sBr_);
  end;

  begin
    -- центральное хранилище
    select a.nls, substr(a.nms,1,38) into NLS_1001, NMS_1001
    from accounts a
    where a.nbs = NBS1_ and a.kv   = kv_  and a.branch=KASZ.SX_BRN and a.dazs is null
      and a.ob22 = OB1_ and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100,
       'Вiдсутнiй '||nbs1_||'/'||KV_||'('|| OB1_ ||') '|| KASZ.SX_BRN );
  end;

  begin
    -- касса бранча
    sBr_ := BRAN_;
    select a.nls, substr(a.nms,1,38)  into NLS_1002, NMS_1002
    from accounts  a
    where a.nbs = NBS2_ and a.kv   = kv_  and a.branch=sBr_ and a.dazs is null
      and a.ob22 = OB2_ and rownum=1;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100,
    'Вiдсутнiй '||nbs2_||'/'||KV_||'('|| OB2_ ||') '|| sBr_ );
  end;
END NLS1;

--------- принять кассу в бранче. Записать реф-Б в заявку
PROCEDURE GET_K
(p_idz kas_z.IDZ%type, p_REFA oper.REF%type ) is
begin
 update kas_z
   set refb = gl.aRef ,
       sos  = 3
  where idz=p_IDZ and refa=p_REFA and refb is null;

 if SQL%rowcount = 0 then
    raise_application_error(-20100,'Вiдсутня касова заявка №'||p_idz);
 end if;

end GET_K;

--------- Захватить заявки на рассмотрение.
PROCEDURE LOCK1 ( p_IDM kas_m.IDM%type, p_DAT2 kas_z.DAT2%type ) is

/*

Матрица вариантов (Шарадов 30-11-2010)
--------------------------------------------------------------------------
Нет закрепленных сумок           | Пусто
--------------------------------------------------------------------------
Одна сумка                       | Все заявки закрепляем за этой сумкой
--------------------------------------------------------------------------
Две сумки одинакового типа       | Пусто
--------------------------------------------------------------------------
Одна сумка типа грн.             |
И                                |
одна сумка типа вал              | Закрепляем за со ответ- типом заявки
--------------------------------------------------------------------------
*/

  l_IDS  kas_u.IDS%type;
  l_kol  int;
begin
  for k in (select * from KAS_Z
            where sos = 0
            and DAT2 >=gl.bdate
            and DAT2 <= p_Dat2
            and BRANCH in ( select branch from kas_b where idm =p_IDM )
            )

  loop
     -- общее кол-во сумок в бранче
     select count(*), min(u.ids) into  l_kol, l_IDS
     from kas_bu b, kas_u u
     where u.d_clos is null and u.ids=b.ids and b.branch= k.branch ;

     If    l_kol = 0 then    /*  Нет закрепленных сумок  */ l_IDS := null;
     ElsIf l_kol = 1 then    /*  Одна сумка              */  null ;
     else
        --  кол-во сумок данного типа в бранче
        select count(*), min(u.ids) into  l_kol, l_IDS
        from kas_bu b, kas_u u
        where u.d_clos is null and u.ids=b.ids and b.branch= k.branch
          and u.vids = decode( nvl(k.kv,980),980,0,1);

        If    l_kol = 0 then  /*  все сумки другого типа  */ l_IDS := null;
        ElsIf l_kol = 1 then  /*  1-на сумка нужного типа */  null ;
        else                                                 l_IDS := null;
        end if;

     end if;

     UPDATE KAS_Z  set sos = 1, IDM = p_IDM, ids = l_IDS  where idz = k.IDZ;

  end loop;

  RETURN;

end LOCK1;

--------- Поменять статус заявки
procedure UPD_SOS (p_Sos kas_z.SOS%type, p_Idz kas_z.IDZ%type ) is
begin
  UPDATE kas_z set sos= p_sos  where idz = p_Idz ;
end UPD_SOS ;

--------- Поменять реквизиты (сумма, кол, № сумки и сохранить промежуточно)
procedure UPD_KASZ
(p_Idz kas_z.IDZ%type,
 p_IDS kas_z.IDs%type,
 p_S   kas_z.s%type,
 p_Kol kas_z.kol%type
) is

  l_vid kas_z.vid%type;
  l_s0  kas_z.s0%type ;
  l_k0  kas_z.k0%type ;
  l_s   kas_z.s%type  ;
  l_kol kas_z.kol%type;

begin

 begin

   select   vid,   s0,   k0,   s, kol
   into   l_vid, l_S0, l_K0, l_s, l_kol
   from kas_z
   where idz=p_IDZ FOR UPDATE OF sos NOWAIT;

   If l_s0 is null and l_k0 is null then
      update kas_z set s0 = s, k0 = kol where idz = p_iDZ;
   end if;

   update kas_z set s   = p_s ,
                    kol = p_kol,
                    ids = p_IDS
    where idz = p_iDZ;

 EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100,'заявка '|| p_idz || '  занята' );
 end;

end UPD_KASZ;

--------- Оплатить заявку в схoвище в дорогу
procedure OPL1
( p_DatF    date,
  P_IdZ     kas_z.idz%type ,
  p_IdS     kas_z.ids%type ,
  p_S1      kas_z.s%type   ,
  P_K2      kas_z.kol%type ,
  P_K3      kas_z.kol%type ,
  P_K4      kas_z.kol%type ,
  p_REF out kas_z.refa%type
  ) is
-------------------------------
   l_branch  kas_z.branch%type;
   l_IdM     kas_m.idm%type   ;
   l_kv      kas_z.KV%type    ;
   l_Vid     kas_z.vid%type   ;
   l_kodv    kas_z.kodv%type  ;
   l_namv    varchar2(80)     := null ;
   l_dat2    kas_z.dat2%type  ;
   l_Kol     kas_z.kol%type   ;
-------------------------------
   Ref_    oper.REF%type ;
   l_Nazn  oper.NAZN%type;
   l_Nazn1 oper.NAZN%type;
   l_S     oper.VOB%type ;
   l_TT    oper.TT%type  ;
   l_Vob   oper.VOB%type ;
   l_Sk    oper.SK%type  ;
----------------------------------
   l_Nbs7 accounts.NBS%type      ;
   l_Ob7  accounts.ob22%type;
   l_Nbs1 accounts.NBS%type      ;
   l_Ob1  accounts.ob22%type;
----------------------------------

begin

  begin
     select z.branch, z.idm, nvl(z.kv,gl.baseval), z.vid , z.dat2, z.kodv
     into   l_branch, l_IdM,     l_kv,             l_Vid , l_dat2, l_KODV
     from kas_z z  where z.idz= p_IDZ ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    raise_application_error(-20100,'Не знайдено заявку '|| p_idz );
  end;

  l_S     := p_s1  * 100 ;
  l_TT    := '1KA';
  l_Vob   := 222  ;
  l_Sk    := 66   ;
  l_Ob1   := '01';

  l_Nazn1 := ' ТВБВ ' || substr(substr(l_branch,-5),1,4) ||
             ' згiдно авансової заявки № ' || p_IdZ;

  If l_VID = 1 then     If l_S <= 0 then RETURN; end if;

     l_Nazn := 'Пiдкрiплення готiвкою' || l_Nazn1;
     KASZ.CEL_MON ( l_Kv, l_S);

     If l_Branch like '%/000000/' or  l_Branch like '%/000000/060000/'   then
        KASZ.NLS1 ( l_kv, l_Branch, '1007',l_Ob1, KASZ.SX_NBS,l_Ob1, '1001',l_Ob1 );
     else
        KASZ.NLS1 ( l_kv, l_Branch, '1007',l_Ob1, KASZ.SX_NBS,l_Ob1, '1002',l_Ob1 );
     end if;
  ElsIf l_vid = 2 then   If l_S <= 0 then RETURN; end if;

     l_Kol  := p_K2 ;
     l_Nazn := 'Пiдкрiплення виробами з БМ' || l_Nazn1;
     begin
       select substr(name,1,80), substr('00'||type_,-2)   into l_namv , l_Ob1
       from BANK_METALS where to_char(kod)=l_kodv;
     EXCEPTION WHEN NO_DATA_FOUND THEN l_namv := null;
     end;

     If l_Branch like '%/000000/' or  l_Branch like '%/000000/060000/'   then
        KASZ.NLS1 ( l_kv, l_Branch , '1107',l_Ob1,
                                     '110'||substr(SX_NBS,4,1), l_Ob1,
                                     '1101',l_Ob1 );
     else
        KASZ.NLS1 ( l_kv, l_Branch , '1107',l_Ob1,
                                     '110'||substr(SX_NBS,4,1), l_Ob1,
                                     '1102',l_Ob1 );
     end if;


  ElsIf l_vid = 3 then

     l_Kol  := p_K3 ;
     l_Nazn := 'Пiдкрiплення юв.монетами ТВБВ' || l_Nazn1;
     begin
       select substr(NAMEMONEY,1,80) into l_namv
       from spr_mon where to_char(KOD_MONEY) =l_kodv;
     EXCEPTION WHEN NO_DATA_FOUND THEN l_namv := null;
     end;

     If l_s > 0  then
        --  З плат.номiналом
        If l_Branch like '%/000000/' or  l_Branch like '%/000000/060000/'   then
           KASZ.NLS1 ( l_kv, l_Branch, '1007',l_Ob1, KASZ.SX_NBS,l_Ob1, '1001',l_Ob1 );
        else
           KASZ.NLS1 ( l_kv, l_Branch, '1007',l_Ob1, KASZ.SX_NBS,l_Ob1, '1002',l_Ob1 );
        end if;

     elsIf p_K3 >0 then

        -- БЕЗ пл.ном_налу !!!!!!!!!!!!!!! ВИЯСНИТИ у методолог_в 981932 -> 17
        l_s    :=  p_K3 * 100;
        l_TT   := '9KA' ;
        l_Vob  :=  121  ;
        l_Nbs7 := '9899';
        l_Ob7  := '17'  ;
        l_Nbs1 := '9819';
        l_Ob1  := '32'  ;
        KASZ.NLS1(gl.baseval,l_Branch, '9899','17', '9819','32', '9819','32');
     else
        RETURN;
     end if;

  ElsIf l_vid = 4 and p_K4 >0 then

     l_Kol  := p_K4 ;
     l_Nazn := 'Пiдкрiплення позабал.цiнностями' || l_Nazn1;
     l_s    := p_k4 * 100;
     l_TT   := '9KA' ;
     l_Vob  := 121   ;
     l_Nbs1 := Substr(l_KODV,1,4);
     l_Ob1  := Substr(l_KODV,5,2);

     begin
        select substr(NAME,1,80),
               decode (l_Nbs1,'9821','9893','9820','9891','9899'), ob22_dor
        into l_namv, l_Nbs7, l_Ob7
        from valuables  where ob22 = l_KODV;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        raise_application_error(-20100,'Не знайдено ОБ22 дороги пiд заявку '|| p_idz );
     end;

     KASZ.NLS1(gl.baseval,l_Branch, l_Nbs7,l_Ob7, l_Nbs1,l_Ob1, l_Nbs1,l_Ob1);

  else
     RETURN;
  end if;

  If l_S <=0 then RETURN; end if;
  --------------------------------
begin
  -- Стать на уровань хранилища
  bc.subst_branch ( KASZ.SX_BRN ) ;
  gl.ref (REF_);
  gl.in_doc3(ref_   => REF_ ,
             tt_    => l_TT ,
             vob_   => l_VOB,
             nd_    => to_char(p_idz),
             pdat_  => SYSDATE ,
             vdat_  => nvl(p_DatF,l_dat2),
             dk_    => 1,
             kv_    => l_kv ,
             s_     => l_S  ,
             kv2_   => l_kv ,
             s2_    => l_S  ,
             sk_    => l_sk ,
             data_  => nvl(p_DatF,l_dat2),
             datp_  => gl.bdate,
             nam_a_ => NMS_1007,
             nlsa_  => NLS_1007,
             mfoa_  => gl.aMfo,
             nam_b_ => NMS_1001,
             nlsb_  => NLS_1001,
             mfob_  => gl.aMfo,
             nazn_  => l_nazn,
             d_rec_ => null,
             id_a_  => gl.aOkpo,
             id_b_  => gl.aOkpo,
             id_o_  => null,
             sign_  => null,
             sos_   => 1,
             prty_  => null,
             uid_   => null);
  gl.payv (  flg_   => 0,
             ref_   => REF_ ,
             dat_   => nvl(p_DatF,l_dat2),
             tt_    => l_TT ,
             dk_    => 1    ,
             kv1_   => l_kv ,
             nls1_  => NLS_1007,
             sum1_  => l_s   ,
             kv2_   => l_kv  ,
             nls2_  => NLS_1001,
             sum2_  => l_S   );
   bc.set_context;
exception when others then
   -- вернуться в свою область видимости
   bc.set_context;
   -- исключение бросаем дальше
   raise_application_error(-20000, SQLERRM||chr(10)
      	||dbms_utility.format_error_backtrace(), true);
end;
--

  UPDATE kas_z  set sos=2, ids=p_ids, refa=REF_, nlsb=NLS_1002  where idz=p_idz;
  -- Доп.реквизиты

  -- INK_M) номер маршрута
  INSERT into operw(ref,tag,value)
         select REF_,'INK_M',m.NAME  from kas_m m where m.idm = l_IDM;

  -- INK_N) номер сумки
  INSERT into operw(ref,tag,value)
         select REF_,'INK_S',s.NOMS  from kas_u s where s.ids = p_IDS;

  for i in (select rownum RN,FIO,PASP,
                   DOCS||' '||docn ser_nom,to_char(ATRT_2,'dd.mm.yyyy') dat_vid , ATRT_1
            from kas_F f
            where exists (select 1 from kas_mf m where m.id=f.id and m.idm=l_IDM)
              and rownum<=3)
  loop

     If i.RN = 1 then
        -- По первому инкассатору
        If l_TT = '1KA' then
           INSERT into operw(ref,tag,value) values (REF_, 'FIO'  , i.FIO);
        else
           INSERT into operw(ref,tag,value) values (REF_, 'VLASN', i.FIO);
        end if;
        INSERT into operw(ref,tag,value) values (REF_,'PASP' ,i.PASP    );
        INSERT into operw(ref,tag,value) values (REF_,'PASPN',i.ser_nom );
        INSERT into operw(ref,tag,value) values (REF_,'ATRT' ,i.dat_vid||' '||i.ATRT_1 );
     elsif i.RN = 2 then
        -- По второму инкассатору
        INSERT into operw(ref,tag,value) values (REF_,'FIO2' ,i.FIO     );
		INSERT into operw(ref,tag,value) values (REF_,'PASPS',i.PASP||' серії '||i.ser_nom||' виданий '||i.dat_vid||' '||i.ATRT_1 );
      --  INSERT into operw(ref,tag,value) values (REF_,'PASPS',i.ser_nom );
      --  INSERT into operw(ref,tag,value) values (REF_,'PASP2',i.dat_vid );
    else
        -- По 3 инкассатору
        INSERT into operw(ref,tag,value) values (REF_,'FIO1' ,i.FIO     );
        INSERT into operw(ref,tag,value) values (REF_,'PASP1',i.PASP||' серії '||i.ser_nom||' виданий '||i.dat_vid||' '||i.ATRT_1 );
     --   INSERT into operw(ref,tag,value) values (REF_,'PASP2',i.dat_vid );
     end if;

  end loop;

  KASZ.UPD_KASZ (p_Idz, p_IDS , p_S1, l_Kol );

  -- Нужно GOLD, SUMGD, OSumm, SUMGD
  If l_namv is not null then
     INSERT INTO operw (ref, tag,value ) VALUES (REF_,'GOLD ',l_namv         );
     INSERT INTO operw (ref, tag,value ) VALUES (REF_,'SUMGD',l_Kol || '.00' );
  end if;

end OPL1;

--------- склеить инкасаторов одного маршрута в одну символьную строку
function list_collector (p_idm number) return varchar2 is
 l_ret varchar2(500) := null;
begin
 for k in (select fio from kas_F f
           where exists (select 1 from kas_Mf m where m.id=f.id and m.idm=p_idm)
          )
 loop
    l_ret := substr(l_ret || k.fio || ', ', 1, 500);
 end loop;
 return l_ret;
end list_collector;
-----------

function SX (tag_ varchar2 ) return varchar2 is
begin
  if tag_ = 'BRN' then return KASz.SX_BRN; end if;
  if tag_ = 'NBS' then return KASz.SX_NBS; end if;

end SX;



BEGIN /* анонимный блок */

/* глоб.переменные:
 SX_BRN accounts.BRANCH%type ; --param('SX_BRN');
 SX_NBS accounts.NBS%type    ; --param('SX_NBS');
*/

 begin
   select substr(trim(val),1,15) into SX_BRN from params where par='SX_BRN';
 EXCEPTION WHEN NO_DATA_FOUND THEN SX_BRN:= '/' || gl.aMFO || '/000000/';
 end;

 begin
   select substr(trim(val),1,4) into SX_NBS from params where par='SX_NBS';
 EXCEPTION WHEN NO_DATA_FOUND THEN  SX_NBS:='1001';
 end;

END KASZ;
/
 show err;
 
PROMPT *** Create  grants  KASZ ***
grant EXECUTE                                                                on KASZ            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KASZ            to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/kasz.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 