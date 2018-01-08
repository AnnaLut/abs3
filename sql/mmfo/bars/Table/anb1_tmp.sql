

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANB1_TMP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANB1_TMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANB1_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.ANB1_TMP 
   (	ID CHAR(4), 
	NAME VARCHAR2(40), 
	V0 NUMBER, 
	G0 NUMBER, 
	N0 NUMBER, 
	SID VARCHAR2(8), 
	PR_99 NUMBER(*,0), 
	PR_SR NUMBER(*,0), 
	PR_AU NUMBER(*,0)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANB1_TMP ***
 exec bpa.alter_policies('ANB1_TMP');


COMMENT ON TABLE BARS.ANB1_TMP IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.ID IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.NAME IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.V0 IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.G0 IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.N0 IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.SID IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.PR_99 IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.PR_SR IS '';
COMMENT ON COLUMN BARS.ANB1_TMP.PR_AU IS '';




PROMPT *** Create  constraint SYS_C0010380 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANB1_TMP MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANB1_TMP ***
grant SELECT                                                                 on ANB1_TMP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANB1_TMP        to BARS_DM;
grant SELECT                                                                 on ANB1_TMP        to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ANB1_TMP        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANB1_TMP.sql =========*** End *** ====
PROMPT ===================================================================================== 
