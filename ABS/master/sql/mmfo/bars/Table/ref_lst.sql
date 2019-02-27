

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REF_LST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REF_LST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REF_LST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REF_LST'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REF_LST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REF_LST ***
begin 
  execute immediate '
  CREATE TABLE BARS.REF_LST 
   (	DATD DATE, 
	ND VARCHAR2(10), 
	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	S NUMBER(24,0), 
	REF NUMBER, 
	REC NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REF_LST ***
 exec bpa.alter_policies('REF_LST');


COMMENT ON TABLE BARS.REF_LST IS '';
COMMENT ON COLUMN BARS.REF_LST.DATD IS '';
COMMENT ON COLUMN BARS.REF_LST.ND IS '';
COMMENT ON COLUMN BARS.REF_LST.MFOA IS '';
COMMENT ON COLUMN BARS.REF_LST.NLSA IS '';
COMMENT ON COLUMN BARS.REF_LST.MFOB IS '';
COMMENT ON COLUMN BARS.REF_LST.NLSB IS '';
COMMENT ON COLUMN BARS.REF_LST.S IS '';
COMMENT ON COLUMN BARS.REF_LST.REF IS '';
COMMENT ON COLUMN BARS.REF_LST.REC IS '';
COMMENT ON COLUMN BARS.REF_LST.KF IS '';




PROMPT *** Create  constraint CC_REFLST_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_LST MODIFY (REF CONSTRAINT CC_REFLST_REF_NN NOT NULL DISABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFLST_REC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_LST MODIFY (REC CONSTRAINT CC_REFLST_REC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REF_LST_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_LST MODIFY (KF CONSTRAINT CC_REF_LST_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_REF_LST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XIE_REF_LST ON BARS.REF_LST (KF, DATD, ND, MFOA, NLSA, MFOB, NLSB, S) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


begin
  execute immediate 'alter  table ref_lst disable constraint CC_REFLST_REF_NN ';
exception when others then null;
end;
/


PROMPT *** Create  grants  REF_LST ***
grant SELECT                                                                 on REF_LST         to BARSREADER_ROLE;
grant DELETE                                                                 on REF_LST         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REF_LST         to BARS_DM;
grant DELETE                                                                 on REF_LST         to PYOD001;
grant SELECT                                                                 on REF_LST         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REF_LST         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REF_LST.sql =========*** End *** =====
PROMPT ===================================================================================== 
