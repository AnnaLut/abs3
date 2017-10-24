

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK9_ZA.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK9_ZA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK9_ZA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK9_ZA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK9_ZA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK9_ZA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK9_ZA 
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




PROMPT *** ALTER_POLICIES to EK9_ZA ***
 exec bpa.alter_policies('EK9_ZA');


COMMENT ON TABLE BARS.EK9_ZA IS '';
COMMENT ON COLUMN BARS.EK9_ZA.NBS IS '';
COMMENT ON COLUMN BARS.EK9_ZA.NAME IS '';
COMMENT ON COLUMN BARS.EK9_ZA.PAP IS '';




PROMPT *** Create  constraint SYS_C009218 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK9_ZA MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_EK9_ZA ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK9_ZA ADD CONSTRAINT XPK_EK9_ZA PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK9_ZA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK9_ZA ON BARS.EK9_ZA (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK9_ZA ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK9_ZA          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK9_ZA          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK9_ZA          to EK9_ZA;
grant FLASHBACK,SELECT                                                       on EK9_ZA          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK9_ZA.sql =========*** End *** ======
PROMPT ===================================================================================== 
