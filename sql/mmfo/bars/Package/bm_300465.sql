
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bm_300465.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BM_300465 IS
----------------------------------
s3622_ varchar2(14) := '36229005'      ; -- ОК
s3903_ varchar2(14) ;
FIO_   varchar2(50) ;
PIDSTAVA_  varchar2(100) ;

BAGS_  varchar2(5);
PASP_  varchar2(15);
PASPN_ varchar2(15);
ATRT_  varchar2(50);

------------------------------------
xx1_ char(3) :='013'; vob1_ int := 6 ; -- Видатки каси грн-ном
xx2_ char(3) :='013'; vob2_ int := 6 ; -- кред.заборг з ном в дорозi - уже не надо
xx3_ char(3) :='007'; vob3_ int := 6 ; -- Закриття дороги грн-ном
xx4_ char(3) :='Z13'; vob4_ int := 16; -- конверсия
xx5_ char(3) :='Z17'; vob5_ int := 6 ; -- видатки з каси  БМ
xx6_ char(3) :='007'; vob6_ int := 6 ; -- закриття дороги по БМ
xx7_ char(3) :='007'; vob7_ int := 6 ; -- ПДВ

N_ number ;
E_ number ;
V_ number ;

ro oper%rowtype;
bm bank_metals%rowtype;
ks bm_nls%rowtype;
--------------------
PROCEDURE SET_NLS (
T varchar2,
D varchar2,
G varchar2,  -- 1. Кількість інкасаторських сумок  - BAGS
F varchar2,
I varchar2,
P varchar2,  -- 2. Пред’явлений документ             - PASP
N varchar2, --- PASPN
A varchar2  -- - ATRT
) ;

---------------------
PROCEDURE SET_bm (p_kod bank_metals.kod%type);
--------------------
PROCEDURE SET_oper ;
--------------------
PROCEDURE pay_ro   ;
------------------------------------------------------
procedure RU  (p_kod bank_metals.kod%type,
               p_kol int   ,
               p_R   bank_metals.CENA_PROD%type) ;
------------------------------------------------------
procedure FL  (p_kod bank_metals.kod%type,
               p_kol int   ,
               p_R   bank_metals.CENA_PROD%type) ;
------------------------------------------------------
procedure upd_web (p_kod          bank_metals.kod%type,
                   p_kol          integer,
                   p_cena_prod    bank_metals.cena_prod%type);
------------------------------------------------------
END ;
/
CREATE OR REPLACE PACKAGE BODY BARS.BM_300465 IS

