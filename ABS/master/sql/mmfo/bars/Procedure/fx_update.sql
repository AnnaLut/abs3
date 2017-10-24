

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FX_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FX_UPDATE ***

  CREATE OR REPLACE PROCEDURE BARS.FX_UPDATE (
    p_dealRef      in  number,
    p_swiBic       in  varchar2,
    p_swiAcc       in  varchar2,
    p_swoBic       in  varchar2,
    p_swoAcc       in  varchar2,
    p_swoInterm    in  varchar2,
    p_swoAltPartyB in  varchar2 )
is

l_doc        fx_deal.refb%type;
l_swiRef     fx_deal.swi_ref%type;
l_swoRef     fx_deal.swo_ref%type;
l_docSos     oper.sos%type;
l_docChk     oper.nextvisagrp%type;
l_docNostro  operw.value%type;

begin

    begin
        select refb, swo_ref, swi_ref
          into l_doc, l_swoRef, l_swiRef
          from fx_deal
         where deal_tag = p_dealRef;
    exception
        when NO_DATA_FOUND then
            raise_application_error(-20780, '\031 Договор не найден');
    end;

    -- Проверяем привязано ли хоть одно сообщение к договору
    if (l_swoRef is not null or l_swiRef is not null) then
        raise_application_error(-20780, '\032 К договору привязаны сообщения. Изменение невозможно');
    end if;

    -- Проверяем состояние документа
    begin
        select sos, nextvisagrp
          into l_docSos, l_docChk
          from oper
         where ref = l_doc;

        -- Проверяем был ли выполнен подбор корсчета по этому документу
        if (l_docSos = 5 and l_docChk = '!!') then

            select value
              into l_docNostro
              from operw
             where ref = l_doc
               and tag = 'NOS_A';

            if (l_docNostro != '0') then
                raise_application_error(-20780,'\033 Выполнен подбор корсчета по порожденному документу.Изменение невозможно');
            end if;

        end if;

    exception
        when NO_DATA_FOUND then null;
    end;

    -- обновляем параметры договора
    update fx_deal
       set swi_bic    = p_swiBic,
           swi_acc    = p_swiAcc,
           swo_bic    = p_swoBic,
           swo_acc    = p_swoAcc,
           interm_b   = p_swoInterm,
           alt_partyb = p_swoAltPartyB
     where deal_tag   = p_dealRef;

    -- обновляем параметры документа
    update operw
       set value = p_swoBic
     where ref = l_doc
       and tag = '57';

    update operw
       set value = p_swoAcc
     where ref = l_doc
       and tag = '58';

end fx_update;
/
show err;

PROMPT *** Create  grants  FX_UPDATE ***
grant EXECUTE                                                                on FX_UPDATE       to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FX_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
