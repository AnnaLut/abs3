

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_FO_TIPS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_FO_TIPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_FO_TIPS'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''FM_FO_TIPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FM_FO_TIPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_FO_TIPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FM_FO_TIPS 
   (	ID NUMBER, 
	NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_FO_TIPS ***
 exec bpa.alter_policies('FM_FO_TIPS');


COMMENT ON TABLE BARS.FM_FO_TIPS IS '';
COMMENT ON COLUMN BARS.FM_FO_TIPS.ID IS '';
COMMENT ON COLUMN BARS.FM_FO_TIPS.NAME IS '';




PROMPT *** Create  constraint XPK_FM_FO_TIPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FM_FO_TIPS ADD CONSTRAINT XPK_FM_FO_TIPS_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FM_FO_TIPS_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FM_FO_TIPS_ID ON BARS.FM_FO_TIPS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FM_FO_TIPS ***
grant SELECT                                                                 on FM_FO_TIPS      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FM_FO_TIPS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_FO_TIPS      to BARS_DM;
grant SELECT                                                                 on FM_FO_TIPS      to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on FM_FO_TIPS      to FINMON01;
grant SELECT                                                                 on FM_FO_TIPS      to UPLD;
grant FLASHBACK,SELECT                                                       on FM_FO_TIPS      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_FO_TIPS.sql =========*** End *** ==
PROMPT ===================================================================================== 
