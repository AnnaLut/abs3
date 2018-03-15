PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU_DATA_REQUEST_TRACKING_601.sql =========*** Run *** 
PROMPT ===================================================================================== 


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU_DATA_REQUEST_TRACKING_601'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBU_DATA_REQUEST_TRACKING_601'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBU_DATA_REQUEST_TRACKING_601 ***
begin 
    execute immediate
    'create table NBU_DATA_REQUEST_TRACKING_601
	(
	request_id       NUMBER(38),
	sys_time         DATE,
	state_id         NUMBER(5),
	tracking_message VARCHAR2(4000)
	)	
    TABLESPACE BRSMDLD';
  exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

grant all on NBU_DATA_REQUEST_TRACKING_601 to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** END *** ========== Scripts /Sql/BARS/Table/NBU_DATA_REQUEST_TRACKING_601.sql =========*** END *** 
PROMPT ===================================================================================== 

