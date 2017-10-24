

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK13_PR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK13_PR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK13_PR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK13_PR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK13_PR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK13_PR ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK13_PR 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK13_PR ***
 exec bpa.alter_policies('EK13_PR');


COMMENT ON TABLE BARS.EK13_PR IS '';
COMMENT ON COLUMN BARS.EK13_PR.NBS IS '';
COMMENT ON COLUMN BARS.EK13_PR.NAME IS '';
COMMENT ON COLUMN BARS.EK13_PR.PAP IS '';




PROMPT *** Create  constraint XPK_EK13_PR ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK13_PR ADD CONSTRAINT XPK_EK13_PR PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010030 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK13_PR MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK13_PR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK13_PR ON BARS.EK13_PR (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK13_PR ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK13_PR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK13_PR         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK13_PR         to EK13_PR;
grant FLASHBACK,SELECT                                                       on EK13_PR         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK13_PR.sql =========*** End *** =====
PROMPT ===================================================================================== 
