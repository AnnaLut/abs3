

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_SNAP_SCN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_SNAP_SCN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_SNAP_SCN'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACCM_SNAP_SCN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACCM_SNAP_SCN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_SNAP_SCN ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_SNAP_SCN 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	FDAT DATE, 
	TABLE_NAME VARCHAR2(30), 
	SNAP_SCN NUMBER, 
	SNAP_DATE DATE, 
	 CONSTRAINT PK_ACCMSNAPSCN PRIMARY KEY (KF, FDAT, TABLE_NAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50 INCLUDING SNAP_DATE OVERFLOW
 PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_SNAP_SCN ***
 exec bpa.alter_policies('ACCM_SNAP_SCN');


COMMENT ON TABLE BARS.ACCM_SNAP_SCN IS 'SCN-� ��������� ��������� ������� ������� �� ��������� ������ SALDOA, SALDOA_DEL_ROWS';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCN.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCN.FDAT IS '���� ��������';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCN.TABLE_NAME IS '��� �������';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCN.SNAP_SCN IS 'SCN ��������� ��������� ������ ������� �� ������ ��������';
COMMENT ON COLUMN BARS.ACCM_SNAP_SCN.SNAP_DATE IS '����+����� ��������� ��������� ������ ������� �� ������ ��������';




PROMPT *** Create  constraint CC_ACCMSNAPSCN_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCN MODIFY (KF CONSTRAINT CC_ACCMSNAPSCN_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCN_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCN MODIFY (FDAT CONSTRAINT CC_ACCMSNAPSCN_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCN_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCN MODIFY (TABLE_NAME CONSTRAINT CC_ACCMSNAPSCN_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSNAPSCN_SNAPSCN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCN MODIFY (SNAP_SCN CONSTRAINT CC_ACCMSNAPSCN_SNAPSCN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCMSNAPSCN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_SNAP_SCN ADD CONSTRAINT PK_ACCMSNAPSCN PRIMARY KEY (KF, FDAT, TABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMSNAPSCN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMSNAPSCN ON BARS.ACCM_SNAP_SCN (KF, FDAT, TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_SNAP_SCN ***
grant SELECT                                                                 on ACCM_SNAP_SCN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_SNAP_SCN   to BARS_DM;
grant SELECT                                                                 on ACCM_SNAP_SCN   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_SNAP_SCN.sql =========*** End ***
PROMPT ===================================================================================== 
