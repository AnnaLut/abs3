

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCOUNTSW_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCOUNTSW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCOUNTSW_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCOUNTSW_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCOUNTSW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCOUNTSW_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ACC NUMBER(38,0), 
	TAG VARCHAR2(8), 
	VALUE VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCOUNTSW_UPDATE ***
 exec bpa.alter_policies('ACCOUNTSW_UPDATE');


COMMENT ON TABLE BARS.ACCOUNTSW_UPDATE IS '';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.IDUPD IS 'ѕервичный ключ дл€ таблицы обновлени€';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.CHGACTION IS ' од обновлени€ (I/U/D)';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.EFFECTDATE IS 'Ѕанковска€ дата начала действи€ параметров';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.CHGDATE IS '—истемана€ дата обновлени€';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.DONEBY IS ' од пользовател€. кто внес обновлени€(если в течении дн€ было несколько обновлений - остаетс€ только последнее)';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.TAG IS '';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.VALUE IS '';
COMMENT ON COLUMN BARS.ACCOUNTSW_UPDATE.KF IS '';




PROMPT *** Create  constraint PK_ACCOUNTSW_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW_UPDATE ADD CONSTRAINT PK_ACCOUNTSW_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002125078 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCOUNTSW_UPDATE MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCOUNTSW_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCOUNTSW_UPDATE ON BARS.ACCOUNTSW_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_ACCOUNTSWUPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_ACCOUNTSWUPDATEEFFDAT ON BARS.ACCOUNTSW_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_ACCOUNTSW_UPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_ACCOUNTSW_UPDATE ON BARS.ACCOUNTSW_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCOUNTSW_UPDATE ***
grant SELECT                                                                 on ACCOUNTSW_UPDATE to BARSUPL;
grant SELECT                                                                 on ACCOUNTSW_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCOUNTSW_UPDATE to BARS_SUP;
grant SELECT                                                                 on ACCOUNTSW_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCOUNTSW_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
