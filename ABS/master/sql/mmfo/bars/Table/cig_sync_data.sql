

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_SYNC_DATA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_SYNC_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_SYNC_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_SYNC_DATA'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''CIG_SYNC_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_SYNC_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_SYNC_DATA 
   (	DATA_ID NUMBER(38,0), 
	DATA_TYPE NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	 CONSTRAINT PK_CIGSYNCDATA PRIMARY KEY (DATA_ID, DATA_TYPE, BRANCH) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_SYNC_DATA ***
 exec bpa.alter_policies('CIG_SYNC_DATA');


COMMENT ON TABLE BARS.CIG_SYNC_DATA IS 'Таблица с референсами данных, готовых к отсылке';
COMMENT ON COLUMN BARS.CIG_SYNC_DATA.DATA_ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.CIG_SYNC_DATA.DATA_TYPE IS 'Тип синхрнизируемых данных (cig_sync_types)';
COMMENT ON COLUMN BARS.CIG_SYNC_DATA.BRANCH IS '';




PROMPT *** Create  constraint CC_CIGSYNCDATA_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_SYNC_DATA MODIFY (BRANCH CONSTRAINT CC_CIGSYNCDATA_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  index PK_CIGSYNCDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGSYNCDATA ON BARS.CIG_SYNC_DATA (DATA_ID, DATA_TYPE, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_SYNC_DATA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_SYNC_DATA   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_SYNC_DATA   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_SYNC_DATA   to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_SYNC_DATA ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_SYNC_DATA FOR BARS.CIG_SYNC_DATA;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_SYNC_DATA.sql =========*** End ***
PROMPT ===================================================================================== 
