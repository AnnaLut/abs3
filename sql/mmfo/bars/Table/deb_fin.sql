

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEB_FIN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEB_FIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEB_FIN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEB_FIN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DEB_FIN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEB_FIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEB_FIN 
   (	NBS VARCHAR2(4), 
	KV NUMBER(3,0), 
	KAT NUMBER(*,0), 
	BV NUMBER, 
	BVQ NUMBER, 
	REZ NUMBER, 
	REZQ NUMBER, 
	REZF NUMBER, 
	REZQF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEB_FIN ***
 exec bpa.alter_policies('DEB_FIN');


COMMENT ON TABLE BARS.DEB_FIN IS 'Финансова дебиторка - итог';
COMMENT ON COLUMN BARS.DEB_FIN.KF IS '';
COMMENT ON COLUMN BARS.DEB_FIN.NBS IS 'Бал.рах.';
COMMENT ON COLUMN BARS.DEB_FIN.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.DEB_FIN.KAT IS 'Кат. якості';
COMMENT ON COLUMN BARS.DEB_FIN.BV IS 'Балансова вартість ном.';
COMMENT ON COLUMN BARS.DEB_FIN.BVQ IS 'Балансова вартість екв.';
COMMENT ON COLUMN BARS.DEB_FIN.REZ IS 'Резерв в ном.';
COMMENT ON COLUMN BARS.DEB_FIN.REZQ IS 'Резерв в екв.';
COMMENT ON COLUMN BARS.DEB_FIN.REZF IS '';
COMMENT ON COLUMN BARS.DEB_FIN.REZQF IS '';




PROMPT *** Create  constraint PK_DEB_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_FIN ADD CONSTRAINT PK_DEB_FIN PRIMARY KEY (NBS, KV, KAT, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEBFIN_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_FIN ADD CONSTRAINT FK_DEBFIN_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEBFIN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEB_FIN MODIFY (KF CONSTRAINT CC_DEBFIN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEB_FIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEB_FIN ON BARS.DEB_FIN (NBS, KV, KAT, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEB_FIN ***
grant SELECT                                                                 on DEB_FIN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEB_FIN         to BARS_DM;
grant SELECT                                                                 on DEB_FIN         to RCC_DEAL;
grant SELECT                                                                 on DEB_FIN         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEB_FIN.sql =========*** End *** =====
PROMPT ===================================================================================== 
