

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_IN_FILES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_RNBU_IN_FILES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_RNBU_IN_FILES 
before insert on rnbu_in_files for each row
declare bars number;
begin
 select s_rnbu_in_files.nextval
 into bars from dual;
        :new.file_id := bars;
end;
/
ALTER TRIGGER BARS.TBI_RNBU_IN_FILES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_RNBU_IN_FILES.sql =========*** E
PROMPT ===================================================================================== 
