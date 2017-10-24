

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_TEMPLATES_4VAL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_TEMPLATES_4VAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_TEMPLATES_4VAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_TEMPLATES_4VAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_TEMPLATES_4VAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_TEMPLATES_4VAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_TEMPLATES_4VAL 
   (	KV NUMBER(*,0), 
	TT CHAR(3), 
	PM NUMBER(*,0), 
	KODN_I NUMBER(*,0), 
	KODN_O NUMBER(*,0), 
	TIP_D CHAR(3), 
	WD CHAR(1), 
	TIP_K CHAR(3), 
	WK CHAR(1), 
	COMM VARCHAR2(70), 
	TTL CHAR(3)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_TEMPLATES_4VAL ***
 exec bpa.alter_policies('TMP_TEMPLATES_4VAL');


COMMENT ON TABLE BARS.TMP_TEMPLATES_4VAL IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.KV IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.TT IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.PM IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.KODN_I IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.KODN_O IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.TIP_D IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.WD IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.TIP_K IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.WK IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.COMM IS '';
COMMENT ON COLUMN BARS.TMP_TEMPLATES_4VAL.TTL IS '';




PROMPT *** Create  constraint SYS_C008964 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TEMPLATES_4VAL MODIFY (KODN_I NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008965 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_TEMPLATES_4VAL MODIFY (KODN_O NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_TEMPLATES_4VAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_TEMPLATES_4VAL to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_TEMPLATES_4VAL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_TEMPLATES_4VAL.sql =========*** En
PROMPT ===================================================================================== 
