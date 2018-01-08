

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VQB_VISIBILITY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VQB_VISIBILITY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VQB_VISIBILITY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VQB_VISIBILITY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VQB_VISIBILITY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VQB_VISIBILITY ***
begin 
  execute immediate '
  CREATE TABLE BARS.VQB_VISIBILITY 
   (	USER_ID NUMBER, 
	TABLE_NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VQB_VISIBILITY ***
 exec bpa.alter_policies('VQB_VISIBILITY');


COMMENT ON TABLE BARS.VQB_VISIBILITY IS '';
COMMENT ON COLUMN BARS.VQB_VISIBILITY.USER_ID IS '';
COMMENT ON COLUMN BARS.VQB_VISIBILITY.TABLE_NAME IS '';




PROMPT *** Create  constraint PK_VQB_VISIBILITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.VQB_VISIBILITY ADD CONSTRAINT PK_VQB_VISIBILITY PRIMARY KEY (USER_ID, TABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VQB_VISIBILITY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VQB_VISIBILITY ON BARS.VQB_VISIBILITY (USER_ID, TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VQB_VISIBILITY ***
grant SELECT                                                                 on VQB_VISIBILITY  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VQB_VISIBILITY  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VQB_VISIBILITY  to BARS_DM;
grant SELECT                                                                 on VQB_VISIBILITY  to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on VQB_VISIBILITY  to VQB_VISIBILITY;
grant FLASHBACK,SELECT                                                       on VQB_VISIBILITY  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VQB_VISIBILITY.sql =========*** End **
PROMPT ===================================================================================== 
