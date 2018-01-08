

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_DRB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_DRB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_DRB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_DRB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_DRB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_DRB ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_DRB 
   (	ID NUMBER, 
	NAME VARCHAR2(255), 
	TYPE_ID NUMBER, 
	EXP_NORMS NUMBER, 
	EXP_NORMS4CALC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_DRB ***
 exec bpa.alter_policies('WCS_DRB');


COMMENT ON TABLE BARS.WCS_DRB IS 'ДРБ';
COMMENT ON COLUMN BARS.WCS_DRB.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_DRB.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_DRB.TYPE_ID IS 'Тип';
COMMENT ON COLUMN BARS.WCS_DRB.EXP_NORMS IS 'Норми витрат (у відсотках до суми валового доходу)';
COMMENT ON COLUMN BARS.WCS_DRB.EXP_NORMS4CALC IS 'Розмір доходів, що враховуються (у відсотках до суми валового доходу) ';




PROMPT *** Create  constraint PK_WCSDRB ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_DRB ADD CONSTRAINT PK_WCSDRB PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSDRB_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_DRB MODIFY (NAME CONSTRAINT CC_WCSDRB_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSDRB_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_DRB MODIFY (TYPE_ID CONSTRAINT CC_WCSDRB_TID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSDRB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSDRB ON BARS.WCS_DRB (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_DRB ***
grant SELECT                                                                 on WCS_DRB         to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_DRB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_DRB         to BARS_DM;
grant SELECT                                                                 on WCS_DRB         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_DRB.sql =========*** End *** =====
PROMPT ===================================================================================== 
