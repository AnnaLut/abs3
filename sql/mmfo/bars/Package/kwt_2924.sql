 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/kwt_2924.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.KWT_2924 IS

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.4.3 19.04.2018';

/*
 добавлено АТМ
 Пакедж по квитовке счетов 2924
*/
---================================================================
procedure DEL_ATM3 (p_acc number) ; -- Очистка План-Частка~суми заг.плат
procedure UPD3     (p_acc number, p_REF1 number, p_Del number, p_S3 number ) ; -- План-Частка~суми заг.плат
procedure CLS_ATM  ( p_DAT date,    p_acc  number , p_pap int );
procedure DEL_ATM2 ( p_REF1 number, p_REF2 number ) ;
procedure DEL_ATM1 ( p_ACC  number, p_REF1 number ) ;
procedure INS_ATM1 ( p_ACC  number, p_REF1 number ) ;
procedure INS_ATM2 ( p_ACC  number, p_REF1 number , p_REF2 number) ;

--------------------------------------------------
procedure RR( p_mode int, p_acc number, p_s number, p_ref number ) ;
PROCEDURE MAX_DAT  ; -- определение ьфлсимальной даты квитовки и установка  ее в пул
PROCEDURE KWT_DAT  ( p_mode int, p_bDAT date) ;  -- обавити в календар по банк- дату
PROCEDURE KWT_ALL  ( p_mode int, p_DAT date) ;  -- квитовка всех
PROCEDURE KWT_ob22 ( p_mode int, p_DAT date, p_ob22 accounts.ob22%type) ;  -- квитовка по об22
PROCEDURE KWT_acc  ( p_mode int, p_DAT date, p_kv int, p_nls varchar2, p_acc number) ;  -- квитовка по acc
PROCEDURE KWT_aa   ( aa accounts%rowtype, p_DAT date) ; -- квитовка по строке
PROCEDURE RKW1     ( p_RKW int, p_RI varchar2) ; -- отметка ручной квитовки
PROCEDURE OK1      ( p_acc number ) ; -- Виконати ручну ЗБАЛАНСОВАНУ квитовку
function DAT31(p_dat date) return int ;
function NAZN7(p_acc accounts.acc%type, p_REF1 oper.ref%type, p_tt tts.tt%type, p_mode int, p_NMS varchar2)  return oper.NAZN%type ;

function header_version return varchar2;
function body_version   return varchar2;
-------------------

END KWT_2924;
/
CREATE OR REPLACE PACKAGE BODY BARS.KWT_2924 IS
 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=   'ver.4.3 19.04.2018';
/*
 19.04.2018 контроль рах.Б
 04.04.2018 … просимо замінити  6399*01 на  6399*L9  7399*40 на  7399*53 
 13.02.2018 Sta -- План-Частка~суми заг.плат
 15.11.2017 Sta -- Трансфер 2017 6399.01 => 6340.01
 01.11.2017 Sta дох/расх за прошліе 180 дней
 21.09.2017 Sta Внебаланс при закр на расходы
 20.09.2017 OYF Изменены имена табл по требованиям стандарта
 07.09.2017 Sta  ATM + Л.Орлик
 28.07.2017 Sta Формирование снимка 31 числа - удаление всего . но вставка по АСС
 13.06.2017 Sta Поле KF в таблице KWT_A_2924 +  KWT_T_2924
 09.06.2017 Sta В работу берем ВСЕ 2924
 11.04.2017 Sta РУЧНА розшифровка с отметкой доп.рекв tag = 'KWT_2924' name = 'Старт-залишок розшифровано вручну'; ff.USE_IN_ARCH  := 0;
. . . . . . .
 Пакедж по квитовке счетов 2924
*/
 modcode  constant varchar2(3) := 'ATM';

 g_TAG ACCOUNTS_FIELD.tag%type := 'KWT_2924';
 n_err number      := -20203 ;
