

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CH_1A.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CH_1A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CH_1A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CH_1A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CH_1A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CH_1A ***
begin 
  execute immediate '
  CREATE TABLE BARS.CH_1A 
   (	MFOA VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CH_1A ***
 exec bpa.alter_policies('CH_1A');


COMMENT ON TABLE BARS.CH_1A IS '';
COMMENT ON COLUMN BARS.CH_1A.MFOA IS '';




PROMPT *** Create  constraint XPK_CH_1A ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_1A ADD CONSTRAINT XPK_CH_1A PRIMARY KEY (MFOA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CH_1A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CH_1A ON BARS.CH_1A (MFOA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CH_1A ***
grant SELECT                                                                 on CH_1A           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CH_1A           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CH_1A           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CH_1A           to RCH_1;
grant SELECT                                                                 on CH_1A           to UPLD;
grant FLASHBACK,SELECT                                                       on CH_1A           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CH_1A.sql =========*** End *** =======
PROMPT ===================================================================================== 
