

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_SIZE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_SIZE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_SIZE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_SIZE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_SIZE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_SIZE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_SIZE 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(25), 
	KV NUMBER(*,0), 
	S NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_SIZE ***
 exec bpa.alter_policies('CCK_SIZE');


COMMENT ON TABLE BARS.CCK_SIZE IS '';
COMMENT ON COLUMN BARS.CCK_SIZE.ID IS '';
COMMENT ON COLUMN BARS.CCK_SIZE.NAME IS '';
COMMENT ON COLUMN BARS.CCK_SIZE.KV IS '';
COMMENT ON COLUMN BARS.CCK_SIZE.S IS '';




PROMPT *** Create  constraint XPK_CCK_SIZE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SIZE ADD CONSTRAINT XPK_CCK_SIZE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CCK_SIZE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_SIZE MODIFY (ID CONSTRAINT NK_CCK_SIZE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CCK_SIZE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CCK_SIZE ON BARS.CCK_SIZE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_SIZE ***
grant SELECT                                                                 on CCK_SIZE        to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CCK_SIZE        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_SIZE        to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CCK_SIZE        to RCC_DEAL;
grant SELECT                                                                 on CCK_SIZE        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_SIZE        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CCK_SIZE        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_SIZE.sql =========*** End *** ====
PROMPT ===================================================================================== 
