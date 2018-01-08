

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_PAY_LOG_HEADER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_PAY_LOG_HEADER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_PAY_LOG_HEADER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ESCR_PAY_LOG_HEADER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_PAY_LOG_HEADER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_PAY_LOG_HEADER 
   (	ID NUMBER, 
	TOTAL_DEAL_COUNT NUMBER, 
	SUCCES_DEAL_COUNT NUMBER, 
	ERROR_DEAL_COUNT NUMBER, 
	OPER_DATE DATE DEFAULT sysdate, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_PAY_LOG_HEADER ***
 exec bpa.alter_policies('ESCR_PAY_LOG_HEADER');


COMMENT ON TABLE BARS.ESCR_PAY_LOG_HEADER IS 'Журнал виконання зарахування компенсацій по енергозберігаючій програмі';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_HEADER.ID IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_HEADER.TOTAL_DEAL_COUNT IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_HEADER.SUCCES_DEAL_COUNT IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_HEADER.ERROR_DEAL_COUNT IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_HEADER.OPER_DATE IS '';
COMMENT ON COLUMN BARS.ESCR_PAY_LOG_HEADER.KF IS '';




PROMPT *** Create  constraint PK_PAY_HEAD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_PAY_LOG_HEADER ADD CONSTRAINT PK_PAY_HEAD_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAY_HEAD_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAY_HEAD_ID ON BARS.ESCR_PAY_LOG_HEADER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_PAY_LOG_HEADER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_PAY_LOG_HEADER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_PAY_LOG_HEADER.sql =========*** E
PROMPT ===================================================================================== 
