

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CP_DEAL_DIFR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CP_DEAL_DIFR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CP_DEAL_DIFR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CP_DEAL_DIFR 
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
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CP_DEAL_DIFR ***
 exec bpa.alter_policies('TMP_CP_DEAL_DIFR');


COMMENT ON TABLE BARS.TMP_CP_DEAL_DIFR IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ID IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.RYN IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ACC IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ACCD IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ACCP IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ACCR IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ACCS IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.REF IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ERAT IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ACCR2 IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.ERATE IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.REF_OLD IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.REF_NEW IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.OP IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.DAT_UG IS '';
COMMENT ON COLUMN BARS.TMP_CP_DEAL_DIFR.PF IS '';




PROMPT *** Create  constraint SYS_C007477 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_DEAL_DIFR MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CP_DEAL_DIFR.sql =========*** End 
PROMPT ===================================================================================== 
