

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DEAL_141027.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DEAL_141027 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DEAL_141027 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DEAL_141027 
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




PROMPT *** ALTER_POLICIES to CP_DEAL_141027 ***
 exec bpa.alter_policies('CP_DEAL_141027');


COMMENT ON TABLE BARS.CP_DEAL_141027 IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ID IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.RYN IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ACC IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ACCD IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ACCP IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ACCR IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ACCS IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.REF IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ERAT IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ACCR2 IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.ERATE IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.DAZS IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.REF_OLD IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.REF_NEW IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.OP IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.DAT_UG IS '';
COMMENT ON COLUMN BARS.CP_DEAL_141027.PF IS '';




PROMPT *** Create  constraint SYS_C009441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL_141027 MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_DEAL_141027 ***
grant SELECT                                                                 on CP_DEAL_141027  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DEAL_141027.sql =========*** End **
PROMPT ===================================================================================== 
