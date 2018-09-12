

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_OPERW_CORP2.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_OPERW_CORP2 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_OPERW_CORP2 
after insert or update ON BARS.OPERW for each row
 WHEN (
new.tag in ('N','n')
      ) declare
    l_count number;
    l_drec_old  oper.d_rec%type;
    l_drec_new  oper.d_rec%type;
begin
  begin
     -- SWIFT - платеж, пришедший через corp2
     select d_rec into l_drec_old from bars.oper where ref=:new.ref and tt in ('IBO', 'IBS', 'IBB', 'CL0', 'CLS', 'CLB');
     if (instr(l_drec_old, '#f')>0 ) then
        begin
            if (instr(l_drec_old, '#'||trim(:new.tag)) <= 0) then
                begin
                   l_drec_new := l_drec_old || trim(:new.tag) || trim(:new.value) || '#';
                   update oper set d_rec=l_drec_new where ref=:new.ref;
                   logger.info('IBANK::insert swift req: ref=' || :new.ref || ', tag ['||trim(:new.tag) ||'], old_value=[' || :old.value || '], new_value=[' || :new.value || '], old_drec=[' || l_drec_old || '], new_drec=[' || l_drec_new || ']');
                end;
            else
                begin
                   l_drec_new := regexp_replace(l_drec_old,'#' || trim(:new.tag) || '\w+#','#' || trim(:new.tag) || trim(:new.value) || '#');
                   update oper set d_rec=l_drec_new where ref=:new.ref;
                   logger.info('IBANK::update swift req: ref=' || :new.ref || ', tag ['||trim(:new.tag) ||'], old_value=[' || :old.value || '], new_value=[' || :new.value || '], old_drec=[' || l_drec_old || '], new_drec=[' || l_drec_new || ']');
                end;
            end if;
        end;
    end if;
    exception
      when no_data_found then null;
   end;
END tiu_operw_corp2;
/
ALTER TRIGGER BARS.TIU_OPERW_CORP2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_OPERW_CORP2.sql =========*** End
PROMPT ===================================================================================== 
