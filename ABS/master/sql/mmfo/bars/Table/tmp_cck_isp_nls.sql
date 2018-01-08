

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CCK_ISP_NLS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CCK_ISP_NLS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CCK_ISP_NLS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CCK_ISP_NLS 
   (	ID NUMBER(38,0), 
	ISP NUMBER(38,0), 
	ORD NUMBER(38,0), 
	KF VARCHAR2(6), 
	BRANCH VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CCK_ISP_NLS ***
 exec bpa.alter_policies('TMP_CCK_ISP_NLS');


COMMENT ON TABLE BARS.TMP_CCK_ISP_NLS IS '';
COMMENT ON COLUMN BARS.TMP_CCK_ISP_NLS.ID IS '';
COMMENT ON COLUMN BARS.TMP_CCK_ISP_NLS.ISP IS '';
COMMENT ON COLUMN BARS.TMP_CCK_ISP_NLS.ORD IS '';
COMMENT ON COLUMN BARS.TMP_CCK_ISP_NLS.KF IS '';
COMMENT ON COLUMN BARS.TMP_CCK_ISP_NLS.BRANCH IS '';




PROMPT *** Create  constraint SYS_C00119350 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CCK_ISP_NLS MODIFY (ISP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119351 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CCK_ISP_NLS MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119352 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CCK_ISP_NLS MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CCK_ISP_NLS ***
grant SELECT                                                                 on TMP_CCK_ISP_NLS to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_CCK_ISP_NLS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CCK_ISP_NLS.sql =========*** End *
PROMPT ===================================================================================== 
