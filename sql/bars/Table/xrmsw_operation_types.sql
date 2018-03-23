

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_OPERATION_TYPES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_OPERATION_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_OPERATION_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_OPERATION_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_OPERATION_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_OPERATION_TYPES 
   (	TRANTYPE NUMBER(*,0), 
	DESCRIPTION VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



begin
 execute immediate 'alter table XRMSW_OPERATION_TYPES add (Method varchar2(500))';
exception when others then null;
end; 
/
begin
 execute immediate 'alter table XRMSW_OPERATION_TYPES add (Procname varchar2(500))';
exception when others then null;
end; 
/
begin
 execute immediate 'alter table XRMSW_OPERATION_TYPES add (INTGTYPE varchar2(50))';
exception when others then null;
end; 
/


PROMPT *** ALTER_POLICIES to XRMSW_OPERATION_TYPES ***
 exec bpa.alter_policies('XRMSW_OPERATION_TYPES');


COMMENT ON TABLE BARS.XRMSW_OPERATION_TYPES IS 'Опис кодів операцій по інтеграції XRM Єдине вікно - АБС';
COMMENT ON COLUMN BARS.XRMSW_OPERATION_TYPES.TRANTYPE IS 'Код';
COMMENT ON COLUMN BARS.XRMSW_OPERATION_TYPES.DESCRIPTION IS 'Опис';




PROMPT *** Create  constraint PK_TRANTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_OPERATION_TYPES ADD CONSTRAINT PK_TRANTYPE PRIMARY KEY (TRANTYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TRANTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TRANTYPE ON BARS.XRMSW_OPERATION_TYPES (TRANTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XRMSW_OPERATION_TYPES ***
grant SELECT                                                                 on XRMSW_OPERATION_TYPES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_OPERATION_TYPES.sql =========***
PROMPT ===================================================================================== 
