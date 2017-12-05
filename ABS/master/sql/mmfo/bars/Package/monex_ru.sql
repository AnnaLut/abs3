CREATE OR REPLACE PACKAGE BARS.MONEX_RU IS

 -- Системы педеводов. Единое онко. Клиринг. Профикс.
 -- Уровень РУ (там, где есть точки обслуживания клиентов)
 -- Сам пакедж  monex(порождение клиринговых платежей - в ГОУ)

  g_header_version   CONSTANT VARCHAR2 (64) := 'version 1.1  11/01/2013';

------- Превращение 2-х знач ОБ22 (симв) в 3-хнач цифровой
function OB3 ( p_ob22 varchar2 )  return varchar2 ;

-------работа с одним счетом---------------------------
procedure op_NLSM ( p_nbs    accounts.nbs%type,    p_ob22   accounts.ob22%type,
                    p_branch accounts.branch%type, p_kv     accounts.kv%type      ) ;

-------работа с одним бранчем---------------------------
procedure OP_branch ( p_Branch3 varchar2 ) ;


---------Главная процедура
procedure OP_nls_MTI (b1_ varchar2, b2_ varchar2, b3_ varchar2, b4_ varchar2, b5_ varchar2 );
  -- Демкович.М.С <DemkovichMS@oschadnybank.com>
  -- Ми думаємо, що правильно було би залишки із старих рахунків перенести на нові
  -- та закрити старі рахунки автоматично без втручання наших бух.

  --Горобец Сергей <gorserg@unity-bars.com.ua>
  -- 11-12-2012 валюты берем по справочнику

  -- 07.12.2012 Sta
  -- Вiдкриття необхiдних рахункiв для роботи групи Бранчiв-3(5 штук) в системах переказiвБ згiдно довiдника
  -- SWI_MTI_LIST

--------------------------------------------
-- header_version - возвращает версию заголовка пакета MONEX_RU
   FUNCTION header_version   RETURN VARCHAR2;

-- body_version - возвращает версию тела пакета MONEX_RU
   FUNCTION body_version     RETURN VARCHAR2;

end monex_RU;
/

GRANT execute ON BARS.monex_RU  TO BARS_ACCESS_DEFROLE;


CREATE OR REPLACE PACKAGE BODY BARS.monex_RU IS

 -- Системы педеводов. Единое онко. Клиринг. Профикс.
 -- Уровень РУ (там, где есть точки обслуживания клиентов)
 -- Сам пакедж  monex(порождение клиринговых платежей - в ГОУ)

   g_body_version   CONSTANT VARCHAR2 (64) := 'version 2  08.11.2017 ';

/*
15.11.2017 Sta Изменения, связанные с Трансф.БС 2017   6110.хх => 6510.хх

21.07.2017    Сухова  Реанимация существующего счета при открытии нового.
12.06.2017    COBUSUPMMFO-851  Sta Авто-Спец парам для счетоа 2909 и 2809
          для 2809 R011=9, S180=3, S240=2
          для 2909 R011=2, S180=3, S240=2
07/12/2015
*/
------- Превращение 2-х знач ОБ22 (симв) в 3-хнач цифровой
function OB3 ( p_ob22 varchar2 )  return varchar2 IS
   s1_   char(1)     := substr( p_ob22,1,1  ) ;    l_ob3 varchar2(3) ;
begin
   If s1_ >= '0' and s1_ <='9' then RETURN '0'||p_ob22; end if;
   ------------------------------------------------------------
   If    s1_ = 'A' then l_ob3 := '10'; ElsIf s1_ = 'B' then l_ob3 := '11'; ElsIf s1_ = 'C' then l_ob3 := '12'; ElsIf s1_ = 'D' then l_ob3 := '13';
   ElsIf s1_ = 'E' then l_ob3 := '14'; ElsIf s1_ = 'F' then l_ob3 := '15'; ElsIf s1_ = 'G' then l_ob3 := '16'; ElsIf s1_ = 'H' then l_ob3 := '17';
   ElsIf s1_ = 'I' then l_ob3 := '18'; ElsIf s1_ = 'J' then l_ob3 := '19'; ElsIf s1_ = 'K' then l_ob3 := '20'; ElsIf s1_ = 'L' then l_ob3 := '21';
   ElsIf s1_ = 'M' then l_ob3 := '22'; ElsIf s1_ = 'N' then l_ob3 := '23'; ElsIf s1_ = 'O' then l_ob3 := '24'; ElsIf s1_ = 'P' then l_ob3 := '25';
   ElsIf s1_ = 'Q' then l_ob3 := '26'; ElsIf s1_ = 'R' then l_ob3 := '27'; ElsIf s1_ = 'S' then l_ob3 := '28'; ElsIf s1_ = 'T' then l_ob3 := '29';
   ElsIf s1_ = 'U' then l_ob3 := '30'; ElsIf s1_ = 'V' then l_ob3 := '31'; ElsIf s1_ = 'W' then l_ob3 := '32'; ElsIf s1_ = 'X' then l_ob3 := '33';
   ElsIf s1_ = 'Y' then l_ob3 := '34'; ElsIf s1_ = 'Z' then l_ob3 := '35';
   end if;
   RETURN  ( l_ob3 || substr(p_ob22,2,1) );
