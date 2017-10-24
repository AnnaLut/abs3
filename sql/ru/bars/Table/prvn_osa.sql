

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_OSA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_OSA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_OSA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_OSA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_OSA ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_OSA 
   (	RNK NUMBER, 
	TIP NUMBER(*,0), 
	ND NUMBER, 
	KV NUMBER(*,0), 
	REZB NUMBER(24,2), 
	REZ9 NUMBER(24,2), 
	AIRC_CCY NUMBER(24,2), 
	IRC_CCY NUMBER(24,2), 
	ID_PROV_TYPE VARCHAR2(2), 
	IS_DEFAULT NUMBER(*,0), 
	COMM VARCHAR2(100), 
	REZB_R NUMBER, 
	REZ9_R NUMBER, 
	FV_ABS NUMBER, 
	VIDD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_OSA ***
 exec bpa.alter_policies('PRVN_OSA');


COMMENT ON TABLE BARS.PRVN_OSA IS '�������� ³����� "������-����"';
COMMENT ON COLUMN BARS.PRVN_OSA.VIDD IS '��� �������';
COMMENT ON COLUMN BARS.PRVN_OSA.RNK IS 'RNK_CLIENT~���~�������';
COMMENT ON COLUMN BARS.PRVN_OSA.TIP IS 'UNIQUE_BARS_IS~����/*~� ���';
COMMENT ON COLUMN BARS.PRVN_OSA.ND IS 'UNIQUE_BARS_IS~*/����~� ���';
COMMENT ON COLUMN BARS.PRVN_OSA.KV IS 'ID_CURRENCY~���~���';
COMMENT ON COLUMN BARS.PRVN_OSA.REZB IS 'PROV_BALANCE_CCY~������ ��~���.���';
COMMENT ON COLUMN BARS.PRVN_OSA.REZ9 IS 'PROV_OFFBALANCE_CCY~������ ��~���/���.���';
COMMENT ON COLUMN BARS.PRVN_OSA.AIRC_CCY IS 'AIRC_CCY~�����~������.���';
COMMENT ON COLUMN BARS.PRVN_OSA.IRC_CCY IS '';
COMMENT ON COLUMN BARS.PRVN_OSA.ID_PROV_TYPE IS 'ID_PROV_TYPE~���/���~������';
COMMENT ON COLUMN BARS.PRVN_OSA.IS_DEFAULT IS '�����~�������';
COMMENT ON COLUMN BARS.PRVN_OSA.COMM IS 'COMM~�������� ���~NBU23_REZ';
COMMENT ON COLUMN BARS.PRVN_OSA.FV_ABS IS 'FV-ABS~�� ��������~�������';
COMMENT ON COLUMN BARS.PRVN_OSA.REZB_R IS '������~������ ��~���.���';
COMMENT ON COLUMN BARS.PRVN_OSA.REZ9_R IS '������~������ ��~���/���.���';



PROMPT *** Create  grants  PRVN_OSA ***
grant SELECT                                                                 on PRVN_OSA        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_OSA.sql =========*** End *** ====
PROMPT ===================================================================================== 
