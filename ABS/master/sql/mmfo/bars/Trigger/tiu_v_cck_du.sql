

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_V_CCK_DU.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_V_CCK_DU ***

  CREATE OR REPLACE TRIGGER BARS.TIU_V_CCK_DU INSTEAD OF  UPDATE or delete  on  V_CCK_DU REFERENCING NEW AS NEW OLD AS OLD  FOR EACH ROW
declare
  l_nd  number   ; l_rnk number       ;  JJ arjk%rowtype     ;
  DAT1_old date  ; DAT1_new date      ;  DAT2_old date       ; DAT2_new date ;    dat1_ date    ; dat2_ date    ;
  daos_    date  ; Mode_ int          ;  sErr_ varchar2(55)  := '\      Недопустимi дати';
  aa     accounts%rowtype ;
  a2701  accounts%rowtype ;   a2708  accounts%rowtype ;
  dd     cc_deal%rowtype  ;
  l_acra number ;
  l_acrb number ;
  l_acc  number  ;
  l_2233 int ;
------------------
BEGIN
  DAT1_old := :old.DAT1 ;  DAT1_new := :new.DAT1 ;
  DAT2_old := :old.DAT2 ;  DAT2_new := :new.DAT2 ;
  l_nd     := :old.ND   ;  l_rnk    := :old.rnk  ;

  if deleting then     delete from nd_txt where nd = l_nd and tag in ( 'DO_DU',  'DINDU','ARJK');
     return;
  end if;

  If :new.arjk is null  then       raise_application_error(-20203,'НЕ задано код установи', TRUE);
  end if;

  begin
     select * into JJ from arjk where id = :new.arjk;
  exception when no_data_found then  raise_application_error(-20203,'НЕ знайдено код установи ' || :new.arjk, TRUE);
  end;

  If  DAT1_new < :old.SDATE  OR   DAT2_new > :old.WDATE then     raise_application_error(-20203,
'DIU: Дата включення в пул ='|| to_char(DAT1_new ,'dd.mm.yyyy') || ' МЕНША  дати початку КД='|| to_char(:old.SDATE ,'dd.mm.yyyy')|| '
 або Дата виключення з пулу='|| to_char(DAT2_new ,'dd.mm.yyyy') || ' БIЛЬША дати заверш. КД='|| to_char(:old.WDATE ,'dd.mm.yyyy'),
TRUE);
  end if;

  If DAT1_new < JJ.dat1 then    raise_application_error(-20203,
'DIU: Дата включення в пул ='|| to_char(DAT1_new ,'dd.mm.yyyy')  || ' МЕНША  дати вiдкриття пулу='|| to_char(JJ.dat1 ,'dd.mm.yyyy') ||
' ' || JJ.name ,   TRUE);
  end if;

  ---------------------
  cck_app.Set_ND_TXT( p_ND  =>l_nd,   p_TAG =>'ARJK',   p_TXT => to_char(JJ.id) );

  If      DAT2_new is null  -- дата исключения пусто
     AND (DAT1_new is not null  and DAT1_old is null  -- дата включения не пусто  и не равно пред.значению
          or
          DAT1_new <> DAT1_old
          ) then
      -- передать  ДУ
      cck_app.Set_ND_TXT( p_ND  =>l_nd,   p_TAG =>'DO_DU',   p_TXT =>to_char(null) );
      cck_app.Set_ND_TXT( p_ND  =>l_nd,   p_TAG =>'DINDU',   p_TXT => to_char(DAT1_new,'dd/mm/yyyy')  );
      mode_ := 1;
  elsIf   DAT1_new = DAT1_old      -- дата включения НЕ поменялась
     and  DAT2_new is not null     -- дата исключения задана
     and  DAT2_new >= DAT1_new     -- дата исключения   >= даты включения
   then
     -- забрать от ДУ
     cck_app.Set_ND_TXT( p_ND  =>l_nd,   p_TAG =>'DO_DU',   p_TXT =>to_char(DAT2_new,'dd/mm/yyyy') );
     mode_ := 2;

  elsIf  DAT1_new is null and DAT1_old is not null     -- дата включения пусто , предыдущая НЕ пусто
   then
     -- удалить, как ошибку от ДУ
     delete from nd_txt x where x.nd = l_nd and x.tag in ('DO_DU','DINDU');
     mode_ := 2;
  else

     raise_application_error(-20203,sErr_ ||'
Дата начала   КД ='||to_char(:old.SDATE ,'dd.mm.yyyy')|| '
Дата завершен КД ='||to_char(:old.WDATE ,'dd.mm.yyyy')|| '
Дата вклч. в пул ='||to_char(DAT1_new   ,'dd.mm.yyyy')|| '
Пред вклч. в пул ='||to_char(DAT1_old   ,'dd.mm.yyyy')|| '
Дата искл.из пула='||to_char(DAT2_new   ,'dd.mm.yyyy')|| '
Дата открыт  пула='||to_char(JJ.dat1    ,'dd.mm.yyyy') ,   TRUE);
   end if ;

   -- флаг ипотеки
   begin
      select a.acc into l_2233  from accounts a, nd_acc n where n.nd = l_nd and n.acc= a.acc and a.nbs ='2233' and ostc<0 and rownum =1;

/*
      If mode_ =2  and nvl( :new.r013, '*' ) not in ('1','9') then
         raise_application_error(-20203,'R013 ('||:new.r013||') HE = 1 або 9 ', TRUE);
      end if;
*/

   exception when no_data_found then l_2233 :=0;
   end;


   If ( getglobaloption('MFOP') = '300465' or gl.aMfo = '300465' )  then

     -- ТОЛЬКО ДЛЯ об. Корпорации.
     for k in (select a.acc, a.nbs , a.accc
               from accounts a
               where rnk = l_rnk and tip in ('SS ','SN ','SP ','SK9','SPN','SK0','ZAL')
                 and exists (select 1 from nd_acc n  where n.nd=l_nd and n.acc= a.acc  union all
                             select 1 from nd_acc n, cc_accp z where n.nd=l_nd and n.acc= z.accs and z.acc= a.acc
                             )
              )
     loop
        if    mode_ = 1 then           --включить в К-файлы
           --1) включить RNK
           begin
             execute immediate   'insert into RNKP_KOD (rnk, kodk) values ( ' || l_rnk || ',' ||  JJ.id || ') ';
           Exception when dup_val_on_index then null;
           end;

           --2) включить ACC
           Begin
             Insert into accountsw (acc, tag, value) values (k.ACC, 'CORPV', 'Y');
           Exception when dup_val_on_index then
             Update accountsw w set w.value = 'Y' where w.acc = k.ACC and w.tag = 'CORPV';
           End;

           If l_2233 > 0 then
