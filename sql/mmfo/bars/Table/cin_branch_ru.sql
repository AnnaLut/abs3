

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIN_BRANCH_RU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIN_BRANCH_RU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIN_BRANCH_RU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_BRANCH_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIN_BRANCH_RU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIN_BRANCH_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIN_BRANCH_RU 
   (	BRANCH VARCHAR2(30), 
	RU VARCHAR2(45), 
	NAME VARCHAR2(74), 
	ADDRESS VARCHAR2(125), 
	NP VARCHAR2(80), 
	TYPE CHAR(5), 
	OPENDATE CHAR(10), 
	CLOSEDATE CHAR(10), 
	CODE VARCHAR2(20), 
	B040 VARCHAR2(20), 
	DESCRIPTION VARCHAR2(70), 
	IDPDR NUMBER(38,0), 
	DATE_CLOSED DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIN_BRANCH_RU ***
 exec bpa.alter_policies('CIN_BRANCH_RU');


COMMENT ON TABLE BARS.CIN_BRANCH_RU IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.BRANCH IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.RU IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.NAME IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.ADDRESS IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.NP IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.TYPE IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.OPENDATE IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.CLOSEDATE IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.CODE IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.B040 IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.IDPDR IS '';
COMMENT ON COLUMN BARS.CIN_BRANCH_RU.DATE_CLOSED IS '';



PROMPT *** Create  grants  CIN_BRANCH_RU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_BRANCH_RU   to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CIN_BRANCH_RU   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIN_BRANCH_RU   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIN_BRANCH_RU   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CIN_BRANCH_RU   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CIN_BRANCH_RU   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIN_BRANCH_RU.sql =========*** End ***
PROMPT ===================================================================================== 
