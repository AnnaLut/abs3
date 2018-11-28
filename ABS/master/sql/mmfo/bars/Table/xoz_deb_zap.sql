

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XOZ_DEB_ZAP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XOZ_DEB_ZAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XOZ_DEB_ZAP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XOZ_DEB_ZAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XOZ_DEB_ZAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.XOZ_DEB_ZAP 
   ( kf      VARCHAR2(6),
     ref1    NUMBER,
     stmt1   NUMBER,
     datz    DATE,
     ref2_ca NUMBER,
     ref2_kf NUMBER,
     sos     INTEGER,
     refd    NUMBER not null,
     txt     VARCHAR2(160)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XOZ_DEB_ZAP ***
 exec bpa.alter_policies('XOZ_DEB_ZAP');

comment on table XOZ_DEB_ZAP is '���� �������� �� ��������� �� �� �� ��';
comment on column XOZ_DEB_ZAP.kf is '��� ��, ���� �������� �����';
comment on column XOZ_DEB_ZAP.ref1 is '��� ���������� � ��';
comment on column XOZ_DEB_ZAP.stmt1 is 'STMT ���������� � ��';
comment on column XOZ_DEB_ZAP.datz is '���� ������������ ������';
comment on column XOZ_DEB_ZAP.ref2_ca is '��� ������ � ��';
comment on column XOZ_DEB_ZAP.ref2_kf is '��� ��������  ��� ������ � ��';
comment on column XOZ_DEB_ZAP.sos is '���� �������: 1=���������� � ��, 2=�������� � ��, -2=³������� � ��, 3=�������� � ��(������� ���/���) ';
comment on column XOZ_DEB_ZAP.refd is '������� ���.��� ������';


PROMPT *** Create  grants  XOZ_DEB_ZAP ***
grant select on XOZ_DEB_ZAP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XOZ_DEB_ZAP.sql =========*** End *** =====
PROMPT ===================================================================================== 
