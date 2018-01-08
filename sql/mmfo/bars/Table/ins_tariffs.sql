

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_TARIFFS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_TARIFFS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_TARIFFS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
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
	AMORT NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_TARIFFS ***
 exec bpa.alter_policies('INS_TARIFFS');


COMMENT ON TABLE BARS.INS_TARIFFS IS 'Страхові тарифи';
COMMENT ON COLUMN BARS.INS_TARIFFS.KF IS '';
COMMENT ON COLUMN BARS.INS_TARIFFS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_TARIFFS.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.INS_TARIFFS.MIN_VALUE IS 'Мінімальна сума';
COMMENT ON COLUMN BARS.INS_TARIFFS.MIN_PERC IS 'Мінімальний процент';
COMMENT ON COLUMN BARS.INS_TARIFFS.MAX_VALUE IS 'Максимальна сума';
COMMENT ON COLUMN BARS.INS_TARIFFS.MAX_PERC IS 'Максимальний процент';
COMMENT ON COLUMN BARS.INS_TARIFFS.AMORT IS 'Коефіцієнт амортизації';




PROMPT *** Create  constraint SYS_C0033278 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFFS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSTARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_TARIFFS ADD CONSTRAINT PK_INSTARIFFS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSTARIFFS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSTARIFFS ON BARS.INS_TARIFFS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_TARIFFS.sql =========*** End *** =
PROMPT ===================================================================================== 