/*

18.03.2013 Мришук В.В. <MrishukVV@oschadnybank.com>

1)   С дорогой
Дебет                 Кредит               Оп.ТТ
980  39036000147547  959  39036000147547  Z43  Передача БМ \
980  39036000147547  959  39036000147547  Z43  Передача БМ / без изм

959  11070904547     959  11014904547     Z41  Вiдправка БМ ч/з ДФС\
959  11070904547     959  11014904547     Z41  Вiдправка БМ ч/з ДФС/ без изм

980  10072903547     980  1001590959      Z42   Відправка грн. ном. БМ ч/з ДФС
980  3907....        980  1001590959      Z42   Відправка грн. ном. БМ ч/з ДФС – сч деб

959  39036000147547  959  11070904547     Z44  Закриття дороги по БМ \
959  39036000147547  959  11070904547     Z44  Закриття дороги по БМ / без изм

980  39036000147547  980  10072903547     Z45  Закриття дороги по грн. ном. БМ
Исключить

------------------

19.02.2013 Игорь Шарадов <sharadowiy@oschadnybank.com>
   Просьба подкрутить операцию Z42 :
   Если идет самовывоз монет (параметр "дорога" = 0),
   то счет кассы на суму номинала инвестиционных монет корреспондирует сo счетами 3907

21.12.2012
 за операціями внутрішньосистемної передачі інвестиційних монет регіональні управління спочатку перераховують кошти  3907 РУ
 після чого відбувається видача номіналу інвестиційних монет - Дт 3907 Кт 1001


16.11.2012 Назва РУ = Назва клиента
09.11.2012 отпускная цена ( p_R)  включает в себя номинал (bm.CENA_NOMI), потому для конверсии его надо отнять
           учет при оплате даты валютирования.

20.09.2012 Sta +Шарадов. Детали проводок

Дата вал   Деб   Кредит   TT  Vob  Ck Назн пл	Теги доп.рекв
-----------------------------------------------------------------
Текущая 3903/980 3903/959 Z43 71     Передача б/м  (золото, ?нв.монета, название со справочника, грами * количество) Донецькому ОУ зг?дно Основание	Основание
Текущая 1107/959 1101/959 Z41 156    В?дправка б/м  (золото, ?нв.монета, название со справочника, грами * количество) Донецькому ОУ зг?дно Основание	Основание
Следующ 3903/959 1107/959 Z44 6      Закриття дороги по б/м  (золото, ?нв.монета, название со справочника, грами * количество) Донецькому ОУ зг?дно Основание	дата валютирования, Основание
Текущая 1007/980 1001/980 Z42 56  72 В?дправка ном?налу б/м  (золото, ?нв.монета, название со справочника, грами * количество) Донецькому ОУ зг?дно Основание	Символ касплана 72,  Основание
Следующ 3903/980 1007/980 Z45 6      Закриття дороги по ном?налу б/м  (золото, ?нв.монета, название со справочника, грами * количество) Донецькому ОУ зг?дно Основание	дата валютирования, Основание

13.11.2012
Текущая	3903/980 3903/959 Z43 71     Передача БМ до «назва РУ»  «Назва БМ з довідника»  «Вага в грамах за 1 шт»  * «Кількість шт.»  згідно  «Підстава»
Текущая	1107/959 1101/959 Z41 156    Відправка БМ до «назва РУ»  «Назва БМ з довідника»  «Вага в грамах за 1 шт»  * «Кількість шт.» згідно «Підстава»
Следующ	3903/959 1107/959 Z44 6      Закриття дороги по БМ «назва РУ»  «Назва БМ з довідника»  «Вага в грамах за 1 шт»  *«Кількість шт.»  згідно «Підстава»
Текущая	1007/980 1001/980 Z42 56  72 Відправка грн. ном. БМ до «назва РУ»  «Назва БМ з довідника»  «Вага в грамах за 1 шт» * «Кількість шт.»  згідно «Підстава»
Следующ 3903/980 1007/980 Z45 6	     Закриття дороги по грн. ном. БМ «назва РУ» + «Назва БМ з довідника»  «Вага в грамах за 1 шт»* «Кількість шт.» згідно «Підстава»

*/
---------------------------------------------
PROCEDURE SET_NLS (
T varchar2,
D varchar2,
G varchar2,  -- 1. Кількість інкасаторських сумок  - BAGS
F varchar2,
I varchar2,
P varchar2,  -- 2. Пред’явлений документ             - PASP
N varchar2, --- PASPN
A varchar2  -- - ATRT
)
    is
--загнать в пул-переменные
begin
  PUL.Set_Mas_Ini ( 'TTTT'     , T, 'Счет_Транзиз'         );
  PUL.Set_Mas_Ini ( 'DOROGA'   , D, 'Дорога=1/0'           );
  PUL.Set_Mas_Ini ( 'FIO'      , F, 'FIO'         );
  PUL.Set_Mas_Ini ( 'PIDSTAVA' , I, 'Пiдстава для операцiї');
  PUL.Set_Mas_Ini ( 'BAGS'     , G, 'Кіл інк.сумок');
  PUL.Set_Mas_Ini ( 'PASP'     , P, 'документ');
  PUL.Set_Mas_Ini ( 'PASPN'    , N, 'Сер,№');
  PUL.Set_Mas_Ini ( 'ATRT'     , A, 'видан');

end SET_NLS;
--------------------------------------------------
PROCEDURE SET_bm (p_kod bank_metals.kod%type)
  is
