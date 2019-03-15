

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_S36.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_S36 ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_S36 
(p_flg   SMALLINT      ,  -- флаг оплаты
 p_ref   oper.ref%type ,  -- референция
 p_vdat  oper.vdat%type,  -- дата валютировния
 p_tt    oper.tt%type,    -- тип транзакции
 p_dk    oper.dk%type  ,  -- признак дебет-кредит
 p_kv    oper.kv%type  ,  -- код валюты А
 p_nlsm  oper.nlsa%type,  -- номер счета А
 p_sa    oper.s%type   ,   -- сумма в валюте А
 p_kvk   oper.kv2%type ,  -- код валюты Б
 p_nlsk  oper.nlsb%type,  -- номер счета Б
 p_ss    oper.s2%type     -- сумма в валюте Б
) is

  r_ss     accounts%rowtype ; -- 2062
  r_dd     cc_deal%rowtype  ; -- КД
  r_s36    accounts%rowtype ; -- 3600
  r_sdi    accounts%rowtype ; -- 2066
  r_asdi    accounts%rowtype ; -- 2066
  r_lim    accounts%rowtype ; -- 8999
  r_txt    nd_txt%rowtype   ;
  r_txt_cr9 nd_txt%rowtype   ; -- відновлювальна лінія
  r_isdi   int_accn%rowtype ; -- % карточка 2066
  --------------------
  l_ssdi      number;
  l_ssdi_ss   number;
  l_ssdi_s36  number;
  l_ssdi_sdi  number;
  l_sdi_acc   number;
  l_sdi_nls   varchar2(15);
  l_          int :=0;
  l_nlskk   accounts.nls%type;
  l_kvkk    accounts.kv%type;
  L_3800    VARCHAR2 (155);
  F1_       VARCHAR2 (155);
  C1_       INT;
  i1_       INT;
/*
=====================================
== PAY_S36 процедура Перехвата первого транша по КД
Заявка ГОУ ОБ от 24.04.2013 № 31/5-03/589
Заявка на модифікацію № 14/1-188 ID:486 від 11.04.2014.
=====================================
*/

