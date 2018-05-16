PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POCI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POCI ***
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''POCI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''POCI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''POCI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POCI ***
begin 
  execute immediate '
CREATE TABLE BARS.POCI
( ID    number,
  NAME  VARCHAR2(50)
) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON TABLE BARS.POCI IS 'Придбані (створені) знецінені активи "POCI"';

COMMENT ON COLUMN BARS.POCI.ID IS 'Значення параметр';

COMMENT ON COLUMN BARS.POCI.NAME IS 'Опис параметра';


PROMPT *** Create  constraint PK_POCI ***
begin   
 execute immediate '
  ALTER TABLE BARS.POCI  ADD CONSTRAINT PK_POCI PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  POCI ***
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.POCI TO BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POCI.sql =========*** End *** =====
PROMPT ===================================================================================== 