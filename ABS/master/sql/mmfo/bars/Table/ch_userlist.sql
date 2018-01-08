

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CH_USERLIST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CH_USERLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CH_USERLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CH_USERLIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CH_USERLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CH_USERLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.CH_USERLIST 
   (	ID NUMBER, 
	FIO VARCHAR2(60), 
	DOC_PERS VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CH_USERLIST ***
 exec bpa.alter_policies('CH_USERLIST');


COMMENT ON TABLE BARS.CH_USERLIST IS '';
COMMENT ON COLUMN BARS.CH_USERLIST.ID IS '';
COMMENT ON COLUMN BARS.CH_USERLIST.FIO IS '';
COMMENT ON COLUMN BARS.CH_USERLIST.DOC_PERS IS '';




PROMPT *** Create  constraint CH_USERLIST_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_USERLIST ADD CONSTRAINT CH_USERLIST_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CH_USERLIST_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CH_USERLIST_PK ON BARS.CH_USERLIST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CH_USERLIST ***
grant SELECT                                                                 on CH_USERLIST     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CH_USERLIST     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CH_USERLIST     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CH_USERLIST     to START1;
grant SELECT                                                                 on CH_USERLIST     to UPLD;
grant FLASHBACK,SELECT                                                       on CH_USERLIST     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CH_USERLIST.sql =========*** End *** =
PROMPT ===================================================================================== 
