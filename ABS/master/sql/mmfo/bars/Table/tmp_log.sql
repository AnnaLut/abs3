

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_LOG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_LOG'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TMP_LOG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TMP_LOG'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_LOG 
   (	REF NUMBER(38,0), 
	MSG VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	DAT_MSG DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_LOG ***
 exec bpa.alter_policies('TMP_LOG');


COMMENT ON TABLE BARS.TMP_LOG IS 'Временная таблица';
COMMENT ON COLUMN BARS.TMP_LOG.REF IS '№ п/п';
COMMENT ON COLUMN BARS.TMP_LOG.MSG IS 'Сообщение';
COMMENT ON COLUMN BARS.TMP_LOG.KF IS '';
COMMENT ON COLUMN BARS.TMP_LOG.DAT_MSG IS '';




PROMPT *** Create  constraint FK_TMPLOG_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LOG ADD CONSTRAINT FK_TMPLOG_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPLOG_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LOG MODIFY (REF CONSTRAINT CC_TMPLOG_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPLOG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LOG MODIFY (KF CONSTRAINT CC_TMPLOG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TMPLOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_LOG ADD CONSTRAINT PK_TMPLOG PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPLOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPLOG ON BARS.TMP_LOG (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LOG         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_LOG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_LOG         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_LOG         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_LOG.sql =========*** End *** =====
PROMPT ===================================================================================== 
