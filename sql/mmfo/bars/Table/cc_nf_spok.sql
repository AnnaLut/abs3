

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_NF_SPOK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_NF_SPOK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_NF_SPOK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_NF_SPOK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_NF_SPOK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_NF_SPOK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_NF_SPOK 
   (	ID NUMBER, 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_NF_SPOK ***
 exec bpa.alter_policies('CC_NF_SPOK');


COMMENT ON TABLE BARS.CC_NF_SPOK IS '';
COMMENT ON COLUMN BARS.CC_NF_SPOK.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.CC_NF_SPOK.NAME IS 'Наименование отдела';




PROMPT *** Create  constraint SYS_C0011219 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_NF_SPOK ADD UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011219 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011219 ON BARS.CC_NF_SPOK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_NF_SPOK ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_NF_SPOK      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_NF_SPOK      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_NF_SPOK      to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on CC_NF_SPOK      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_NF_SPOK.sql =========*** End *** ==
PROMPT ===================================================================================== 
