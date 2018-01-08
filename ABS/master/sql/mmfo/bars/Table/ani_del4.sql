

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_DEL4.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_DEL4 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_DEL4'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL4'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL4'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_DEL4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_DEL4 
   (	KV NUMBER(3,0), 
	NLS VARCHAR2(15), 
	VOSQ NUMBER, 
	KOSQ NUMBER, 
	DOSQ NUMBER, 
	IOSQ NUMBER, 
	VOSN NUMBER, 
	KOSN NUMBER, 
	DOSN NUMBER, 
	IOSN NUMBER, 
	KOSN1 NUMBER, 
	DOSN1 NUMBER, 
	DEL_KN NUMBER, 
	DEL_DN NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_DEL4 ***
 exec bpa.alter_policies('ANI_DEL4');


COMMENT ON TABLE BARS.ANI_DEL4 IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.KV IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.NLS IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.VOSQ IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.KOSQ IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.DOSQ IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.IOSQ IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.VOSN IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.KOSN IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.DOSN IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.IOSN IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.KOSN1 IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.DOSN1 IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.DEL_KN IS '';
COMMENT ON COLUMN BARS.ANI_DEL4.DEL_DN IS '';




PROMPT *** Create  constraint SYS_C009412 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI_DEL4 MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009413 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI_DEL4 MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANI_DEL4 ***
grant SELECT                                                                 on ANI_DEL4        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_DEL4.sql =========*** End *** ====
PROMPT ===================================================================================== 
