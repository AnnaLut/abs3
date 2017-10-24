

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_CONTRACTPR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_CONTRACTPR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_CONTRACTPR ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_CONTRACTPR 
   (	BIC NUMBER(11,0), 
	IDCONTRACT VARCHAR2(40), 
	VIDCONTRAC NUMBER(11,0), 
	ID_SH NUMBER(11,0), 
	PERCEN NUMBER(18,8), 
	DA DATE, 
	NLS_6 VARCHAR2(25), 
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




PROMPT *** ALTER_POLICIES to S6_S6_CONTRACTPR ***
 exec bpa.alter_policies('S6_S6_CONTRACTPR');


COMMENT ON TABLE BARS.S6_S6_CONTRACTPR IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.IDCONTRACT IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.VIDCONTRAC IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.ID_SH IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.PERCEN IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.DA IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.NLS_6 IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.ISP_MODIFY IS '';
COMMENT ON COLUMN BARS.S6_S6_CONTRACTPR.D_MODIFY IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_CONTRACTPR.sql =========*** End 
PROMPT ===================================================================================== 
