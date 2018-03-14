PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU_DATA_TYPE_601.sql =========*** Run *** 
PROMPT ===================================================================================== 

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBU_DATA_TYPE_601'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBU_DATA_TYPE_601'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBU_DATA_TYPE_601***
begin 
    execute immediate
    'create table NBU_DATA_TYPE_601
	(
  	id                NUMBER(38),
  	data_type_code    VARCHAR2(30 CHAR),
  	data_type_name    VARCHAR2(4000),
  	gathering_block   VARCHAR2(4000),
  	transfering_block VARCHAR2(4000),
  	is_active         NUMBER(1)
	)
    TABLESPACE BRSMDLD';
  exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

grant all on NBU_DATA_TYPE_601 to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** END *** ========== Scripts /Sql/BARS/Table/NBU_DATA_TYPE_601.sql =========*** END *** 
PROMPT ===================================================================================== 