---================================================================
procedure DEL_ATM3 (p_acc number) is  -- Очистка План-Частка~суми заг.плат
begin If gl.doc.s <> to_number(pul.GET('ITOG3')) then 
         raise_application_error( n_err, 'Сума документу НЕ = Сумі введених часток = ' || to_number(pul.GET('ITOG3')) ) ;
      end if ;
      insert into atm_ref2 (ref1, ref2, s) select ref1, gl.aRef, s from atm_ref3 where acc = p_acc ;
      delete from atm_ref3 where acc = p_acc ;
      pul.put ('ITOG3', null );
end del_atm3;

procedure UPD3     (p_acc number, p_REF1 number, p_Del number, p_S3 number ) is -- План-Частка~суми заг.плат
 l_I3 number ;
begin
 If p_S3 > p_Del then return; end if;
 ---------------------------------------
 delete from ATM_REF3 where acc= p_acc and  REF1 = p_Ref1   ;
 insert into ATM_REF3 (s,ref1,acc) values (p_S3*100,p_Ref1, p_acc);
 select sum( s) into l_I3 from ATM_REF3 where acc= p_acc  ;
 pul.put ('ITOG3', to_char(l_I3) );
end UPD3;

procedure CLS_ATM  ( p_DAT date,    p_acc number , p_pap int ) is
  oo oper%rowtype;   l_DAT date ; l_OST number;   l_dk1 int  ; l_dk2 int ;   l_D1  number; l_D2   number;
  BBBBOO varchar2 (6) ;
begin
--l_dat := NVL(p_DAT, add_months( gl.bdate, -1) ) ;
  l_dat := NVL(p_DAT,  gl.bdate) - 180 ;
  for k in (select a.* from accounts a where  a.tip in ('AT7', 'AT8') and a.dazs is null and kv = gl.baseval and p_acc in ( 0, a.acc ) and a.pap = p_pap )
  loop
     If k.ostc = 0 then
        delete from atm_ref2 where ref1 in (select ref1 from atm_ref1 where acc = k.acc);
        delete from atm_ref1 where acc = k.acc ;
     else
        l_ost := fost ( k.acc, (l_dat-1) );
        l_dk1 := k.pap - 1 ;
        l_DK2 := 2 - k.pap ;

/* 04.04.2018 … просимо замінити  
6399*01 на  6399*L9
7399*40 на  7399*53
*/
        OP_BS_OB1( substr(k.branch,1,15), '6399L9' ) ;
        OP_BS_OB1( substr(k.branch,1,15), '739953' ) ; 
        OP_BS_OB1( substr(k.branch,1,15), '961804' ) ;

        for x in (select * from atm_ref1 where acc = k.acc )
        loop
           begin select s into l_D1 from opldok where ref = x.ref1  and acc = k.acc and dk =  l_dk1 and fdat < l_dat ;
                 select NVL(sum(s),0) into l_D2 from opldok where ref in (select ref2 from atm_ref2 where ref1 = x.ref1 ) and acc = k.acc and dk =  l_dk2 ;
                 oo.s  := l_D1 - l_D2 ;
                 If oo.s <> 0 then
                    If oo.s > 0 then oo.dk := l_dk1 ;         Else             oo.dk := l_dk2 ;           end if;
                    oo.s := LEAST ( ABS(oo.s), abs(k.Ostc) ) ;

                    If oo.dk = 1 then oo.nlsb := nbs_ob22_null( '6399' , 'L9' , k.branch); oo.nam_b :=  'Надлишки грошових коштів,виявл. в АТМ' ;
                    else              oo.nlsb := nbs_ob22_null( '7399' , '53' , k.branch); oo.nam_b :=  'Нестачі грошових коштів, виявл. в АТМ' ;
                    end if ;
