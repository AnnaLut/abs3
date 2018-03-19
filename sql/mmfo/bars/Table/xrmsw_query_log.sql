

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_QUERY_LOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to xrmsw_query_log ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_QUERY_LOG'', ''WHOLE'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_QUERY_LOG'', ''FILIAL'' , ''M'', ''M'',''M'', ''M'');
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_QUERY_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_QUERY_LOG 
   (  TRANSACTIONID VARCHAR2(30), 
  REQ BLOB, 
  RESP BLOB, 
  KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (REQ) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (RESP) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XRMSW_QUERY_LOG ***
 exec bpa.alter_policies('XRMSW_QUERY_LOG');


COMMENT ON TABLE BARS.XRMSW_QUERY_LOG IS '';
COMMENT ON COLUMN BARS.XRMSW_QUERY_LOG.TRANSACTIONID IS 'TransactionId';
COMMENT ON COLUMN BARS.XRMSW_QUERY_LOG.REQ IS 'Тіло запиту';
COMMENT ON COLUMN BARS.XRMSW_QUERY_LOG.RESP IS 'Тіло відповіді';
COMMENT ON COLUMN BARS.XRMSW_QUERY_LOG.KF IS 'KF';




PROMPT *** Create  index I_XRMSW_QUERY_LOG_TR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_XRMSW_QUERY_LOG_TR ON BARS.XRMSW_QUERY_LOG (TRANSACTIONID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_QUERY_LOG.sql =========*** End *
PROMPT ===================================================================================== 
