

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKR_S.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKR_S ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKR_S'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PEREKR_S'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PEREKR_S'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKR_S ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKR_S 
   (	IDS NUMBER(38,0), 
	NAME VARCHAR2(100), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKR_S ***
 exec bpa.alter_policies('PEREKR_S');


COMMENT ON TABLE BARS.PEREKR_S IS 'Перекрытия. Список схем перекрытия.';
COMMENT ON COLUMN BARS.PEREKR_S.IDS IS 'Код схемы';
COMMENT ON COLUMN BARS.PEREKR_S.NAME IS 'Наименование схемы';
COMMENT ON COLUMN BARS.PEREKR_S.KF IS '';




PROMPT *** Create  constraint PK_PEREKRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_S ADD CONSTRAINT PK_PEREKRS PRIMARY KEY (KF, IDS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_S ADD CONSTRAINT FK_PEREKRS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_S MODIFY (NAME CONSTRAINT CC_PEREKRS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_S MODIFY (KF CONSTRAINT CC_PEREKRS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008527 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_S MODIFY (IDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PEREKRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PEREKRS ON BARS.PEREKR_S (KF, IDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKR_S ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_S        to ABS_ADMIN;
grant SELECT                                                                 on PEREKR_S        to BARS015;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_S        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREKR_S        to BARS_DM;
grant SELECT                                                                 on PEREKR_S        to DPT;
grant SELECT                                                                 on PEREKR_S        to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_S        to PEREKR_S;
grant SELECT                                                                 on PEREKR_S        to REF0000;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_S        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_S        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PEREKR_S        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKR_S.sql =========*** End *** ====
PROMPT ===================================================================================== 
