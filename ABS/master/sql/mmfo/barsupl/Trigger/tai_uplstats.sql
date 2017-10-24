

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Trigger/TAI_UPLSTATS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_UPLSTATS ***

  CREATE OR REPLACE TRIGGER BARSUPL.TAI_UPLSTATS after insert or update of status_id on barsupl.upl_stats for each row
declare
   l_bankdate date;
begin
   if inserting then
         case
              when :new.rec_type = 'FILE'   then
               update upl_current_jobs set current_fileid = :new.file_id  where group_statid = :new.parent_id;
            when :new.rec_type = 'GROUP'  then
                       update upl_current_jobs set group_statid = :new.id where stat_id = :new.parent_id;
                  else null;
         end case;

   end if;

   if updating    then  -- UPLOADED or ERROR
      if :new.rec_type = 'GROUP' and :new.status_id in (1,2)  then
           update upl_current_jobs set status_id = :new.status_id  where stat_id = :new.parent_id;
        end if;
      if :new.rec_type = 'FILE' then
         update upl_current_jobs set last_filename  = :new.file_name  where group_statid = :new.parent_id;
      end if;

   end if;
end;
/
ALTER TRIGGER BARSUPL.TAI_UPLSTATS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Trigger/TAI_UPLSTATS.sql =========*** End
PROMPT ===================================================================================== 
