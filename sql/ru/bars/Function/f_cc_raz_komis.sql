
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cc_raz_komis.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CC_RAZ_KOMIS (p_type number, p_nd number, p_komis char) RETURN NUMBER IS
S NUMBER;
/******************************************************************************
   NAME:       f_cc_raz_komis
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        12/08/2011   novikov       1. Created this function.
   1.1        16/09/2011   novikov       Тарифы выделены в отдельную таблице
   1.2        08/12/2011   novikov       Поддержку тарифов для инвалютных кредитов

   NOTES: Процедура возвращает три типа значения в операцию ввода
          1. Сумму которую нельзя редактировать
          2. 0 - его тоже нельзя редактировать в форме ввода
          3. null - в форме ввода сумма открыта для редактирования

   Automatically available Auto Replace Keywords:
      Object Name:     f_cc_raz_kom
      Sysdate:         12/08/2011
      Date and Time:   12/08/2011, 13:48:13, and 12/08/2011 13:48:13
      Username:        novikov (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
 l_tmp    number;
 r_kom  cc_prod_komis%rowtype;
 r_tarif cc_raz_komis_tarif%rowtype;
 l_sdate cc_deal.sdate%type;
 l_ostc accounts.ostc%type;
 l_ostx accounts.ostx%type;
 l_kv   accounts.kv%type;

BEGIN
  s:=null;

 if p_nd is null then
    raise_application_error(-20100,'Відсутній реф. договору.');
 end if;

 if p_komis is null then
    raise_application_error(-20100,'Відсутній реф. комісії.');
 end if;

  begin
  select komis into l_tmp from cc_raz_komis where komis=p_komis;
  exception when no_data_found then
    raise_application_error(-20100,'Відсутня комісія реф='||p_komis);
  end;

  begin
  select c.prod,c.komis,c.pdv,c.tarif,d.sdate  , ad.kv
    into r_kom.prod,r_kom.komis,r_kom.pdv,r_kom.tarif,l_sdate, l_kv
    from cc_prod_komis c,cc_deal d , cc_add ad
   where komis=p_komis and d.prod=c.prod and d.nd=p_nd and ad.nd=d.nd and ad.adds=0;
  exception when no_data_found then
    raise_application_error(-20100,'До КД №'||to_char(p_nd)||' комісія реф='||p_komis||' відсутня' );
  end;

  begin

  select c.*
   into r_tarif
  from cc_raz_komis_tarif c where kod=r_kom.tarif and kv=l_kv
       and fdat=(select max(fdat)  from cc_raz_komis_tarif where  kod=r_kom.tarif and fdat<l_sdate and kv=l_kv);

    if r_tarif.tip=-1 then
      return null; -- открываем сумму для ввода
    elsif  r_tarif.tip=0 then
      return gl.p_icurval(l_kv,r_tarif.tar*100,gl.bdate); -- передаем сумму константу
    end if;

  exception when no_data_found then
    return 0;  -- тарифа не существует
  end;

    -- проверка на допустимость тарифа
  if nvl(r_tarif.pr,0)>0 and r_tarif.tip not in (1,2,3,4) then
    raise_application_error(-20100,'Для комісії реф='||p_komis||' не вказан тип ставки або його невірне значення!');
  end if;

 if r_tarif.pr is not null then


   begin
    select abs(a.ostc/100),abs(a.ostx)/100
      into l_ostc, l_ostx
      from accounts a,nd_acc n, cc_deal d
     where d.nd=n.nd and n.acc=a.acc and a.tip='LIM' and d.nd=p_nd;
   exception when no_data_found then
     raise_application_error(-20100,'Не знайден рахунок LIM по кд. реф='||to_char(p_nd));
   end;

    if r_tarif.tip=1 then
           S:=l_ostx*r_tarif.pr/100;
    elsif r_tarif.tip=2 then
           S:=l_ostc*r_tarif.pr/100;
    elsif r_tarif.tip=3 then
           S:=greatest(l_ostx-l_ostc,0)*r_tarif.pr/100;
    elsif r_tarif.tip=4 then
           S:=(l_ostc*r_tarif.pr)/100;
    end if;

 else
  S:=r_tarif.tar;
 end if;

  RETURN gl.p_icurval(l_kv,S*100,gl.bdate);
END f_cc_raz_komis;
/
 show err;
 
PROMPT *** Create  grants  F_CC_RAZ_KOMIS ***
grant EXECUTE                                                                on F_CC_RAZ_KOMIS  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CC_RAZ_KOMIS  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cc_raz_komis.sql =========*** End
 PROMPT ===================================================================================== 
 