begin
  E_ := null;

  begin
    select * into bm from bank_metals where  kod = p_kod;
  exception when NO_DATA_FOUND THEN
    raise_application_error(-20100, 'Код виробу '||p_kod|| 'не знайдено');
  end;

  begin
     select * into ks from bm_nls
     where kv= bm.kv and tip = bm.type_ and pdv= nvl(bm.pdv,0);
  exception when NO_DATA_FOUND THEN
    raise_application_error(-20100, 'Код виробу '||p_kod|| ' рахунки не знайдено');
  end;


  E_:= round(bm.VES_UN *1000/10,0) ;


end set_bm ;
----------------------------------------------------
PROCEDURE SET_oper
  is
begin

  insert into tts(tt, name)
  select ro.tt, ro.tt|| ' XXX' from dual
  where not exists (select 1 from tts where tt=ro.TT);


  gl.ref (ro.REF);
  ro.nd := nvl(substr(to_char(ro.REF),-10),'1');
  ro.kv2 := nvl(ro.kv2, ro.kv);

logger.info('BM-2 '|| ro.nlsa || ',' || ro.kv || ' ,' || ro.nlsb|| ', '|| ro.kv2);

  begin
    select trim(substr(a.nms,1,38)), ca.okpo, trim(substr(b.nms,1,38)), cb.okpo
    into ro.nam_a, ro.id_a,  ro.nam_b, ro.id_b
    from accounts a, customer ca, accounts b, customer cb
    where a.dazs is null and a.nls=ro.nlsa and a.rnk=ca.rnk and a.kv=ro.kv
      and b.dazs is null and b.nls=ro.nlsb and b.rnk=cb.rnk and b.kv=ro.kv2;
  exception when NO_DATA_FOUND THEN
    raise_application_error(-20100, 'не знайдено рах '||
                         ro.nlsa ||'/'||ro.kv  || ', '||
                         ro.nlsb ||'/'||ro.kv2 );
  end;
end SET_oper;

------------------
PROCEDURE pay_ro
  is
begin
  SET_oper;
logger.info('BM-1 '|| ro.tt || ','||ro.vob||' ,' || ro.kv || ' ,' || ro.nlsa || ', '|| ro.s || ','||  ro.kv2 || ',' || ro.nlsb || ', '|| ro.s2);
  gl.in_doc3(ref_  => ro.REF   , tt_   => ro.tt   , vob_  => ro.vob  ,
             nd_   => ro.nd    , pdat_ => SYSDATE , vdat_ => ro.VDAT , dk_ => 1,
             kv_   => ro.kv    , s_    => ro.s    ,
             kv2_  => ro.kv2   , s2_   => ro.s2   ,
             sk_   => ro.sk    , data_ => gl.BDATE, datp_ => gl.bdate,
             nam_a_=> ro.nam_a , nlsa_ => ro.nlsa , mfoa_ => gl.aMfo ,
             nam_b_=> ro.nam_b , nlsb_ => ro.nlsb , mfob_ => gl.aMfo ,
             nazn_ => substr( ro.nazn,1,160),
             d_rec_=> null, id_a_ => ro.id_a, id_b_ => ro.id_b, id_o_ => null,
             sign_ => null, sos_  => 1,       prty_ => null,    uid_  => null);


  gl.payv(0,ro.REF,ro.VDAT,ro.tt,1, ro.kv,ro.nlsa,ro.s, ro.kv2,ro.nlsb,ro.s2);


  If BAGS_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'BAGS', BAGS_  );
  end if;

  If PASP_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'PASP', PASP_  );
  end if;

  If PASPN_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'PASPN', PASPN_);
  end if;

  If ATRT_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'ATRT', ATRT_  );
  end if;

  If FIO_ is not null then
     insert into operw(ref, tag, value) values ( ro.REF, 'FIO' , FIO_   );
  end if;


end pay_ro;
---------------------
procedure RU  (p_kod bank_metals.kod%type,
               p_kol int   ,
               p_R   bank_metals.CENA_PROD%type)
  Is
  doroga_ varchar2(10);
  name_ru varchar2(38);
