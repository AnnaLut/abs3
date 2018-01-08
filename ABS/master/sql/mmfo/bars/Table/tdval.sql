

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TDVAL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TDVAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TDVAL'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TDVAL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TDVAL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TDVAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TDVAL 
   (	REF NUMBER(38,0), 
	REC NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	 CONSTRAINT PK_TDVAL PRIMARY KEY (REF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TDVAL ***
 exec bpa.alter_policies('TDVAL');


COMMENT ON TABLE BARS.TDVAL IS '';
COMMENT ON COLUMN BARS.TDVAL.REF IS '';
COMMENT ON COLUMN BARS.TDVAL.REC IS '';
COMMENT ON COLUMN BARS.TDVAL.KF IS '';




PROMPT *** Create  constraint CC_TDVAL_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TDVAL MODIFY (REF CONSTRAINT CC_TDVAL_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TDVAL_REC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TDVAL MODIFY (REC CONSTRAINT CC_TDVAL_REC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TDVAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TDVAL MODIFY (KF CONSTRAINT CC_TDVAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TDVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TDVAL ADD CONSTRAINT PK_TDVAL PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XAK_DVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TDVAL ADD CONSTRAINT XAK_DVAL UNIQUE (REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TDVAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TDVAL ON BARS.TDVAL (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_DVAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XAK_DVAL ON BARS.TDVAL (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TDVAL ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TDVAL           to BARS014;
grant SELECT                                                                 on TDVAL           to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TDVAL           to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TDVAL           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TDVAL.sql =========*** End *** =======
PROMPT ===================================================================================== 
