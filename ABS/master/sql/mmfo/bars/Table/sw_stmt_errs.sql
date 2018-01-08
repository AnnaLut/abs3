

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_STMT_ERRS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_STMT_ERRS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_STMT_ERRS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_STMT_ERRS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_STMT_ERRS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_STMT_ERRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_STMT_ERRS 
   (	STMT_SWREF NUMBER(38,0), 
	STMT_PTIME DATE, 
	STMT_ERRMSG VARCHAR2(4000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_STMT_ERRS ***
 exec bpa.alter_policies('SW_STMT_ERRS');


COMMENT ON TABLE BARS.SW_STMT_ERRS IS 'SWT. Ошибки при разборе выписок';
COMMENT ON COLUMN BARS.SW_STMT_ERRS.STMT_SWREF IS 'Реф. сообщения';
COMMENT ON COLUMN BARS.SW_STMT_ERRS.STMT_PTIME IS 'Дата и время обработки';
COMMENT ON COLUMN BARS.SW_STMT_ERRS.STMT_ERRMSG IS 'Сообщение об ошибке';
COMMENT ON COLUMN BARS.SW_STMT_ERRS.KF IS '';




PROMPT *** Create  constraint PK_SWSTMTERRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_ERRS ADD CONSTRAINT PK_SWSTMTERRS PRIMARY KEY (STMT_SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTMTERRS_STMTSWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_ERRS MODIFY (STMT_SWREF CONSTRAINT CC_SWSTMTERRS_STMTSWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTMTERRS_STMTPTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_ERRS MODIFY (STMT_PTIME CONSTRAINT CC_SWSTMTERRS_STMTPTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTMTERRS_STMTERRMSG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_ERRS MODIFY (STMT_ERRMSG CONSTRAINT CC_SWSTMTERRS_STMTERRMSG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTMTERRS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT_ERRS MODIFY (KF CONSTRAINT CC_SWSTMTERRS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWSTMTERRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWSTMTERRS ON BARS.SW_STMT_ERRS (STMT_SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_STMT_ERRS ***
grant SELECT                                                                 on SW_STMT_ERRS    to BARSREADER_ROLE;
grant SELECT                                                                 on SW_STMT_ERRS    to BARS_DM;
grant SELECT                                                                 on SW_STMT_ERRS    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_STMT_ERRS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_STMT_ERRS.sql =========*** End *** 
PROMPT ===================================================================================== 
