

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_NBUR_REF_FILES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_NBUR_REF_FILES ***

  CREATE OR REPLACE TRIGGER BARS.TBI_NBUR_REF_FILES 
before insert on BARS.NBUR_REF_FILES
for each row
begin

  if ( :new.FILE_CODE is Null or length( :new.FILE_CODE ) != 3 )
  then
    raise_application_error( -20666, 'Value for field [FILE_CODE] must be specified!', true );
  else
    :new.ID := case SubStr(:new.FILE_CODE,1,1)
               when '#' then '1'
               when '@' then '2'
               else '0' end
               || to_char(ASCII(SubStr(:new.FILE_CODE,2,1)))
               || to_char(ASCII(SubStr(:new.FILE_CODE,3,1)));
  end if;

end tbi_dpu_deal;
/
ALTER TRIGGER BARS.TBI_NBUR_REF_FILES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_NBUR_REF_FILES.sql =========*** 
PROMPT ===================================================================================== 
