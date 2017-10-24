

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_PARAMS_TEMPLATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_PARAMS_TEMPLATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_PARAMS_TEMPLATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_PARAMS_TEMPLATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_PARAMS_TEMPLATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_PARAMS_TEMPLATE 
   (	ID_PAR VARCHAR2(6), 
	NAME_PAR VARCHAR2(255), 
	TXT VARCHAR2(1000), 
	DAY VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_PARAMS_TEMPLATE ***
 exec bpa.alter_policies('VIP_PARAMS_TEMPLATE');


COMMENT ON TABLE BARS.VIP_PARAMS_TEMPLATE IS '��������� ���������� ���������� �� VIP �볺����';
COMMENT ON COLUMN BARS.VIP_PARAMS_TEMPLATE.ID_PAR IS '������������� ���������';
COMMENT ON COLUMN BARS.VIP_PARAMS_TEMPLATE.NAME_PAR IS '������������ ���������';
COMMENT ON COLUMN BARS.VIP_PARAMS_TEMPLATE.TXT IS '����� �����������';
COMMENT ON COLUMN BARS.VIP_PARAMS_TEMPLATE.DAY IS 'ʳ������ ���~��������� ����� ����';



PROMPT *** Create  grants  VIP_PARAMS_TEMPLATE ***
grant INSERT,SELECT,UPDATE                                                   on VIP_PARAMS_TEMPLATE to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on VIP_PARAMS_TEMPLATE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_PARAMS_TEMPLATE.sql =========*** E
PROMPT ===================================================================================== 