end OB3 ;


-------работа с одним счетом---------------------------
procedure op_NLSM ( p_nbs    accounts.nbs%type,    p_ob22   accounts.ob22%type,    p_branch accounts.branch%type, p_kv     accounts.kv%type      )  IS
                    ra       accounts%rowtype ;    p4_ int;
begin

  begin select substr( P_ob22||' '|| replace (txt,'у','i'), 1,50), r020        into ra.nms, ra.nbs  from sb_ob22 where r020 = p_NBS   and ob22= P_OB22 and d_close is null;
  EXCEPTION WHEN NO_DATA_FOUND THEN   
     If p_NBS ='6110' then 
        begin select substr( P_ob22||' '|| replace (txt,'у','i'), 1,50), r020  into ra.nms, ra.nbs  from sb_ob22  where r020 = '6510' and ob22= P_OB22 and d_close is null;
        EXCEPTION WHEN NO_DATA_FOUND THEN   null ;
        end;
     end if;
  end ;

  If ra.NBS is null then raise_application_error(-20100, '     : Недопустима пара ' || p_NBS || '/' || P_OB22  ); end if;
  --------------------------------------------------------------------------------------------------------------------------
  ra.nls := vkrzn( substr(p_branch,2,5),    ra.nbs || '00' || MONEX_RU.ob3(p_ob22) || '00' || substr( substr(p_branch,-4), 1,3)   ) ;

   begin  select * into ra from accounts where kv = p_kv and nls = ra.nls;
          If ra.dazs is NOT null  then  update accounts set dazs = null     where acc=ra.acc;    end if ;
   EXCEPTION WHEN NO_DATA_FOUND THEN

      begin select to_number(val) into ra.rnk from BRANCH_PARAMETERS  where tag='RNK' and branch=P_BRANCH;
      EXCEPTION WHEN NO_DATA_FOUND THEN  ra.rnk := 1 ;       -- найти РНК бранча
      end;

      begin select to_number(val) into ra.ISP from BRANCH_PARAMETERS  where tag='AVTO_ISP' and branch=P_BRANCH;
      EXCEPTION WHEN NO_DATA_FOUND THEN  ra.ISP := gl.aUid ;      -- найти исполнителя для сч
      end;

      begin select id into ra.GRP from  groups_nbs where nbs=ra.NBS and rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN ra.grp := null;       -- найти группу дост для бал.сч
      end;

      op_reg (99,0,0, ra.GRP, p4_, ra.RNK, ra.nls, p_kv, ra.NMS, 'ODB', ra.isp, ra.ACC );

   end;

   -- дополнительно к открытию счета + 12.06.2017    COBUSUPMMFO-851  Sta Авто-Спец парам для счетоа 2909 и 2809
   update accounts set tobo = p_branch where acc=ra.acc ;
   Accreg.setAccountSParam ( ra.acc, 'OB22', p_OB22 )   ;
   If    ra.nbs='2809' then Accreg.setAccountSParam(ra.acc,'R011',9); Accreg.setAccountSParam(ra.acc,'S180',3); Accreg.setAccountSParam(ra.acc,'S240',2) ;
   elsIf ra.nbs='2909' then Accreg.setAccountSParam(ra.acc,'R011',2); Accreg.setAccountSParam(ra.acc,'S180',3); Accreg.setAccountSParam(ra.acc,'S240',2) ;
   end if ;

   declare
     -- Демкович.М.С <DemkovichMS@oschadnybank.com>
     -- Ми думаємо, що правильно було би залишки із старих рахунків перенести на нові
     -- та закрити старі рахунки автоматично без втручання наших бух.
     ro oper%rowtype;
   begin
     ro.tt  := '015';
     for k in (select * from accounts  where nbs = ra.nbs and ob22= p_ob22 and branch=p_branch and kv =p_kv and nls <> ra.nls and dazs is null     )
     loop
        If k.ostc <>0 then
           If k.ostc >0 then ro.dk := 1; ro.s :=  k.ostc;
           else              ro.dk := 0; ro.s := -k.ostc;
           end if;
           gl.ref (ro.REF);
           gl.in_doc3(
              ref_  => ro.REF  , tt_=>ro.tt,  vob_  => 6       ,  nd_   => substr(to_char(ro.REF),-10),
              pdat_ => SYSDATE , vdat_ => GL.BDATE             ,  dk_   => ro.dk   ,
              kv_   => k.kv    , s_ => ro.s,  kv2_  => k.kv    ,  s2_   => ro.s    ,  sk_   => NULL   ,
              data_ => gl.BDATE, datp_ => gl.bdate             ,
              nam_a_=> substr(k.nms,1,38)  ,  nlsa_ => k.nls   ,  mfoa_ => gl.aMfo ,
              nam_b_=> substr(ra.nms,1,38) ,  nlsb_ => ra.nls  ,  mfob_ => gl.aMfo ,
              nazn_ => 'Автоматичне згорнення залишку в зв`язку з вiдкриттям нового рахунку',
              d_rec_=> null,id_a_=>gl.aOkpo,  id_b_ => gl.aOkpo,
              id_o_ => null,sign_=>null    ,  sos_  => 1       ,  prty_ => null,  uid_  => null );

           gl.payv(0,ro.REF,gl.bDATE,ro.tt,ro.dk, k.kv ,k.nls, ro.s, k.kv, ra.nls, ro.s);
           gl.pay (2,ro.REF,gl.bDATE);

        end if;
        update accounts set dazs = gl.bdate + decode (k.ostc,0,0,1) where acc = k.acc;
     end loop;

   end;

   RETURN;
