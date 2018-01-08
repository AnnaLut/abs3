

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_AA.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_AA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_AA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_AA 
   (	NLSN VARCHAR2(15), 
	NP080 VARCHAR2(4), 
	NOB22 VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_AA ***
 exec bpa.alter_policies('TMP_AA');


COMMENT ON TABLE BARS.TMP_AA IS '';
COMMENT ON COLUMN BARS.TMP_AA.NLSN IS '';
COMMENT ON COLUMN BARS.TMP_AA.NP080 IS '';
COMMENT ON COLUMN BARS.TMP_AA.NOB22 IS '';




PROMPT *** Create  constraint SYS_C008764 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_AA MODIFY (NLSN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_AA ***
grant SELECT                                                                 on TMP_AA          to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_AA          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_AA.sql =========*** End *** ======
PROMPT ===================================================================================== 
