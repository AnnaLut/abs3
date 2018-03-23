

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_TO_BPK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_TO_BPK ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_TO_BPK ( p_nd cc_deal.nd%type) is
/*
16.03.2017 Sta +Litvin

02/03/2017 LSO Код операції змінив на новий CMK, + перевірка на картковий продукт.
21.02.2017 Sta Процедура дополнительной бизнес-логики, которая выполныется при авторизации КЭШ-кредина на БПК с дисконтом в теле кредита
------------------------------------------

Нехай кредит  = -50.00 ( такий має бути залишок на 2203)
Нехай дисконт = + 3.00 ( такий має бути залишок на 2206)
----------------------------------------------------------
•  В OPER буде запис    з реф ХХХХХ
DK    = 1
NLSA  = 2203* ( або що-угодно)
NLSB  = 2625*  -- Обовязково тільки це !
S     = 47.00
Ця сума 47.00  з цим реф  ХХХХХ  відправляэться до ПЦ.
як вибрати 2625* ? лише прив’язаний до КД.
----------------------------------------------------------
• В OPLDOK з реф ХХХХХ  буде складна бух.мордель, тобто такі  проводки
Деб   Крд   Сума
2203  2924  50.00 – по факту  \
2924  2206   3.00 – по факту  / Чорні
2924  2625  47.00 – по плану  - Зелена

Після квитовки з ПЦ зелена проводка –-> Почорніє .
І якщо це відбудеться в один день – чудово ! Інакще – матимемо  нічне сальдо на 2924 .
----------------------------------------------------------
ПС. В діючій програмі KWT_2924  ця «трійця»  50-3 = 47 автоматично НЕ заквитується.
Але по признаку збалансованості в єдиному реф.ХХХХ
Можна буде доробити алгоритм квитовки, але про це трохи пізніше – з О.Орлик.
*/
   dd     cc_deal%rowtype  ;
   a2202  accounts%rowtype ;
   a2625  accounts%rowtype ;
   cu     customer%rowtype ;
   a2206  accounts%rowtype ;
   oo     oper%rowtype     ;
   l_2924  accounts.NLS%type ;
   g_errN number := -20203 ;
   g_errS varchar2(50)     := 'CCK_to_BPK:КД '||p_nd||' Не знайдено ' ;
   l_err  varchar2(100)    ;
   s_SDI  varchar2(50)     ;
begin
   begin
      l_err:= '';         select d.* into dd    from cc_deal  d where nd = p_nd and sos <13 ;
      l_err:= 'рах.SS';   select a.* into a2202 from accounts a, nd_acc n where n.nd=dd.nd and n.acc=a.acc and a.tip='SS ';
      l_err:= 'рах.SDI';  select a.* into a2206 from accounts a, nd_acc n where n.nd=dd.nd and n.acc=a.acc and a.tip='SDI';
      l_err:= 'рах.2625'; select a.* into a2625 from accounts a, nd_acc n, w4_acc w where n.nd=dd.nd and n.acc=a.acc and a.nbs='2625' and a.rnk=dd.rnk and a.acc = w.acc_pk and card_code like 'STND_MYCR_UA%';
      l_err:= 'РНК кл.'||dd.rnk; select c.* into cu from customer c       where rnk = dd.rnk ;
      l_err:= 'Суму рекв.Дисконту';  select txt into s_SDI from nd_txt    where nd  = dd.nd and tag = 'S_SDI';
      s_SDI:=  replace  ( s_SDI, '.', '' );
      s_SDI:=  replace  ( s_SDI, ',', '' );
      begin    l_err:= 'Число-Дисконт';   a2206.ostc := to_number (s_SDI);
      exception when others then raise_application_error(g_errn, g_errS||l_err )  ;
      end;
   EXCEPTION WHEN NO_DATA_FOUND  THEN raise_application_error(g_errn, g_errS||l_err )  ;
   end;

   oo.TT   := 'CMK';
   oo.nazn := 'Перерахування суми кредиту на БПК згідно КД №'||dd.cc_id|| ' від '|| to_char(dd.sdate, 'dd.mm.yyyy');
   a2202.ostc := dd.limit *100 ;
   oo.s    :=  a2202.ostc - a2206.OSTC ;
   oo.nd   := Substr(dd.cc_id,1,10);
   oo.vob  := 6 ; --- ???
   oo.kv   := a2202.KV ;
   oo.vdat := gl.bdate ;
   oo.dk   := 1 ;
   oo.nam_a:=Substr( a2202.nms,1,38);     oo.nlsa := a2202.nls ;  oo.mfoa := gl.aMfo;  oo.id_a := cu.okpo ;
   oo.nam_b:=Substr( a2625.nms,1,38);     oo.nlsb := a2625.nls ;  oo.mfob := gl.aMfo;  oo.id_b := cu.okpo ;

   gl.ref (oo.REF);
   gl.in_doc3 (ref_=>oo.REF  ,  tt_ =>oo.tt  , vob_=>oo.vob,  nd_  =>oo.nd   ,pdat_=>SYSDATE, vdat_=>oo.vdat , dk_ =>oo.dk,
                kv_=>oo.kv   ,  s_  =>oo.S   , kv2_=>oo.kv ,  s2_  =>oo.S    ,sk_  => null  , data_=>gl.BDATE,datp_=>gl.bdate,
             nam_a_=>oo.nam_a, nlsa_=>oo.nlsa,mfoa_=>oo.mfoa,nam_b_=>oo.nam_b,nlsb_=>oo.nlsb, mfob_=>oo.mfob,
              nazn_=>oo.nazn ,d_rec_=>null   ,id_a_=>oo.id_a, id_b_=>oo.id_b ,id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
   l_2924 := bpk_get_transit('10',oo.NLSA,oo.NLSB,oo.KV ) ;


   gl.payv(0, oo.ref, oo.vdat, 'KK1', oo.dk,  oo.kv,  a2202.nls,  a2202.ostc,  oo.kv,  l_2924   , a2202.ostc ) ;
   update opldok set txt = 'Видача кредиту для зарахування на картковий рахунок' where ref = gl.aRef and stmt = gl.aStmt;

   gl.payv(0, oo.ref, oo.vdat, 'KK1', oo.dk,  oo.kv,  l_2924   ,  a2206.ostc,  oo.kv,  a2206.nls, a2206.ostc ) ;
   update opldok set txt = 'Комісія за видачу кредиту' where ref = gl.aRef and stmt = gl.aStmt;

   gl.pay (2, oo.ref, oo.vdat);

   gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk,  oo.kv,  l_2924   ,  oo.s      ,  oo.kv,  a2625.nls, oo.s       ) ;
   update opldok set txt = 'Зарахування кредиту на картковий рахунок' where ref = gl.aRef and stmt = gl.aStmt;

end;
/
show err;

PROMPT *** Create  grants  CCK_TO_BPK ***
grant EXECUTE                                                                on CCK_TO_BPK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CCK_TO_BPK      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_TO_BPK.sql =========*** End **
PROMPT ===================================================================================== 
