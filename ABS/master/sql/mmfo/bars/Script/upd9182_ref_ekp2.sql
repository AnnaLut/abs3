
delete from BARS.NBUR_REF_EKP2
 where file_code ='F5X';

begin
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC) 
       Values ('AF5001', 'Сума збитків від незаконних дій/кількість сумнівних операцій з платіжними картками
');
exception                                           
  when DUP_VAL_ON_INDEX then    null;                                    
end;                                                
/                                                   
                                                    
begin                                               
Insert into BARS.NBUR_REF_EKP2   (EKP, DSC)
       Values ('AF5002', 'Кількість пристроїв через які здійснювалися незаконні дії/ сумнівні операції');
exception
  when DUP_VAL_ON_INDEX then    null;
end;
/

declare
 tabid_  int; 
 tab_          meta_tables.tabname%type  := 'NBUR_REF_EKP2'; 
begin

    begin 
       select tabid into tabid_ from meta_tables where tabname=tab_;
    EXCEPTION WHEN NO_DATA_FOUND THEN tabid_ := NULL;
    end;
    if tabid_ is not null  then
          update meta_columns
             set showwidth =2
           where tabid =tabid_
             and colid =3;
    end if;

end;
/


COMMIT;






