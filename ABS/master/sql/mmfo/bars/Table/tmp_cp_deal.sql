

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CP_DEAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CP_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CP_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CP_DEAL 
   (	ID NUMBER, 
	RYN NUMBER, 
	ACC NUMBER, 
	ACCD NUMBER, 
	ACCP NUMBER, 
	ACCR NUMBER, 
	ACCS NUMBER, 
	REF NUMBER, 
	ERAT NUMBER, 
	ACCR2 NUMBER, 
	ERATE NUMBER, 
	DAZS DATE, 
	REF_OLD NUMBER(*,0), 
	REF_NEW NUMBER(*,0), 
	OP NUMBER(*,0), 
	DAT_UG DATE, 
	PF NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CP_DEAL ***
 exec bpa.alter_policies('TMP_CP_DEAL');


COMMENT ON TABLE BARS.TMP_CP_DEAL IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ID IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.RYN IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ACC IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ACCD IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ACCP IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ACCR IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ACCS IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.REF IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ERAT IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ACCR2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.ERATE IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.REF_OLD IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.REF_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.OP IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.DAT_UG IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL.PF IS '';




PROMPT *** Create  constraint SYS_C004844 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_DEAL MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CP_DEAL ***
grant SELECT                                                                 on TMP_CP_DEAL     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CP_DEAL     to BARS_DM;
grant SELECT                                                                 on TMP_CP_DEAL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CP_DEAL.sql =========*** End *** =
PROMPT ===================================================================================== 
