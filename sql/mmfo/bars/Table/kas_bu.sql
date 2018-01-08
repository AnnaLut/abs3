

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_BU.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_BU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_BU'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KAS_BU'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KAS_BU'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_BU ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_BU 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30), 
	IDS NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_BU ***
 exec bpa.alter_policies('KAS_BU');


COMMENT ON TABLE BARS.KAS_BU IS '¡–¿Õ◊I Ú‡ øı —”Ã »';
COMMENT ON COLUMN BARS.KAS_BU.KF IS ' Ó‰ Ã‘Œ';
COMMENT ON COLUMN BARS.KAS_BU.BRANCH IS ' Ó‰~¡–¿Õ◊”';
COMMENT ON COLUMN BARS.KAS_BU.IDS IS ' Ó‰~—”Ã »';




PROMPT *** Create  constraint PK_KASBU ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_BU ADD CONSTRAINT PK_KASBU PRIMARY KEY (IDS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASBU_IDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_BU ADD CONSTRAINT FK_KASBU_IDS FOREIGN KEY (IDS)
	  REFERENCES BARS.KAS_U (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASBU_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_BU ADD CONSTRAINT FK_KASBU_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASBU_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_BU MODIFY (KF CONSTRAINT CC_KASBU_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KASBU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KASBU ON BARS.KAS_BU (IDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_BU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_BU          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_BU          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_BU          to PYOD001;
grant FLASHBACK,SELECT                                                       on KAS_BU          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_BU.sql =========*** End *** ======
PROMPT ===================================================================================== 
