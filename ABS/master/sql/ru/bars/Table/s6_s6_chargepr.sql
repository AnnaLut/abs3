

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_CHARGEPR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_CHARGEPR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_CHARGEPR ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_CHARGEPR 
   (	NLS VARCHAR2(25), 
	GROUP_U NUMBER(11,0), 
	I_VA NUMBER(11,0), 
	PERCENRATE NUMBER(11,0), 
	DA DATE, 
	SERV_I_VA NUMBER(11,0), 
	SERV_DB_S VARCHAR2(25), 
	SERV_KR_S VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_CHARGEPR ***
 exec bpa.alter_policies('S6_S6_CHARGEPR');


COMMENT ON TABLE BARS.S6_S6_CHARGEPR IS '';
COMMENT ON COLUMN BARS.S6_S6_CHARGEPR.NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_CHARGEPR.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_S6_CHARGEPR.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_CHARGEPR.PERCENRATE IS '';
COMMENT ON COLUMN BARS.S6_S6_CHARGEPR.DA IS '';
COMMENT ON COLUMN BARS.S6_S6_CHARGEPR.SERV_I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_CHARGEPR.SERV_DB_S IS '';
COMMENT ON COLUMN BARS.S6_S6_CHARGEPR.SERV_KR_S IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_CHARGEPR.sql =========*** End **
PROMPT ===================================================================================== 
