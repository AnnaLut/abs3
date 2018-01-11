

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PKK_INF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PKK_INF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PKK_INF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PKK_INF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PKK_INF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PKK_INF ***
begin 
  execute immediate '
  CREATE TABLE BARS.PKK_INF 
   (	REC NUMBER(38,0), 
	NLS VARCHAR2(14), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	NLSB VARCHAR2(14), 
	S NUMBER(22,0), 
	KV NUMBER(3,0), 
	DATP DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PKK_INF ***
 exec bpa.alter_policies('PKK_INF');


COMMENT ON TABLE BARS.PKK_INF IS '';
COMMENT ON COLUMN BARS.PKK_INF.REC IS '';
COMMENT ON COLUMN BARS.PKK_INF.NLS IS '';
COMMENT ON COLUMN BARS.PKK_INF.KF IS '';
COMMENT ON COLUMN BARS.PKK_INF.NLSB IS '';
COMMENT ON COLUMN BARS.PKK_INF.S IS '';
COMMENT ON COLUMN BARS.PKK_INF.KV IS '';
COMMENT ON COLUMN BARS.PKK_INF.DATP IS '';




PROMPT *** Create  constraint CC_PKKINF_REC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF MODIFY (REC CONSTRAINT CC_PKKINF_REC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKINF_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF MODIFY (NLS CONSTRAINT CC_PKKINF_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PKKINF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF MODIFY (KF CONSTRAINT CC_PKKINF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PKKINF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PKK_INF ADD CONSTRAINT PK_PKKINF PRIMARY KEY (REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PKKINF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PKKINF ON BARS.PKK_INF (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_PKKINF_NLS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_PKKINF_NLS ON BARS.PKK_INF (NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PKK_INF ***
grant SELECT                                                                 on PKK_INF         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_INF         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PKK_INF         to OBPC;
grant DELETE                                                                 on PKK_INF         to PYOD001;
grant SELECT                                                                 on PKK_INF         to TECH004;
grant SELECT                                                                 on PKK_INF         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PKK_INF         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PKK_INF.sql =========*** End *** =====
PROMPT ===================================================================================== 
