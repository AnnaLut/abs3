

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_ACC_USERID.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_ACC_USERID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_ACC_USERID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_ACC_USERID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_ACC_USERID ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_ACC_USERID 
   (	MFO VARCHAR2(12), 
	OKPO VARCHAR2(14), 
	RT VARCHAR2(1), 
	OT VARCHAR2(1), 
	ODAT DATE, 
	NLS VARCHAR2(40), 
	KV NUMBER(6,0), 
	C_AG VARCHAR2(1), 
	NMK VARCHAR2(70), 
	ADR VARCHAR2(80), 
	C_REG NUMBER(2,0), 
	C_DST NUMBER(2,0), 
	BIC VARCHAR2(40), 
	COUNTRY NUMBER(3,0), 
	REF NUMBER, 
	USERID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_ACC_USERID ***
 exec bpa.alter_policies('DPA_ACC_USERID');


COMMENT ON TABLE BARS.DPA_ACC_USERID IS 'Временная таблица для формирования @F';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.MFO IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.OKPO IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.RT IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.OT IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.ODAT IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.NLS IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.KV IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.C_AG IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.NMK IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.ADR IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.C_REG IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.C_DST IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.BIC IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.COUNTRY IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.REF IS '';
COMMENT ON COLUMN BARS.DPA_ACC_USERID.USERID IS '';



PROMPT *** Create  grants  DPA_ACC_USERID ***
grant INSERT                                                                 on DPA_ACC_USERID  to BARS_ACCESS_DEFROLE;
grant INSERT                                                                 on DPA_ACC_USERID  to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_ACC_USERID.sql =========*** End **
PROMPT ===================================================================================== 
