

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_REFQUE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_REFQUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_REFQUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_REFQUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_REFQUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_REFQUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_REFQUE 
   (	REF NUMBER, 
	USERID NUMBER, 
	 CONSTRAINT XPK_CASHREFQUE PRIMARY KEY (REF, USERID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_REFQUE ***
 exec bpa.alter_policies('CASH_REFQUE');


COMMENT ON TABLE BARS.CASH_REFQUE IS 'Таблица визирования рефов. для отбора кассовых виз. Населяется триигером';
COMMENT ON COLUMN BARS.CASH_REFQUE.REF IS '';
COMMENT ON COLUMN BARS.CASH_REFQUE.USERID IS 'визирь';




PROMPT *** Create  constraint XPK_CASHREFQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_REFQUE ADD CONSTRAINT XPK_CASHREFQUE PRIMARY KEY (REF, USERID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CASHREFQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CASHREFQUE ON BARS.CASH_REFQUE (REF, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_REFQUE ***
grant SELECT                                                                 on CASH_REFQUE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_REFQUE     to BARS_DM;
grant SELECT                                                                 on CASH_REFQUE     to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_REFQUE.sql =========*** End *** =
PROMPT ===================================================================================== 
