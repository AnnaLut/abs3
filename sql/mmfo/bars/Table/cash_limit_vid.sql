

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_LIMIT_VID.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_LIMIT_VID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_LIMIT_VID'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_LIMIT_VID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_LIMIT_VID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_LIMIT_VID ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_LIMIT_VID 
   (	VID VARCHAR2(1), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_LIMIT_VID ***
 exec bpa.alter_policies('CASH_LIMIT_VID');


COMMENT ON TABLE BARS.CASH_LIMIT_VID IS '';
COMMENT ON COLUMN BARS.CASH_LIMIT_VID.VID IS '';
COMMENT ON COLUMN BARS.CASH_LIMIT_VID.NAME IS '';




PROMPT *** Create  constraint XPK_CASH_LIMIT_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LIMIT_VID ADD CONSTRAINT XPK_CASH_LIMIT_VID PRIMARY KEY (VID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CASH_LIMIT_VID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CASH_LIMIT_VID ON BARS.CASH_LIMIT_VID (VID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_LIMIT_VID ***
grant SELECT                                                                 on CASH_LIMIT_VID  to BARSREADER_ROLE;
grant SELECT                                                                 on CASH_LIMIT_VID  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_LIMIT_VID  to BARS_DM;
grant SELECT                                                                 on CASH_LIMIT_VID  to RPBN001;
grant SELECT                                                                 on CASH_LIMIT_VID  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_LIMIT_VID.sql =========*** End **
PROMPT ===================================================================================== 
