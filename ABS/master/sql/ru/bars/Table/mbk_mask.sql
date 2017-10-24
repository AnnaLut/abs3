

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MBK_MASK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MBK_MASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MBK_MASK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MBK_MASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MBK_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.MBK_MASK 
   (	ID VARCHAR2(10), 
	MASK VARCHAR2(250), 
	DESCR VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MBK_MASK ***
 exec bpa.alter_policies('MBK_MASK');


COMMENT ON TABLE BARS.MBK_MASK IS '';
COMMENT ON COLUMN BARS.MBK_MASK.ID IS '';
COMMENT ON COLUMN BARS.MBK_MASK.MASK IS '';
COMMENT ON COLUMN BARS.MBK_MASK.DESCR IS '';




PROMPT *** Create  constraint NK_MBK_MASK_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.MBK_MASK MODIFY (ID CONSTRAINT NK_MBK_MASK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MBK_MASK ***
grant SELECT                                                                 on MBK_MASK        to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MBK_MASK.sql =========*** End *** ====
PROMPT ===================================================================================== 
