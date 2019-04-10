
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/monex_ru.sql =========*** Run *** ==
 PROMPT ===================================================================================== 

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

--Блокировка счетов ПС 2909 и 2809   
procedure stop_start_operations ( p_mode int , p_kod_nbu varchar2 ); 

procedure add_kod_nbu (p_kod_nbu varchar2, p_id varchar2, 
                       p_NAME_SWI varchar2, p_NAME_MONEX0 varchar2, p_DESC_SWI varchar2,
                       p_nlst varchar2, p_mfob  varchar2, p_nlsb varchar2, 
                       p_ob22_2909 varchar2, p_ob22_2809 varchar2, p_ob22_kom varchar2);
procedure upd_kod_nbu (p_kod_nbu varchar2, p_id varchar2, 
                       p_NAME_SWI varchar2, p_NAME_MONEX0 varchar2, p_DESC_SWI varchar2,
                       p_nlst varchar2, p_mfob  varchar2, p_nlsb varchar2, 
                       p_ob22_2909 varchar2, p_ob22_2809 varchar2, p_ob22_kom varchar2);  
                       
end monex_RU;
/
CREATE OR REPLACE PACKAGE BODY BARS.MONEX_RU IS

 -- Системы педеводов. Единое онко. Клиринг. Профикс.
 -- Уровень РУ (там, где есть точки обслуживания клиентов)
 -- Сам пакедж  monex(порождение клиринговых платежей - в ГОУ)

   g_body_version   CONSTANT VARCHAR2 (64) := 'version 2  08.11.2017 ';

