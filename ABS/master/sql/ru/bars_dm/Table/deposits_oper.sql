

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/DEPOSITS_OPER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table DEPOSITS_OPER ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.DEPOSITS_OPER 
   (
 PER_ID      NUMBER 
,KF          VARCHAR2(6)
,DEPOSIT_ID  NUMBER(38,0)
,ND_DEP      VARCHAR2(35)
,cnt_dubl	 NUMBER(10)
,ref	     number(38)
,nd	         varchar2(10)
,mfoa	     varchar2(12)
,nlsa	     varchar2(15)
,s	         number(24)
,kv	         integer
,vdat	     date
,s2	         number(24)
,kv2	     NUMBER(38)
,mfob	     varchar2(12)
,nlsb	     varchar2(15)
,sk	         number(2)
,datd	     date
,nazn	     varchar2(160)
,tt	         varchar2(3)
,tobo	     varchar2(30)
,ida	     varchar2(14)
,nama	     varchar2(38)
,idb	     varchar2(14)
,namb	     varchar2(38)
,vob	     number(38)
,pdat	     date
,odat	     date
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND  ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

-- Add comments to the columns 
comment on column DEPOSITS_OPER.kf            is '���������� ����������';
comment on column DEPOSITS_OPER.deposit_id    is 'ID ��������';
comment on column DEPOSITS_OPER.nd_dep        is '� ��������';
comment on column DEPOSITS_OPER.cnt_dubl      is '����� ������������';
comment on column DEPOSITS_OPER.ref           is '���������� ����� ���������';
comment on column DEPOSITS_OPER.nd            is '����� ���������';
comment on column DEPOSITS_OPER.mfoa          is '��� ��������';
comment on column DEPOSITS_OPER.nlsa          is '������� ��������';
comment on column DEPOSITS_OPER.s             is '����';
comment on column DEPOSITS_OPER.kv            is '��� ������ ������� ��������';
comment on column DEPOSITS_OPER.vdat          is '���� �����������';
comment on column DEPOSITS_OPER.s2            is '���� � ����� ������� ����������';
comment on column DEPOSITS_OPER.kv2           is '��� ������ ������� ����������';
comment on column DEPOSITS_OPER.mfob          is '��� ����������';
comment on column DEPOSITS_OPER.nlsb          is '����� ������� ����������';
comment on column DEPOSITS_OPER.sk            is '���';
comment on column DEPOSITS_OPER.datd          is '���� ���������';
comment on column DEPOSITS_OPER.nazn          is '����������� �������';
comment on column DEPOSITS_OPER.tt            is '��� ��������';
comment on column DEPOSITS_OPER.tobo          is '��� ����. ��������';
comment on column DEPOSITS_OPER.ida           is '������ �������� �';
comment on column DEPOSITS_OPER.nama          is '����� ������� ��������';
comment on column DEPOSITS_OPER.idb           is '������ ����������';
comment on column DEPOSITS_OPER.namb          is '����� ������� ����������';
comment on column DEPOSITS_OPER.vob           is '��� ���������';
comment on column DEPOSITS_OPER.pdat          is '���� ���������';
comment on column DEPOSITS_OPER.odat          is '���� ������';

PROMPT *** Create  index I_DEPOSIT_OPER_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_DEPOSIT_OPER_PERID ON BARS_DM.DEPOSITS_OPER (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEPOSITS_OPER ***
grant SELECT                                                                 on DEPOSITS_OPER     to BARS;
grant SELECT                                                                 on DEPOSITS_OPER     to BARSUPL;
grant SELECT                                                                 on DEPOSITS_OPER     to UPLD;
grant SELECT                                                                 on DEPOSITS_OPER     to BARS_ACCESS_DEFROLE;

prompt *** Create  errlog to DEPOSITS_OPER
begin
    dbms_errlog.create_error_log(dml_table_name => 'DEPOSITS_OPER');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/DEPOSITS_OPER.sql =========*** End **
PROMPT ===================================================================================== 
