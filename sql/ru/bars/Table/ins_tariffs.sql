

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_TARIFFS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_TARIFFS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_TARIFFS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_TARIFFS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_TARIFFS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_TARIFFS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300), 
	MIN_VALUE NUMBER, 
	MIN_PERC NUMBER, 
	MAX_VALUE NUMBER, 
	MAX_PERC NUMBER, 
	AMORT NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_TARIFFS ***
 exec bpa.alter_policies('INS_TARIFFS');


COMMENT ON TABLE BARS.INS_TARIFFS IS '������� ������';
COMMENT ON COLUMN BARS.INS_TARIFFS.ID IS '�������������';
COMMENT ON COLUMN BARS.INS_TARIFFS.NAME IS '������������';
COMMENT ON COLUMN BARS.INS_TARIFFS.MIN_VALUE IS '̳������� ����';
COMMENT ON COLUMN BARS.INS_TARIFFS.MIN_PERC IS '̳�������� �������';
COMMENT ON COLUMN BARS.INS_TARIFFS.MAX_VALUE IS '����������� ����';
COMMENT ON COLUMN BARS.INS_TARIFFS.MAX_PERC IS '������������ �������';
COMMENT ON COLUMN BARS.INS_TARIFFS.AMORT IS '���������� �����������';




PROMPT *** Create  constraint PK_INSTARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFFS ADD CONSTRAINT PK_INSTARIFFS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101161 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFFS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSTARIFFS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSTARIFFS ON BARS.INS_TARIFFS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_TARIFFS.sql =========*** End *** =
PROMPT ===================================================================================== 
