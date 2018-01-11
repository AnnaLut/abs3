

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CH_BIC.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CH_BIC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CH_BIC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CH_BIC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CH_BIC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CH_BIC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CH_BIC 
   (	BIC_E VARCHAR2(11), 
	NAME VARCHAR2(38)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CH_BIC ***
 exec bpa.alter_policies('CH_BIC');


COMMENT ON TABLE BARS.CH_BIC IS '';
COMMENT ON COLUMN BARS.CH_BIC.BIC_E IS '';
COMMENT ON COLUMN BARS.CH_BIC.NAME IS '';




PROMPT *** Create  constraint PK_CH_BIC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CH_BIC ADD CONSTRAINT PK_CH_BIC PRIMARY KEY (BIC_E)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CH_BIC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CH_BIC ON BARS.CH_BIC (BIC_E) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CH_BIC ***
grant SELECT                                                                 on CH_BIC          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CH_BIC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CH_BIC          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CH_BIC          to RCH_1;
grant SELECT                                                                 on CH_BIC          to UPLD;
grant FLASHBACK,SELECT                                                       on CH_BIC          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CH_BIC.sql =========*** End *** ======
PROMPT ===================================================================================== 
