

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_HIST_PR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_HIST_PR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_HIST_PR ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_HIST_PR 
   (	PERCENRATE NUMBER(11,0), 
	DA DATE, 
	PERCEN NUMBER(18,8), 
	ISP_MODIFY NUMBER(11,0), 
	D_MODIFY DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_HIST_PR ***
 exec bpa.alter_policies('S6_S6_HIST_PR');


COMMENT ON TABLE BARS.S6_S6_HIST_PR IS '';
COMMENT ON COLUMN BARS.S6_S6_HIST_PR.PERCENRATE IS '';
COMMENT ON COLUMN BARS.S6_S6_HIST_PR.DA IS '';
COMMENT ON COLUMN BARS.S6_S6_HIST_PR.PERCEN IS '';
COMMENT ON COLUMN BARS.S6_S6_HIST_PR.ISP_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_S6_HIST_PR.D_MODIFY IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_HIST_PR.sql =========*** End ***
PROMPT ===================================================================================== 
