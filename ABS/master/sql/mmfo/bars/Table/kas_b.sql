

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_B.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_B'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KAS_B'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KAS_B'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_B 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30), 
	IDM NUMBER(*,0), 
	NSM NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_B ***
 exec bpa.alter_policies('KAS_B');


COMMENT ON TABLE BARS.KAS_B IS 'ÁÐÀÍ×I òà ¿õ Ìàðøðóòè';
COMMENT ON COLUMN BARS.KAS_B.KF IS 'Êîä ÌÔÎ';
COMMENT ON COLUMN BARS.KAS_B.BRANCH IS 'Êîä~ÁÐÀÍ×Ó';
COMMENT ON COLUMN BARS.KAS_B.IDM IS 'Êîä~Ìàðøðóòó';
COMMENT ON COLUMN BARS.KAS_B.NSM IS '¹ çìiíè';




PROMPT *** Create  constraint CC_KASB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_B MODIFY (KF CONSTRAINT CC_KASB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KASB ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_B ADD CONSTRAINT PK_KASB PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KASB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KASB ON BARS.KAS_B (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_B ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_B           to ABS_ADMIN;
grant SELECT                                                                 on KAS_B           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_B           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_B           to PYOD001;
grant SELECT                                                                 on KAS_B           to UPLD;
grant FLASHBACK,SELECT                                                       on KAS_B           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_B.sql =========*** End *** =======
PROMPT ===================================================================================== 
