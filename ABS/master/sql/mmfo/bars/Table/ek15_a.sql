

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK15_A.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK15_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK15_A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK15_A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK15_A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK15_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK15_A 
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




PROMPT *** ALTER_POLICIES to EK15_A ***
 exec bpa.alter_policies('EK15_A');


COMMENT ON TABLE BARS.EK15_A IS '';
COMMENT ON COLUMN BARS.EK15_A.NBS IS '';
COMMENT ON COLUMN BARS.EK15_A.PROC IS '';
COMMENT ON COLUMN BARS.EK15_A.NAME IS '';
COMMENT ON COLUMN BARS.EK15_A.PAP IS '';




PROMPT *** Create  constraint XPK_EK15_A ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK15_A ADD CONSTRAINT XPK_EK15_A PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008505 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK15_A MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK15_A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK15_A ON BARS.EK15_A (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK15_A ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK15_A          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK15_A          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK15_A          to EK15_A;
grant FLASHBACK,SELECT                                                       on EK15_A          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK15_A.sql =========*** End *** ======
PROMPT ===================================================================================== 
