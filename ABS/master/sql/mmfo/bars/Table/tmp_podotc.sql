

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PODOTC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PODOTC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PODOTC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PODOTC 
   (	ID NUMBER(38,0), 
	TAG VARCHAR2(10), 
	VAL VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PODOTC ***
 exec bpa.alter_policies('TMP_PODOTC');


COMMENT ON TABLE BARS.TMP_PODOTC IS '';
COMMENT ON COLUMN BARS.TMP_PODOTC.ID IS '';
COMMENT ON COLUMN BARS.TMP_PODOTC.TAG IS '';
COMMENT ON COLUMN BARS.TMP_PODOTC.VAL IS '';




PROMPT *** Create  constraint SYS_C00132369 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PODOTC MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132370 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PODOTC MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132371 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_PODOTC MODIFY (VAL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_PODOTC ***
grant SELECT                                                                 on TMP_PODOTC      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PODOTC.sql =========*** End *** ==
PROMPT ===================================================================================== 
