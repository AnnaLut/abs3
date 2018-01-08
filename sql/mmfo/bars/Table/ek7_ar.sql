

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK7_AR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK7_AR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK7_AR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK7_AR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK7_AR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK7_AR ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK7_AR 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(38,0), 
	PROC NUMBER(7,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK7_AR ***
 exec bpa.alter_policies('EK7_AR');


COMMENT ON TABLE BARS.EK7_AR IS '';
COMMENT ON COLUMN BARS.EK7_AR.NBS IS '';
COMMENT ON COLUMN BARS.EK7_AR.NAME IS '';
COMMENT ON COLUMN BARS.EK7_AR.PAP IS '';
COMMENT ON COLUMN BARS.EK7_AR.PROC IS '';




PROMPT *** Create  constraint XPK_EK7_AR ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK7_AR ADD CONSTRAINT XPK_EK7_AR PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006451 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK7_AR MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK7_AR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK7_AR ON BARS.EK7_AR (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK7_AR ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK7_AR          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK7_AR          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK7_AR          to EK7_AR;
grant FLASHBACK,SELECT                                                       on EK7_AR          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK7_AR.sql =========*** End *** ======
PROMPT ===================================================================================== 