/*
Шевченко С.И. <SchevchenkoSI@oschadnybank.com>
СЛУЖБОВА  ЗАПИСКА
Кому:    Директору департаменту інформатизації Колеснікову Ю.В.
Від кого:    Головного бухгалтера-директора департаменту бухгалтерського обліку Костенко Г.С.
Дата    28.08.2013
REF №:    13/1-03/85
Тема:    Щодо доопрацювання АБС „БАРС Millennium”

починаючи зі звітності станом на 02.09.2013 в АБС БАРС першочергово необхідно забезпечити автоматичне заповнення параметрів за кредитами, переданими АРЖК:
- параметру R013=2 та S580=6 за кредитами, які обліковуються на рах.2233 ;
- параметру R013=5 та S580=6 за нар/дох  , які обліковуються на рах.2238  (доходи, нараховані протягом 30 днів).
  У цьому випадку залишок на рахунку 2238 повинен розбиватись на 2 частини: «Доходи, нараховані протягом 30 днів» з параметрами R013=5 та S580=6
                                                                         та «Доходи, нараховані понад 30 днів» з параметрами R013=6 та S580=6;
- параметру S580=6 до усіх похідних рахунків від основного рахунку (рах. 2233) з обліку іпотечного кредиту, переданого АРЖК (наприклад рахунки 2400, 9500).
*/
              If    k.nbs = '2233'  then  update specparam set r013 = '2', s580 = '6' where acc = k.acc ;
                                          update specparam set r013 = '2', s580 = '6' where acc = k.accc;
              elsIf k.nbs = '2238' then   update specparam set r013 = '5', s580 = '6' where acc = k.acc ;
              else                        update specparam set             s580 = '6' where acc = k.acc ;
              end if;
           end if;

        elsif mode_ = 2 then
           --исключить из К-файлов = исключить ACC
