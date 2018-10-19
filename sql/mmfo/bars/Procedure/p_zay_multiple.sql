

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_MULTIPLE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAY_MULTIPLE ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAY_MULTIPLE (p_id number, p_sum1 int default null, p_sum2 int default null)
-- Процедура разбиения заявки на покупку/продажу валюты (Надра, для частичного удовлетворения заявки)
-- ver 1.0  04/05/2012
is

 ern        NUMBER;          -- код ошибки (из err_zay)
 msg        VARCHAR2(254);   -- текстовка ошибки "для себя"
 err        EXCEPTION;
 prm        VARCHAR2(25)  := null;  -- параметр, передаваемый в сообщения об ошибке
 l_title    varchar2(100) := 'ZAY. p_zay_multiple. ';

 r_zay      zayavka%ROWTYPE;    -- массив данных про первоначальную заявку
 r_zay1     zayavka%ROWTYPE;


 --
 -- внутр.процедура  собственно вставки новой заявки
 --
 procedure p_zay_ins (p_s int, r_rt in out zayavka%ROWtype)
 is
  l_id  number;
 begin
        l_id := bars_sqnc.get_nextval('s_zayavka');
        r_rt.comm := 'Разбиение заявки № '||r_rt.id||' клиента '||r_rt.rnk||' суммы '||r_rt.s2;
        r_rt.id := l_id;
        r_rt.s2 := p_s*100;
        r_rt.identkb:=l_id;--COBUMMFO-9206
        r_rt.datedokkb := null;  -- чтобы триггер tbi_zayavka вставил текущее время
        insert into zayavka  values r_rt;
        -- потому как триггер tbi_zayavka затирает другими значениями, а нам необходимы первоначальные
        update zayavka set isp = r_rt.isp, tobo = r_rt.tobo where id = l_id;
 end;

begin
 -- трасса входящих параметров
  bars_audit.trace('%s Params: p_id=%s, p_sum1=%s, p_sum2=%s',
        l_title, to_char(p_id), to_char(p_sum1), to_char(p_sum2));

    -- проверка - заявка отсутствует
    begin
     select z.* into r_zay from zayavka z where z.id = p_id and z.sos >= 0;
    exception when no_data_found then
         msg  := 'Заявка ' || p_id || ' не найдена!' ;
         ern  := 6;
         prm  := p_id;
         bars_audit.trace('%s Неуспешное выполнение разбиения заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end;

    -- проверка - введенные суммы не равны сумме первоначальной заявки
    if (nvl(p_sum1,0) + nvl(p_sum2,0) )  <> r_zay.s2/100 or nvl(p_sum1,0) = 0 or nvl(p_sum2,0) = 0 then
         msg  := 'Введеные суммы не совпадают!' ;
         ern  := 24;
         prm  := p_id;
         bars_audit.trace('%s Неуспешное выполнение разбиения заявки № %s - %s', l_title, to_char(p_id), to_char(msg));
         raise err;
    end if;

    -- сохраняем первоначальный массив в копию
    r_zay1 := r_zay;
    -- запускаем внутр.процедуру для первой суммы с первонач.массивом
    p_zay_ins (p_sum1, r_zay);
    -- запускаем внутр.процедуру для второй суммы с первонач.массивом (копией, поскольку r_zay в out предыдущего запуска уже изменен)
    p_zay_ins (p_sum2, r_zay1);
    -- первоначальной заявке меняем sos
    update zayavka set sos = -1 where id = p_id;

EXCEPTION
   WHEN err THEN
      bars_error.raise_error('ZAY', ern, prm);

end;
/
show err;

PROMPT *** Create  grants  P_ZAY_MULTIPLE ***
grant EXECUTE                                                                on P_ZAY_MULTIPLE  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAY_MULTIPLE  to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_MULTIPLE.sql =========*** En
PROMPT ===================================================================================== 
