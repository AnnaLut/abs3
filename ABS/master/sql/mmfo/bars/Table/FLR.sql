PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FLOATING_RATE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FLR ***
BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FLR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FLR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FLR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FLR ***
begin 
  execute immediate '
CREATE TABLE BARS.FLR
( FLR_ID    VARCHAR2(10) NOT NULL,
  FLR_NAME  VARCHAR2(50)
) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON TABLE BARS.FLR IS 'Тип ставки FLR';

COMMENT ON COLUMN BARS.FLR.FLR_ID IS 'Параметр';

COMMENT ON COLUMN BARS.FLR.FLR_NAME IS 'Наименование параметра';


PROMPT *** Create  constraint PK_FLR ***
begin   
 execute immediate '
  ALTER TABLE BARS.FLR  ADD CONSTRAINT PK_FLR PRIMARY KEY (FLR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  FLR ***
GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.FLR TO BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FLR.sql =========*** End *** =====
PROMPT ===================================================================================== 