/*
А для переноса сумм на расходы нужно использовать D66 – Внутрішн МемОрд по Доходах/Витратах
и бух модель Дебет 7399/40 Кредит    2924/08
Одночасно повинна бути сформована проводка по відображенню суми, списаної у збиток заборгованості за позабалансовим рахунком:
Дебет              9618/04Кредит     9910
*/
                    select substr(nms,1,38) into oo.nam_b from accounts where kv = gl.baseval and nls = oo.nlsb;
                    gl.ref (oo.REF);  oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
                    gl.in_doc3 (ref_=> oo.REF, tt_=>'D66', vob_ =>6      , nd_  =>oo.nd, pdat_=>SYSDATE, vdat_=>gl.bdate, dk_  => oo.dk,
                                 kv_=> k.kv  , s_ =>oo.S , kv2_ =>k.kv   , s2_  =>oo.S , sk_  => null  , data_=>gl.BDATE, datp_=> gl.bdate,
                              nam_a_=> Substr(k.nms,1,38), nlsa_=>k.nls  , mfoa_=>gl.aMfo ,
                              nam_b_=> oo.nam_b          , nlsb_=>oo.nlsb, mfob_=>gl.amfo ,
                              nazn_ => oo.nam_b          , d_rec_=>null  , id_a_=>gl.aOkpo, id_b_=> gl.aOkpo, id_o_=>null, sign_=>null, sos_=>1, prty_=>null, uid_=>null );
                    gl.payv( 0,  oo.ref, gl.bdate ,'D66', oo.dk, k.kv, k.nls, oo.s, k.kv,  oo.nlsb, oo.s);

                    If oo.dk = 0 then
                       oo.nlsb :=  nbs_ob22_null('9618', '04', k.branch);
                       oo.nlsA :=  nbs_ob22_null('9910', '01', k.branch);
                       gl.payv( 0,  oo.ref, gl.bdate ,'D66', oo.dk, k.kv, oo.nlsa, oo.s, k.kv,  oo.nlsb, oo.s);
                    end if;

                    gl.pay ( 2,  oo.ref, gl.bdate);
                    k.ostc :=fost(k.acc, gl.bdate);
                    oo.S := 0;
                 end if;
           EXCEPTION WHEN NO_DATA_FOUND THEN null ;
           end;

           If oo.S = 0 then  KWT_2924.DEL_ATM1 (k.acc, x.REF1);  end if;

        end loop; -- x

     end if;
  end loop ; -- k

end CLS_ATM;
---------------------------------------------------

procedure DEL_ATM2 ( p_REF1 number, p_REF2 number) is
                     l_ref1 number;
begin l_REF1 := NVL( p_ref1,to_number(pul.get('ATM_R1'))) ;
      delete from atm_ref2 where ref1 = l_REF1 and ref2 = p_ref2 ;
end DEL_ATM2 ;
--------------
procedure DEL_ATM1 ( p_ACC number, p_REF1 number) is
                     l_acc number;
begin l_ACC := NVL ( p_acc, to_number( pul.get('ATM_ACC')));
      delete from atm_ref2 where ref1 = p_ref1 ;
      delete from atm_ref1 where ref1 = p_ref1 and acc = l_acc;
end DEL_ATM1 ;
------------
procedure INS_ATM1 ( p_ACC number, p_REF1 number) is
                     l_acc number;
begin l_ACC := NVL ( p_acc, to_number( pul.get('ATM_ACC')));
  insert into atm_ref1(acc,ref1) select a.acc,o.ref from accounts a, opldok o where a.acc = l_acc and a.acc=o.acc and o.ref=p_ref1 and o.dk=a.pap-1 and a.tip in ('AT7','AT8');
end INS_ATM1;
-------------------------------------

procedure INS_ATM2 ( p_ACC number, p_REF1 number, p_REF2 number) is
                     l_acc number; l_ref1 number; l_REF2 number; l_dk1 int   ;  l_dk2 int ;
                     l_D1  number; l_D2   number; l_Del  number;
  bb accounts%rowtype;
  x_Ref number;
  x_S   number;
  x_Err varchar2(50) ;
