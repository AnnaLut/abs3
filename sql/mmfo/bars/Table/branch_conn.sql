

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_CONN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_CONN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_CONN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_CONN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_CONN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_CONN ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_CONN 
   (	BRANCH VARCHAR2(30), 
	FLAG_ CHAR(10), 
	KEY_TYPE CHAR(10), 
	KEY_VALUE VARCHAR2(100), 
	COMMENTS VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_CONN ***
 exec bpa.alter_policies('BRANCH_CONN');


COMMENT ON TABLE BARS.BRANCH_CONN IS ' Описание ключей подразделения ';
COMMENT ON COLUMN BARS.BRANCH_CONN.BRANCH IS ' Код подразделения банка ';
COMMENT ON COLUMN BARS.BRANCH_CONN.FLAG_ IS ' Признак OFF /ON line';
COMMENT ON COLUMN BARS.BRANCH_CONN.KEY_TYPE IS ' Тип ключа ';
COMMENT ON COLUMN BARS.BRANCH_CONN.KEY_VALUE IS ' Значение ключа ';
COMMENT ON COLUMN BARS.BRANCH_CONN.COMMENTS IS ' Комментарии ';




PROMPT *** Create  constraint BRANCH_CONN_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_CONN ADD CONSTRAINT BRANCH_CONN_PK PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHCONN_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_CONN MODIFY (BRANCH CONSTRAINT CC_BRANCHCONN_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BRANCH_CONN_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.BRANCH_CONN_PK ON BARS.BRANCH_CONN (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_CONN ***
grant SELECT                                                                 on BRANCH_CONN     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_CONN     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_CONN     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH_CONN     to START1;
grant SELECT                                                                 on BRANCH_CONN     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_CONN     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BRANCH_CONN     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_CONN.sql =========*** End *** =
PROMPT ===================================================================================== 
