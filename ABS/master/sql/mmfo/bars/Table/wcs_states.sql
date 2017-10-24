

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_STATES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_STATES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_STATES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_STATES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_STATES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_STATES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_STATES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	PARENT VARCHAR2(100), 
	BEFORE_PROC VARCHAR2(4000), 
	AFTER_PROC VARCHAR2(4000), 
	IS_DISP NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_STATES ***
 exec bpa.alter_policies('WCS_STATES');


COMMENT ON TABLE BARS.WCS_STATES IS 'Состояния заявки';
COMMENT ON COLUMN BARS.WCS_STATES.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.WCS_STATES.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.WCS_STATES.PARENT IS 'Предидущее состояние';
COMMENT ON COLUMN BARS.WCS_STATES.BEFORE_PROC IS 'Процедура выполняемая до установки состояния';
COMMENT ON COLUMN BARS.WCS_STATES.AFTER_PROC IS 'Процедура выполняемая по окончанию состояния';
COMMENT ON COLUMN BARS.WCS_STATES.IS_DISP IS 'Отображаемое ли состояние';




PROMPT *** Create  constraint CC_WCSSTATES_ISDISP ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STATES ADD CONSTRAINT CC_WCSSTATES_ISDISP CHECK (is_disp in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSSTATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STATES ADD CONSTRAINT PK_WCSSTATES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSSTATES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_STATES MODIFY (NAME CONSTRAINT CC_WCSSTATES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSSTATES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSSTATES ON BARS.WCS_STATES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_STATES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_STATES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_STATES      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_STATES      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_STATES.sql =========*** End *** ==
PROMPT ===================================================================================== 