/*
01.02.2018 Sta COBUMMFO-6497   
  1) функція «Відкриття рахунків для роботи Бр-3 в МТІ» відкриваються рахунки з некоректними спецпараметрами.
     Просимо для рахунків 2809 спецпараметр R011=9 змінити на R011=6, а
     для рахунків 2909 спецпараметр R011=2 змінити на R011=0
  2) обхожу без "свала" попытки открыть счета для систем, у которых в настройках остались закрытые об22

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

  If ra.NBS is null then RETURN ; end if ; ------------raise_application_error(-20100, '     : Недопустима пара ' || p_NBS || '/' || P_OB22  ); 
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

--для рахунків 2809 спецпараметр R011=9 змінити на R011=6
--для рахунків 2909 спецпараметр R011=2 змінити на R011=0

   If    ra.nbs='2809' then Accreg.setAccountSParam(ra.acc,'R011',6); Accreg.setAccountSParam(ra.acc,'S180',3); Accreg.setAccountSParam(ra.acc,'S240',2) ;
   elsIf ra.nbs='2909' then Accreg.setAccountSParam(ra.acc,'R011',0); Accreg.setAccountSParam(ra.acc,'S180',3); Accreg.setAccountSParam(ra.acc,'S240',2) ;
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
  for s in (select * from SWI_MTI_LIST sml
            where exists (select m.kod_nbu from MONEX0 m where sml.kod_nbu = m.kod_nbu 
                                                               and m.is_active = 1))
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
-------работа с одним бранчем---------------------------

--Блокировка счетов ПС 2909 и 2809
procedure stop_start_operations ( p_mode int , p_kod_nbu varchar2 ) IS --p_mode=1 - блокируем
  acc_count number;                                                    --p_mode=0 - разблокируем
  ERR_USER  EXCEPTION;  
  ERR_PROC  EXCEPTION;
  l_trace    varchar2(1000) := 'MONEX_RU.stop_start_operations:';                                                  
BEGIN
  if (bars_context.current_branch_code <> '/')
    then raise ERR_USER;
  end if;    
select count(a.acc) into acc_count
  from ACCOUNTS a
 where a.dazs is null--не закрытые
   and ((a.ob22 in (select m.ob22
                      from MONEX0 m
                     where m.kod_nbu = p_kod_nbu
                      -- and m.is_active = 1
                       ) and a.nbs = '2909' and a.blkk <> p_mode) or
       (a.ob22 in (select m.ob22_2809
                      from MONEX0 m
                     where m.kod_nbu = p_kod_nbu
                      -- and m.is_active = 1
                       ) and a.nbs = '2809') and a.blkd <> p_mode);
if acc_count = 0 then raise ERR_PROC;
else                             
    for b in (select kf from mv_kf)--по бренчам
      loop
        bc.go (b.kf);
        for ak in (select a.acc --счета по ПС по кредиту
                    from ACCOUNTS a
                   where a.kf = b.kf
                     and a.nbs = '2909'
                     and a.dazs is null--не закрытые
                     and a.ob22 in
                   (select m.ob22
                      from MONEX0 m
                     where m.kod_nbu = p_kod_nbu
                      -- and m.is_active = 1
                       )
                     and a.blkk <> p_mode         
                    )                                       
          loop              
            Accreg.setAccountSParam(ak.Acc, 'BLKK', p_mode );
          end loop;
        for ad in (select a.acc --счета по ПС по дебету
                    from ACCOUNTS a
                   where a.kf = b.kf
                     and a.nbs = '2809'
                     and a.dazs is null--не закрытые
                     and a.ob22 in
                   (select m.ob22_2809
                      from MONEX0 m
                     where m.kod_nbu = p_kod_nbu
                      -- and m.is_active = 1
                       ) 
                     and a.blkd <> p_mode        
                    )                    
          loop
            Accreg.setAccountSParam(ad.Acc, 'BLKD', p_mode );
          end loop;             
      end loop;
update monex0 m
       set m.is_active = decode (p_mode, 1, 0, 1)
where m.kod_nbu = p_kod_nbu;
    bc.home;
end if;      
exception  
WHEN ERR_USER THEN  
     bars_error.raise_nerror ( 'MNX', 'ERR_USER');  
     bc.home;    
WHEN ERR_PROC THEN
     bars_error.raise_nerror ( 'MNX', 'ERR_PROC');
     bc.home;
WHEN OTHERS THEN
    bars_audit.trace(l_trace||' ошибка '||sqlerrm); 
    bc.home;    
END stop_start_operations;

--Добавление ПС
procedure add_kod_nbu (p_kod_nbu varchar2, p_id varchar2,    
                       p_NAME_SWI varchar2, p_NAME_MONEX0 varchar2, p_DESC_SWI varchar2,
                       p_nlst varchar2, p_mfob  varchar2, p_nlsb varchar2, 
                       p_ob22_2909 varchar2, p_ob22_2809 varchar2, p_ob22_kom varchar2) IS
  v_kod_nbu_monex0 varchar2 (255); 
  v_txt_d060       varchar2 (255);
  v_id_mon0        number;                                             
  ERR_USER         EXCEPTION;  
  ERR_KOD_NBU      EXCEPTION;
  NOT_KOD_NBU      EXCEPTION;
  NOT_ID_PROFIX    EXCEPTION;
  NOT_OB           EXCEPTION;
  l_trace    varchar2(1000) := 'MONEX_RU.add_kod_nbu:';                                                  
BEGIN
  v_kod_nbu_monex0 := null;
if (bars_context.current_branch_code <> '/')
      then raise ERR_USER;
elsif p_kod_nbu is null
      then raise NOT_KOD_NBU;  
elsif p_id is null
      then raise NOT_ID_PROFIX; 
elsif (p_ob22_2909 is null and p_ob22_2809 is null) or p_ob22_kom is null
      then raise NOT_OB;                
else
  begin
     select m.kod_nbu, d060.txt, (select max(id)+1 from monex0) as id_mon0
       into v_kod_nbu_monex0, v_txt_d060, v_id_mon0
        from monex0 m
       right join kl_d060 d060
          on m.kod_nbu = d060.d060 
         and d060.d_close is not null 
       where d060.d060 = p_kod_nbu;
   exception when NO_DATA_FOUND then--системмы нет в справочнике d060
    select max(id)+1 into v_id_mon0 from monex0;
  end;              
 if v_kod_nbu_monex0 is not null
       then raise ERR_KOD_NBU; --ошибка такая системма уже существует
     else
        insert into monex0(KOD_NBU, NAME, nlst, mfob,nlsb,ob22,ob22_2809, ob22_kom, is_active, id) 
        values(p_kod_nbu, nvl (p_NAME_MONEX0, v_txt_d060), p_nlst, p_mfob, p_nlsb,p_ob22_2909, p_ob22_2809, p_ob22_kom, 1, v_id_mon0);
        insert into swi_mti_list (num, id, name, description, ob22_2909, ob22_2809, ob22_kom, kod_nbu)
        values (v_id_mon0, p_id, nvl (p_NAME_SWI ,v_txt_d060), nvl (p_DESC_SWI ,v_txt_d060), p_ob22_2909, p_ob22_2809, p_ob22_kom, p_kod_nbu); 
     end if;  
   FOR  M IN ( SELECT * FROM MV_KF)--перенос тригера TRIGGER TAI_SWIMTILIST  after insert ON SWI_MTI_LIST for each row
   LOOP BC.GO (M.kf) ;--открываем счета
       for k in (select DISTINCT (b.BRANCH) BRANCH 
                   from BRANCH_PARAMETERS p 
                   join BRANCH b on b.BRANCH = p.BRANCH
                  where p.tag ='SWI' and p.val='1' and b.DATE_CLOSED is null 
                    and substr (p.branch, 2 ,6)= M.kf and length (p.branch) = 22
                    and exists (select prnk.branch from BRANCH_PARAMETERS prnk where prnk.tag='RNK' and prnk.branch = b.branch))
       loop if k.branch is not null then MONEX_RU.op_NLSM ( p_nbs =>'6110',  p_ob22 => p_ob22_kom ,  p_branch => k.branch, p_kv => gl.baseval ); end if;  end loop;

       for k in (select b.branch 
                   from BRANCH_PARAMETERS p 
                   join BRANCH b on b.BRANCH = p.BRANCH 
                  where p.tag ='SWI' and p.val='1' and b.DATE_CLOSED is null 
                    and substr (p.branch, 2 ,6)= M.kf and length (p.branch) = 22
                    and exists (select prnk.branch from BRANCH_PARAMETERS prnk where prnk.tag='RNK' and prnk.branch = b.branch))
       loop     --grishkovmv@oschadbank.ua (Mastercard Moneysend не предусмотрено открытие ОБ22 для 2809)
          if k.branch is not null then
          if p_ob22_2809 is not null then    MONEX_RU.op_NLSM ( p_nbs =>'2809',  p_ob22 => p_ob22_2809,  p_branch => k.branch, p_kv => gl.baseval );  end if;
          MONEX_RU.op_NLSM ( p_nbs =>'2909',  p_ob22 => p_ob22_2909,  p_branch => k.branch, p_kv => gl.baseval );
          end if;
     -- по каждой из допустимых валют открываем счтета
/*     for s2 in (select * from swi_mti_curr where num=s.num)-- встака из MONEX_RU.OP_branch 
     loop
        if p_ob22_2809 is not null then
            MONEX_RU.op_NLSM( p_nbs =>'2809',  p_ob22 => p_ob22_2809,  p_branch => k.branch, p_kv => s2.kv);
        end if;
        MONEX_RU.op_NLSM( p_nbs =>'2909',  p_ob22 => p_ob22_2909,  p_branch => k.branch, p_kv => s2.kv);
     end loop;*/  
      end loop ; -- K       
   END LOOP ; --- M                    
