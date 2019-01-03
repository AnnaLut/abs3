PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_VAL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_VAL_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_VAL_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ND_VAL_ARC'', ''WHOLE''  , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table ND_VAL_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_VAL_ARC 
   (	FDAT DATE, 
	ND NUMBER(*,0), 
	TIPA NUMBER(*,0), 
	KOL NUMBER, 
	RNK NUMBER(*,0), 
	FIN NUMBER(*,0), 
	TIP_FIN NUMBER(*,0), 
	ISTVAL NUMBER(*,0), 
	S080 VARCHAR2(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	S180 VARCHAR2(1),
        OKPO VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to ND_VAL_ARC ***
 exec bpa.alter_policies('ND_VAL_ARC');


COMMENT ON TABLE  BARS.ND_VAL_ARC IS 'Параметри по договору';
COMMENT ON COLUMN BARS.ND_VAL_ARC.S180 IS 'Параметр s180';
COMMENT ON COLUMN BARS.ND_VAL_ARC.FDAT IS 'Звітна дата';
COMMENT ON COLUMN BARS.ND_VAL_ARC.ND IS 'Реф. договору';
COMMENT ON COLUMN BARS.ND_VAL_ARC.TIPA IS 'Тип активу ';
COMMENT ON COLUMN BARS.ND_VAL_ARC.KOL IS 'К-ть днів прострочки';
COMMENT ON COLUMN BARS.ND_VAL_ARC.RNK IS 'РНК';
COMMENT ON COLUMN BARS.ND_VAL_ARC.FIN IS 'Фін. стан';
COMMENT ON COLUMN BARS.ND_VAL_ARC.TIP_FIN IS 'Тип фін стану: 0 - фін.стан 1-2,  1 - фін.стан 1-5, 0 - фін.стан 1-10';
COMMENT ON COLUMN BARS.ND_VAL_ARC.ISTVAL IS 'Источник валютной выручки';
COMMENT ON COLUMN BARS.ND_VAL_ARC.S080 IS 'Параметр s080';
COMMENT ON COLUMN BARS.ND_VAL_ARC.KF IS '';
COMMENT ON COLUMN BARS.ND_VAL_ARC.OKPO  IS 'ОКПО';

begin
 execute immediate   'alter table ND_VAL_ARC add (OKPO VARCHAR2(30)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/
COMMENT ON COLUMN ND_VAL_ARC.OKPO  IS 'ОКПО';

PROMPT *** Create  constraint PK_ND_VAL_ARC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_VAL_ARC ADD CONSTRAINT PK_ND_VAL_ARC PRIMARY KEY (FDAT, rnk, ND, TIPA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_NDVAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_VAL_ARC MODIFY (KF CONSTRAINT CC_NDVALARC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_ND_VAL_ARC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ND_VAL_ARC ON BARS.ND_VAL_ARC (FDAT, okpo, ND, TIPA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  ND_VAL_ARC ***
grant SELECT                                                                 on ND_VAL_ARC          to BARSREADER_ROLE;
grant SELECT                                                                 on ND_VAL_ARC          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_VAL_ARC          to RCC_DEAL;
grant SELECT                                                                 on ND_VAL_ARC          to START1;
grant SELECT                                                                 on ND_VAL_ARC          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_VAL_ARC.sql =========*** End *** ======
PROMPT ===================================================================================== 
