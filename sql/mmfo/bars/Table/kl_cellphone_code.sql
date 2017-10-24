

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_CELLPHONE_CODE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_CELLPHONE_CODE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_CELLPHONE_CODE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_CELLPHONE_CODE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_CELLPHONE_CODE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_CELLPHONE_CODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_CELLPHONE_CODE 
   (	RNK NUMBER DEFAULT null, 
	PHONENUMBER VARCHAR2(13), 
	CODE NUMBER, 
	SMS_ID NUMBER(*,0), 
	SMS_STATUS VARCHAR2(100), 
	EFFECTDATE TIMESTAMP (6) DEFAULT sysdate, 
	CELLPHONE_CONFIRMED NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_CELLPHONE_CODE ***
 exec bpa.alter_policies('KL_CELLPHONE_CODE');


COMMENT ON TABLE BARS.KL_CELLPHONE_CODE IS '��������� ������� ���� ������������ ��� ��������� �볺���';
COMMENT ON COLUMN BARS.KL_CELLPHONE_CODE.RNK IS '��� ��賺��� (��� ��������)';
COMMENT ON COLUMN BARS.KL_CELLPHONE_CODE.PHONENUMBER IS '�������� �����';
COMMENT ON COLUMN BARS.KL_CELLPHONE_CODE.CODE IS '��� ������������, �� ���������� �볺���';
COMMENT ON COLUMN BARS.KL_CELLPHONE_CODE.SMS_ID IS '������������� sms-���i�������� �� ����� ����������';
COMMENT ON COLUMN BARS.KL_CELLPHONE_CODE.SMS_STATUS IS '������ sms-���i�������� �� ����� ����������';
COMMENT ON COLUMN BARS.KL_CELLPHONE_CODE.EFFECTDATE IS '���� ���� �������';
COMMENT ON COLUMN BARS.KL_CELLPHONE_CODE.CELLPHONE_CONFIRMED IS '������� �� ����������� �������� �������';




PROMPT *** Create  index IX_CELLPHONE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IX_CELLPHONE ON BARS.KL_CELLPHONE_CODE (PHONENUMBER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_CELLPHONE_CODE ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on KL_CELLPHONE_CODE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_CELLPHONE_CODE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_CELLPHONE_CODE.sql =========*** End
PROMPT ===================================================================================== 
