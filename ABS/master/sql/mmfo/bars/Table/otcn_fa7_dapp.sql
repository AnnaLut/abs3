

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_DAPP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FA7_DAPP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FA7_DAPP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FA7_DAPP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FA7_DAPP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FA7_DAPP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FA7_DAPP 
   (	ACC NUMBER(38,0), 
	DAPP DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FA7_DAPP ***
 exec bpa.alter_policies('OTCN_FA7_DAPP');


COMMENT ON TABLE BARS.OTCN_FA7_DAPP IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_DAPP.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_DAPP.DAPP IS '';




PROMPT *** Create  constraint SYS_C0010168 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FA7_DAPP MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IX_OTCN_FA7_DAPP ***
begin   
 execute immediate '
  CREATE INDEX BARS.IX_OTCN_FA7_DAPP ON BARS.OTCN_FA7_DAPP (ACC) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_FA7_DAPP ***
grant SELECT                                                                 on OTCN_FA7_DAPP   to BARSREADER_ROLE;
grant SELECT                                                                 on OTCN_FA7_DAPP   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_DAPP.sql =========*** End ***
PROMPT ===================================================================================== 
