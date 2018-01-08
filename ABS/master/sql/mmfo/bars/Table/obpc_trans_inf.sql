

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_INF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_TRANS_INF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_TRANS_INF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRANS_INF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_TRANS_INF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_TRANS_INF ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_TRANS_INF 
   (	TRANSIT_NLS VARCHAR2(14), 
	TRAN_TYPE CHAR(2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_TRANS_INF ***
 exec bpa.alter_policies('OBPC_TRANS_INF');


COMMENT ON TABLE BARS.OBPC_TRANS_INF IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS_INF.TRANSIT_NLS IS '';
COMMENT ON COLUMN BARS.OBPC_TRANS_INF.TRAN_TYPE IS '';




PROMPT *** Create  constraint PK_OBPC_TRANS_INF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_INF ADD CONSTRAINT PK_OBPC_TRANS_INF PRIMARY KEY (TRANSIT_NLS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCTRANSINF_OBPCTRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_INF ADD CONSTRAINT FK_OBPCTRANSINF_OBPCTRANS FOREIGN KEY (TRAN_TYPE)
	  REFERENCES BARS.OBPC_TRANS (TRAN_TYPE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCTRANSINF_TRANSITNLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_TRANS_INF MODIFY (TRANSIT_NLS CONSTRAINT CC_OBPCTRANSINF_TRANSITNLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCTRANSINF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCTRANSINF ON BARS.OBPC_TRANS_INF (TRANSIT_NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_TRANS_INF ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_TRANS_INF  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_TRANS_INF  to OBPC;
grant FLASHBACK,SELECT                                                       on OBPC_TRANS_INF  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_TRANS_INF.sql =========*** End **
PROMPT ===================================================================================== 
