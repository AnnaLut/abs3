
declare
l_tabid number;
l_message   varchar2(1000); 
 begin
    begin
      select tabid into l_tabid from meta_tables where tabname = 'DOC_SCHEME';
    exception when no_data_found then  l_message:=l_message||'DOC_SCHEME'||' не знайдено в метаописі';
     bars_report.print_message(l_message);  
    end;
 
    begin 
      insert into references (tabid,type) values (l_tabid,10);
    exception when dup_val_on_index then null;
    end;
    
    begin
    insert into refapp (tabid,codeapp,acode,APPROVE,revoked,grantor)
    values (l_tabid,'$RM_MAIN','RW',1,0,1) ;
    exception when dup_val_on_index then null;
    end;
    
 end;
/ 
commit;