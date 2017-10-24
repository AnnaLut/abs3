
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_stop_op.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_STOP_OP (kod_ int,
                                           ref_ oper.ref%type,
                                           tt_  oper.tt%type   default null,
                                           kv_  int            default null,
                                           tag_ operw.tag%type default null,
                                           nls_ varchar2       default null,
                                           s_   number         default null)

                        return numeric is  su_  numeric;
/*

 04.10.2010 llv – создана функция для Сбербанка(схема с иерарх.отделениями и мульти-МФО).
 04.10.2010 llv – Код = 1, проверка правильности заполнения
                  доп. реквизитов 50К, 50F в операции CFS.

*/
--
l_val1   operw.value%type;
l_val2   operw.value%type;
l_tag    operw.tag%type;
l_tag_n1 op_field.name%type;
l_tag_n2 op_field.name%type;
l_kv     oper.kv%type;

--

ern  constant positive  := 999;
err  exception;
erm  varchar2(250);

begin
-- bars_audit.trace('F_STOP(KOD_ => '||KOD_||', KV_ => '||KV_||', NLS_ => '''||NLS_||''', S_ => '||S_||')');
   if kod_= 1 and tt_= 'CFS' then
      begin

          select max(decode(w.tag, '50K  ', w.value)), max(decode(w.tag, '50F  ', w.value)),
                 max(decode(f.tag, '50K  ', f.name)),  max(decode(f.tag, '50F  ', f.name))
            into l_val1, l_val2, l_tag_n1, l_tag_n2
            from operw w,op_field f
           where w.ref = ref_
             and f.tag in ('50K  ','50F  ');

          if l_val1 is null and l_val2 is null and kv_ = 643
             then  erm := '01000 ERR1 – Незаповнений додатковиq реквізит '||l_tag_n1;
                   raise err;
          elsif l_val1 is null and l_val2 is null and kv_ != 643
                then  erm := '01000 ERR1 – Незаповнений додатковиq реквізит '||l_tag_n2;
                      raise err;
          elsif kv_  = 643 and l_val2 is not null
                then erm :='01000 ERR2 – Некоректне співвідношення валюти ('||kv_||') операції та додаткового реквізиту '||l_tag_n2 ;
                     raise err;
          elsif kv_ != 643 and l_val1 is not null
                then erm :='01000 ERR2 – Некоректне співвідношення валюти ('||kv_||') операції та додаткового реквізиту '||l_tag_n1 ;
                     raise err;

          end if;

      end;

   end if;

RETURN 0 ;

EXCEPTION
 WHEN err    THEN raise_application_error(-(20000+ern),'\'||erm,TRUE);
 WHEN OTHERS THEN raise_application_error(-(20000+ern),SQLERRM,TRUE);

END f_stop_op ;
/
 show err;
 
PROMPT *** Create  grants  F_STOP_OP ***
grant EXECUTE                                                                on F_STOP_OP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_STOP_OP       to BARS_CONNECT;
grant EXECUTE                                                                on F_STOP_OP       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_stop_op.sql =========*** End *** 
 PROMPT ===================================================================================== 
 