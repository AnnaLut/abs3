

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_INTDOCCHECK_TMP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_INTDOCCHECK_TMP ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_INTDOCCHECK_TMP (p_ref number)
--
-- Version 1.0 12/06/2018
-- ВРЕМЕННАЯ ПРОЦЕДУРА ВЗАМЕН P_FM_INTDOCCHECK ДЛЯ РЕКОМПИЛЯЦИИ В РАБОЧЕЕ ВРЕМЯ
-- проверка начальных (исходящих) документов
--   мультимфо
--   с проверкой доп.реквизитов
--
is
  -- код группы визирования "Заблокировано Фин.Мониторингом"
  c_grp   constant number := getglobaloption ('FM_GRP1');
  l_datr  date;
  l_doc_lock_limit constant number := 100;
  ----
  -- fm_check - проверка по одному референсу
  --
  procedure fm_check (p_ref number)
  is
     resource_busy   exception;
     pragma exception_init (resource_busy, -54);
     --
     l_nazn  oper.nazn%type;
     l_nama  oper.nam_a%type;
     l_namb  oper.nam_b%type;
     l_tt    oper.tt%type;
     l_flag  number;
     l_otm   number := 0;
  begin
     begin
        select o.tt, o.nazn, o.nam_a, o.nam_b
          into l_tt, l_nazn, l_nama, l_namb
          from oper o
         where o.ref = p_ref
           for update of o.sos nowait;
     exception
        when no_data_found then return;
        when resource_busy then return;
     end;

     -- не проверять операции с флагом "Не сверять со списком террористов"
     begin
        select nvl(f.value,0) into l_flag from tts_flags f where f.tt = l_tt and f.fcode = 30;
     exception when no_data_found then
        l_flag := 0;
     end;
     if l_flag = 1 then
        return;
     end if;

     -- проверка на совпадение со списком террористов
     -- наименование отправителя
     l_otm := f_istr (l_nama);
     -- наименование получателя
     if l_otm = 0 then
        l_otm := f_istr (l_namb);
     end if;
     -- назначение платежа
     if l_otm = 0 then
        l_otm := f_istr (l_nazn);
     end if;


     if l_otm = 0 then
        for d in ( select value
                     from operw
                    where ref = p_ref
                      and tag in ('FIO', 'FIO2', 'OTRIM') )
        loop
           l_otm := f_istr (d.value);
           if l_otm > 0 then
              exit;
           end if;
        end loop;
     end if;


     /*COBUSUPABS-5202
     По операціям з кодами CVO, IBO, CVS додатково перевіряти на наявність терористів у Переліку додатковий реквізит операції "59" «SWT.59 Beneficiare Customer»
     (%TERROR%, де TERROR - найменування юрособи або ПІБ особи з переліку осіб).
В даному тезі присутня інформація, відмінна від ПІБ учасника.*/
     if l_otm = 0 and l_tt in ('CVO', 'IBO', 'CVS') then
       begin
          with o59 as
          (select f_translate_kmu(o.value) as t59 from bars.operw o where ref = p_ref and tag = '59')
          select c1 into l_otm
          from bars.v_finmon_reft r, o59
          where regexp_like(o59.t59, '[^A-Za-zА-Яа-я]'||REGEXP_REPLACE ( f_translate_kmu(c6 || ' ' || c7 || ' ' || c8 || ' ' || c9), '([()\:"])', '\\\1', 1, 0)||'[^A-Za-zА-Яа-я]')
          and rownum = 1;
       exception
         when no_data_found then l_otm := 0;
       end;
     end if;
     /*COBUSUPABS-5202 end*/

     -- ставим признак "проверено" для документа
     update ref_que set fmcheck = 1 where ref = p_ref;

    -- доп проверка ) виключення з правил. Загальне правило, якщо є збіг по ПІБ - операція блокується.
    -- Але якщо ми можемо перевірити дату народження особи в Переліку і в операції, і якщо вони не рівні, то тільки тоді операція не блокується.
     if l_otm >= 10000 then
       bars_audit.info('l_otm>= 10000 = '||l_otm);
        begin
         select to_date(c13,'dd.mm.yyyy')
           into l_datr
           from finmon_reft
          where c1 = l_otm;
          bars_audit.info('Дата рождения из finmon_reft = '||to_char(l_datr,'dd.mm.yyyy'));
        exception when value_error
                  then l_datr := null;
                       bars_audit.info('Дата рождения из finmon_reft не найдена или не в видe dd.mm.yyyy');
        end;

        if l_datr is not null
        then
         begin
            for dats in ( select to_date(value,'dd/mm/yyyy') value
                         from operw
                        where ref = p_ref
                          and tag in ('DATN', 'DRDAY', 'DT_R') )
            loop
               if dats.value = l_datr
               then bars_audit.info('Дата рождения из operw = '||to_char(dats.value,'dd.mm.yyyy'));
                    exit;
               else l_otm := 0;
                    bars_audit.info('Дата рождения из operw = '||to_char(dats.value,'dd.mm.yyyy')|| ' не равна дате рождения в списке. Сбрасываем признак.');
               end if;
            end loop;
         exception when value_error
                   then bars_audit.info('Дата рождения из operw не найдена или не в видe dd.mm.yyyy');
         end;
        end if;
     end if;
     -- если документ подозрительный, заносим его в очередь подозр. документов
     if l_otm > 0 then
        begin
           insert into fm_ref_que (ref, otm)
           values (p_ref, l_otm);
        exception
           -- запись уже есть
           when dup_val_on_index then null;
        end;

        if c_grp is not null then
           insert into oper_visa (ref, dat, userid, groupid, status)
           values (p_ref, sysdate, user_id, c_grp, 1);
        end if;
     end if;

  end fm_check;
begin

  if p_ref is not null then
     -- проверка одного документа
     for r in (select ref from ref_que where nvl(fmcheck, 0) = 0 and ref = p_ref )
     loop
        fm_check(r.ref);
     end loop;
  else

     for b in ( select kf from mv_kf )
     loop
        -- представляемся чужим МФО
        bc.subst_mfo(b.kf);


        for r in (select rownum rn, ref from ref_que where nvl(fmcheck, 0) = 0 )
        loop
           fm_check(r.ref);
           -- коммитим (отпуская oper for update) каждые N проверенных документов
           if mod(r.rn, l_doc_lock_limit) = 0 then
               commit;
           end if;
        end loop;


        -- возвращаемся к себе
        bc.set_context;
     end loop;

  end if;

exception when others then

  --
  -- этот блок нужен, чтобы не оставаться в чужом бранче
  --
  -- возвращаемся к себе
  bc.set_context;
  --

  -- обязательно выбрасываем ошибку дальше
  raise_application_error(-20000,
        dbms_utility.format_error_stack() || chr(10) ||
        dbms_utility.format_error_backtrace());

end;
/
show err;

PROMPT *** Create  grants  P_FM_INTDOCCHECK_TMP ***
grant EXECUTE                                                                on P_FM_INTDOCCHECK_TMP to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_INTDOCCHECK_TMP to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_INTDOCCHECK_TMP.sql =========*** 
PROMPT ===================================================================================== 
