
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_desc_exception.sql ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_DESC_EXCEPTION ( p_ref   oper.ref%type,
                                                        p_kv    oper.kv%type,
                                                        p_nlsa  oper.nlsa%type   default null,
                                                        p_nlsb  oper.nlsb%type   default null
                                                        )
RETURN NUMBER is
   l_tt             oper.tt%type;
   l_okpo_a         varchar (14);
   l_okpo_b         varchar (14);
   l_chk_res        NUMBER (1);
   l_doca           varchar(15);
   l_docb           varchar(15);
   l_exception_flag operw.value%type;
   l_exception_desc operw.value%type;
   l_res_nlsa       NUMBER;
   l_res_nlsb       NUMBER;
   l_ob22           accounts.ob22%type;
-------------------------------------------------------------------------------
/*
LitvinSO 13/10/2015
COBUSUPABS-3825
    В операціях з масками рахунків:
-    PKD Дт 2625 Кт 2630,2635
-    DPI Дт 2620 Кт 2630,2635
здійснювати перевірку на збіг ІНН власника рахунку по дебету з ІНН власника рахунку по кредиту. Якщо в картці клієнта ІНН відсутній (або 000000000), здійснювати перевірку по реквізитам документу власника рахунку.
            За результатами перевірки:
-    якщо відправник та отримувач коштів є однією і тою ж особою (ІНН або реквізити документів збігаються), операцію виконувати.
-    якщо відправник та отримувач коштів - різні особи (ІНН або реквізити документів не збігаються), а реквізит «Ознака винятку» має значення:
                     - «0» - операцію не виконувати, видавати повідомлення: «Необхідно
                         заповнити реквізити «Ознаку винятку» і «Опис винятку»;
                     - «1», а реквізит «Опис винятку» (довідник) не заповнено -
                               операцію не виконувати видавати повідомлення: «Необхідно
                         заповнити реквізити «Ознаку винятку» і «Опис винятку»;
                     - «1» та реквізит «Опис винятку» заповнено єдиним можливим для
                       вибору значенням: «договором депозиту ФО дозволено поповнення
                       шляхом перерахування з поточного рахунку іншої ФО» -
                               операцію виконувати.

LitvinSO Create27/08/2015
Задача:COBUSUPABS-3735
при введенні операцій з наведеним нижче сполученням рахунків в ІВ по дебету та кредиту:
-    PKD Дт 2625 Кт 2620 2630 2635
-    PKR Дт 2620 2630 2635 2638 Кт 2625
-    PK! Дт 2625 Кт 2620
-    W43 Дт 2630 2638 Кт 2625
-    DPI Дт 2620 2630 2635 2638 Кт 2620 2630 2635
-    DPL Дт 2638 Кт 2620 2630 2635
забезпечити перевірку на збіг ІНН власника рахунку по дебету з ІНН власника рахунку по кредиту. Якщо в картці клієнта ІНН відсутній (або 000000000), здійснювати перевірку по реквізитам документу власника рахунку.
        За результатами перевірки:
-    якщо відправник та отримувач коштів є однією і тою ж особою (ІНН або реквізити документів збігаються), операцію виконувати.
-    якщо відправник та отримувач коштів - різні особи (ІНН або реквізити документів не збігаються), а реквізит «Ознака винятку» має значення:
                     - «0» - операцію не виконувати, видавати повідомлення: «Операція не
                       відповідає вимогам чинного законодавства, постанова НБУ № 365
                       від 16.09.2013р»;
                     - «1», а реквізит «Опис винятку» (довідник) не заповнено -
                               операцію не виконувати;
                     - «1» та реквізит «Опис винятку» заповнено з довідника –
                               операцію виконувати.
*/
function Check_NLS(p_kv    oper.kv%type,
                   p_nlsa  oper.nlsa%type   default null,
                   p_nlsb  oper.nlsb%type   default null)
RETURN NUMBER IS
    begin
        begin
            select c.okpo, upper(p.ser)||upper(p.numdoc) into l_okpo_a, l_doca from accounts a, customer c, person p  where a.nls = p_nlsa and a.kv = p_kv and a.rnk = c.rnk and c.rnk = p.rnk;
        exception
                        when no_data_found then
                            bars_error.raise_error('DOC',47,'Не знайдено данних клієнта по рахунку А');
        end;

        begin
            select c.okpo, upper(p.ser)||upper(p.numdoc) into l_okpo_b, l_docb from accounts a, customer c, person p where a.nls = p_nlsb and a.kv = p_kv and a.rnk = c.rnk and c.rnk = p.rnk;
        exception
                        when no_data_found then
                            bars_error.raise_error('DOC',47,'Не знайдено данних клієнта по рахунку Б');
        end;

        if (l_okpo_a not like '000000000%') and  (l_okpo_b not like '000000000%') and (l_okpo_a = l_okpo_b)  then
                return 0;
        elsif (l_okpo_a like '000000000%') and  (l_okpo_b like '000000000%') and (l_doca = l_docb) then
                return 0;
        else
                return 1;
        end if;

      end;
