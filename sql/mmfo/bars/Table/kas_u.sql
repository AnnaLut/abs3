

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_U.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_U ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_U'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KAS_U'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KAS_U'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_U ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_U 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	IDS NUMBER(*,0), 
	VIDS NUMBER(*,0), 
	NOMS VARCHAR2(20), 
	D_CLOS DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_U ***
 exec bpa.alter_policies('KAS_U');


COMMENT ON TABLE BARS.KAS_U IS 'СУМКИ';
COMMENT ON COLUMN BARS.KAS_U.KF IS 'Код МФО';
COMMENT ON COLUMN BARS.KAS_U.IDS IS 'Код~Сумки';
COMMENT ON COLUMN BARS.KAS_U.VIDS IS 'Вид сумки (0-грн, 1-вал)';
COMMENT ON COLUMN BARS.KAS_U.NOMS IS 'Номер~сумки';
COMMENT ON COLUMN BARS.KAS_U.D_CLOS IS 'Дата~закриття~сумки';




PROMPT *** Create  constraint PK_KASU ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_U ADD CONSTRAINT PK_KASU PRIMARY KEY (IDS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASU_VIDS_01 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_U ADD CONSTRAINT CC_KASU_VIDS_01 CHECK (nvl(vids,5) in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASU_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_U MODIFY (KF CONSTRAINT CC_KASU_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KASU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KASU ON BARS.KAS_U (IDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_KASU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_KASU ON BARS.KAS_U (KF, NOMS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_U ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_U           to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_U           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_U           to PYOD001;
grant FLASHBACK,SELECT                                                       on KAS_U           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_U.sql =========*** End *** =======
PROMPT ===================================================================================== 
