

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_LOG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_LOG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REZ_LOG'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_LOG 
   (	KOD NUMBER(*,0), 
	ROW_ID NUMBER, 
	USER_ID NUMBER, 
	CHGDATE DATE, 
	TXT VARCHAR2(100), 
	FDAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_LOG ***
 exec bpa.alter_policies('REZ_LOG');


COMMENT ON TABLE BARS.REZ_LOG IS 'Журнал расчета резерва';
COMMENT ON COLUMN BARS.REZ_LOG.KF IS '';
COMMENT ON COLUMN BARS.REZ_LOG.KOD IS 'Код функции';
COMMENT ON COLUMN BARS.REZ_LOG.ROW_ID IS 'Порядковый номер';
COMMENT ON COLUMN BARS.REZ_LOG.USER_ID IS 'Пользователь';
COMMENT ON COLUMN BARS.REZ_LOG.CHGDATE IS 'Время выполнения';
COMMENT ON COLUMN BARS.REZ_LOG.TXT IS 'Комментарий о выполнении';
COMMENT ON COLUMN BARS.REZ_LOG.FDAT IS '';




PROMPT *** Create  constraint PK_REZLOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_LOG ADD CONSTRAINT PK_REZLOG PRIMARY KEY (ROW_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REZLOG_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_LOG MODIFY (KF CONSTRAINT CC_REZLOG_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZLOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZLOG ON BARS.REZ_LOG (ROW_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_LOG ***
grant SELECT                                                                 on REZ_LOG         to BARSREADER_ROLE;
grant SELECT                                                                 on REZ_LOG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_LOG         to BARS_DM;
grant SELECT                                                                 on REZ_LOG         to RCC_DEAL;
grant SELECT                                                                 on REZ_LOG         to START1;
grant SELECT                                                                 on REZ_LOG         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_LOG.sql =========*** End *** =====
PROMPT ===================================================================================== 
