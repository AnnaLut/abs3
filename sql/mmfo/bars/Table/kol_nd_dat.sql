PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOL_ND_DAT.sql =========*** Run *** ======
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to KOL_ND_DAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOL_ND_DAT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KOL_ND_DAT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOL_ND_DAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOL_ND_DAT 
   (	DAT   DATE,
        TIPA  NUMBER,
  	ND    INTEGER, 
	KOL   NUMBER, 
	KF    VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to KOL_ND_DAT ***
 exec bpa.alter_policies('KOL_ND_DAT');

COMMENT ON TABLE  BARS.KOL_ND_DAT       IS 'таблица к-во дней просрочки на дату';
COMMENT ON COLUMN BARS.KOL_ND_DAT.DAT   IS 'Дата';
COMMENT ON COLUMN BARS.KOL_ND_DAT.ND    IS 'Реф.договора'; 
COMMENT ON COLUMN BARS.KOL_ND_DAT.TIPA  IS 'Тип актива';
COMMENT ON COLUMN BARS.KOL_ND_DAT.KOL   IS 'К-во дней';
COMMENT ON COLUMN BARS.KOL_ND_DAT.KF    IS 'Код филиала';

PROMPT *** Create  constraint KOL_ND_DAT ***
begin   
 execute immediate 'alter table KOL_ND_DAT drop constraint PK_KOL_ND_DAT cascade';
exception when others then
  if  sqlcode=-2443  then null; else raise; end if;
 end;
/

begin   
 execute immediate 'drop index PK_KOL_ND_DAT ';
exception when others then
  if  sqlcode=-1418  then null; else raise; end if;
 end;
/


begin   
 execute immediate '
  ALTER TABLE BARS.KOL_ND_DAT ADD CONSTRAINT PK_KOL_ND_DAT PRIMARY KEY (DAT,ND,TIPA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint CC_KOLNDDAT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOL_ND_DAT MODIFY (KF CONSTRAINT CC_KOLNDDAT_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint FK_KOLNDDAT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KOL_ND_DAT ADD CONSTRAINT FK_KOLNDDAT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
PROMPT *** Create  index PK_KOL_ND_DAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KOL_ND_DAT ON BARS.KOL_ND_DAT (DAT,ND,TIPA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/
PROMPT *** Create  grants  KOL_ND_DAT ***
grant SELECT   on KOL_ND_DAT   to BARS_ACCESS_DEFROLE;
grant SELECT   on KOL_ND_DAT   to RCC_DEAL;
grant SELECT   on KOL_ND_DAT   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Table/KOL_ND_DAT.sql =======*** End *** ======
PROMPT ===================================================================================== 
