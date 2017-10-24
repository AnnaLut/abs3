

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CCK_AUTHNOTARY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CCK_AUTHNOTARY ***

  CREATE OR REPLACE PROCEDURE BARS.CCK_AUTHNOTARY (p_mode int, p_nd number) is

    l_accreditation_id varchar2(250);
    l_accreditation_row notary_accreditation%rowtype;

    --При авторизации проверка доп.реквизитов
    --пока только p_mode = 0 - проверка

begin
    bars_audit.info('Start cck_authnotary nd = ' || p_nd);

    if (p_mode = 0) then

        begin
            select txt
            into   l_accreditation_id
            from   nd_txt
            where  tag = 'FION' and
                   nd = p_nd;
        exception
            when no_data_found then
                 null;
        end;

        if (l_accreditation_id is null) then
            raise_application_error(-20203, 'Не заповнений додатковий реквізит "ПІБ нотаріуса"');
        else
            -- Оскільки даний параметр може заповнюватися в Центурі без використання довідника акредитованих нотаріусів
            -- перевіримо, чи є значення ідентифікатора числом
            if (regexp_like(l_accreditation_id, '^d*$')) then
                l_accreditation_row := nota.read_accreditation(to_number(l_accreditation_id), p_lock => true, p_raise_ndf => false);
            end if;
        end if;

        if (l_accreditation_row.accreditation_type_id = nota.ACCR_TYPE_ONE_TIME) then
            begin
                attribute_utl.set_value(l_accreditation_row.id, nota.ATTR_CODE_ACCR_STATE, nota.ACCR_STATE_ONE_TIME_OFF);

                insert into notary_queue(object_type, object_id)
                select 'USE_ACCREDITATION', l_accreditation_row.id
                from   DUAL
                where  not exists (select 1
                                   from   notary_queue t
                                   where  t.object_type = 'USE_ACCREDITATION' and
                                          t.object_id = l_accreditation_row.id and
                                          t.kf = sys_context('bars_context', 'user_mfo'));
            exception
                when others then
                     bars_audit.error('cck_authnotary' || chr(10) || sqlerrm || chr(10) || dbms_utility.format_error_stack());
                     raise_application_error(-20203, 'Не вдалося погасити разову акредитацію нотаріуса');
            end;
        end if;
    end if;
     cck_empl_gpk(p_nd,1);
    bars_audit.info('Finish cck_authnotary  nd = ' || p_nd);
end cck_authnotary;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CCK_AUTHNOTARY.sql =========*** En
PROMPT ===================================================================================== 
