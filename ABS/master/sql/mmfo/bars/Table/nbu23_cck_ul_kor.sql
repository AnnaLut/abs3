PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBU23_CCK_UL_KOR.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to NBU23_CCK_UL_KOR ***

BEGIN 
    if f_ourmfo_g = 300465  then 
       execute immediate  
          'begin  
              bpa.alter_policy_info(''NBU23_CCK_UL_KOR'', ''CENTER'' , null, null, null, null);
	      bpa.alter_policy_info(''NBU23_CCK_UL_KOR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
	      bpa.alter_policy_info(''NBU23_CCK_UL_KOR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
	      null;
	   end; 
	  '; 
    else 
       execute immediate  
          'begin  
	      bpa.alter_policy_info(''NBU23_CCK_UL_KOR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
	      bpa.alter_policy_info(''NBU23_CCK_UL_KOR'', ''WHOLE''  , null, ''E'', ''E'', ''E'');
              null;
           end; 
          '; 
    end if;
END; 
/

PROMPT *** Create  table NBU23_CCK_UL_KOR ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBU23_CCK_UL_KOR 
   (	ID      NUMBER, 
	MOD     VARCHAR2(3), 
	ND      NUMBER(10,0), 
	PDAT    DATE, 
	ZDAT    DATE, 
	FIN23   NUMBER(*,0), 
	OBS23   NUMBER(*,0), 
	KAT23   NUMBER(*,0), 
	K23     NUMBER, 
	ISP     NUMBER(38,0), 
	COMM    VARCHAR2(254), 
	FIN_351 NUMBER(*,0), 
	PD      NUMBER, 
	KF      VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/



 begin 
  execute immediate 
    ' alter table Nbu23_Cck_Ul_Kor add(FIN_351 NUMBER(*,0))';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

 begin 
  execute immediate 
    ' alter table Nbu23_Cck_Ul_Kor add(PD NUMBER)';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

 begin 
  execute immediate 
    ' alter table Nbu23_Cck_Ul_Kor add(KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''))';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

 begin 
  execute immediate 
    ' alter table Nbu23_Cck_Ul_Kor add(KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''))';
exception when others then 
  if sqlcode=-1430 then null; else raise; end if;
end;
/

begin
 execute immediate   'alter table nbu23_cck_ul_kor add (VKR varchar2(3)) ';
exception when others then
  -- ORA-01430: column being added already exists in table
  if SQLCODE = - 01430 then null;   else raise; end if; 
end;
/

PROMPT *** ALTER_POLICIES to NBU23_CCK_UL_KOR ***
 exec bpa.alter_policies('NBU23_CCK_UL_KOR');
 
 
COMMENT ON COLUMN nbu23_cck_ul_kor.VKR  IS '�������� ��������� �������';

COMMENT ON TABLE  BARS.NBU23_CCK_UL_KOR         IS '������ ������� ����������� ��������� ���23';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.FIN_351 IS '���� �������� (351 ����.)';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.PD      IS 'PD (��������� �������)';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.KF      IS '';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.ID      IS '';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.MOD     IS '';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.ND      IS 'ND �������� �����';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.PDAT    IS '���� �� ��� �������� ���';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.ZDAT    IS '������ �����';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.FIN23   IS '���� ������������ ��������� ���23';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.OBS23   IS '���� ������������� �����';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.KAT23   IS '��������';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.K23     IS '���������� �������� �����';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.ISP     IS 'ID ��������';
COMMENT ON COLUMN BARS.NBU23_CCK_UL_KOR.COMM    IS '������� ������� �����������';

PROMPT *** Create  constraint PK_NBU23CCKULKOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBU23_CCK_UL_KOR ADD CONSTRAINT PK_NBU23CCKULKOR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_NBU23CCKULKOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBU23CCKULKOR ON BARS.NBU23_CCK_UL_KOR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index UK_NBU23CCKULKOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBU23CCKULKOR ON BARS.NBU23_CCK_UL_KOR (MOD, ND, PDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  NBU23_CCK_UL_KOR ***
grant SELECT,UPDATE                                                          on NBU23_CCK_UL_KOR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBU23_CCK_UL_KOR to BARS_DM;
grant SELECT,UPDATE                                                          on NBU23_CCK_UL_KOR to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBU23_CCK_UL_KOR.sql =========*** End 
PROMPT ===================================================================================== 
