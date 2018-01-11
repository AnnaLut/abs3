

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EVENT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EVENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EVENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EVENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EVENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EVENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.EVENT 
   (	EVENT NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EVENT ***
 exec bpa.alter_policies('EVENT');


COMMENT ON TABLE BARS.EVENT IS '';
COMMENT ON COLUMN BARS.EVENT.EVENT IS '';
COMMENT ON COLUMN BARS.EVENT.NAME IS '';




PROMPT *** Create  constraint XPK_EVENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.EVENT ADD CONSTRAINT XPK_EVENT PRIMARY KEY (EVENT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007245 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EVENT MODIFY (EVENT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EVENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EVENT ON BARS.EVENT (EVENT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EVENT ***
grant SELECT                                                                 on EVENT           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EVENT           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EVENT           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EVENT           to EVENT;
grant DELETE,INSERT,SELECT,UPDATE                                            on EVENT           to START1;
grant SELECT                                                                 on EVENT           to UPLD;
grant FLASHBACK,SELECT                                                       on EVENT           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EVENT.sql =========*** End *** =======
PROMPT ===================================================================================== 