begin l_ACC  := NVL( p_acc, to_number( pul.get('ATM_ACC' ))) ;
      l_REF1 := NVL( p_ref1, to_number (pul.get('ATM_R1'  ))) ;
      l_REF2 := NVL( p_ref2, gl.aRef ) ;
      l_DK1  :=              to_number (pul.get('ATM_DK'  ))  ; l_DK2 := 1- l_DK1;

      If gl.doc.tt ='015' and gl.doc.nlsb NOT like '2924%'  and gl.doc.nlsb NOT like '2909%'  
         OR     
         gl.doc.tt ='013' and gl.doc.nlsb NOT like '2924%' then x_Err := 'ATM_ERR1'; goto ERR_; -- '1)Рах.'||gl.doc.nlsb|| ' не відповідає коду операції' ; 
      end if ;


      If gl.doc.nlsb like '2924%' or  gl.doc.nlsb like '2909%' then
         begin select * into bb from accounts where kv= gl.doc.kv2 and nls = gl.doc.nlsb;   exception when no_data_found then bb.ob22 := '**' ;  end;  
         If gl.doc.tt in ('015'      )  and bb.ob22 = '81'  and gl.doc.nlsb like '2909%'                      OR 
            gl.doc.tt in ('015','013')  and bb.ob22 = '10'  and gl.doc.nazn like 'Спис.кошти по опрот.плат.%' OR
            gl.doc.tt in ('015'      )  and bb.ob22 = '08'  and gl.doc.nazn like 'Взаємозак%'                 OR 
            gl.doc.tt in ('015'      )  and bb.ob22 = '07'  and gl.doc.nazn like 'Перенесено%' then null;
         else                                                   x_Err := 'ATM_ERR2'; goto ERR_ ; -- '2)Рах.'||gl.doc.nlsb|| ' не відповідає призначенню'; 
         end if;
      end if ;

      If gl.doc.nlsb like '2924%'  and  gl.doc.tt in ('015' )  and gl.doc.nazn like 'Взаємозак%' and  l_Ref1 > 0 then -- "Кучку-> в -> ямку" только для один-в-один. не для нескольких кучек одновременноthen

         begin select to_number(w.value) into x_Ref from operw  w where w.tag ='REFX' and w.ref = gl.aRef ;
         exception when others then                             x_Err := 'ATM_ERR3'; goto ERR_ ; -- '3) Відсутній Дод.рекв.REFX = Реф."ямки "'; goto ERR_ ; 
         end;
         Select nvl(sum(s),0)      into x_S from atm_ref2           where ref1= x_Ref;
         begin select o.S - x_S   into x_S   from oper o, atm_ref1 r where r.Ref1= x_Ref and r.acc= bb.acc and o.ref = x_Ref and o.S - x_S >= gl.doc.S;
               insert into atm_ref2 (ref1, ref2) values (x_ref, l_ref2) ;
         exception when others then                             x_Err := 'ATM_ERR4'; goto ERR_ ; -- '4) Не відповідає умовам ""ямки"'; goto ERR_ ; 
         end;
      end if;

/*    При разборе кучек заг.суммою это не подходит
      select         s     into l_D1 from opldok where ref =        l_ref1                                     and acc = l_acc and dk =  l_dk1 ;
      select NVL(sum(s),0) into l_D2 from opldok where ref in (select ref2 from atm_ref2 where ref1 = l_ref1 ) and acc = l_acc and dk =  l_dk2 ;
      l_del  := l_D1 - l_D2 ;
      If l_Del < 0 then           x_Err := 'ATM_ERR5'; goto ERR_ ; --'5)Сума док'; goto ERR_ ;       end if ;
      begin   select ref into l_ref2 from opldok o where o.acc = l_acc and o.ref = L_ref2 and o.dk = l_DK2 and o.s <= l_Del;
      exception when no_data_found then null;
      end;  
      --insert into atm_ref2 (ref1, ref2) select l_ref1, l_ref2 from opldok o where o.acc = l_acc and o.ref = p_ref2 and o.dk = l_DK2 and o.s <= l_Del;
  */
      <<ERR_>> NULL;      If x_Err is not null then   bars_error.raise_nerror( modcode, x_Err); end if;


      If l_Ref1 > 0 then     insert into atm_ref2 (ref1, ref2, s ) values (l_ref1, l_ref2, null ) ;
      else                   insert into atm_ref2 (ref1, ref2, s ) select    ref1, l_ref2, s from atm_ref3 where acc = l_ACC;  
      end if ;

      delete from atm_ref3 where acc = l_ACC;

