----------------------- �������-�������� ����� ��� KWT_T_2924

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KWT_T_2924.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KWT_T_2924 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KWT_T_2924'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KWT_T_2924'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KWT_T_2924 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KWT_T_2924 
   (	ACC NUMBER, 
	FDAT DATE, 
	REF NUMBER, 
	S NUMBER, 
	TT2 CHAR(3), 
	RKW NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KWT_T_2924 ***
 exec bpa.alter_policies('KWT_T_2924');


COMMENT ON TABLE BARS.KWT_T_2924 IS '';
COMMENT ON COLUMN BARS.KWT_T_2924.ACC IS '';
COMMENT ON COLUMN BARS.KWT_T_2924.FDAT IS '';
COMMENT ON COLUMN BARS.KWT_T_2924.REF IS '';
COMMENT ON COLUMN BARS.KWT_T_2924.S IS '';
COMMENT ON COLUMN BARS.KWT_T_2924.TT2 IS '';
COMMENT ON COLUMN BARS.KWT_T_2924.RKW IS '';




PROMPT *** Create  index I1_TKWT2924 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_TKWT2924 ON BARS.KWT_T_2924 (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KWT_T_2924.sql =========*** End *** ==
PROMPT ===================================================================================== 
