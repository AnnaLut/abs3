

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CD_DATE_HIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CD_DATE_HIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CD_DATE_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CD_DATE_HIST 
   (	REF NUMBER, 
	ACC NUMBER, 
	DAT_UG DATE, 
	ACTIVE NUMBER, 
	REF_MAIN NUMBER(*,0), 
	REF_PARENT NUMBER, 
	DATE_CONTRACT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CD_DATE_HIST ***
 exec bpa.alter_policies('CD_DATE_HIST');


COMMENT ON TABLE BARS.CD_DATE_HIST IS '';
COMMENT ON COLUMN BARS.CD_DATE_HIST.REF IS '';
COMMENT ON COLUMN BARS.CD_DATE_HIST.ACC IS '';
COMMENT ON COLUMN BARS.CD_DATE_HIST.DAT_UG IS '';
COMMENT ON COLUMN BARS.CD_DATE_HIST.ACTIVE IS '';
COMMENT ON COLUMN BARS.CD_DATE_HIST.REF_MAIN IS '';
COMMENT ON COLUMN BARS.CD_DATE_HIST.REF_PARENT IS '';
COMMENT ON COLUMN BARS.CD_DATE_HIST.DATE_CONTRACT IS '';




PROMPT *** Create  constraint SYS_C004860 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CD_DATE_HIST MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CD_DATE_HIST ***
grant SELECT                                                                 on CD_DATE_HIST    to BARSREADER_ROLE;
grant SELECT                                                                 on CD_DATE_HIST    to BARS_DM;
grant SELECT                                                                 on CD_DATE_HIST    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CD_DATE_HIST.sql =========*** End *** 
PROMPT ===================================================================================== 