function Check_REKV(p_ida    oper.id_a%type,
                    p_idb  oper.id_b%type)
RETURN NUMBER IS
l_ida oper.id_a%type;
l_idb oper.id_b%type;
begin

        if p_ida like '000000000%' or p_idb like '000000000%' then
           return 0;
        end if;

        if p_ida = p_idb  then
            return 0;
        else
            return 1;
        end if;

end;
BEGIN
    begin
            select tt, id_a, id_b into l_tt, l_okpo_a, l_okpo_b from oper where ref = p_ref;
         if l_tt = 'PKD' and substr(p_nlsa,1,4) in('2625') and substr(p_nlsb,1,4) in('2630','2635','2620') and p_kv <> 980 then
                l_chk_res := Check_NLS(p_kv,p_nlsa,p_nlsb);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
               -- l_res_nlsa       := f_is_resident(P_KV, P_NLSA, P_REF);
               -- l_res_nlsb       := f_is_resident(P_KV, P_NLSB, P_REF);
        /* заявка COBUSUPABS-3825 звільнити від перевірки на збіг ІНН або реквізити клієнта, якщо має місце таке сполучення рахунків:
            PKR Дт 2630 2635 2638 Кт 2625*/
         elsif l_tt = 'PKR' and substr(p_nlsa,1,4) in('2620') and substr(p_nlsb,1,4) in('2625') and p_kv <> 980 then
                l_chk_res := Check_NLS(p_kv,p_nlsa,p_nlsb);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
         elsif l_tt = 'DPI' and substr(p_nlsa,1,4) in('2620','2638') and substr(p_nlsb,1,4) in('2620','2630','2635') and p_kv <> 980 then
                l_chk_res := Check_NLS(p_kv,p_nlsa,p_nlsb);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
         elsif l_tt = 'DPJ' and substr(p_nlsa,1,4) in('2620') and substr(p_nlsb,1,4) in('2620','2630','2635') and p_kv <> 980 then
                l_chk_res := Check_REKV(l_okpo_a,l_okpo_b);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
         elsif l_tt = 'OW4' and substr(p_nlsa,1,4) in('2625') and substr(p_nlsb,1,4) in('2630','2635','2620') and p_kv <> 980 then
                l_chk_res := Check_NLS(p_kv,p_nlsa,p_nlsb);
                l_exception_flag := f_operw (p_ref, 'EXCFL');
                l_exception_desc := f_operw (p_ref, 'EXCTN');
         elsif l_tt = 'PKD' and substr(p_nlsa,1,4) in('2625','2620') and substr(p_nlsb,1,4) in('2625','2620') and p_kv = 980 then
                l_exception_desc := f_operw (p_ref, 'EXCTN');
                l_res_nlsa       := f_is_resident(P_KV, P_NLSA, P_REF);
                l_res_nlsb       := f_is_resident(P_KV, P_NLSB, P_REF);
                begin
                 select a.ob22 into l_ob22 from accounts a where a.nls = p_nlsb and a.kv  =p_kv;
                exception
                        when no_data_found then
                        l_ob22 := null;
                end;
                
                if l_res_nlsa = 1 and l_res_nlsb  = 0 
                  then
                     if l_ob22 ='19' or 
                        l_exception_desc = 'рішення суду або рішення інших органів (посадових осіб), яке підлягає примусовому виконанню'
                        then
                        return 0;
                     else
                      bars_error.raise_error('DOC',47,'Операція порушує вимоги р.7 постанови НБУ 492 від 12.11.2003р.');
                     end if;
                else
                 return 0;
                end if;
         else return 0;
         end if;
     end;