begin

  --узнать изделие
  set_bm (p_kod);

  --узнать счет и другое
  s3903_    := pul.get_mas_ini_val ('TTTT'     ) ;
  FIO_      := pul.get_mas_ini_val ('FIO'      ) ;
  PIDSTAVA_ := pul.get_mas_ini_val ('PIDSTAVA' ) ;
  doroga_   := pul.get_mas_ini_val ('DOROGA'   ) ;

  BAGS_  := substr(pul.get_mas_ini_val ('BAGS' ) ,1,5);
  PASP_  := substr(pul.get_mas_ini_val ('PASP' ) ,1,15);
  PASPN_ := substr(pul.get_mas_ini_val ('PASPN') ,1,15);
  ATRT_  := substr(pul.get_mas_ini_val ('ATRT' ) ,1,50);


  begin
    select substr(c.nmk,1,38) into name_ru from accounts a, customer c where a.kv=980 and a.nls=s3903_ and a.rnk=c.rnk;
--  select substr(nms,1,38)   into name_ru from accounts               where   kv=980 and nls = s3903_;
  exception when NO_DATA_FOUND THEN  name_ru := null;
  end;

  -------- 1. Z43  конверсия --------------------------
  ro.nlsa := s3903_      ;  ro.nlsb := s3903_     ;
  ro.tt   := 'Z43'       ;  ro.vob  := 71         ;
  ro.sk   := null        ;
  ro.kv   := 980         ;  ro.kv2  := bm.kv      ;
  ro.VDAT := gl.bdate    ;
  -- отпускная цена ( p_R)  включает в себя номинал (bm.CENA_NOMI)
  -- потому для конверсии его надо отнять
  ro.s    := ( p_R - nvl(bm.CENA_NOMI,0) ) * p_KOl;
  ro.s2   := E_ * p_KOL  ;
  ro.nazn := Substr('Передача БМ до ' || trim(name_ru)  || ' ' ||   trim(bm.name) || ' '        ||
                     to_char(bm.VES)  || ' гр. * ' || to_char(p_kol)   || ' шт. ' || 'згiдно '  || trim(PIDSTAVA_)
                     ,1,160);
  pay_ro  ;

  -------- 2.Z41 Видатки каси БМ -----------------------
  If doroga_ = '1' then ro.nlsa := ks.s1107      ;
  else                  ro.nlsa := s3903_        ;
  end if;

  ro.nlsb := ks.s1101   ;
  ro.VDAT := gl.bdate   ;
  ro.tt   := 'Z41'      ;  ro.vob  := 156        ;
  ro.sk   := null   ;
  ro.kv   := bm.kv      ;  ro.kv2  := bm.kv      ;
  ro.s    := E_ * p_KOL ;  ro.s2   := E_ * p_KOL ;

  If doroga_ = '1' then
    -- В случае отправки через фельдсвязь инвестиционных монет (дорога = 1) по операціям Z41, Z42:
    -- Назначение операции перед словами «до (назва РУ)» вставить слова «ч/з ДФС»

     ro.nazn := Substr('Вiдправка БМ ч/з ДФС до ' || trim(name_ru)     || ' '     || trim(bm.name) || ' '       ||
                        to_char(bm.VES) || ' гр. * ' || to_char(p_kol) || ' шт. ' || 'згiдно '     || trim(PIDSTAVA_)
                        ,1,160);
  else
     --	В случае самовывоза  инвестиционных монет (дорога = 0)  для операции Z41 и Z42
     --1. Назначение платежа должно начинаться со слов «Видача БМ (назва РУ)», а не «Відправка БМ до (назва РУ)»
     --2. Ввести в параметри процедури и доп.рекв операции новый Параметр «Отримувач/Платник»  -  тэг =FIO.

     ro.nazn := Substr('Видача БМ ' || trim(name_ru)   || ' ' ||  trim(bm.name)   || ' '     ||
                        to_char(bm.VES)          || ' гр. * ' || to_char(p_kol)   || ' шт. ' ||  'згiдно '  || trim(PIDSTAVA_)
                        ,1,160);
  end if;

  pay_ro  ;

  --------- 3. Z44 закриття дороги по БМ ------------------
  If doroga_ = '1' then
     ro.nlsa := s3903_    ;    ro.nlsb := ks.s1107     ;
     ro.kv   := bm.kv     ;    ro.kv2  := bm.kv        ;
     ro.VDAT := Dat_Next_U(gl.bdate,1) ;
     ro.sk   := null ;
     ro.s    := E_ * p_KOL;    ro.s2   := E_ * p_KOL   ;
     ro.tt   := 'Z44'     ;    ro.vob  := 6            ;
     ro.nazn := Substr('Закриття дороги по БМ ' || trim(name_ru)    || ' '     ||  trim(bm.name)     || ' '       ||
                     to_char(bm.VES) || ' гр. * ' || to_char(p_kol) || ' шт. ' ||  'згiдно '         || trim(PIDSTAVA_)
                     ,1,160);
     pay_ro  ;
  end if;

  -- грн-ном
  N_ := nvl(bm.CENA_NOMI,0) * p_kol ;


  If N_ > 0 then
     ----- 4. Z42 Видатки каси--------------------
     --980  3907....        980  1001590959      Z42   Відправка грн. ном. БМ ч/з ДФС – сч деб
     -- всегда 3907 !!!!!!

     begin
        select nls_3907 into             ro.nlsa  from bm_3903 where nls =s3903_;
     exception when NO_DATA_FOUND THEN  ro.nlsa := s3903_  ;
     end;

     ro.nlsb := ks.s1001   ;
     ro.VDAT := gl.bdate   ;
     ro.kv   := gl.baseval ;  ro.kv2  := gl.baseval ;
     ro.s    := N_         ;  ro.s2   := N_         ;
     ro.tt   := 'Z42'      ;  ro.vob  := 56         ;
     ro.sk   := 72         ;

     If doroga_ = '1' then
       -- В случае отправки через фельдсвязь инвестиционных монет (дорога = 1) по операціям Z41, Z42:
       -- Назначение операции перед словами «до (назва РУ)» вставить слова «ч/з ДФС»
        ro.nazn := Substr('Відправка грн. ном. БМ ч/з ДФС до ' || trim(name_ru)   || ' ' || trim(bm.name)  || ' ' ||
                     to_char(bm.VES)   || ' гр. * ' || to_char(p_kol)  || ' шт. ' || 'згiдно '  || trim(PIDSTAVA_)
                     ,1,160);

     else
        --	В случае самовывоза  инвестиционных монет (дорога = 0)  для операции Z41 и Z42
        --1. Назначение платежа должно начинаться со слов «Видача БМ (назва РУ)», а не «Відправка БМ до (назва РУ)»
        --2. Ввести в параметри процедури и доп.рекв операции новый Параметр «Отримувач/Платник»  -  тэг =FIO.
        ro.nazn := Substr('Видача грн. ном. БМ ' || trim(name_ru)   || ' '     || trim(bm.name) || ' '       ||
                   to_char(bm.VES)  || ' гр. * ' || to_char(p_kol)  || ' шт. ' || 'згiдно '     || trim(PIDSTAVA_)
                     ,1,160);

     end if;

     pay_ro  ;

