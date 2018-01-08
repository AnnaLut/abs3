

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_STMT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_STMT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_STMT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_STMT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_STMT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_STMT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_STMT 
   (	MT NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_STMT ***
 exec bpa.alter_policies('SW_STMT');


COMMENT ON TABLE BARS.SW_STMT IS 'SWT. Типы выписок';
COMMENT ON COLUMN BARS.SW_STMT.MT IS 'Код типа сообщения';




PROMPT *** Create  constraint PK_SWSTMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT ADD CONSTRAINT PK_SWSTMT PRIMARY KEY (MT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWSTMT_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT ADD CONSTRAINT FK_SWSTMT_SWMT FOREIGN KEY (MT)
	  REFERENCES BARS.SW_MT (MT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSTMT_MT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_STMT MODIFY (MT CONSTRAINT CC_SWSTMT_MT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWSTMT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWSTMT ON BARS.SW_STMT (MT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_STMT ***
grant SELECT                                                                 on SW_STMT         to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_STMT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_STMT         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_STMT         to SWIFT001;
grant SELECT                                                                 on SW_STMT         to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_STMT         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SW_STMT         to WR_REFREAD;



PROMPT *** Create SYNONYM  to SW_STMT ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_STMT FOR BARS.SW_STMT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_STMT.sql =========*** End *** =====
PROMPT ===================================================================================== 
