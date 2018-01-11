

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BSZ.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BSZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BSZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BSZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BSZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BSZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.BSZ 
   (	IDZ NUMBER(38,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BSZ ***
 exec bpa.alter_policies('BSZ');


COMMENT ON TABLE BARS.BSZ IS 'Папки показникiв "Балансу"';
COMMENT ON COLUMN BARS.BSZ.IDZ IS 'Код папки';
COMMENT ON COLUMN BARS.BSZ.NAME IS 'Назва папки';




PROMPT *** Create  constraint SYS_C005090 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSZ MODIFY (IDZ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BSZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSZ ADD CONSTRAINT XPK_BSZ PRIMARY KEY (IDZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BSZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BSZ ON BARS.BSZ (IDZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BSZ ***
grant SELECT                                                                 on BSZ             to BARSREADER_ROLE;
grant SELECT                                                                 on BSZ             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BSZ             to BARS_DM;
grant SELECT                                                                 on BSZ             to SALGL;
grant SELECT                                                                 on BSZ             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BSZ.sql =========*** End *** =========
PROMPT ===================================================================================== 
