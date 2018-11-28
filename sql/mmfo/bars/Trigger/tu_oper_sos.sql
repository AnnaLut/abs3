CREATE OR REPLACE TRIGGER "TU_OPER_SOS"
 after update of sos ON BARS.OPER for each row 
 WHEN ( new.sos < 0       )
declare
    l_flag    boolean := true;
    l_swRef   sw_journal.swref%type;
    l_mt      sw_journal.mt%type;
    l_stmtRow sw_950d.n%type;
begin -- Разные спец.обрабртки снятия с визы или сторно или БЭК

    -- 24.09.2018 Снятие с визы Оплаты запросов из РУ на выдшкодування XOZ
    If :new.tt = 'MNK'  and :new.nlsA = '3739200703017' and :new.MFOa = '300465' and gl.aMfo = :new.MFOA and :new.MFOB <> :new.MFOA then
       EXECUTE IMMEDIATE ' update XOZ_DEB_ZAP set sos = 1 , ref2_CA = null WHERE sos = 2 and ref2_CA = '|| :new.REF  ;
       RETURN ;
    end if;

    -- 100 лет назад - удаления привязки документа к сообщению SWIFT
    while (l_flag)
    loop
        begin  select j.swref, j.mt into l_swRef, l_mt  from sw_oper l, sw_journal j  where l.ref   = :new.ref    and l.swref = j.swref         and rownum <= 1;
           if l_mt != 950 then 
              bars_swift.impmsg_document_unlink(:new.ref, l_swRef);
           else
              select n into l_stmtRow from sw_950d where swref= l_swRef  and our_ref = :new.ref;
              bars_swift.stmt_document_unlink(l_swRef, l_stmtRow);
           end if;
        exception   when NO_DATA_FOUND then    l_flag := false;
        end;
    end loop;

end;
/