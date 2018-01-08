BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ON_DATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ON_DATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ON_DATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ON_DATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ON_DATE 
   (	USER_ID  NUMBER DEFAULT sys_context(''bars_global'', ''user_id''),
        ID 	 NUMBER,        --5 � �� � ������i
        CP_ID    VARCHAR2(20),  --6 ��� ��
	RYN      NUMBER, 
        RYN_NAME VARCHAR2(35),  --10 ���.��������
	REF      NUMBER,        --4 ��� ����� ���i��i 
	ERAT     NUMBER,        --22 �����. ������ %
        DOX      NUMBER,
        EMI      NUMBER,
        KV       NUMBER,         --7 ��� 
        MDATE    DATE,           --11 ���� ��������� 
        OSTA     NUMBER,         --14 ���� ���i����
        PF       NUMBER,
        PF_NAME  VARCHAR2(70),   --9 ��������
        DATD     DATE,           --1 ���� ����� ���i��
        ND       VARCHAR2(32),   --2 � ����� ���i��i
        RNK      NUMBER,
        SUMB     NUMBER,         --3 ���� ����� ���i��i 
        VIDD     NUMBER,         --8 ��� ���� (���.���.)
        IR       NUMBER,         --12 ��������� %��. ���� 
        MO_PR    NUMBER,         --13 ���.% ��.������
        OSTD     NUMBER,         --15 ���� ��������
        OSTP     NUMBER,         --16 ���� ���쳿
        OSTR     NUMBER,         --17 ���� ����� %
        OSTR2    NUMBER,         --18 ���� �������� %
        OSTS     NUMBER,         --19 ���� ������.
        OSTAB    NUMBER,         --20 ���� ��� N-����
        OSTAF    NUMBER,         --21 ���� ��� N-���
        P_DATE   DATE            --23 �� ����
   ) TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to CP_ON_DATE ***
 exec bpa.alter_policies('CP_ON_DATE');


COMMENT ON TABLE BARS.CP_ON_DATE IS '������� ��� ���� �� �������� �� ����';


PROMPT *** Create  index IDX1_CPONDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX1_CPONDATE ON BARS.CP_ON_DATE (USER_ID, ID) 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  CP_ON_DATE ***
grant SELECT                                            on CP_ON_DATE         to BARS_ACCESS_DEFROLE;








