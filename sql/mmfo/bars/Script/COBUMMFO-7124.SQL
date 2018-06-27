
--------    COBUMMFO-7124   ---------------- 

set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Обновление операций 310,445,OW4,PKR,001,181


Delete from chklist_tts where tt='310' and idchk=2 ;

begin
  insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
  values (11, '310', 2, null, null, null);
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''310'', 2, null, null, null) - первичный ключ не найден!');
    else raise;
    end if;
end;



DELETE from PS_TTS where TT='445' and (NBS='260' or NBS='2605') and DK=1  ; 

begin
  insert into ps_tts(nbs, tt, dk)
  values ('2900', 'OW4', 1 );
exception when others then 
  null;
end;
/

begin
  insert into ps_tts(nbs, tt, dk, ob22 )
  values ('2622', 'PKR', 0, '05' );
exception when others then 
  null;
end;
/

begin
  insert into ps_tts(nbs, tt, dk, ob22 )
  values ('2622', '001', 0, '05' );
exception when others then 
  null;
end;
/

begin
  insert into ps_tts(nbs, tt, dk )
  values ('3652', 'PKR', 0 );
exception when others then 
  null;
end;
/


DELETE from PS_TTS where TT='181' and NBS='1001' and DK=1 ; 
begin
  insert into ps_tts(nbs, tt, dk )
  values ('1001', '181', 1 );
exception when others then 
  null;
end;
/
 


commit;