/*
     If doroga_ = '1' then
        ----------- 5. Z45 Закриття дороги грн-ном ----------------------
        ro.nlsa := s3903_     ;  ro.nlsb := ks.s1007   ;
        ro.kv   := gl.baseval ;  ro.kv2  := gl.baseval ;
        ro.s    := N_         ;  ro.s2   := N_         ;
        ro.tt   := 'Z45'      ;  ro.vob  := 6          ;  ro.sk := null ;
        ro.VDAT := Dat_Next_U(gl.bdate,1);
        ro.nazn := Substr('Закриття дороги по грн. ном. БМ ' || trim(name_ru) || ' '       ||   trim(bm.name)   || ' ' ||
                   to_char(bm.VES) || ' гр. * ' || to_char(p_kol) || ' шт. '  || 'згiдно ' || trim(PIDSTAVA_ )
                     ,1,160);
        pay_ro  ;
     end if;
 */

  end if;

  -------- 6. ПДВ -------ЖДУ от ШАРАДОВА !!!!!---
  ---------------------------------
  If s3903_ like '39%' then  bm.pdv := 0;
  else                       bm.pdv := nvl(bm.pdv,0);
  end if;

  If bm.pdv = 1 then

     V_ := round( 0.2 * ( p_R - nvl(bm.CENA_NOMI,0) ) * p_KOl,0) ;

     ro.VDAT := gl.bdate   ;
     ro.nlsa := s3903_     ; ro.nlsb := s3622_     ;
     ro.kv   := gl.baseval ; ro.kv2  := gl.baseval ;
     ro.s    := V_         ; ro.s2   := V_         ;
     ro.tt   := XX7_       ; ro.vob  := VOB7_      ;
     ro.sk   := null       ;
     ro.nazn := Substr(trim(bm.name)|| ' ' || p_kol || 'шт. ПДВ',1,160);
     pay_ro  ;
  end if;


