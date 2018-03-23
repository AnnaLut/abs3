

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_GETSETCARDPARAM_TRANS.sql ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_GETSETCARDPARAM_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_GETSETCARDPARAM_TRANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_GETSETCARDPARAM_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_GETSETCARDPARAM_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_GETSETCARDPARAM_TRANS 
   (	TRANSACTIONID VARCHAR2(30), 
	ND VARCHAR2(100), 
	XMLTAGS CLOB, 
	STATUSCODE NUMBER, 
	ERRORMESSAGE VARCHAR2(2000),
	kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (XMLTAGS) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'ALTER TABLE BARS.XRMSW_GETSETCARDPARAM_TRANS add(kf VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/


PROMPT *** ALTER_POLICIES to XRMSW_GETSETCARDPARAM_TRANS ***
 exec bpa.alter_policies('XRMSW_GETSETCARDPARAM_TRANS');


COMMENT ON TABLE BARS.XRMSW_GETSETCARDPARAM_TRANS IS '';
COMMENT ON COLUMN BARS.XRMSW_GETSETCARDPARAM_TRANS.TRANSACTIONID IS '';
COMMENT ON COLUMN BARS.XRMSW_GETSETCARDPARAM_TRANS.ND IS '';
COMMENT ON COLUMN BARS.XRMSW_GETSETCARDPARAM_TRANS.XMLTAGS IS '';
COMMENT ON COLUMN BARS.XRMSW_GETSETCARDPARAM_TRANS.STATUSCODE IS '';
COMMENT ON COLUMN BARS.XRMSW_GETSETCARDPARAM_TRANS.ERRORMESSAGE IS '';




PROMPT *** Create  constraint FK_XCGCP_TRANSACTIONID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_GETSETCARDPARAM_TRANS ADD CONSTRAINT FK_XCGCP_TRANSACTIONID FOREIGN KEY (TRANSACTIONID)
	  REFERENCES BARS.XRMSW_AUDIT (TRANSACTIONID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XRMSW_GETSETCARDPARAM_TRANS ***
grant SELECT                                                                 on XRMSW_GETSETCARDPARAM_TRANS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_GETSETCARDPARAM_TRANS.sql ======
PROMPT ===================================================================================== 
