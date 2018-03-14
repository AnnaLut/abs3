
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU_DATA_REQUEST_601.sql =========*** Run *** 
PROMPT ===================================================================================== 


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU_DATA_REQUEST_601'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBU_DATA_REQUEST_601'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBU_DATA_REQUEST_601 ***
begin 
    execute immediate
    'create table NBU_DATA_REQUEST_601
	(
	id                 NUMBER(38),
	report_instance_id NUMBER(38),
	kf                 VARCHAR2(6 CHAR),
	data_type_id       NUMBER(38),
	state_id           INTEGER
	)	
    TABLESPACE BRSMDLD';
  exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

exec bpa.alter_policies('NBU_DATA_REQUEST_601');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UIX_NBU_DATA_REQUEST_601 on NBU_DATA_REQUEST_601 (id,report_instance_id)';
exception
    when name_already_used then
         null;
 end;
/

grant all on NBU_DATA_REQUEST_601 to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** END *** ========== Scripts /Sql/BARS/Table/NBU_DATA_REQUEST_601.sql =========*** END *** 
PROMPT ===================================================================================== 

