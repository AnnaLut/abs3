

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_PROTOCOL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_PROTOCOL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_PROTOCOL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_PROTOCOL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_PROTOCOL'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_PROTOCOL ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_PROTOCOL 
   (	USERID NUMBER, 
	DAT DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	DAT_BANK DATE, 
	DAT_SYS DATE, 
	DAT_OTCN DATE, 
	CRC VARCHAR2(64), 
	REF NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_PROTOCOL ***
 exec bpa.alter_policies('REZ_PROTOCOL');


COMMENT ON TABLE BARS.REZ_PROTOCOL IS 'протокол формирования проводок по резервам';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.KF IS '';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.USERID IS 'код пользователя';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.DAT IS 'отчетная дата';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.BRANCH IS '';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.DAT_BANK IS '';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.DAT_SYS IS '';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.DAT_OTCN IS '';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.CRC IS '';
COMMENT ON COLUMN BARS.REZ_PROTOCOL.REF IS 'Реф. выполнения проводок';




PROMPT *** Create  constraint PK_REZ_PROTOCOL ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL ADD CONSTRAINT PK_REZ_PROTOCOL PRIMARY KEY (DAT, DAT_SYS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZPROTOCOL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL MODIFY (KF CONSTRAINT CC_REZPROTOCOL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZ5_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_PROTOCOL MODIFY (BRANCH CONSTRAINT CC_REZ5_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_PROTOCOL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_PROTOCOL ON BARS.REZ_PROTOCOL (DAT, DAT_SYS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_PROTOCOL ***
grant SELECT                                                                 on REZ_PROTOCOL    to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_PROTOCOL    to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_PROTOCOL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_PROTOCOL    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_PROTOCOL    to RCC_DEAL;
grant SELECT                                                                 on REZ_PROTOCOL    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REZ_PROTOCOL    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on REZ_PROTOCOL    to WR_REFREAD;



PROMPT *** Create SYNONYM  to REZ_PROTOCOL ***

  CREATE OR REPLACE PUBLIC SYNONYM REZ_PROTOCOL FOR BARS.REZ_PROTOCOL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_PROTOCOL.sql =========*** End *** 
PROMPT ===================================================================================== 
