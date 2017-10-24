

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VYPISKA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VYPISKA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VYPISKA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VYPISKA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VYPISKA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VYPISKA ***
begin 
  execute immediate '
  CREATE TABLE BARS.VYPISKA 
   (	FDAT DATE, 
	NLS VARCHAR2(15), 
	KV NUMBER(38,0) DEFAULT 980, 
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




PROMPT *** ALTER_POLICIES to VYPISKA ***
 exec bpa.alter_policies('VYPISKA');


COMMENT ON TABLE BARS.VYPISKA IS '';
COMMENT ON COLUMN BARS.VYPISKA.FDAT IS '';
COMMENT ON COLUMN BARS.VYPISKA.NLS IS '';
COMMENT ON COLUMN BARS.VYPISKA.KV IS '';
COMMENT ON COLUMN BARS.VYPISKA.DOS IS '';
COMMENT ON COLUMN BARS.VYPISKA.KOS IS '';
COMMENT ON COLUMN BARS.VYPISKA.OST IS '';




PROMPT *** Create  constraint XPK_VYPISKA ***
begin   
 execute immediate '
  ALTER TABLE BARS.VYPISKA ADD CONSTRAINT XPK_VYPISKA PRIMARY KEY (NLS, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007093 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VYPISKA MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007094 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VYPISKA MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_VYPISKA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_VYPISKA ON BARS.VYPISKA (NLS, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VYPISKA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VYPISKA         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VYPISKA         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VYPISKA.sql =========*** End *** =====
PROMPT ===================================================================================== 
