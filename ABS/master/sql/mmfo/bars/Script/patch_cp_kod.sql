begin   
 bc.go(300465);
 begin
   execute immediate 'ALTER TRIGGER TAIU_CPKOD_UPDATE DISABLE';
   exception when others then
     dbms_output.put_line('Не зміг відключити тріггер TAIU_CPKOD_UPDATE'); 
 end;

 begin
   execute immediate 'alter table CP_KOD add kf varchar2(6) default sys_context(''bars_context'',''user_mfo'')';
   exception when others then
    if  sqlcode=-1430  then null; 
    else 
      execute immediate 'ALTER TRIGGER TAIU_CPKOD_UPDATE ENABLE';
      bc.home;
      raise; 
    end if;
 end;

 begin
   execute immediate 'ALTER TRIGGER TAIU_CPKOD_UPDATE ENABLE';
   exception when others then
     dbms_output.put_line('Не зміг включити тріггер TAIU_CPKOD_UPDATE'); 
 end;
 bc.home;

 end;
/
