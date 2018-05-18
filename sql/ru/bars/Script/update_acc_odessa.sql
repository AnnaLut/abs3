declare
kf_ number;
begin 
tuda;
 select f_ourmfo into kf_ from dual;
    if (kf_=328845) then 
    update ACCOUNTSW set value='FVTPL/Other' where value = 'FVTPL' and tag='IFRS';
	commit;
       else 
        dbms_output.put_line (kf_);
        dbms_output.put_line ('выбрана не Одесса');
        end if;
      end;  
/