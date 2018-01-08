

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_F84.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_F84 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_F84 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_F84 
   (	NLS VARCHAR2(15), 
	KV NUMBER, 
	NMS VARCHAR2(70), 
	DAT_RS DATE, 
	OST NUMBER(24,0), 
	S_NS NUMBER(24,0), 
	S_RS NUMBER(24,0), 
	S_RRS NUMBER(24,0), 
	S_SI NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_F84 ***
 exec bpa.alter_policies('CP_F84');


COMMENT ON TABLE BARS.CP_F84 IS '';
COMMENT ON COLUMN BARS.CP_F84.NLS IS '';
COMMENT ON COLUMN BARS.CP_F84.KV IS '';
COMMENT ON COLUMN BARS.CP_F84.NMS IS '';
COMMENT ON COLUMN BARS.CP_F84.DAT_RS IS '';
COMMENT ON COLUMN BARS.CP_F84.OST IS '';
COMMENT ON COLUMN BARS.CP_F84.S_NS IS '';
COMMENT ON COLUMN BARS.CP_F84.S_RS IS '';
COMMENT ON COLUMN BARS.CP_F84.S_RRS IS '';
COMMENT ON COLUMN BARS.CP_F84.S_SI IS '';




PROMPT *** Create  constraint SYS_C007584 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_F84 MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007585 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_F84 MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007586 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_F84 MODIFY (DAT_RS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_F84 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_F84          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_F84          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_F84          to CP_F84;
grant SELECT                                                                 on CP_F84          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_F84.sql =========*** End *** ======
PROMPT ===================================================================================== 