end RU;

--------------------------------------------------------
procedure FL  (p_kod bank_metals.kod%type,
               p_kol int   ,
               p_R   bank_metals.CENA_PROD%type)
  Is
begin
  --узнать изделие
  set_bm (p_kod);

  --узнать счет и другое
  s3903_    := pul.get_mas_ini_val ('TTTT')  ;
  FIO_      := pul.get_mas_ini_val ('FIO'  ) ;
  PIDSTAVA_ := pul.get_mas_ini_val ('PIDSTAVA' ) ;

  -- конверсия
  ro.tt   := '013'       ;  ro.vob  := 16         ;
  ro.VDAT := gl.bdate    ;

  ro.nlsa := s3903_      ;  ro.nlsb := ks.s1101   ;
  ro.kv   := 980         ;  ro.kv2  := bm.kv      ;
  ro.s    := ( p_R - nvl(bm.CENA_NOMI,0) ) * p_KOl;
  ro.s2   := E_ * p_KOL  ;
  ro.sk   := 30          ;
  ro.nazn := Substr(bm.name|| ' ' || p_kol || 'шт. Конверсiя.',1,160);
  pay_ro  ;

  -- ПДВ
  bm.pdv := nvl(bm.pdv,0);

  If bm.pdv = 1 then
     V_ := round( 0.2 * ( p_R - nvl(bm.CENA_NOMI,0) ) * p_KOl,0) ;
     ro.VDAT := gl.bdate   ;
     ro.nlsa := s3903_     ; ro.nlsb := s3622_     ;
     ro.kv   := gl.baseval ; ro.kv2  := gl.baseval ;
     ro.s    := V_         ; ro.s2   := V_         ;
     ro.tt   := XX7_       ; ro.vob  := VOB7_      ;
     ro.sk   := 30         ;
     ro.nazn := Substr(bm.name|| ' ' || p_kol || 'шт. ПДВ',1,160);
     pay_ro  ;
  end if;

  -- грн-ном
  N_ := nvl(bm.CENA_NOMI,0) * p_kol ;
  If N_ > 0 then
     -- Видатки каси
     ro.VDAT := gl.bdate   ;
     ro.nlsa := s3903_              ;     ro.nlsb := ks.s1001   ;
     ro.kv   := gl.baseval          ;     ro.kv2  := gl.baseval ;
     ro.s    := N_                  ;     ro.s2   := N_         ;
     ro.tt   := '013'               ;     ro.vob  := VOB1_      ;
     ro.sk   := 73                  ;
     ro.nazn := Substr(bm.name|| ' ' || p_kol || 'шт.Списання грн-ном з каси',1,160);
     pay_ro  ;
  end if;

end FL;

procedure upd_web (p_kod          bank_metals.kod%type,
                   p_kol          integer,
                   p_cena_prod    bank_metals.cena_prod%type)
is
   l_nlst   accounts.nls%type;
begin
   l_nlst := pul.get_mas_ini_val ('TTTT');

   if l_nlst like '1001%'
   then
      bm_300465.fl (p_kod, p_kol, p_cena_prod);
   else
      bm_300465.ru (p_kod, p_kol, p_cena_prod);
   end if;
end upd_web;
------------------------------------------------
end ;
/
 show err;
 
PROMPT *** Create  grants  BM_300465 ***
grant EXECUTE                                                                on BM_300465       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BM_300465       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bm_300465.sql =========*** End *** =
 PROMPT ===================================================================================== 
 