

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CP_ZAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CP_ZAL ***

  CREATE OR REPLACE PROCEDURE BARS.P_CP_ZAL        ( p_nls varchar2, -- счет залога
                 p_acc int     , -- acc счета ЦБ
                 p_kv  int     ,p_pawn int     ,p_ID  number,p_nd   varchar2,
                 p_rnk Int     ,p_ob22 varchar2,p_s   number,p_ref  int     ,
                 mode_ int ) is

-- mode_  =  0 - Оприбуткування
--          1 - Списання

l_nms   accounts.nms%type;
l_Acc   accounts.acc%type;
l_pap   accounts.pap%type;
l_dk    oper.dk%type;
ref_    integer;
l_nmsk  accounts.nms%type;
l_nlsk  accounts.nls%type;
l_NAZN  oper.nazn%type;
flg37_  char(1);
l_cp_id cp_kod.cp_id%type;
l_nd    oper.nd%type;
l_okpo  customer.okpo%type;
l_s     oper.s%type;


begin
   if p_s=0 or nvl(p_acc,0) = 0 THEN RETURN; end if;
   l_nd := p_nd;
   if mode_ = 0 THEN -- Новый залог
      begin
         select nmk||' Забезпечення' into l_nms from customer where rnk=p_rnk;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_error.raise_error('DPT',109);
      end;
      -- открытие счета залога
      Op_Reg(2      , -- счет залога
             null   , -- номера договора нет для ценных бумаг
             p_pawn , -- вид залога
             1      , -- место нахождения залога (1 у заставодавця)
             l_nd   , -- номер договора залога (пишем номер тикета)
             p_rnk  , -- РНК
             p_nls  , -- номер счета,
             p_KV   , -- код валюты (980),
             l_nms  , -- Наименование счета
             'ZAL'  , -- Тип счета
             user_id, -- исполнитель
             l_Acc);  -- acc счета

      if getglobaloption('HAVETOBO') = 2 or gl.amfo ='300465' then
         begin
            execute immediate 'INSERT INTO specparam_int (ACC,OB22) VALUES ('||l_acc||','''||p_ob22||''' )';
         EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
            execute immediate 'UPDATE specparam_int SET OB22='''||p_ob22 ||''' WHERE  acc = '||l_acc;
         end;
      end if;
      --связка  залогов и ЦБ (привязываем к счету)
      begin
         execute immediate 'insert into cc_accp (accs, acc, nd, rnk) values ( '|| p_acc || ',' || l_acc ||','|| p_ref ||','|| p_rnk ||' ) ' ;
      EXCEPTION WHEN DUP_VAL_ON_INDEX THEN  null;
      end ;
      -- pawn_acc
      begin
         execute immediate 'insert into pawn_acc (acc,pawn,mpawn) values ( '|| p_acc || ',' || p_pawn ||', 1 ) ' ;
      EXCEPTION WHEN DUP_VAL_ON_INDEX THEN  null;
      end ;
   else
      begin
         select acc into l_acc from accounts where nls=p_nls and kv=p_kv;
      EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
      end;
   end if;
   begin
      select cp_id into l_cp_id from cp_kod where id=p_id;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      l_cp_id := Null;
   end;

   select Substr(tobopack.GetTOBOParam('NLS_9900'),1,15) into l_nlsk from dual;
   begin
      select nms into l_nmsk from accounts where nls=l_nlsk and kv=p_kv;
   EXCEPTION WHEN NO_DATA_FOUND THEN
       bars_error.raise_error('DPT',25);
   end;
    -- Проводка по залогам
   SELECT  a.pap INTO l_pap FROM accounts a WHERE a.nls=p_nls and a.kv=p_kv;

   if p_s>0 THEN
      l_nazn := 'Оприбуткування';
   else
      l_nazn := 'Списання';
   end if;

   l_nazn := l_nazn || ' забезпечення за ЦП ' || l_cp_id;
   -- увеличение залога пассивные счета
   If    p_s > 0 and l_Pap = 2 THEN l_Dk := 1;
   -- уменьшение залога пассивные счета
   ElsIf p_s < 0 and l_Pap = 2 THEN l_Dk := 0;
   -- увеличение залога активные счета
   ElsIf p_s > 0 and l_Pap = 1 THEN l_Dk := 0;
   -- уменьшение залога активные счета
   ElsIf p_s < 0 and l_Pap = 1 THEN l_Dk := 1;
   end if;
   l_s := Abs(p_s)*100;
   BEGIN
     SELECT SUBSTR (val, 1, 14) INTO l_okpo
       FROM params
      WHERE par = 'OKPO';
   EXCEPTION WHEN NO_DATA_FOUND THEN
        l_okpo := '';
   END;
   logger.info('CP_K: p_nls = ' || p_nls) ;
   logger.info('CP_K: l_nlsk= ' || l_nlsk) ;

   gl.ref (ref_);
   gl.in_doc2(ref_,
              'ZAL',
              6,
              l_nd,
              SYSDATE,
              gl.bDATE,
              l_dk,
              p_kv,
              l_s,
              p_kv,
              l_s,
              NULL,
              NULL,
              gl.bDATE,
              SYSDATE,
              l_nmsk,
              l_nlsk,
              gl.aMFO,
              l_nms,
              p_nls,
              gl.aMFO,
              l_NAZN,
              null,
              l_okpo,
              l_okpo,
              NULL,
              NULL,
              0,
              0,
              NULL);

   -- 37 - Оплата по факт.залишку = 1 / По план.залишку = 0 / Не платити = 2
   begin
      select substr(flags,38,1) into flg37_ from tts where tt = gl.doc.tt;
   exception when no_data_found then
      flg37_ :=0;
   end;

   gl.dyntt2 (   sos_   => gl.doc.sos,
                 mod1_  => flg37_,
                 mod2_  => 1,
                 ref_   => gl.doc.ref,
                 vdat1_ => gl.doc.vdat,
                 vdat2_ => gl.doc.vdat,
                 tt0_   => gl.doc.tt,
                 dk_    => gl.doc.dk,
                 kva_   => gl.doc.kV,
                 mfoa_  => gl.doc.mfoa,
                 nlsa_  => gl.doc.nlsa,
                 sa_    => gl.doc.s,
                 kvb_   => gl.doc.kv2,
                 mfob_  => gl.doc.mfob,
                 nlsb_  => gl.doc.nlsb,
                 sb_    => gl.doc.s2,
                 sq_    => gl.doc.sq,
                 nom_   => 0);


end;
/
show err;

PROMPT *** Create  grants  P_CP_ZAL ***
grant EXECUTE                                                                on P_CP_ZAL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CP_ZAL        to RCC_DEAL;
grant EXECUTE                                                                on P_CP_ZAL        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CP_ZAL.sql =========*** End *** 
PROMPT ===================================================================================== 
