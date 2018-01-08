

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_DEL_3A.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_DEL_3A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_DEL_3A'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OTCN_DEL_3A'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_DEL_3A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_DEL_3A ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_DEL_3A 
   (	DATF DATE, 
	ISP NUMBER, 
	ACC NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	TPF VARCHAR2(100), 
	SUMO NUMBER, 
	SUMF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_DEL_3A ***
 exec bpa.alter_policies('OTCN_DEL_3A');


COMMENT ON TABLE BARS.OTCN_DEL_3A IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.KV IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.TPF IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.SUMO IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.SUMF IS '';
COMMENT ON COLUMN BARS.OTCN_DEL_3A.KF IS '';




PROMPT *** Create  constraint CC_OTCNDEL3A_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_DEL_3A MODIFY (KF CONSTRAINT CC_OTCNDEL3A_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OTCN_DEL_3A ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_DEL_3A ADD CONSTRAINT PK_OTCN_DEL_3A PRIMARY KEY (TPF, ACC, ISP, DATF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005149 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_DEL_3A MODIFY (DATF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005150 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_DEL_3A MODIFY (ISP NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005151 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_DEL_3A MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005152 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_DEL_3A MODIFY (NLS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005153 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_DEL_3A MODIFY (KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005154 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_DEL_3A MODIFY (TPF NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_DEL_3A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_DEL_3A ON BARS.OTCN_DEL_3A (TPF, ACC, ISP, DATF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_DEL_3A ***
grant SELECT                                                                 on OTCN_DEL_3A     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_DEL_3A     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_DEL_3A     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_DEL_3A     to RPBN002;
grant SELECT                                                                 on OTCN_DEL_3A     to UPLD;



PROMPT *** Create SYNONYM  to OTCN_DEL_3A ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_DEL_3A FOR BARS.OTCN_DEL_3A;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_DEL_3A.sql =========*** End *** =
PROMPT ===================================================================================== 
