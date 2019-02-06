CREATE OR REPLACE function BARS.F_zay_eqv_check (
       p_zay_id   zayavka.id%type          default null,
 --      p_days number default null, --кількість днів контролю , якщо NULL - то
                                  -- за поточну дату
       p_mode varchar2 default null --'M' - контроль місяць, 'D' - контроль день
)
return number
is
/*
06,02,2019 - v.5 додано коментарі
30.01.2019 - v.4
15.01.2019  - Функція перевіряє чи не перевищено ліміт на безпідставну купівлю
валюти по обіржевим заявкам. І повертає суму переліміту (-число) або суму
недоліміту (+ число)
У зв’язку зі змінами у чинному законодавстві (набуттям чинності з 07.02.2019р.
Закону України «Про валюту і валютні операції», постанови НБУ № 5
«Про затвердження Положення про заходи захисту та визначення порядку
здійснення окремих операцій в іноземній валюті , далі- постанова №5)
35.	Банкам забороняється здійснювати:
операції з продажу банківських металів без фізичної поставки за безготівкові
гривні клієнтам (фізичним особам, юридичним особам, фізичним особам-підприємцям)
,що перевищують незначний розмір, протягом робочого дня в межах банку на одного
клієнта. Перерахунок здійснюється за курсом, визначеним згідно з офіційними
курсами банківських металів, установленим Національним банком
на день проведення операції.
*/
       l_okpo number;
       l_SER_PASP VARCHAR2(10);
       l_NOM_PASP VARCHAR2(20);
    --   l_tgr number(1);
       ss_eq  number; --сума операцій за добу по РНК(за місяць - всі в табл. контролю)
       sin_eq number; --еквівалент поточної заявки
       --l_request zayavka%rowtype;
       l_sos     zayavka.sos%type;
       l_viza    zayavka.viza%type;
       l_id number;
       l_rnk number;
       l_kv2 varchar2(3);
       l_s2 number;
       l_kf varchar2(6);
       l_days number(2);
       l_prv number (1);--признак металу
       l_custtype customer.custtype%type;
       l_ch_date_m date;
       l_ch_date_d date;
begin
/***********v 1.0
sin_eq:=  gl.p_icurval (p_kv, p_suma, trunc(SYSDATE)); --еквівалент

 begin
    select okpo into l_okpo from customer c where c.rnk= p_rnk ;
 exception
  when no_data_found then
    bc.go(p_mfo);
    select okpo into l_okpo from customer c where c.rnk= p_rnk ;
    bc.go('300465');
 end ;


--визначаємо суму всіх еквівалентів заявок за день по ОКПО
select nvl(sum(summa),0) into ss_eq from zay_val_control
    where okpo in (select okpo from customer c
                    where c.rnk= p_rnk and c.DATE_OFF is null)
    and zay_date=p_date;

--порівнюємо результат з дозволеними обмеженнями
--незначний розмір це на сьогодні є 149 999,99 грн. в
--еквіваленті за офіційним курсом гривні до іноземних валют,
--установленим Національним банком України на дату здійснення операції.

    result:=F_get_CURR_LIM_DAY1-(sin_eq + ss_eq);

    return result;
    *****************************/

    /*********v 2.0
    якщо контроль на ZAY21, тобто заявка вже створена
    отримуємо ID , по ньому знаходимо все по заявці  */

  -----------------все по поточній заявці
  select *
  into
         l_id
        ,l_rnk
        ,l_kv2
        ,l_s2
        ,l_kf
  from   (select *
          from   (select id, rnk, kv2, s2, kf
                  from   zayavka
                  union all
                  select id, rnk, kv2, s2, mfo
                  from   zayavka_ru)
          where  id = p_zay_id

          );
    ---------------------------------------
    --знаходимо ОКПО клієнта по поточній заявці
    begin
      select c.okpo, p.ser, p.numdoc, c.custtype
      into   l_okpo, l_SER_PASP, l_NOM_PASP, l_custtype
      from   customer c
             left   join person p   on     p.rnk = c.rnk
      where  c.rnk = l_rnk
             and date_off is null;
    exception
      when no_data_found then
        bc.go(l_kf);
        select okpo, p.ser, p.numdoc,c.custtype
        into   l_okpo, l_SER_PASP, l_NOM_PASP, l_custtype
        from   customer c
               left   join person p on  p.rnk = c.rnk
        where  c.rnk = l_rnk
               and date_off is null;
        bc.go('300465');
    end;
    ------------------------------
    ----еквівалент поточної заявки
    sin_eq:=  gl.p_icurval (l_kv2,l_s2, trunc(SYSDATE));
    ------------------------------
    -----------------признак металу , якщо ЮО - то признак тільки 1
    if l_custtype=2 then l_prv:=1;
      else
      select prv into l_prv  from tabval where kv=l_kv2;
    end if;
    ---------------------------------------
    --режим перевірки
    --перевірка за місяць(по введеним (0,1)) + перевірка за день(по оплаченим(1,2))
    if    p_mode = 'M' then        
    -- операції на контролі по ОКПО з заявки
   select coalesce(sum(z.summa), 0)
    into   ss_eq
    from 
    (
    --сума за місяць(по введеним (0,1))
    select Z.SUMMA
    from   zay_val_control z
          inner  join tabval tv on tv.kv = z.kv2 and tv.prv = l_prv
    where  z.okpo || z.SER_PASP || z.NOM_PASP =
           l_okpo || l_SER_PASP || l_NOM_PASP
           and z.sos = 0
           and z.viza = 1
           and z.zay_date >= trunc(sysdate) - 30
     
    union all
      -- сума за день(по оплаченим(1,2))
    select z.summa
    from   zay_val_control z
          inner  join tabval tv on tv.kv = z.kv2 and tv.prv = l_prv
    where  z.okpo || z.SER_PASP || z.NOM_PASP =
           l_okpo || l_SER_PASP || l_NOM_PASP
           and z.sos = 1
           and z.viza = 2
           and z.zay_date_v =trunc(sysdate)
     ) z      
           ; 
      
    elsif p_mode = 'D' then --перевірка за день (по оплаченим(1,2))
    -- операції на контролі по ОКПО з заявки
     select coalesce(sum(z.summa), 0)
    into   ss_eq
    from   zay_val_control z
          inner  join tabval tv on tv.kv = z.kv2 and tv.prv = l_prv
    where  z.okpo || z.SER_PASP || z.NOM_PASP =
           l_okpo || l_SER_PASP || l_NOM_PASP
           and z.sos = 1
           and z.viza = 2
           and z.zay_date_v =trunc(sysdate)
           ;
   end if;

    ----------------------------
    
    --результат=різниця між незначною сумою купівлі , та сумою заявок
    
    return F_get_CURR_LIM_DAY1/*149 999 99*/-(sin_eq + ss_eq); -- переліміт(-), недоліміт (+) операцій

end;
/