end op_NLSM;

-------работа с одним бранчем---------------------------
procedure OP_branch ( p_Branch3 varchar2 ) IS
  p_kv number;
BEGIN
  -- цикл по системам
  for s in (select * from SWI_MTI_LIST)
  loop
     -- проверка, что по системе есть валюта хоть одна
     begin
        select kv into p_kv from swi_mti_curr where num=s.num and rownum<2;
     exception when no_data_found then
        raise_application_error(-20100, 'Для системи ' || s.name || ' не задано жодної валюти у довіднику swi_mti_curr.');
     end;

     -- 980 всегда отрываем
     MONEX_RU.op_NLSM   ( p_nbs =>'6110',  p_ob22 => s.OB22_KOM ,  p_branch => substr(p_branch3,1,15) , p_kv => 980);
     if s.OB22_2809 is not null then
         MONEX_RU.op_NLSM   ( p_nbs =>'2809',  p_ob22 => s.OB22_2809,  p_branch => p_branch3,               p_kv => 980 );
     end if;
     MONEX_RU.op_NLSM   ( p_nbs =>'2909',  p_ob22 => s.OB22_2909,  p_branch => p_branch3,               p_kv => 980 );

     -- по каждой из допустимых валют открываем счтета
     for s2 in (select * from swi_mti_curr where num=s.num)
     loop
        if s.OB22_2809 is not null then
            MONEX_RU.op_NLSM( p_nbs =>'2809',  p_ob22 => s.OB22_2809,  p_branch => p_branch3,               p_kv => s2.kv);
        end if;
        MONEX_RU.op_NLSM( p_nbs =>'2909',  p_ob22 => s.OB22_2909,  p_branch => p_branch3,               p_kv => s2.kv);
     end loop;

  end loop;
END OP_branch;


---------Главная процедура
procedure OP_nls_MTI (b1_ varchar2, b2_ varchar2, b3_ varchar2, b4_ varchar2, b5_ varchar2 ) IS

BEGIN
  If b1_ is not null then MONEX_RU.OP_branch ( p_Branch3 => b1_); end if;
  If b2_ is not null then MONEX_RU.OP_branch ( p_Branch3 => b2_); end if;
  If b3_ is not null then MONEX_RU.OP_branch ( p_Branch3 => b3_); end if;
  If b4_ is not null then MONEX_RU.OP_branch ( p_Branch3 => b4_); end if;
  If b5_ is not null then MONEX_RU.OP_branch ( p_Branch3 => b5_); end if;
end OP_nls_MTI ;

--------------------------------------------------

-- header_version - возвращает версию заголовка пакета MONEX_RU
   FUNCTION header_version   RETURN VARCHAR2 is
   BEGIN
      RETURN 'Package header MONEX_RU ' || g_header_version;
   END header_version;

-- body_version - возвращает версию тела пакета MONEX_RU
   FUNCTION body_version     RETURN VARCHAR2 is
   BEGIN
      RETURN 'Package body MONEX_RU ' || g_body_version;
   END body_version;


end monex_RU;
/