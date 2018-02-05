

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RETURN_TRANFER.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RETURN_TRANFER ***

  CREATE OR REPLACE PROCEDURE BARS.RETURN_TRANFER (
                       p_REF1          NUMBER,       -- Старий референс виплаченого переказу
                       p_REASON        VARCHAR2,     -- Причина повернення
                       p_kom           number,       -- Сума комісії В ВАЛЮТI
                       p_Code          OUT INT,      -- null - без помилок , інше з помилками
                       p_Message       OUT VARCHAR2, -- Текст помилки
                       p_ref2          OUT number    -- Новий референс  створеного документа на возврат перевода
                       )
is

/*
 02.02.2018 Исправление Ошибки "Обратные проводки с асинхронным stmt" - Нашел ММ - спс.
 23.11.2017 Трансфер-2017 7109.02 ===> 7509.02	за операціями з клієнтами

 Заявка .....
 Гришков Максим Валерійович GrishkovMV@oschadbank.ua
 тел. +38(044)249-31-60
*/
   oo oper%rowtype    ;
   ss SWI_MTI_LIST%rowtype;
   pp opldok%rowtype  ;
   ww operw%rowtype   ;
   aa accounts%rowtype;
   bb accounts%rowtype;
   l_7109 accounts.NBS%type := '7509' ;
begin

   If NVL(newnbs.g_state,0)  = 1 then null;  Else  l_7109 := '7109';  end if;


   p_Code :=1 ;
   If nvl(length ( p_REASON ),0)  <5 then
      p_Message := 'НЕ указано причину повернення !'; RETURN;
   end if;

   begin
      select *  into oo from oper where ref = p_ref1;
   EXCEPTION  WHEN NO_DATA_FOUND THEN p_Message := 'Ref1='||p_ref1 || ' НЕ знайдено !'; RETURN;
   end;

   begin
      select s.*  into ss
      from opldok p, accounts  a , SWI_MTI_LIST s
      where p.ref = p_ref1 and p.dk = 0     and p.sos = 5
        and p.acc = a.acc  and a.nbs='2809' and a.ob22=s.ob22_2809  ;
   EXCEPTION  WHEN NO_DATA_FOUND THEN p_Message := 'Ref1='||p_ref1 || ' НЕ є виплатою переказу СМГП !'; RETURN;
   end;

   begin
      select 1  into p_Code
      from opldok p, accounts a
      where p.ref = p_ref1 and p.dk = 0     and p.sos = 5
        and p.acc = a.acc  and a.nbs='2900' and a.ob22='01' and trunc(oo.pdat)  < trunc(sysdate) ;
	p_Message := 'Ref1='||p_ref1 || ' Виплата переказу проводилась з продажою валюти! Повернення переказу неможливе '; RETURN;
   EXCEPTION  WHEN NO_DATA_FOUND THEN null;
   end;

   begin
      select *  into ww  from operw where ref = p_ref1 and tag ='REF92';
      p_Message := 'Анулювання '|| p_ref1|| ' уже виконане ! Див Ref='||ww.value ; RETURN;
   EXCEPTION  WHEN NO_DATA_FOUND THEN null;
   end;

   ---------- уточнить   ------!!!
   oo.tt  := 'MUB'; oo.sk := 32 ; oo.nazn := substr('Прийнято готівку у разі помилкової виплати системного  переказу "'|| ss.name||'"' ,1,160);
   oo.dk  := 1 - oo.Dk;    oo.ref := null; oo.vob := 240;
   pp.txt := 'Анулювання';
   gl.ref(oo.REF);
   -----------------------------

   If trunc(oo.pdat)  < trunc(sysdate) then
      --  повернення - в последующие дни
      If nvl(p_kom,0) <=0 then
         p_Message := 'НЕ указано суму комiciї (iнф.з ЦА ОБ) !' ;   RETURN;
      end if;

      begin
        oo.nlsa  := nbs_ob22_null ('2909',ss.ob22_2909, oo.branch ) ;
        select * into aa from accounts where kv= oo.kv and nls = oo.nlsa and dazs is null;
        oo.nam_a := substr(aa.nms,1,38);
      EXCEPTION  WHEN NO_DATA_FOUND THEN  p_Message := 'Не знайдено рах 2909/'|| ss.ob22_2909 ;  RETURN;
      end;

      begin
        oo.nlsb  := BRANCH_USR.GET_BRANCH_PARAM2('CASH',0);
        select * into bb from accounts where kv= oo.kv and nls = oo.nlsb and dazs is null;
        oo.nam_b := substr(bb.nms,1,38);
      EXCEPTION  WHEN NO_DATA_FOUND THEN  p_Message := 'Не знайдено рах каси' ;  RETURN;
      end;

      gl.in_doc3(ref_=> oo.REF   , tt_   => oo.TT   , vob_  => oo.VOB  , nd_   => oo.nd   , pdat_ => SYSDATE,
              vdat_  => gl.BDATE , dk_   => oo.dk   , kv_   => oo.kv   , s_    => oo.S    , kv2_  => oo.kv2 ,
              s2_    => oo.S     , sk_   => oo.sk   , data_ => gl.bdate, datp_ => gl.bdate,
              nam_a_ => oo.nam_a , nlsa_ => oo.nlsa , mfoa_ => oo.mfoa ,
              nam_b_ => oo.nam_b , nlsb_ => oo.nlsb , mfob_ => oo.mfob , nazn_ => oo.nazn ,
              d_rec_ => oo.d_rec , id_a_ => oo.id_a , id_b_ => oo.id_b , id_o_ => null    ,
              sign_  => null     , sos_  => 1       , prty_ => null    , uid_  => null  ) ;
      gl.payv(0, oo.ref, gl.bdate, oo.tt, 0, oo.kv, oo.nlsa, oo.s, oo.kv, oo.nlsb, oo.s ) ;


      begin
        oo.nlsb  := nbs_ob22_null ( l_7109, '02', oo.branch );
        select * into bb from accounts where kv= 980 and nls = oo.nlsb and dazs is null;
        oo.nam_b := substr(bb.nms,1,38);
      EXCEPTION  WHEN NO_DATA_FOUND THEN  p_Message := 'Не знайдено рах 7109/02' ;  RETURN;
      end;

      oo.s     := p_Kom * 100;
      oo.s2    := gl.p_icurval( oo.kv, oo.s,  gl.bdate  );
      gl.payv(0, oo.ref, gl.bdate, 'D07', 0, oo.kv, oo.nlsa, oo.s, gl.baseval, oo.nlsb, oo.s2 );
   else
      --  повернення - в той же системный день
	  -- oo.VOB :=	 224;
      gl.in_doc3(ref_=> oo.REF   , tt_   => oo.TT   , vob_  => oo.VOB  , nd_   => oo.nd   , pdat_ => SYSDATE,
              vdat_  => gl.BDATE , dk_   => oo.dk   , kv_   => oo.kv   , s_    => oo.S    , kv2_  => oo.kv2 ,
              s2_    => oo.S     , sk_   => oo.sk   , data_ => gl.bdate, datp_ => gl.bdate,
              nam_a_ => oo.nam_a , nlsa_ => oo.nlsa , mfoa_ => oo.mfoa ,
              nam_b_ => oo.nam_b , nlsb_ => oo.nlsb , mfob_ => oo.mfob , nazn_ => oo.nazn ,
              d_rec_ => oo.d_rec , id_a_ => oo.id_a , id_b_ => oo.id_b , id_o_ => null    ,
              sign_  => null     , sos_  => 1       , prty_ => null    , uid_  => null  ) ;
          -- 02.02.2018 Исправление Ошибки "Обратные проводки с асинхронным stmt" - Нашел ММ - спс.
