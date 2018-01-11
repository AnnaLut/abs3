

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_NBS_OB22.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_NBS_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_NBS_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_NBS_OB22 
   (	NBS CHAR(4), 
	OB22 CHAR(2), 
	OB_9129 CHAR(2), 
	OB_OVR CHAR(2), 
	OB_2207 CHAR(2), 
	OB_2208 CHAR(2), 
	OB_2209 CHAR(2), 
	OB_3570 CHAR(2), 
	OB_3579 CHAR(2), 
	TIP CHAR(3), 
	OB_2627 CHAR(2), 
	OB_2625X CHAR(2), 
	OB_2627X CHAR(2), 
	OB_2625D CHAR(2), 
	OB_2628 CHAR(2), 
	OB_6110 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_NBS_OB22 ***
 exec bpa.alter_policies('TMP_W4_NBS_OB22');


COMMENT ON TABLE BARS.TMP_W4_NBS_OB22 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.NBS IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_9129 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_OVR IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_2207 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_2208 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_2209 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_3570 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_3579 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.TIP IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_2627 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_2625X IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_2627X IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_2625D IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_2628 IS '';
COMMENT ON COLUMN BARS.TMP_W4_NBS_OB22.OB_6110 IS '';




PROMPT *** Create  constraint SYS_C00119195 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_NBS_OB22 MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119196 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_NBS_OB22 MODIFY (OB22 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119197 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_NBS_OB22 MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_W4_NBS_OB22 ***
grant SELECT                                                                 on TMP_W4_NBS_OB22 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_W4_NBS_OB22 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_NBS_OB22.sql =========*** End *
PROMPT ===================================================================================== 