end INS_ATM2;

procedure RR ( p_mode int, p_acc number, p_s number, p_ref number ) is
  -- p_mode = 1 добавити "умовний документ"
  -- p_mode = 2 виправити суму документу
  -- p_mode = 3 вилучити докуметн
  -- p_mode = 0 перемістити в загальну тапблицб несквитованих

  l_ref number ;
  l_s   number := p_s * 100 ;
  l_acc number := NVL( p_acc, to_number ( pul.get ('ACC') ) );
  l_ss  number ;
  l_dat01 date  := to_date   ( pul.get ('DAT01') ,'dd-mm-yyyy') ;
  l_dat31 date ;
begin

  l_dat31   := l_dat01 - 1 ;

  if  p_mode = 1 then
      select  nvl(min(ref ),0) -1  into l_ref  from kwt_rt_2924 ;
      insert  into kwt_rt_2924 (acc,  ref, fdat, s )  values (l_acc, l_ref, l_dat01, l_s ) ;

  elsif p_mode = 2 then
     update kwt_rt_2924 set s= l_s where  ref = p_ref ;

  elsif p_mode = 3 then
     delete from kwt_rt_2924       where  ref = p_ref ;

  elsif p_mode = 0 then
     select  sum(s) - bars.fost(l_acc, l_dat31 ) into l_ss from kwt_rt_2924 where  acc = l_acc ;
     If l_ss <> 0 then
        raise_application_error(n_err,'НЕ збалансовано залишок та суму докуметів' )  ;
     end if ;

     insert into kwt_t_2924 (ACC,FDAT,REF,S) select acc,fdat,ref,s from kwt_rt_2924 where  acc = l_acc ;

     delete from kwt_rt_2924  where  acc = l_acc   ;
     insert into kwt_a_2924 ( acc, branch, daos, nls, kv, ob22, dat_KWT , KF)
                       select acc ,branch, daos, nls, kv, ob22, l_dat31 , KF
                       from accounts where acc = l_acc  ;
     -- отметка о завершении
     insert into accountsw ( acc, tag, value ) values ( l_acc, 'KWT_2924', to_char(l_dat31, 'dd.mm.yyyy'))  ;
     pul.put  ('ACC', null  ) ;
  end if;
end;


PROCEDURE MAX_DAT  is -- определение максимальной даты квитовки и установка  ее в пул
  l_dat date ;
begin
  select max(dat_kwt) into l_dat from kwt_a_2924 ;
  PUL.put('DAT_KWT_2924', to_char( l_dat, 'dd.mm.yyyy') ) ;
end ;


PROCEDURE KWT_DAT  ( p_mode int, p_bDAT date) is  -- добавити в календар по банк- дату
   l_dat_sys date;
begin
   select max(dat_sys) into l_dat_sys from kwt_d_2924 ;
   If  l_dat_sys is null then l_dat_sys := trunc( sysdate) ; end if;

   insert into kwt_d_2924 (Dat_sys , Dat_kwt  )
   select dat_sys, DAT_NEXT_U(dat_sys,-2)
   from (select l_dat_sys + c.num dat_sys from conductor c
         where DAT_NEXT_U(l_dat_sys + c.num,-2) <= p_bDat);
end;



PROCEDURE KWT_ALL  ( p_mode int, p_DAT date ) is  -- квитовка всех
  dd kwt_d_2924%rowtype;
  l_Txt varchar2(250);
