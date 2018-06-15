prompt *** Create  trigger TBI_NBUR_REF_FILES ***

CREATE OR REPLACE TRIGGER TBI_NBUR_REF_FILES 
before insert on NBUR_REF_FILES
for each row
begin

  if ( :new.FILE_CODE is Null or length( :new.FILE_CODE ) != 3 )
  then
    raise_application_error( -20666, 'Value for field [FILE_CODE] must be specified!', true );
  else
    :new.ID := case :new.FILE_FMT
               when 'XML'
               then '3' || to_char(ASCII(SubStr(:new.FILE_CODE,1,1)))
                        || to_char(ASCII(SubStr(:new.FILE_CODE,2,1)))
               else case SubStr(:new.FILE_CODE,1,1)
                    when '#' then '1'
                    when '@' then '2'
                    else '0' end
                    || to_char(ASCII(SubStr(:new.FILE_CODE,2,1)))
                    || to_char(ASCII(SubStr(:new.FILE_CODE,3,1)))
               end;
  end if;

end TBI_NBUR_REF_FILES;
/

show errors;
