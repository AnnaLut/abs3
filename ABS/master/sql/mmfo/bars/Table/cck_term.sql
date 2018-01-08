

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_TERM.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_TERM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_TERM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_TERM'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_TERM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_TERM ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_TERM 
   (	ID NUMBER, 
	NAME VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_TERM ***
 exec bpa.alter_policies('CCK_TERM');


COMMENT ON TABLE BARS.CCK_TERM IS '';
COMMENT ON COLUMN BARS.CCK_TERM.ID IS '';
COMMENT ON COLUMN BARS.CCK_TERM.NAME IS '';




PROMPT *** Create  constraint XPK_CCK_TERM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_TERM ADD CONSTRAINT XPK_CCK_TERM PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CCK_TERM_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_TERM MODIFY (ID CONSTRAINT NK_CCK_TERM_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CCK_TERM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CCK_TERM ON BARS.CCK_TERM (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_TERM ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CCK_TERM        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_TERM        to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CCK_TERM        to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_TERM        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CCK_TERM        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_TERM.sql =========*** End *** ====
PROMPT ===================================================================================== 
