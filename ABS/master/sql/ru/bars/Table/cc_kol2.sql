

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_KOL2.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_KOL2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_KOL2'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_KOL2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_KOL2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_KOL2 
   (	CUSTTYPE NUMBER, 
	TBLANK VARCHAR2(10), 
	NLS VARCHAR2(15), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_KOL2 ***
 exec bpa.alter_policies('CC_KOL2');


COMMENT ON TABLE BARS.CC_KOL2 IS '';
COMMENT ON COLUMN BARS.CC_KOL2.CUSTTYPE IS '��� ��, �� ';
COMMENT ON COLUMN BARS.CC_KOL2.TBLANK IS '';
COMMENT ON COLUMN BARS.CC_KOL2.NLS IS '';
COMMENT ON COLUMN BARS.CC_KOL2.BRANCH IS '';




PROMPT *** Create  constraint FK_CC_KOL2_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL2 ADD CONSTRAINT FK_CC_KOL2_TIP FOREIGN KEY (TBLANK)
	  REFERENCES BARS.CC_KOL_TBLANK (TBLANK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00124045 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL2 MODIFY (TBLANK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00124044 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_KOL2 MODIFY (CUSTTYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_KOL2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_KOL2 ON BARS.CC_KOL2 (TBLANK, NLS, CUSTTYPE, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_KOL2 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_KOL2         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_KOL2         to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_KOL2.sql =========*** End *** =====
PROMPT ===================================================================================== 
