

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_ACC_OLD.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_ACC_OLD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_ACC_OLD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ND_ACC_OLD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_ACC_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_ACC_OLD 
   (	ND NUMBER, 
	ACC NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_ACC_OLD ***
 exec bpa.alter_policies('ND_ACC_OLD');


COMMENT ON TABLE BARS.ND_ACC_OLD IS '';
COMMENT ON COLUMN BARS.ND_ACC_OLD.ND IS '';
COMMENT ON COLUMN BARS.ND_ACC_OLD.ACC IS '';




PROMPT *** Create  constraint XPK_NDACCOLD ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_ACC_OLD ADD CONSTRAINT XPK_NDACCOLD PRIMARY KEY (ND, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NDACCOLD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NDACCOLD ON BARS.ND_ACC_OLD (ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_ACC_OLD ***
grant SELECT                                                                 on ND_ACC_OLD      to BARSREADER_ROLE;
grant SELECT                                                                 on ND_ACC_OLD      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_ACC_OLD.sql =========*** End *** ==
PROMPT ===================================================================================== 
