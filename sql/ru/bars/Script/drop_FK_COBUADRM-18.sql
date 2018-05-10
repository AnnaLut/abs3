begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS drop constraint FK_CUSTOMERADR_HOUSES]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS drop constraint FK_CUSTOMERADR_REGIONS ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS drop constraint FK_CUSTOMERADR_AREAS ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS drop constraint FK_CUSTOMERADR_SETTLEMENTS ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS drop constraint FK_CUSTOMERADR_STREETS ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS drop constraint FK_CUSTOMERADR_HOMETYPE ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS drop constraint FK_CUSTOMERADR_HOMEPARTTYPE ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.CUSTOMER_ADDRESS drop constraint FK_CUSTOMERADR_ROOMTYPE ]';
exception
  when OTHERS then
  null;
end;
/


begin
  execute immediate q'[alter table BARS.SETTLEMENTS_MATCH drop constraint FK_SETTLEMENTSMATCH_AREA ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.SETTLEMENTS_MATCH drop constraint FK_SETTLEMENTSMATCH_SETTLEMID ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.STREETS_MATCH drop constraint FK_STREETSMATCH_AREA ]';
exception
  when OTHERS then
  null;
end;
/

begin
  execute immediate q'[alter table BARS.STREETS_MATCH drop constraint FK_STREETSMATCH_SETTLEMENTS ]';
exception
  when OTHERS then
  null;
end;
/

BEGIN 
        execute immediate  
          'begin  
               bpa.remove_policies( p_table_name => ''CUSTOMER_ADDRESS'');
               null;
           end; 
          '; 
END; 
/
