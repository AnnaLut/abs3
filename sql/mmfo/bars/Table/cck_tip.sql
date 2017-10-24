

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_TIP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_TIP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_TIP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_TIP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_TIP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_TIP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_TIP 
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




PROMPT *** ALTER_POLICIES to CCK_TIP ***
 exec bpa.alter_policies('CCK_TIP');


COMMENT ON TABLE BARS.CCK_TIP IS '';
COMMENT ON COLUMN BARS.CCK_TIP.ID IS '';
COMMENT ON COLUMN BARS.CCK_TIP.NAME IS '';




PROMPT *** Create  constraint XPK_CCK_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_TIP ADD CONSTRAINT XPK_CCK_TIP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CCK_TIP_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_TIP MODIFY (ID CONSTRAINT NK_CCK_TIP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CCK_TIP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CCK_TIP ON BARS.CCK_TIP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_TIP ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CCK_TIP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_TIP         to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CCK_TIP         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_TIP         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CCK_TIP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_TIP.sql =========*** End *** =====
PROMPT ===================================================================================== 
