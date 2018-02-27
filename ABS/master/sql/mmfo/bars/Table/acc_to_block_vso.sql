

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_TO_BLOCK_VSO.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_TO_BLOCK_VSO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_TO_BLOCK_VSO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_TO_BLOCK_VSO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_TO_BLOCK_VSO ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_TO_BLOCK_VSO 
   (	ACC NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_TO_BLOCK_VSO ***
 exec bpa.alter_policies('ACC_TO_BLOCK_VSO');


COMMENT ON TABLE BARS.ACC_TO_BLOCK_VSO IS '';
COMMENT ON COLUMN BARS.ACC_TO_BLOCK_VSO.ACC IS '';

begin   
 execute immediate '
  alter table BARS.ACC_TO_BLOCK_VSO
  add constraint PK_ACC_TO_BLOCK_VSO primary key (ACC)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  ACC_TO_BLOCK_VSO ***
grant SELECT                                                                 on ACC_TO_BLOCK_VSO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_TO_BLOCK_VSO.sql =========*** End 
PROMPT ===================================================================================== 
