

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VID_9129.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VID_9129 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VID_9129'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VID_9129'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VID_9129'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VID_9129 ***
begin 
  execute immediate '
  CREATE TABLE BARS.VID_9129 
   (	VIDD_9129 NUMBER, 
	NAM VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VID_9129 ***
 exec bpa.alter_policies('VID_9129');


COMMENT ON TABLE BARS.VID_9129 IS '';
COMMENT ON COLUMN BARS.VID_9129.VIDD_9129 IS '';
COMMENT ON COLUMN BARS.VID_9129.NAM IS '';




PROMPT *** Create  constraint XPK_VID_9129 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VID_9129 ADD CONSTRAINT XPK_VID_9129 PRIMARY KEY (VIDD_9129)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005380 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VID_9129 MODIFY (VIDD_9129 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_VID_9129 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_VID_9129 ON BARS.VID_9129 (VIDD_9129) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VID_9129 ***
grant SELECT                                                                 on VID_9129        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VID_9129        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VID_9129        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on VID_9129        to RCC_DEAL;
grant SELECT                                                                 on VID_9129        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VID_9129        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VID_9129.sql =========*** End *** ====
PROMPT ===================================================================================== 
