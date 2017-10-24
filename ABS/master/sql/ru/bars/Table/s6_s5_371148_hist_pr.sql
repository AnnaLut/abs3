

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S5_371148_HIST_PR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S5_371148_HIST_PR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S5_371148_HIST_PR ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S5_371148_HIST_PR 
   (	NLS NUMBER(14,0), 
	I_VA NUMBER(3,0), 
	DATE_ST DATE, 
	PROC_ST VARCHAR2(40), 
	K_D VARCHAR2(1), 
	NLS_SP NUMBER(14,0), 
	NLS_ZS NUMBER(14,0), 
	NLS_3801 NUMBER(14,0), 
	NLS_6204 NUMBER(14,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S5_371148_HIST_PR ***
 exec bpa.alter_policies('S6_S5_371148_HIST_PR');


COMMENT ON TABLE BARS.S6_S5_371148_HIST_PR IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.NLS IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.DATE_ST IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.PROC_ST IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.K_D IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.NLS_SP IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.NLS_ZS IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.NLS_3801 IS '';
COMMENT ON COLUMN BARS.S6_S5_371148_HIST_PR.NLS_6204 IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S5_371148_HIST_PR.sql =========*** 
PROMPT ===================================================================================== 
