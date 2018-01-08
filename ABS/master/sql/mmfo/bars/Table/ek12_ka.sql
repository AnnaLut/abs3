

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK12_KA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK12_KA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK12_KA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK12_KA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK12_KA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK12_KA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK12_KA 
   (	NBS VARCHAR2(4), 
	PROC NUMBER, 
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




PROMPT *** ALTER_POLICIES to EK12_KA ***
 exec bpa.alter_policies('EK12_KA');


COMMENT ON TABLE BARS.EK12_KA IS '';
COMMENT ON COLUMN BARS.EK12_KA.NBS IS '';
COMMENT ON COLUMN BARS.EK12_KA.PROC IS '';
COMMENT ON COLUMN BARS.EK12_KA.NAME IS '';
COMMENT ON COLUMN BARS.EK12_KA.PAP IS '';




PROMPT *** Create  constraint XPK_EK12_KA ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK12_KA ADD CONSTRAINT XPK_EK12_KA PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007088 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK12_KA MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK12_KA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK12_KA ON BARS.EK12_KA (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK12_KA ***
grant SELECT                                                                 on EK12_KA         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK12_KA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK12_KA         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK12_KA         to EK12_KA;
grant SELECT                                                                 on EK12_KA         to UPLD;
grant FLASHBACK,SELECT                                                       on EK12_KA         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK12_KA.sql =========*** End *** =====
PROMPT ===================================================================================== 
