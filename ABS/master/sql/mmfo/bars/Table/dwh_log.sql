

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_LOG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_LOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_LOG ***
begin 
  execute immediate '
		create table BARS.DWH_LOG
		(
			package_id     NUMBER(38),
			package_data   CLOB,
			recieved_date  DATE default sysdate,
			package_status VARCHAR2(10),
			package_error  VARCHAR2(2000),
			package_type   NUMBER(2),
			bank_date      VARCHAR2(20),
			kf             VARCHAR2(6)
		)
		tablespace BRSDYND';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

alter table bars.dwh_log modify package_id number(38);


PROMPT *** ALTER_POLICIES to DWH_LOG ***
 exec bpa.alter_policies('DWH_LOG');


-- Add comments to the table 
COMMENT ON TABLE BARS.DWH_LOG IS 'протокол отримання інформації і обробки від DWH';
-- Add comments to the columns 
COMMENT ON COLUMN BARS.DWH_LOG.PACKAGE_ID IS 'номер пакету';
COMMENT ON COLUMN BARS.DWH_LOG.PACKAGE_DATA IS 'дані пакету';
COMMENT ON COLUMN BARS.DWH_LOG.RECIEVED_DATE IS 'дата надходження пакету';
COMMENT ON COLUMN BARS.DWH_LOG.PACKAGE_STATUS IS 'статус обробки';
COMMENT ON COLUMN BARS.DWH_LOG.PACKAGE_ERROR IS 'помилка при обробці';
COMMENT ON COLUMN BARS.DWH_LOG.PACKAGE_TYPE IS 'тип повідомлення 1 - сегменти, 2 - навантаження';
COMMENT ON COLUMN BARS.DWH_LOG.BANK_DATE IS 'банківська дата повідомлення в форматі(DD/MM/YYYY)';
COMMENT ON COLUMN BARS.DWH_LOG.KF IS 'Код фiлiалу (МФО)';




PROMPT *** Create  constraint PK_DWH_LOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_LOG ADD CONSTRAINT PK_DWH_LOG PRIMARY KEY (PACKAGE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWH_PACKAGE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_LOG MODIFY (PACKAGE_ID CONSTRAINT CC_DWH_PACKAGE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWH_PACKAGE_DATA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_LOG MODIFY (PACKAGE_DATA CONSTRAINT CC_DWH_PACKAGE_DATA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DWH_LOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DWH_LOG ON BARS.DWH_LOG (PACKAGE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_LOG ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DWH_LOG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DWH_LOG         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_LOG.sql =========*** End *** =====
PROMPT ===================================================================================== 