begin
  If p_dat is null then

     dd.DAT_SYS  := trunc (sysdate) ;

     begin select * into dd from kwt_d_2924  where  DAT_SYS = dd.DAT_SYS;
     EXCEPTION WHEN NO_DATA_FOUND THEN l_txt := g_TAG || ' Не знайдено дату'|| to_char( dd.DAT_SYS ,'dd.mm.yyyy') || ' в календарi квитовки 2924 ';
        If p_mode = 0 then logger.info(l_txt); else raise_application_error(n_err,l_txt) ; end if ;
     end;

  else
     dd.DAT_KWT := p_dat ;
  end if ;

  for ka in (select * from accounts where dazs is null and dapp is not null and nbs = '2924'
--------------- and ob22 in ( '01', '14', '15', '16', '17', '18', '23', '25', '26', '27', '28' )
  )
  loop     KWT_2924.KWT_aa ( ka , dd.DAT_KWT );   end loop ;

end KWT_ALL;

PROCEDURE KWT_ob22 ( p_mode int, p_DAT date, p_ob22 accounts.ob22%type) is  -- квитовка по об22
begin for ka in (select * from accounts where dazs is null and dapp is not null and nbs = '2924' and ob22 = p_ob22  )
      loop KWT_2924.KWT_aa ( ka , p_dat ); end loop ;
end KWT_ob22;

PROCEDURE KWT_acc  ( p_mode int, p_DAT date, p_kv int, p_nls varchar2, p_acc number) is  -- квитовка по acc
  l_Dat_End date ;
  max_bdat date  ;

begin
  l_Dat_End := NVL( p_dat, gl.bdate-2);
  select max(fdat) - 2 into max_bdat from fdat ;
  l_Dat_End := LEAST ( l_Dat_End ,  max_bdat ) ;

  If KWT_2924.DAT31 ( l_dat_end ) = 1  then
     -- это месячная отчетная дата. сделаем копию
     delete from  kwt_t31_2924 ;
     delete from  kwt_a31_2924 ;
   end if;

   for ka in (select * from accounts where dazs is null and dapp is not null and nbs = '2924' and (acc = p_acc or kv = p_kv and nls = p_nls ) )
   loop KWT_2924.KWT_aa ( ka , p_dat ); end loop ;
end KWT_ACC;

PROCEDURE KWT_aa ( aa accounts%rowtype, p_DAT date) is
  l_Dat_VZ  date ;
  l_dapp    date ;
  l_Dat_beg date ;
  l_Dat_End date ;
  l_RI     rowid ;
  l_Ost number   := 0 ;
  l_Deb number   := 0 ;
  l_Krd number   := 0 ;
  max_bdat date  ;
  nTmp_ int      ;
begin
  If aa.nbs <> '2924' then RETURN; end if;
  l_Dat_End := NVL( p_dat, gl.bdate-2);

  select max(fdat) - 2 into max_bdat from fdat ;

  l_Dat_End := LEAST ( l_Dat_End ,  max_bdat ) ;
----------------------------------------------------
-- НЕльзя залазить в ттекущую банк-таду и более.


  select max(fdat) into l_Dat_VZ from saldoa where ostf=0 and dos<>kos and acc=aa.ACC and fdat <= l_dat_end;

-- 05.04.2017 Sta +Olach

If l_Dat_VZ < to_date('01-09-2017','dd-mm-yyyy') then
   -- Для задавненных счетов проверяем доп.реквизит об ручной расшифровке
   begin select 1 into nTmp_ from bars.accountsw  ww  where ww.acc = aa.acc and ww.tag = 'KWT_2924';
   EXCEPTION WHEN NO_DATA_FOUND THEN  Return;
   end ;

end if;
---------------------------------------------------------------

  select max(fdat) into l_dapp   from saldoa where                         acc=aa.acc and fdat <= l_dat_end;

  begin select   dat_kwt + 1   into  l_dat_beg  from kwt_a_2924 where acc = aa.acc;
  EXCEPTION WHEN NO_DATA_FOUND THEN  l_dat_beg := l_Dat_VZ;
        insert into kwt_a_2924 (acc, branch, daos, nls, kv, ob22, KF ) values (aa.acc, aa.branch, aa.daos, aa.nls, aa.kv, aa.ob22, aa.KF );
  end;

  If l_Dat_end < l_Dat_beg then RETURN; end if;

