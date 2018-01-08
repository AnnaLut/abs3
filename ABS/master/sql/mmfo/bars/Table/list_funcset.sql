

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LIST_FUNCSET.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LIST_FUNCSET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LIST_FUNCSET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LIST_FUNCSET'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LIST_FUNCSET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LIST_FUNCSET ***
begin 
  execute immediate '
  CREATE TABLE BARS.LIST_FUNCSET 
   (	REC_ID NUMBER(38,0), 
	SET_ID NUMBER(38,0), 
	FUNC_ID NUMBER(38,0), 
	FUNC_ACTIVITY NUMBER(1,0), 
	FUNC_POSITION NUMBER(5,0), 
	FUNC_COMMENTS VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LIST_FUNCSET ***
 exec bpa.alter_policies('LIST_FUNCSET');


COMMENT ON TABLE BARS.LIST_FUNCSET IS 'Справочник списков функций';
COMMENT ON COLUMN BARS.LIST_FUNCSET.REC_ID IS 'Номер записи';
COMMENT ON COLUMN BARS.LIST_FUNCSET.SET_ID IS 'Код записи';
COMMENT ON COLUMN BARS.LIST_FUNCSET.FUNC_ID IS 'Номер функции (ID)';
COMMENT ON COLUMN BARS.LIST_FUNCSET.FUNC_ACTIVITY IS 'Активность функции';
COMMENT ON COLUMN BARS.LIST_FUNCSET.FUNC_POSITION IS 'Позиция расположения';
COMMENT ON COLUMN BARS.LIST_FUNCSET.FUNC_COMMENTS IS 'Комментарий';
COMMENT ON COLUMN BARS.LIST_FUNCSET.KF IS '';




PROMPT *** Create  constraint SYS_C009255 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET MODIFY (REC_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LISTFUNCSET_SETID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET MODIFY (SET_ID CONSTRAINT CC_LISTFUNCSET_SETID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LISTFUNCSET_FUNCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET MODIFY (FUNC_ID CONSTRAINT CC_LISTFUNCSET_FUNCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LISTFUNCSET_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET MODIFY (KF CONSTRAINT CC_LISTFUNCSET_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_LISTFUNCSET ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET ADD CONSTRAINT PK_LISTFUNCSET PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_LISTFUNCSET_FUNCACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_FUNCSET ADD CONSTRAINT CC_LISTFUNCSET_FUNCACTIVITY CHECK (func_activity in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_LISTFUNCSET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_LISTFUNCSET ON BARS.LIST_FUNCSET (SET_ID, FUNC_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LISTFUNCSET ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LISTFUNCSET ON BARS.LIST_FUNCSET (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LIST_FUNCSET ***
grant DELETE,INSERT,SELECT,UPDATE                                            on LIST_FUNCSET    to ABS_ADMIN;
grant SELECT                                                                 on LIST_FUNCSET    to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on LIST_FUNCSET    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LIST_FUNCSET    to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on LIST_FUNCSET    to START1;
grant SELECT                                                                 on LIST_FUNCSET    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on LIST_FUNCSET    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LIST_FUNCSET.sql =========*** End *** 
PROMPT ===================================================================================== 