----- for k in (select * from opldok where ref =p_ref1 order by stmt, dk )
----- loop  gl.pay2 (NULL, oo.ref, gl.bdate, k.tt, null, 1-k.dk, to_char(k.acc), k.s, k.sq, 1, pp.txt );  end loop;
       for k in (select od.acc ACCD, ok.acc ACCK, od.s , od.sq , od.tt
                from opldok od, opldok ok 
                where od.ref = p_ref1 and od.dk = 0 and ok.ref = od.ref and ok.dk = 1 and od.stmt = ok.stmt 
               )
      loop gl.pay2 (NULL, oo.ref, gl.bdate, k.tt, null, 1, to_char(k.accD), k.s, k.sq, 1, pp.txt );  
           gl.pay2 (NULL, oo.ref, gl.bdate, k.tt, null, 0, to_char(k.accK), k.s, k.sq, 0, pp.txt );  
      end loop;

   end if;


   insert into operw (ref, tag, value)
    select oo.ref, tag, value from operw where ref = p_ref1 and tag in ('ADRES','ATRT','FIO','NAMED','PASPN','REZID');

   Insert into operw (ref, tag, value) values ( oo.ref, 'BACKV', p_REASON );


   Insert into operw (ref, tag, value) values ( p_ref1, 'REF92', to_char(oo.ref) );
   Insert into operw (ref, tag, value) values ( oo.ref, 'REF92', to_char(p_ref1) );

   p_Code :=0 ;
   p_ref2 := oo.ref;
end;
/
show err;

PROMPT *** Create  grants  RETURN_TRANFER ***
grant EXECUTE                                                                on RETURN_TRANFER  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RETURN_TRANFER  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RETURN_TRANFER.sql =========*** En
PROMPT ===================================================================================== 
