

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SUMMCODES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SUMMCODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SUMMCODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SUMMCODES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SUMMCODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SUMMCODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SUMMCODES 
   (	CODID NUMBER(38,0), 
	COD CHAR(1), 
	VALUE NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SUMMCODES ***
 exec bpa.alter_policies('SUMMCODES');


COMMENT ON TABLE BARS.SUMMCODES IS '';
COMMENT ON COLUMN BARS.SUMMCODES.CODID IS '';
COMMENT ON COLUMN BARS.SUMMCODES.COD IS '';
COMMENT ON COLUMN BARS.SUMMCODES.VALUE IS '';




PROMPT *** Create  constraint SYS_C008492 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMMCODES MODIFY (CODID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008493 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMMCODES MODIFY (COD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008494 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SUMMCODES MODIFY (VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SUMMCODES ***
grant SELECT                                                                 on SUMMCODES       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SUMMCODES       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SUMMCODES       to START1;
grant SELECT                                                                 on SUMMCODES       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SUMMCODES.sql =========*** End *** ===
PROMPT ===================================================================================== 
