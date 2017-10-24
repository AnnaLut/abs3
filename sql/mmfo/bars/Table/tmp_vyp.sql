

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_VYP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_VYP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_VYP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_VYP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_VYP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_VYP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_VYP 
   (	FDAT DATE, 
	NLS VARCHAR2(15), 
	KV NUMBER(38,0), 
	DOS NUMBER, 
	KOS NUMBER, 
	OST NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_VYP ***
 exec bpa.alter_policies('TMP_VYP');


COMMENT ON TABLE BARS.TMP_VYP IS '';
COMMENT ON COLUMN BARS.TMP_VYP.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_VYP.NLS IS '';
COMMENT ON COLUMN BARS.TMP_VYP.KV IS '';
COMMENT ON COLUMN BARS.TMP_VYP.DOS IS '';
COMMENT ON COLUMN BARS.TMP_VYP.KOS IS '';
COMMENT ON COLUMN BARS.TMP_VYP.OST IS '';




PROMPT *** Create  constraint SYS_C007384 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_VYP MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007385 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_VYP MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_VYP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_VYP         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_VYP         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_VYP.sql =========*** End *** =====
PROMPT ===================================================================================== 
