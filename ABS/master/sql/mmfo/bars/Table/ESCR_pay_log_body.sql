

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_PAY_LOG_BODY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_PAY_LOG_BODY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_PAY_LOG_BODY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ESCR_PAY_LOG_BODY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_PAY_LOG_BODY ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_PAY_LOG_BODY 
   (	ID_LOG NUMBER, 
	DEAL_ID NUMBER, 
	SUCCES_DEAL_COUNT NUMBER, 
	ERR_CODE NUMBER, 
	COMMENTS VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_PAY_LOG_BODY ***
 exec bpa.alter_policies('ESCR_PAY_LOG_BODY');


COMMENT ON TABLE BARS.ESCR_PAY_LOG_BODY IS 'Журнал виконання зарахування компенсацій по енергозберігаючій програмі (специфікація)';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_BODY.ID_LOG IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_BODY.DEAL_ID IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_BODY.SUCCES_DEAL_COUNT IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_BODY.ERR_CODE IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_BODY.COMMENTS IS '';



PROMPT *** Create  grants  ESCR_PAY_LOG_BODY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_PAY_LOG_BODY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_PAY_LOG_BODY.sql =========*** End
PROMPT ===================================================================================== 