/*

при вилученні кредиту із пулу проставляється значення R013 "1" або "9" виконавцем РУ.

R020  R013
2233  1    Довгостр.іпотеч.кредити фiз.особам у НВ,що забезпечені заставою нерух.майна житл.призначення,що належить позичальнику та є вільниіи від обмежень
2233  2    Довгострокові іпотечні кредити, надані фізичним особам та включені до складу іпотечного покриття за іпотечними облігаціями, емітованими фінансовою установою, більше ніж 50% корпоративних прав якої належить державі та/або державним банкам
2233  9    Інші довгострокові іпотечні кредити, що надані фiзичним особам
*/

           delete from accountsw w where w.acc = k.ACC and w.tag = 'CORPV';
           If l_2233 > 0 then

              If    k.nbs = '2233'  then  update specparam set r013 = :new.r013, s580=4       where acc = k.acc ;
                                          update specparam set r013 = :new.r013, s580=4       where acc = k.accc;

              elsIf k.nbs = '2238' then   update specparam set r013 = '3' , s580=4    where acc = k.acc ;
--            else                        update specparam set                        where acc = k.acc ;
              end if;

           end if;
        end if;
     end loop;
  end if;

  If JJ.NLS_2809  is not null and mode_ = 1 then

     --используется пока в УПБ
     select  a.* into aa from accounts a where tip='SS ' and acc in (select acc from nd_acc where nd = l_ND);
     a2701.nls := vkrzn( substr(gl.amfo,1,5),  '27010' || l_nd );

     -- процедура открытия и присоединения счетов к КД по телу кредита 2701
     cck.CC_OP_NLS ( ND_  => l_nd,     KV_  => 980 , NLS_ => a2701.nls  , TIP_PRT => 'DIU' ,  ISP_  => aa.isp,
                     GRP_ => aa.grp,  P080_ => null, MDA_ => aa.mdate, ACC_    => l_acc );
     update accounts set rnk = JJ.rnk where acc = l_acc;


     a2708.nls := vkrzn( substr(gl.amfo,1,5),  '27080' || l_nd );

     -- процедура открытия и присоединения счетов к КД по процентам ДИУ 2708
     cck.CC_OP_NLS ( ND_  => l_nd,     KV_  => 980 , NLS_ => a2708.nls  , TIP_PRT => 'DIU' ,  ISP_  => aa.isp,
                     GRP_ => aa.grp,  P080_ => null, MDA_ => aa.mdate, ACC_    => l_acra );

     update accounts set rnk = JJ.rnk where acc = l_acra;

     begin
       select acc  into l_acrb from accounts where JJ.nls_7061 = nls and kv=980;
     exception when no_data_found then  raise_application_error(-20203,'НЕ знайдено рах.7061 для установи=' || JJ.id, TRUE);
     end;

     Insert into INT_ACCN (ACC,ID,METR,BASEM,BASEY,FREQ, ACR_DAT, ACRA,ACRB) Values (l_acc,1,0,0,0,1,gl.bdate-1, l_acra, l_acrb );
     Insert into INT_RATN (ACC,ID,BDAT,IR) Values (l_acc,1 ,gl.bdate, JJ.ir);

  END IF;

end TIU_v_cck_du ;


/
ALTER TRIGGER BARS.TIU_V_CCK_DU ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_V_CCK_DU.sql =========*** End **
PROMPT ===================================================================================== 
