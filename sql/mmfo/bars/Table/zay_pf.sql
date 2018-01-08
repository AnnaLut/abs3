

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_PF.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_PF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_PF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_PF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAY_PF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_PF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_PF 
   (	KOD NUMBER, 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(38), 
	OKPO VARCHAR2(14), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_PF ***
 exec bpa.alter_policies('ZAY_PF');


COMMENT ON TABLE BARS.ZAY_PF IS 'Справочник районных управлений Пенс.Фонда';
COMMENT ON COLUMN BARS.ZAY_PF.KOD IS 'Код района';
COMMENT ON COLUMN BARS.ZAY_PF.MFO IS 'МФО ПФ';
COMMENT ON COLUMN BARS.ZAY_PF.NLS IS 'Счет ПФ';
COMMENT ON COLUMN BARS.ZAY_PF.NMS IS 'Наименование ПФ';
COMMENT ON COLUMN BARS.ZAY_PF.OKPO IS 'Код ОКПО ПФ';
COMMENT ON COLUMN BARS.ZAY_PF.KF IS '';




PROMPT *** Create  constraint XPK_ZAY_PF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PF ADD CONSTRAINT XPK_ZAY_PF PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ZAYPF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PF ADD CONSTRAINT FK_ZAYPF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ZAY_PF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PF MODIFY (KOD CONSTRAINT NK_ZAY_PF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYPF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_PF MODIFY (KF CONSTRAINT CC_ZAYPF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAY_PF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAY_PF ON BARS.ZAY_PF (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_PF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_PF          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_PF          to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_PF          to WR_ALL_RIGHTS;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_PF          to ZAY;



PROMPT *** Create SYNONYM  to ZAY_PF ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_PF FOR BARS.ZAY_PF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_PF.sql =========*** End *** ======
PROMPT ===================================================================================== 
