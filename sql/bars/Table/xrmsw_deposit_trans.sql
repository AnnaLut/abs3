

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_DEPOSIT_TRANS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_DEPOSIT_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_DEPOSIT_TRANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_DEPOSIT_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_DEPOSIT_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_DEPOSIT_TRANS 
   (	TRANSACTIONID VARCHAR2(30), 
	DPTID NUMBER(38,0), 
	NLS VARCHAR2(15), 
	RATE NUMBER, 
	NLSINT VARCHAR2(15), 
	DAOS DATE, 
	DAT_BEGIN DATE, 
	DAT_END DATE, 
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0), 
	DKBO_NUM VARCHAR2(50), 
	DKBO_IN DATE, 
	DKBO_OUT DATE, 
	STATUSCODE NUMBER, 
	ERRORMESSAGE VARCHAR2(2000),
	kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'ALTER TABLE BARS.XRMSW_DEPOSIT_TRANS add(kf VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/


PROMPT *** ALTER_POLICIES to XRMSW_DEPOSIT_TRANS ***
 exec bpa.alter_policies('XRMSW_DEPOSIT_TRANS');


COMMENT ON TABLE BARS.XRMSW_DEPOSIT_TRANS IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.TRANSACTIONID IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.DPTID IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.NLS IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.RATE IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.NLSINT IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.DAOS IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.DAT_END IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.BLKD IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.BLKK IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.DKBO_NUM IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.DKBO_IN IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.DKBO_OUT IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.STATUSCODE IS '';
COMMENT ON COLUMN BARS.XRMSW_DEPOSIT_TRANS.ERRORMESSAGE IS '';




PROMPT *** Create  constraint FK_XDST_TRANSACTIONID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_DEPOSIT_TRANS ADD CONSTRAINT FK_XDST_TRANSACTIONID FOREIGN KEY (TRANSACTIONID)
	  REFERENCES BARS.XRMSW_AUDIT (TRANSACTIONID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XRMSW_DEPOSIT_TRANS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on XRMSW_DEPOSIT_TRANS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_DEPOSIT_TRANS.sql =========*** E
PROMPT ===================================================================================== 
