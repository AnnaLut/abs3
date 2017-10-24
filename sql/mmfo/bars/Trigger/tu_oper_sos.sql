

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SOS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_SOS ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_SOS 
after update of sos ON BARS.OPER
for each row
    WHEN (
new.sos < 0
      ) declare
    l_flag    boolean := true;
    l_swRef   sw_journal.swref%type;
    l_mt      sw_journal.mt%type;
    l_stmtRow sw_950d.n%type;

begin
    --
    -- ������� �������� �������� ��������� � ��������� SWIFT
    --
    while (l_flag)
    loop

        begin

            select j.swref, j.mt into l_swRef, l_mt
              from sw_oper l, sw_journal j
             where l.ref   = :new.ref
               and l.swref = j.swref
               and rownum <= 1;

            if (l_mt != 950) then

                bars_swift.impmsg_document_unlink(:new.ref, l_swRef);

            else

                select n into l_stmtRow
                  from sw_950d
                 where swref   = l_swRef
                   and our_ref = :new.ref;

                bars_swift.stmt_document_unlink(l_swRef, l_stmtRow);

            end if;

        exception
            when NO_DATA_FOUND then
                l_flag := false;
        end;
    end loop;

end;


/
ALTER TRIGGER BARS.TU_OPER_SOS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SOS.sql =========*** End ***
PROMPT ===================================================================================== 
