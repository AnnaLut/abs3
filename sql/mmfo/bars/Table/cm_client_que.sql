

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_CLIENT_QUE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_CLIENT_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_CLIENT_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CM_CLIENT_QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CM_CLIENT_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_CLIENT_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_CLIENT_QUE 
   (	ID NUMBER(*,0), 
	DATEIN DATE, 
	DATEMOD DATE, 
	OPER_TYPE NUMBER(*,0), 
	OPER_STATUS NUMBER(*,0), 
	RESP_TXT VARCHAR2(1000), 
	BRANCH VARCHAR2(30), 
	OPENDATE DATE, 
	CLIENTTYPE NUMBER(*,0), 
	TAXPAYERIDENTIFIER VARCHAR2(10), 
	SHORTNAME VARCHAR2(105), 
	FIRSTNAME VARCHAR2(105), 
	LASTNAME VARCHAR2(105), 
	MIDDLENAME VARCHAR2(105), 
	ENGFIRSTNAME VARCHAR2(64), 
	ENGLASTNAME VARCHAR2(64), 
	COUNTRY VARCHAR2(3), 
	RESIDENT NUMBER(*,0), 
	WORK VARCHAR2(254), 
	OFFICE VARCHAR2(32), 
	DATE_W DATE, 
	ISVIP VARCHAR2(1), 
	K060 VARCHAR2(2), 
	COMPANYNAME VARCHAR2(200), 
	SHORTCOMPANYNAME VARCHAR2(32), 
	PERSONALISATIONNAME VARCHAR2(32), 
	KLAS_CLIENT_ID NUMBER(*,0), 
	CONTACTPERSON VARCHAR2(105), 
	BIRTHDATE DATE, 
	BIRTHPLACE VARCHAR2(1024), 
	GENDER VARCHAR2(1), 
	ADDR1_CITYNAME VARCHAR2(100), 
	ADDR1_PCODE VARCHAR2(10), 
	ADDR1_DOMAIN VARCHAR2(48), 
	ADDR1_REGION VARCHAR2(48), 
	ADDR1_STREET VARCHAR2(100), 
	ADDR2_CITYNAME VARCHAR2(100), 
	ADDR2_PCODE VARCHAR2(10), 
	ADDR2_DOMAIN VARCHAR2(48), 
	ADDR2_REGION VARCHAR2(48), 
	ADDR2_STREET VARCHAR2(100), 
	EMAIL VARCHAR2(32), 
	PHONENUMBER VARCHAR2(12), 
	PHONENUMBER_MOB VARCHAR2(12), 
	PHONENUMBER_DOD VARCHAR2(12), 
	FAX VARCHAR2(12), 
	TYPEDOC NUMBER(*,0), 
	PASPNUM VARCHAR2(16), 
	PASPSERIES VARCHAR2(16), 
	PASPDATE DATE, 
	PASPISSUER VARCHAR2(128), 
	FOREIGNPASPNUM VARCHAR2(16), 
	FOREIGNPASPSERIES VARCHAR2(16), 
	FOREIGNPASPDATE DATE, 
	FOREIGNPASPENDDATE DATE, 
	FOREIGNPASPISSUER VARCHAR2(128), 
	CONTRACTNUMBER VARCHAR2(19), 
	PRODUCTCODE VARCHAR2(32), 
	CARD_TYPE VARCHAR2(36), 
	CNTM NUMBER(*,0), 
	PIND VARCHAR2(32), 
	OKPO_SYSORG VARCHAR2(10), 
	KOD_SYSORG NUMBER(*,0), 
	REGNUMBERCLIENT VARCHAR2(32), 
	REGNUMBEROWNER VARCHAR2(32), 
	ACC NUMBER(22,0), 
	CL_RNK VARCHAR2(32), 
	CL_DT_ISS DATE, 
	CARD_BR_ISS VARCHAR2(30), 
	CARD_ADDR_ISS VARCHAR2(100), 
	DELIVERY_BR VARCHAR2(30), 
	RNK NUMBER(22,0), 
	KK_SECRET_WORD VARCHAR2(32), 
	KK_FLAG NUMBER(1,0), 
	KK_REGTYPE NUMBER(1,0), 
	KK_CITYAREAID NUMBER(10,0), 
	KK_STREETTYPEID NUMBER(10,0), 
	KK_STREETNAME VARCHAR2(64), 
	KK_APARTMENT VARCHAR2(32), 
	KK_POSTCODE VARCHAR2(5), 
	ADD_INFO VARCHAR2(500), 
	IDCARDENDDATE DATE, 
	EDDR_ID VARCHAR2(20), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SHORTNAMEOWNER VARCHAR2(105)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add columns for CM *************
begin   
 execute immediate '
	alter table cm_client_que add (
		addr1_city_type varchar2(30)   ,
		addr1_street_type  varchar2(25)  ,
		addr1_address varchar2(70)  ,
		addr1_house  varchar2(5) ,
		addr1_flat varchar2(5) ,
		addr2_city_type varchar2(30)  ,
		addr2_street_type  varchar2(25)  ,
		addr2_address varchar2(70)  ,
		addr2_house  varchar2(5) ,
		addr2_flat varchar2(5)     ) ';
exception when others then
  if  sqlcode=-955 or sqlcode=-01430  then null; else raise; end if;
 end;
/

alter table cm_client_que modify  addr1_house varchar2(100 char);
alter table cm_client_que modify  addr2_house varchar2(100 char);
alter table cm_client_que modify  addr1_flat  varchar2(100 char);
alter table cm_client_que modify  addr2_flat  varchar2(100 char);


PROMPT *** ALTER_POLICIES to CM_CLIENT_QUE ***
 exec bpa.alter_policies('CM_CLIENT_QUE');
/

-- Add comments to the columns 
comment on column CM_CLIENT_QUE.id  		is '��������� ������������� ������';
comment on column CM_CLIENT_QUE.datein  	is '���� ��������� ������';
comment on column CM_CLIENT_QUE.datemod  	is '���� ����������� ������';
comment on column CM_CLIENT_QUE.oper_type  	is '��� ��������';
comment on column CM_CLIENT_QUE.oper_status  	is '������ ��������';
comment on column CM_CLIENT_QUE.resp_txt     	is '���� �������';
comment on column CM_CLIENT_QUE.branch       	is '��� �������� �����';
comment on column CM_CLIENT_QUE.opendate     	is '���� �������� �볺���';
comment on column CM_CLIENT_QUE.clienttype   	is '��� �볺���';
comment on column CM_CLIENT_QUE.taxpayeridentifier  is '���������������� ��� �������';
comment on column CM_CLIENT_QUE.shortname           is '������������ �볺��� ����������';
comment on column CM_CLIENT_QUE.firstname           is '���';
comment on column CM_CLIENT_QUE.lastname            is '�������';
comment on column CM_CLIENT_QUE.middlename          is '��-�������';
comment on column CM_CLIENT_QUE.engfirstname        is '��� �� ���������� (�� ���������� )';
comment on column CM_CLIENT_QUE.englastname         is '������� �� ���������� (�� ����������)';
comment on column CM_CLIENT_QUE.country             is '������������';
comment on column CM_CLIENT_QUE.resident            is '������ ���������';
comment on column CM_CLIENT_QUE.work                is '̳��� ������';
comment on column CM_CLIENT_QUE.office              is '������';
comment on column CM_CLIENT_QUE.date_w              is '���� �������� �� ������';
comment on column CM_CLIENT_QUE.isvip               is '������� VIP �������';
comment on column CM_CLIENT_QUE.k060                is '������� ���������';
comment on column CM_CLIENT_QUE.companyname         is '����� ����������';
comment on column CM_CLIENT_QUE.shortcompanyname    is '������� ������������ �����������';
comment on column CM_CLIENT_QUE.personalisationname   is '����� ������ �� ���������� (�� ����.)';
comment on column CM_CLIENT_QUE.klas_client_id        is '��. ������';
comment on column CM_CLIENT_QUE.contactperson         is '������� ��������� �����';
comment on column CM_CLIENT_QUE.birthdate             is '���� ����������';
comment on column CM_CLIENT_QUE.birthplace            is '̳��� ����������';
comment on column CM_CLIENT_QUE.gender                is '�����';
comment on column CM_CLIENT_QUE.addr1_cityname        is '̳��� (��������/���������)';
comment on column CM_CLIENT_QUE.addr1_pcode           is '������ (��������/���������)';
comment on column CM_CLIENT_QUE.addr1_domain          is '������� (��������/���������)';
comment on column CM_CLIENT_QUE.addr1_region          is '����� (��������/���������)';
comment on column CM_CLIENT_QUE.addr1_street          is '������, �������, �������� (��������/���������)';
comment on column CM_CLIENT_QUE.addr2_cityname        is '̳��� (����������)';
comment on column CM_CLIENT_QUE.addr2_pcode           is '������ (����������)';
comment on column CM_CLIENT_QUE.addr2_domain          is '������� (����������)';
comment on column CM_CLIENT_QUE.addr2_region          is '����� (����������)';
comment on column CM_CLIENT_QUE.addr2_street          is '������, �������, �������� (����������)';
comment on column CM_CLIENT_QUE.email                 is 'e-mail';
comment on column CM_CLIENT_QUE.phonenumber           is '�������';
comment on column CM_CLIENT_QUE.phonenumber_mob       is '������� ��������';
comment on column CM_CLIENT_QUE.phonenumber_dod       is '������� ����������';
comment on column CM_CLIENT_QUE.fax                   is '����';
comment on column CM_CLIENT_QUE.typedoc               is '��� ���������';
comment on column CM_CLIENT_QUE.paspnum               is '����� ��������� �� ������� �����';
comment on column CM_CLIENT_QUE.paspseries            is '���� ��������� �� ������� �����';
comment on column CM_CLIENT_QUE.paspdate              is '���� ������ ��������� �� ������� �����';
comment on column CM_CLIENT_QUE.paspissuer            is '��� ������� �������� �� ������� �����';
comment on column CM_CLIENT_QUE.foreignpaspnum        is '����� ������������ ��������';
comment on column CM_CLIENT_QUE.foreignpaspseries     is '���� ������������ ��������';
comment on column CM_CLIENT_QUE.foreignpaspdate       is '���� ������ ������������ ��������';
comment on column CM_CLIENT_QUE.foreignpaspenddate    is '����������� ������� ������ ��';
comment on column CM_CLIENT_QUE.foreignpaspissuer     is '��� ������� ����������� �������';
comment on column CM_CLIENT_QUE.contractnumber        is '����� ����������� ������� 2625';
comment on column CM_CLIENT_QUE.productcode           is '��� ��������';
comment on column CM_CLIENT_QUE.card_type             is '��� ��������� ����������';
comment on column CM_CLIENT_QUE.cntm                  is '���������� ������� �������� �����';
comment on column CM_CLIENT_QUE.pind                  is '����� �����';
comment on column CM_CLIENT_QUE.okpo_sysorg           is '���� �������� ����������';
comment on column CM_CLIENT_QUE.kod_sysorg            is '��� �������� �������� ����������';
comment on column CM_CLIENT_QUE.regnumberclient       is '��������� ��� �볺���, �������� ������� � ���';
comment on column CM_CLIENT_QUE.regnumberowner        is '��������� ��� �볺���, ��������� ����� � ���';
comment on column CM_CLIENT_QUE.cl_rnk                is '��� ������ � ���';
comment on column CM_CLIENT_QUE.cl_dt_iss             is '���� ������ ����� ������';
comment on column CM_CLIENT_QUE.card_br_iss           is '����� ��������, �� ���� ���������� ������';
comment on column CM_CLIENT_QUE.card_addr_iss         is '����� ��������, �� ���� ���������� ������';
comment on column CM_CLIENT_QUE.delivery_br           is '��� ��������, ���� ����� ��������� ������';
comment on column CM_CLIENT_QUE.rnk                   is '������������ ����� �볺���';
comment on column CM_CLIENT_QUE.kk_secret_word        is '����� ����� ��� ��';
comment on column CM_CLIENT_QUE.kk_flag               is '������� ������������� �������� ������ �� ��';
comment on column CM_CLIENT_QUE.kk_regtype            is '��� ��������� �����������';
comment on column CM_CLIENT_QUE.kk_cityareaid         is '��� ������ ����';
comment on column CM_CLIENT_QUE.kk_streettypeid       is '��� ���� ������';
comment on column CM_CLIENT_QUE.kk_streetname         is '������';
comment on column CM_CLIENT_QUE.kk_apartment          is '����� ������� (�� ��������)';
comment on column CM_CLIENT_QUE.kk_postcode           is '�������� ������';
comment on column CM_CLIENT_QUE.add_info              is '��������� ����������';
comment on column CM_CLIENT_QUE.shortnameowner        is '������������ �볺���-��������� ����������';
comment on column CM_CLIENT_QUE.addr2_city_type           is '��� ���������� ������ (�������� ������)';
comment on column CM_CLIENT_QUE.addr2_street_type          is '��� ������ (�������� ������)';
comment on column CM_CLIENT_QUE.addr2_address               is '������ (�������� ������)';
comment on column CM_CLIENT_QUE.addr2_house                is '����� ������� (�������� ������)';
comment on column CM_CLIENT_QUE.addr2_flat                 is '����� �������� (�������� ������)';
comment on column CM_CLIENT_QUE.addr1_city_type           is '��� ���������� ������ (�������� ������)';
comment on column CM_CLIENT_QUE.addr1_street_type          is '��� ������ (�������� ������)';
comment on column CM_CLIENT_QUE.addr1_address              is '������ (�������� ������)';
comment on column CM_CLIENT_QUE.addr1_house                is '����� ������� (�������� ������)';
comment on column CM_CLIENT_QUE.addr1_flat                 is '����� �������� (�������� ������)';

/

PROMPT *** Create  constraint PK_CMCLIENTQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE ADD CONSTRAINT PK_CMCLIENTQUE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMCLIENTQUE_OPERSTATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE ADD CONSTRAINT CC_CMCLIENTQUE_OPERSTATUS CHECK (oper_status in (1,2,3,10,99)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CMCLIENTQUE_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE ADD CONSTRAINT FK_CMCLIENTQUE_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMCLIENTQUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE MODIFY (KF CONSTRAINT CC_CMCLIENTQUE_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CMCLIENTQUE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE MODIFY (ID CONSTRAINT CC_CMCLIENTQUE_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CMCLIENTQUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CLIENT_QUE ADD CONSTRAINT FK_CMCLIENTQUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_CMCLIENTQUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_CMCLIENTQUE ON BARS.CM_CLIENT_QUE (DATEIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_CMCLIENTQUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_CMCLIENTQUE ON BARS.CM_CLIENT_QUE (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CMCLIENTQUE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CMCLIENTQUE ON BARS.CM_CLIENT_QUE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMCLIENTQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMCLIENTQUE ON BARS.CM_CLIENT_QUE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin
    execute immediate 'alter table CM_CLIENT_QUE
  drop constraint CC_CMCLIENTQUE_OPERSTATUS';
 exception when others then 
    if sqlcode = -2443 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table CM_CLIENT_QUE
  add constraint CC_CMCLIENTQUE_OPERSTATUS
  check (oper_status in (1,2,3,10,20,30,99))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  grants  CM_CLIENT_QUE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CM_CLIENT_QUE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_CLIENT_QUE   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_CLIENT_QUE   to OW;
grant FLASHBACK,SELECT                                                       on CM_CLIENT_QUE   to WR_REFREAD;





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_CLIENT_QUE.sql =========*** End ***
PROMPT ===================================================================================== 
