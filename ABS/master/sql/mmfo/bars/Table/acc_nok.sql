

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_NOK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_NOK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_NOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_NOK 
   (	ACC NUMBER(*,0), 
	XXX CHAR(3)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_NOK ***
 exec bpa.alter_policies('ACC_NOK');


COMMENT ON TABLE BARS.ACC_NOK IS '';
COMMENT ON COLUMN BARS.ACC_NOK.ACC IS '';
COMMENT ON COLUMN BARS.ACC_NOK.XXX IS '';




PROMPT *** Create  constraint XPK_ACC_NOK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_NOK ADD CONSTRAINT XPK_ACC_NOK PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACC_NOK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACC_NOK ON BARS.ACC_NOK (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_NOK ***
grant SELECT                                                                 on ACC_NOK         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_NOK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_NOK         to BARS_DM;
grant SELECT                                                                 on ACC_NOK         to UPLD;
grant FLASHBACK,SELECT                                                       on ACC_NOK         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_NOK.sql =========*** End *** =====
PROMPT ===================================================================================== 
