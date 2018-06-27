

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPPI.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPPI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPPI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPPI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPPI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPPI ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPPI 
   (	SPPI_ID VARCHAR2(5), 
	SPPI_NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPPI ***
 exec bpa.alter_policies('SPPI');


COMMENT ON TABLE BARS.SPPI IS 'Відповідність критерію SPPI';
COMMENT ON COLUMN BARS.SPPI.SPPI_ID IS 'Параметр';
COMMENT ON COLUMN BARS.SPPI.SPPI_NAME IS 'Наименование параметра';




PROMPT *** Create  constraint SYS_C00139606 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPPI MODIFY (SPPI_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint PK_SPPI ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPPI ADD CONSTRAINT PK_SPPI PRIMARY KEY (SPPI_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create index PK_SPPI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPPI ON BARS.SPPI (SPPI_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** ADD COLUMN sppi_value***
begin
execute immediate '
 alter table sppi add sppi_value number(1)';
 exception when others then 
    if sqlcode=-01430 then null;
    end if;
end;
/

PROMPT *** Create  grants  SPPI ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SPPI            to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPPI.sql =========*** End *** ========
PROMPT ===================================================================================== 
