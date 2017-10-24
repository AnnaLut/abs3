

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_AGRW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_AGRW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_AGRW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_AGRW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_AGRW ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_AGRW 
   (	AGREEMENT_ID NUMBER, 
	TAG_ID NUMBER, 
	VALUE VARCHAR2(150)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_AGRW ***
 exec bpa.alter_policies('DPT_AGRW');


COMMENT ON TABLE BARS.DPT_AGRW IS '';
COMMENT ON COLUMN BARS.DPT_AGRW.AGREEMENT_ID IS '';
COMMENT ON COLUMN BARS.DPT_AGRW.TAG_ID IS '';
COMMENT ON COLUMN BARS.DPT_AGRW.VALUE IS '';




PROMPT *** Create  constraint SYS_C002446754 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGRW MODIFY (TAG_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002446753 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_AGRW MODIFY (AGREEMENT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_AGRW ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_AGRW        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_AGRW.sql =========*** End *** ====
PROMPT ===================================================================================== 