--l_ost :=  Fost(aa.acc, l_dat_end);
  begin select ostf - dos + kos into l_ost from saldoa where acc = aa.acc and fdat = ( select max(fdat) from saldoa where acc = aa.acc and fdat <= l_dat_end );
  EXCEPTION WHEN NO_DATA_FOUND THEN  l_ost := 0;
  end;


  If    l_dapp < l_dat_Beg  then  ------------------------------------------------ Протокол старый. без изменений
        update kwt_a_2924 set dat_KWT = l_dat_end where acc= aa.acc;

  ElsIf l_ost =  0       then        delete from kwt_t_2924 where acc = aa.acc ; ---- Протокол НУЛЕВОЙ = пустой
        update kwt_a_2924 set dapp=l_DAPP, datvz=l_dat_VZ, dat_KWT=l_dat_end, IXD = 0, IXK = 0 where acc= aa.acc;

  Else  EXECUTE   IMMEDIATE  ' truncate  TABLE TMP_KWT_2924 ';
     If l_Dat_VZ >= l_dat_beg then   delete from kwt_t_2924 where acc = aa.acc ;       l_dat_beg :=  l_dat_VZ ; ---- Протокол вновь созданный
     else  Insert into TMP_KWT_2924( s,fdat,ref,tt2) select s,fdat,ref,tt2 from kwt_t_2924 where acc = aa.acc ; ---- Протокод приращенный
                                     delete from kwt_t_2924 where acc = aa.acc ;
     end if;

     -- Запомним в табл и квитуем одновременно все суммы по счету - БЕЗ никаких сортировок !
     for oo in (select o.tt, o.ref, o.fdat, (2*dk-1) * o.s  S            from opldok o, saldoa s
                where s.fdat >= l_dat_Beg and s.fdat <= l_dat_end and s.acc = aa.ACC and s.fdat = o.fdat and s.acc = o.acc)
      loop
/*
сквитувати в 2 кроки з таким пріоритетом
1)	Спочатку «Сума+РЕФ»
2)	Потім  «Тільки Сума»
*/

         begin select rowid into l_RI from TMP_KWT_2924 where s = -oo.s and REF= oo.REF and rownum = 1    ; --- будем искать противоположный знак в том же реф
               delete                 from TMP_KWT_2924 where               rowid  = l_RI ; --- сквитовано
         EXCEPTION WHEN NO_DATA_FOUND THEN
               begin select rowid into l_RI from TMP_KWT_2924 where s = -oo.s and rownum = 1    ; --- будем искать противоположный знак с любым реф
                     delete                 from TMP_KWT_2924 where               rowid  = l_RI ; --- сквитовано
               EXCEPTION WHEN NO_DATA_FOUND THEN
                    insert into TMP_KWT_2924 (s,fdat,ref,tt2) values (oo.s, oo.fdat, oo.ref, oo.tt ) ; --- будем писать со своим знаком
               END;
         END;
      end loop; --- oo

      -- Выгрузим несквитованное
      insert into  kwt_t_2924  (acc,fdat,s,ref,tt2) select aa.acc,fdat,s,ref,tt2  from TMP_KWT_2924;
      If l_Ost > 0 then l_krd :=   l_Ost ;
      else              l_deb := - l_Ost ;
      end if;

      update kwt_a_2924 set dapp=l_DAPP, datvz = l_dat_VZ, dat_KWT = l_dat_end, IXD= l_deb/100, IXK= l_krd/100 where acc= aa.acc;

      If KWT_2924.DAT31 ( l_dat_end ) = 1  then
         -- это месячная отчетная дата. сделаем копию
         insert into  kwt_t31_2924 ( acc, fdat, s, ref,tt2) select aa.acc,fdat,s,ref,tt2  from TMP_KWT_2924;
         insert into  kwt_a31_2924 ( ACC, BRANCH , NLS, KV, OB22, DAOS, DAPP, DATVZ, DAT_KWT, IXD, IXK)
                              select ACC, BRANCH , NLS, KV, OB22, DAOS, DAPP, DATVZ, DAT_KWT, IXD, IXK
                              from kwt_a_2924 where acc= aa.acc and dat_KWT = l_dat_end   ;
      end if;

  end if ;

  commit ;

