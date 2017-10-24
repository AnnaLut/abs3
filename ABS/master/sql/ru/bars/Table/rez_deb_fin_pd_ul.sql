

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_DEB_FIN_PD_UL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_DEB_FIN_PD_UL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_DEB_FIN_PD_UL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_DEB_FIN_PD_UL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_DEB_FIN_PD_UL ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_DEB_FIN_PD_UL 
   (	KOL_MIN NUMBER, 
	KOL_MAX NUMBER, 
	FIN NUMBER(*,0), 
	PD NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_DEB_FIN_PD_UL ***
 exec bpa.alter_policies('REZ_DEB_FIN_PD_UL');


COMMENT ON TABLE BARS.REZ_DEB_FIN_PD_UL IS '������� ����������� ��������� ������� ��� �������� < 3 ��.';
COMMENT ON COLUMN BARS.REZ_DEB_FIN_PD_UL.KOL_MIN IS '�-�� ��� ����������� ��';
COMMENT ON COLUMN BARS.REZ_DEB_FIN_PD_UL.KOL_MAX IS '�-�� ��� ����������� ��';
COMMENT ON COLUMN BARS.REZ_DEB_FIN_PD_UL.FIN IS '���� �����������';
COMMENT ON COLUMN BARS.REZ_DEB_FIN_PD_UL.PD IS '�������� ����������� ��������� ������� ';



PROMPT *** Create  grants  REZ_DEB_FIN_PD_UL ***
grant SELECT                                                                 on REZ_DEB_FIN_PD_UL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_DEB_FIN_PD_UL to RCC_DEAL;
grant SELECT                                                                 on REZ_DEB_FIN_PD_UL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_DEB_FIN_PD_UL.sql =========*** End
PROMPT ===================================================================================== 