--bars_audit.info ('exc. l_chk_res: '||l_chk_res||' l_exception_desc: '||l_exception_desc||' l_tt: '||l_tt);
    if l_chk_res = 0 then
          return 0;
    elsif l_chk_res = 1 and l_exception_flag = 0 then
          --bars_audit.info ('exc1');
          bars_error.raise_error('DOC',47,'Необхідно заповнити реквізити «Ознаку винятку» і «Опис винятку»');
    elsif l_chk_res = 1 and l_exception_flag = 1 and l_exception_desc is null then
          --bars_audit.info ('exc2');
          bars_error.raise_error('DOC',47,'«Операція не відповідає вимогам чинного законодавства, постанова НБУ № 365 від 16.09.2013р»');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt = 'PKD' or l_tt = 'OW4' or l_tt = 'DPI' or l_tt = 'DPJ')  and substr(p_nlsb,1,4) in('2630','2635') and l_exception_desc is not null and l_exception_desc != 'ДОГОВОРОМ ДЕПОЗИТУ ФО ДОЗВОЛЕНО ПОПОВНЕННЯ ШЛЯХОМ ПЕРЕРАХУВАННЯ З ПОТОЧНОГО РАХУНКУ ІНШОЇ ФО' then
          --bars_audit.info ('exc3');
          bars_error.raise_error('DOC',47,'Необхідно заповнити реквізити «Ознаку винятку» і «Опис винятку» допустимим значенням');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt = 'PKD' or l_tt = 'OW4') and substr(p_nlsb,1,4) ='2625' and substr(p_nlsb,1,4) ='2620' and l_exception_desc = 'ДОГОВОРОМ ДЕПОЗИТУ ФО ДОЗВОЛЕНО ПОПОВНЕННЯ ШЛЯХОМ ПЕРЕРАХУВАННЯ З ПОТОЧНОГО РАХУНКУ ІНШОЇ ФО' then
          --bars_audit.info ('exc4');
          bars_error.raise_error('DOC',47,'Необхідно заповнити реквізити «Ознаку винятку» і «Опис винятку» допустимим значенням');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt = 'PKD' or l_tt = 'OW4' ) and substr(p_nlsb,1,4) = '2620'  and l_exception_desc is not null and l_exception_desc = 'ДОГОВОРОМ ДЕПОЗИТУ ФО ДОЗВОЛЕНО ПОПОВНЕННЯ ШЛЯХОМ ПЕРЕРАХУВАННЯ З ПОТОЧНОГО РАХУНКУ ІНШОЇ ФО' then
          --bars_audit.info ('exc5');
          bars_error.raise_error('DOC',47,'Необхідно заповнити реквізити «Ознаку винятку» і «Опис винятку» допустимим значенням');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt = 'PKR' /*or l_tt = 'DPI'*/ ) and l_exception_desc is not null and l_exception_desc = 'ДОГОВОРОМ ДЕПОЗИТУ ФО ДОЗВОЛЕНО ПОПОВНЕННЯ ШЛЯХОМ ПЕРЕРАХУВАННЯ З ПОТОЧНОГО РАХУНКУ ІНШОЇ ФО' then
          --bars_audit.info ('exc6');
          bars_error.raise_error('DOC',47,'Необхідно заповнити реквізити «Ознаку винятку» і «Опис винятку» допустимим значенням');
    elsif l_chk_res = 1 and l_exception_flag = 1 and ( l_tt = 'DPI' or l_tt = 'DPJ') and substr(p_nlsb,1,4) = '2620'  and  l_exception_desc is not null and l_exception_desc = 'ДОГОВОРОМ ДЕПОЗИТУ ФО ДОЗВОЛЕНО ПОПОВНЕННЯ ШЛЯХОМ ПЕРЕРАХУВАННЯ З ПОТОЧНОГО РАХУНКУ ІНШОЇ ФО' then
          --bars_audit.info ('exc5');
          bars_error.raise_error('DOC',47,'Необхідно заповнити реквізити «Ознаку винятку» і «Опис винятку» допустимим значенням');
    elsif l_chk_res = 1 and l_exception_flag = 1 and (l_tt != 'PKD' or l_tt != 'OW4' or l_tt != 'DPI' or l_tt != 'DPJ') and l_exception_desc is not null and l_exception_desc != 'ДОГОВОРОМ ДЕПОЗИТУ ФО ДОЗВОЛЕНО ПОПОВНЕННЯ ШЛЯХОМ ПЕРЕРАХУВАННЯ З ПОТОЧНОГО РАХУНКУ ІНШОЇ ФО' then
          --bars_audit.info ('exc');
          return 0;
    --else  bars_error.raise_error('DOC',47,'Необхідно заповнити реквізити «Ознаку винятку» і «Опис винятку» допустимим значенням');
    end if;
return 0;

end F_CHECK_DESC_EXCEPTION;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_DESC_EXCEPTION ***
grant EXECUTE                                                                on F_CHECK_DESC_EXCEPTION to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_desc_exception.sql ========
 PROMPT ===================================================================================== 
 