end KWT_aa;

PROCEDURE RKW1     ( p_RKW int, p_RI varchar2) is  -- отметка ручной квитовки
begin update kwt_t_2924 set rkw = p_RKW where rowid = p_RI ; end RKW1;

PROCEDURE OK1      ( p_acc number ) is -- Виконати ручну ЗБАЛАНСОВАНУ квитовку
 l_acc kwt_t_2924.acc%type ;
 l_S   kwt_t_2924.s%type   ;

begin
  l_ACC := NVL(p_acc, to_number (PUL.GET('ACC') ) );
  select sum(s) into l_s  from kwt_t_2924 where acc = l_ACC and rkw = 1 ;
  If l_s <> 0  then raise_application_error(-20000, 'KWT_2924: НЕ збалансовані відмічені для квитовки суми !' );   end if ;
  delete                  from kwt_t_2924 where acc = l_ACC and rkw = 1 ;
end OK1;
---------------
function DAT31(p_dat date) return int is
begin  if to_char(p_dat,'YYYYMM') < to_char( DAT_NEXT_U(p_DAT,1), 'YYYYMM' ) then RETURN 1; else RETURN 0; end if;
end DAT31;


function NAZN7(p_acc accounts.acc%type, p_REF1 oper.ref%type, p_tt tts.tt%type, p_mode int, p_NMS varchar2)  return oper.NAZN%type is l_nazn oper.NAZN%type;
begin

  If    p_mode = 1 and p_tt = '013' then l_nazn := 'Спис.кошти по опрот.плат. АТМ А_______ тран. за __/__/__ (дата оскар. __/__/__ ) ';  ------реф. ___________ надл. __/__/__   411997******7295';                       
  ElsIf p_mode = 2 and p_tt = '013' then l_nazn := 'Взаємозак. нестачі по АТМ/ІПТ А_______ зг. служб.записки №__ від __/__/__' ; --  реф. ___________ від __/__/__ за рах.надлишків реф. ___________ від __/__/__ зг. служб.записки №__ від __/__/__';
  ElsIf p_mode = 3 and p_tt = '013' then l_nazn := 'Перенесено на відповідний аналітичний рахунок кошти  '; -- _________ від __/__/__  на реф.___________ від __/__/__';                                           
  ElsIf p_mode = 1 then 
     If    p_TT = 'PKR' then l_nazn := 'Зараховано на карт/рах. зг. звернення' ; 
     ElsIf p_TT = '310' then l_nazn := 'Кошти для зарах на рах.2625 ПІБ, ІНН;' ; 
     ElsIf p_tt = '015' then l_nazn := 'Кошти для виплати <ПІБ> зг. звернення' ; 
     end if;
     l_Nazn := l_Nazn ||' SC-...(надл. за ';   
  else null ;
  end if; 

  for oo in (select to_char(o.vdat,'dd/mm/yyyy') || ',реф.'|| o.REF||', ' txt from oper o              where o.ref = p_REF1      union all 
             select to_char(o.vdat,'dd/mm/yyyy') || ',реф.'|| o.REF||', ' txt from oper o, atm_ref3 x  where o.ref = x.ref1  and x.acc = p_acc 
             )
  loop   l_nazn := Substr(l_nazn || oo.txt, 1, 160) ; end loop;
         l_nazn := Substr(l_nazn || p_NMS , 1, 160) ; 
  RETURN l_NAZN;

end NAZN7;


function header_version return varchar2 is begin  return 'Package header KWT_2924 '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body KWT_2924 '  ||G_BODY_VERSION  ; end body_version;
--------------

---Аномимный блок --------------
begin   null ;
END KWT_2924 ;
/
 show err;
 
PROMPT *** Create  grants  KWT_2924 ***
grant EXECUTE                                                                on KWT_2924        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KWT_2924        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/kwt_2924.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 