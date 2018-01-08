

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANKS_RU.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANKS_RU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANKS_RU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANKS_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BANKS_RU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANKS_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANKS_RU 
   (	RU NUMBER(*,0), 
	MFO VARCHAR2(12), 
	NAME VARCHAR2(38), 
	RNK NUMBER, 
	OKPO VARCHAR2(8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANKS_RU ***
 exec bpa.alter_policies('BANKS_RU');


COMMENT ON TABLE BARS.BANKS_RU IS '';
COMMENT ON COLUMN BARS.BANKS_RU.RU IS '';
COMMENT ON COLUMN BARS.BANKS_RU.MFO IS '';
COMMENT ON COLUMN BARS.BANKS_RU.NAME IS '';
COMMENT ON COLUMN BARS.BANKS_RU.RNK IS '';
COMMENT ON COLUMN BARS.BANKS_RU.OKPO IS '';




PROMPT *** Create  constraint XPK_BANKS_RU ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS_RU ADD CONSTRAINT XPK_BANKS_RU PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BANKS_RU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BANKS_RU ON BARS.BANKS_RU (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANKS_RU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS_RU        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANKS_RU        to BARS_DM;
grant SELECT                                                                 on BANKS_RU        to FINMON;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS_RU        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANKS_RU.sql =========*** End *** ====
PROMPT ===================================================================================== 
