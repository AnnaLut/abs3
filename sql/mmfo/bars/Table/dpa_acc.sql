

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_ACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPA_ACC'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPA_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_ACC ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.DPA_ACC 
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
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_ACC ***
 exec bpa.alter_policies('DPA_ACC');


COMMENT ON TABLE BARS.DPA_ACC IS '';
COMMENT ON COLUMN BARS.DPA_ACC.MFO IS '';
COMMENT ON COLUMN BARS.DPA_ACC.OKPO IS '';
COMMENT ON COLUMN BARS.DPA_ACC.RT IS '';
COMMENT ON COLUMN BARS.DPA_ACC.OT IS '';
COMMENT ON COLUMN BARS.DPA_ACC.ODAT IS '';
COMMENT ON COLUMN BARS.DPA_ACC.NLS IS '';
COMMENT ON COLUMN BARS.DPA_ACC.KV IS '';
COMMENT ON COLUMN BARS.DPA_ACC.C_AG IS '';
COMMENT ON COLUMN BARS.DPA_ACC.NMK IS '';
COMMENT ON COLUMN BARS.DPA_ACC.ADR IS '';
COMMENT ON COLUMN BARS.DPA_ACC.C_REG IS '';
COMMENT ON COLUMN BARS.DPA_ACC.C_DST IS '';
COMMENT ON COLUMN BARS.DPA_ACC.BIC IS '';
COMMENT ON COLUMN BARS.DPA_ACC.COUNTRY IS '';
COMMENT ON COLUMN BARS.DPA_ACC.KF IS '';




PROMPT *** Create  constraint CC_DPAACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_ACC MODIFY (KF CONSTRAINT CC_DPAACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_ACC ***
grant INSERT                                                                 on DPA_ACC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPA_ACC         to BARS_DM;
grant INSERT                                                                 on DPA_ACC         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_ACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
