

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F42_PR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F42_PR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F42_PR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F42_PR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OTCN_F42_PR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F42_PR ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F42_PR 
   (	ACC NUMBER, 
	F42P54 NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F42_PR ***
 exec bpa.alter_policies('OTCN_F42_PR');


COMMENT ON TABLE BARS.OTCN_F42_PR IS 'Спецпараметры счетов, которые определят формирование 03 и 54 показателей 42 файла';
COMMENT ON COLUMN BARS.OTCN_F42_PR.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_F42_PR.F42P54 IS '';
COMMENT ON COLUMN BARS.OTCN_F42_PR.KF IS '';




PROMPT *** Create  constraint PK_OTCN_F42_PR ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_PR ADD CONSTRAINT PK_OTCN_F42_PR PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006748 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_PR MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCNF42PR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_F42_PR MODIFY (KF CONSTRAINT CC_OTCNF42PR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_F42_PR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_F42_PR ON BARS.OTCN_F42_PR (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_F42_PR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_PR     to ABS_ADMIN;
grant SELECT                                                                 on OTCN_F42_PR     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_PR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_F42_PR     to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on OTCN_F42_PR     to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_F42_PR     to RPBN002;
grant SELECT                                                                 on OTCN_F42_PR     to START1;
grant SELECT                                                                 on OTCN_F42_PR     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_F42_PR     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F42_PR.sql =========*** End *** =
PROMPT ===================================================================================== 
