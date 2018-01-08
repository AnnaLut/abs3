

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKR_R.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKR_R ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKR_R'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PEREKR_R'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PEREKR_R'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKR_R ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKR_R 
   (	IDR NUMBER(38,0), 
	NAME VARCHAR2(35), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKR_R ***
 exec bpa.alter_policies('PEREKR_R');


COMMENT ON TABLE BARS.PEREKR_R IS 'Перекрытия. Состав схем перекрытия.';
COMMENT ON COLUMN BARS.PEREKR_R.IDR IS 'Схема перекрытия';
COMMENT ON COLUMN BARS.PEREKR_R.NAME IS 'Наименование схемы';
COMMENT ON COLUMN BARS.PEREKR_R.KF IS '';




PROMPT *** Create  constraint FK_PEREKRR_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_R ADD CONSTRAINT FK_PEREKRR_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009832 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_R MODIFY (IDR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_R MODIFY (NAME CONSTRAINT CC_PEREKRR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_R MODIFY (KF CONSTRAINT CC_PEREKRR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PEREKRR ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_R ADD CONSTRAINT PK_PEREKRR PRIMARY KEY (KF, IDR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PEREKRR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PEREKRR ON BARS.PEREKR_R (KF, IDR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKR_R ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_R        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_R        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREKR_R        to BARS_DM;
grant SELECT                                                                 on PEREKR_R        to RPBN001;
grant SELECT                                                                 on PEREKR_R        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_R        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKR_R.sql =========*** End *** ====
PROMPT ===================================================================================== 
