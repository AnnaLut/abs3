

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_DEL3.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_DEL3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_DEL3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_DEL3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_DEL3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_DEL3 
   (	ID NUMBER(38,0), 
	FIO VARCHAR2(60)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_DEL3 ***
 exec bpa.alter_policies('ANI_DEL3');


COMMENT ON TABLE BARS.ANI_DEL3 IS '';
COMMENT ON COLUMN BARS.ANI_DEL3.ID IS '';
COMMENT ON COLUMN BARS.ANI_DEL3.FIO IS '';




PROMPT *** Create  constraint SYS_C006237 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI_DEL3 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANI_DEL3 ***
grant SELECT                                                                 on ANI_DEL3        to BARSREADER_ROLE;
grant SELECT                                                                 on ANI_DEL3        to BARS_DM;
grant SELECT                                                                 on ANI_DEL3        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_DEL3.sql =========*** End *** ====
PROMPT ===================================================================================== 