begin

  begin

    If    p_dk = 1 then  r_ss.nls := p_nlsm ; r_ss.kv := p_kv  ; r_ss.ostc := p_sa;
    elsif p_dk = 0 then  r_ss.nls := p_nlsk ; r_ss.kv := p_kvk ; r_ss.ostc := p_ss;
    else  RETURN;
    end if;

	/*
	з метою уникнення порушення чинного валютного законодавства та застосування штрафних санкцій до АТ «Ощадбанк» (службова у вкладці),
    просимо зробити  заборону проведення в усіх кодах операцій в АБС БАРС (ЦА та РУ) за маскою рахунків:  Дт поточний рахунок клієнта (ЮО та ФО) Кт 3800 (OB22=03) в іноземній валюті або банківських металах:
    поточні рахунки клієнтів : 2600,2650,2541,2542,2544,2545,255,2560,2548,2520,2530,2620,2625 (прошу колег з департаменту бухгалтерського обліку доповнити перелік, якщо щось забула)
 	*/



	if   (p_dk = 1 and regexp_like(p_nlsm, '^(2600)|^(2650)|^(2541)|^(2542)|^(2544)|^(2545)|^(255)|^(2560)|^(2548)|^(2520)|^(2530)|^(2620)|^(2625)') and p_kv  != 980)    or
		 (p_dk = 0 and regexp_like(p_nlsk, '^(2600)|^(2650)|^(2541)|^(2542)|^(2544)|^(2545)|^(255)|^(2560)|^(2548)|^(2520)|^(2530)|^(2620)|^(2625)') and p_kvk != 980)
	    then

	      if p_kv = p_kvk
		      then   l_nlskk  := case p_dk when 1 then p_nlsk else p_nlsm end; l_kvkk   := case p_dk when 1 then p_kvk  else p_kv   end;
		  else

				 begin
						  SELECT TRIM (s3800) INTO L_3800 FROM tts WHERE tt = p_tt AND s3800 IS NOT NULL;
				  EXCEPTION WHEN NO_DATA_FOUND THEN null;
				 end;

				 l_nlskk := gl.dyn_nls ( f       => SUBSTR (L_3800, 3, LENGTH (L_3800) - 3),
				                         REF     => gl.aREF, tt     => p_tt,    vdat    => p_vdat,
								         dk      => p_dk,   mfoa    => gl.aMFO, nlsa    => p_nlsm,  kva     => p_kv,
								         s       => p_sa,   mfob    => gl.aMFO, nlsb    => p_nlsk,  kvb     => p_kvk,
								         s2      => p_ss);
				 l_kvkk :=  case p_dk when 0 then p_kvk  else p_kv   end;
	      end if;

	 -- Рах Б   3800/03  заборонено
	 begin
	    Select 1
		  into l_
		  from accounts
		 where nls = l_nlskk
           and kv  = l_kvkk
		   and nbs = '3800' and ob22 = '03';

        -- Erorr
		  raise_application_error (- (20203), '\9999 - Заборонено кореспонденцію рахунків Дт'|| case p_dk when 1 then p_nlsm||'('||p_kv||')' else p_nlsk||'('||p_kvk||')' end||' Кт'||l_nlskk||' Об22=03');
 		exception when no_data_found then  null;
	 end;

	end if;



    -- Проверка на новый ссудный счет ЮЛ, Фл
    If substr(r_ss.nls,1,2) not in ('20', '22') or substr(r_ss.nls,4,1) > '4'  then
       RETURN;
    end if;

    -- acc 8999
    select accc, isp , grp into r_ss.accc, r_ss.isp, r_ss.grp from accounts where kv=r_ss.kv and nls=r_ss.nls and dazs is null and ostc=0 and ostb=0;

    select a.* into r_lim from accounts a  where acc = r_ss.accc;

    -- Проверка на новый не стандартный КД ЮЛ
    select d.* into r_dd from cc_deal d, nd_acc n where n.acc= r_ss.accc and n.nd= d.nd and d.vidd in (2,3,12,13) and d.sos=10;

    -- COBUSUPABS-5013 блокування перенесення дисконту з рахунку 3600 на 2066 для відновлювальної кредитної лінії
    select t.txt into r_txt_cr9.txt from  nd_txt t where t.nd = r_dd.nd  and t.tag = 'I_CR9';
       if r_txt_cr9.txt = '0' then
               RETURN;
       end if;
    -- Проверка на первую выдачу
    --!!--select dos into r_ss.dos from saldoa where acc=r_ss.accc and dos>0 and rownum=1;
    select count(*) into r_ss.dos from saldoa where acc=r_ss.accc and dos>0;
      if r_ss.dos > 0 then
        RETURN;
      end if;

    -- Проверка на наличие доп.рекв по нач.комиссии - эта сумма указана в валюте договора, т.е. в r_lim.KV
    select * into r_txt from nd_txt where nd = r_dd.nd and tag ='S_SDI';
    begin
      --l_ssdi := nvl(to_number(trim(r_txt.txt)) * 100,0);
      l_ssdi := nvl(cck_app.to_number2(trim(r_txt.txt)) * 100,0);
    exception when others then RETURN;
    end;

    If l_ssdi = 0 then
       RETURN;
    end if;

    -- Проверка на наличие 3600-S36 с остатком , > 0
    select a.* into r_s36 from accounts a, nd_acc n
    where n.acc = a.acc and a.tip = 'S36' and a.nbs = '3600' and a.ostc = a.ostb and a.ostc > 0 and n.nd = r_dd.nd and a.ob22 in ('09','10');

    -- Проверка на достаточность остатка на сч 3600
    If gl.p_icurval(r_lim.kv, l_ssdi, gl.bd) > gl.p_icurval(r_s36.kv, r_s36.ostc, gl.bd) then
       RETURN;
    end if;

    -- Проверка на достаточность остатка на сч 3600
    If gl.p_icurval(r_lim.kv, l_ssdi, gl.bd) > gl.p_icurval(r_ss.kv, r_ss.ostc, gl.bd) then
       RETURN;
    end if;

    -- Ищем счет SDI  в валюте первого транша
    begin
       select a.*  into r_sdi
         FROM nd_acc n, accounts a
        where a.tip = 'SDI'  and n.nd = r_dd.nd
          and a.acc = n.acc  and a.dazs is null
          and (a.nbs like '20_6' or a.nbs like '22_6')
          and a.kv = r_ss.kv;
    exception when NO_DATA_FOUND THEN
          begin
            select a.* into r_asdi
              FROM nd_acc n, accounts a
             where a.tip = 'SDI'  and n.nd = r_dd.nd
               and a.acc = n.acc  and a.dazs is null
               and (a.nbs like '20_6' or a.nbs like '22_6')
               and a.kv <> r_ss.kv and rownum = 1;
            CCK.cc_op_nls(r_dd.nd, r_ss.kv, r_asdi.nls, 'SDI', r_asdi.isp, r_asdi.grp, null, r_asdi.mdate, l_sdi_acc);
          exception when no_data_found then
            select f_newnls2 (r_ss.accc,'SDI',substr(r_ss.nls,1,3)||'6',null, r_ss.kv) INTO l_sdi_nls from dual;
            CCK.cc_op_nls(r_dd.nd, r_ss.kv, l_sdi_nls, 'SDI', r_ss.isp, r_ss.grp, null, r_ss.mdate, l_sdi_acc);
          end;
    end;

    -- Проверка на SDI с 0-остатком
    select a.* into r_sdi from accounts a
    where a.acc = nvl(r_sdi.acc, l_sdi_acc) and a.ostc = a.ostb and a.ostc = 0;

    --узнать % карточку сч SDI
    select i.* into r_isdi from int_accn i where i.acc = r_sdi.acc and i.acrb is not null and rownum = 1;

    -- доделать % карточку 3600 для лин.амортизации
    if nvl(cck_app.Get_ND_TXT(r_dd.nd,'S_S36'),0) = 0 then
      update int_accn set id    = 1,
                          metr  = 4,
                          basem = 0,
                          basey = 0,
                          freq  = 1,
                          acr_dat = (gl.bdate-1) ,
                          tt    = '%%1',
                          acra  = r_s36.acc,
                          acrb  = r_isdi.acrb,
                          s     = 0,
                          io    = 0
              where acc = r_s36.acc;
      if SQL%rowcount = 0 then
         insert into int_accn (ACC,   ID,METR,BASEM,BASEY,FREq,ACR_DAT,      tt  ,ACRA  , ACRB   , S, IO )
                     values   (r_s36.acc, 1,   4,    0,    0, 1, (gl.bdate-1), '%%1',r_s36.acc, r_isdi.acrb, 0, 0 );
      end if;
    end if;

  exception when NO_DATA_FOUND then RETURN;
  end;

  --!!--Приведение суммы l_ssdi в валюту 3600
  l_ssdi_s36 := gl.p_ncurval ( r_s36.kv, gl.p_icurval ( r_lim.KV, l_ssdi, gl.bdate), gl.bdate);

  -- приведение остатка 3600 в валюту сч 2066
  If r_s36.kv <> r_sdi.kv  then r_s36.ostc := gl.p_ncurval ( r_sdi.kv, gl.p_icurval ( r_s36.kv, r_s36.ostc, gl.bdate), gl.bdate);
                          r_s36.ostq := gl.p_icurval ( r_sdi.kv, r_s36.ostc, gl.bdate);
  else                    r_s36.ostq := l_ssdi;
                       -- r_s36.ostc := r_s36.ostc;
  end if;

  -- приведение суммы транша в валюту сч 2066
  If r_ss.kv <> r_sdi.kv  then r_ss.ostc := gl.p_ncurval ( r_sdi.KV, gl.p_icurval ( r_ss.KV, r_ss.ostc, gl.bdate), gl.bdate);
  --else                    r_ss.ostc :=                                             r_ss.ostc;
  end if;

  --!!--Приведение суммы l_ssdi в валюту 2066
  l_ssdi_sdi := gl.p_ncurval ( r_sdi.kv, gl.p_icurval ( r_lim.KV, l_ssdi, gl.bdate), gl.bdate);

  --!!--Приведение суммы l_ssdi в валюту 2062
  l_ssdi_ss := gl.p_ncurval ( r_ss.kv, gl.p_icurval ( r_lim.KV, l_ssdi, gl.bdate), gl.bdate);

  -- Проверка на непревышение суммы комиссии над суммой транша
  If l_ssdi_ss > r_ss.OSTC   then
     RETURN;
  end if;
  --------------------------------------------------------------------------------
  gl.payv(p_flg, p_ref, p_vdat, '013', 1, r_s36.kv, r_s36.nls, l_ssdi_s36, r_sdi.kv, r_sdi.nls, l_ssdi_sdi);
  ---------------------------------------------------------------------------------
END PAY_S36 ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_S36.sql =========*** End *** =
PROMPT ===================================================================================== 