end if;         
exception  
WHEN ERR_USER THEN  
     bars_error.raise_nerror ( 'MNX', 'ERR_USER');  
     bc.home;    
WHEN ERR_KOD_NBU THEN
     bars_error.raise_nerror ( 'MNX', 'ERR_KOD_NBU');
     bc.home;
WHEN NOT_KOD_NBU THEN
     bars_error.raise_nerror ( 'MNX', 'NOT_KOD_NBU');
     bc.home;
WHEN NOT_OB THEN
     bars_error.raise_nerror ( 'MNX', 'NOT_OB');
     bc.home;     
WHEN NOT_ID_PROFIX THEN
     bars_error.raise_nerror ( 'MNX', 'NOT_ID_PROFIX');
     bc.home;          
WHEN OTHERS THEN
    bars_audit.trace(l_trace||' ошибка '||sqlerrm); 
    bc.home;    
END add_kod_nbu;

--Изменение ПС
procedure upd_kod_nbu (p_kod_nbu varchar2, p_id varchar2, 
                       p_NAME_SWI varchar2, p_NAME_MONEX0 varchar2, p_DESC_SWI varchar2,
                       p_nlst varchar2, p_mfob  varchar2, p_nlsb varchar2, 
                       p_ob22_2909 varchar2, p_ob22_2809 varchar2, p_ob22_kom varchar2) IS                                            
  ERR_USER         EXCEPTION;  
  NOT_KOD_NBU      EXCEPTION;
  NOT_ID_PROFIX    EXCEPTION;  
  l_trace    varchar2(1000) := 'MONEX_RU.upd_kod_nbu:';                                                  
BEGIN
if (bars_context.current_branch_code <> '/')
      then raise ERR_USER;
elsif p_kod_nbu is null
      then raise NOT_KOD_NBU;  
elsif p_id is null
      then raise NOT_ID_PROFIX;    
else
       update monex0 m0
          set m0.name      = p_NAME_MONEX0,          
              m0.nlst      = p_nlst,
              m0.mfob      = p_mfob,
              m0.nlsb      = p_nlsb,
              m0.ob22      = p_ob22_2909,
              m0.ob22_2809 = p_ob22_2809,
              m0.ob22_kom  = p_ob22_kom
        where m0.kod_nbu   = p_kod_nbu;
       update swi_mti_list s
          set s.id        = p_id,
              s.name      = p_NAME_SWI,
              s.description = p_DESC_SWI,
              s.ob22_2909 = p_ob22_2909,
              s.ob22_2809 = p_ob22_2809,
              s.ob22_kom  = p_ob22_kom
        where s.kod_nbu   = p_kod_nbu;
end if;         
exception  
WHEN ERR_USER THEN  
     bars_error.raise_nerror ( 'MNX', 'ERR_USER');  
     bc.home;    
WHEN NOT_KOD_NBU THEN
     bars_error.raise_nerror ( 'MNX', 'NOT_KOD_NBU');
     bc.home;
WHEN NOT_ID_PROFIX THEN
     bars_error.raise_nerror ( 'MNX', 'NOT_ID_PROFIX');
     bc.home; 
WHEN OTHERS THEN
    bars_audit.trace(l_trace||' ошибка '||sqlerrm); 
    bc.home;    
END upd_kod_nbu;

end monex_RU;
/
 show err;
 
PROMPT *** Create  grants  MONEX_RU ***
grant EXECUTE                                                                on MONEX_RU        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MONEX_RU        to CUST001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/monex_ru.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 
