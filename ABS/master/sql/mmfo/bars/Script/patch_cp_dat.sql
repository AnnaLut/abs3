begin   
 bc.go(300465);
 begin
   execute immediate 'ALTER TRIGGER taiu_cpdat_update DISABLE';
   exception when others then
     dbms_output.put_line('Не зміг відключити тріггер taiu_cpdat_update'); 
 end;

 begin
   execute immediate 'alter table CP_DAT add kf varchar2(6) default sys_context(''bars_context'',''user_mfo'')';
   exception when others then
    if  sqlcode=-1430  then null; 
    else 
      bc.home;
      execute immediate 'ALTER TRIGGER taiu_cpdat_update ENABLE';
      raise; 
    end if;
 end;

 begin
   execute immediate 'ALTER TRIGGER taiu_cpdat_update ENABLE';
   exception when others then
     dbms_output.put_line('Не зміг включити тріггер taiu_cpdat_update'); 
 end;
 bc.home;

 end;
/

 exec bc.go('/' );