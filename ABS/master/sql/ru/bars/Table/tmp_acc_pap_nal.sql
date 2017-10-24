

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACC_PAP_NAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACC_PAP_NAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACC_PAP_NAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACC_PAP_NAL 
   (	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	PAP NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACC_PAP_NAL ***
 exec bpa.alter_policies('TMP_ACC_PAP_NAL');


COMMENT ON TABLE BARS.TMP_ACC_PAP_NAL IS '';
COMMENT ON COLUMN BARS.TMP_ACC_PAP_NAL.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACC_PAP_NAL.NLS IS '';
COMMENT ON COLUMN BARS.TMP_ACC_PAP_NAL.PAP IS '';




PROMPT *** Create  constraint SYS_C0037902 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_PAP_NAL MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0037901 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_PAP_NAL MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACC_PAP_NAL ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_ACC_PAP_NAL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACC_PAP_NAL.sql =========*** End *
PROMPT ===================================================================================== 
