BEGIN 
DBMS_SCHEDULER.SET_ATTRIBUTE ( 
name => 'NBU_SERVICE_CALLER', 
attribute => 'repeat_interval', 
value => 'Freq=Minutely;Interval=3'); 
END; 
/ 
                       
begin
dbms_scheduler.enable(name =>'NBU_SERVICE_CALLER');
end;
/