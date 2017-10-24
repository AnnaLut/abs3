

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T_KWT_2924.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T_KWT_2924 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T_KWT_2924'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T_KWT_2924'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T_KWT_2924 ***
begin 
  execute immediate '
  CREATE TABLE BARS.T_KWT_2924 
   (	ACC NUMBER, 
	FDAT DATE, 
	REF NUMBER, 
	S NUMBER, 
	TT2 CHAR(3), 
	RKW NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T_KWT_2924 ***
 exec bpa.alter_policies('T_KWT_2924');


COMMENT ON TABLE BARS.T_KWT_2924 IS '';
COMMENT ON COLUMN BARS.T_KWT_2924.ACC IS '';
COMMENT ON COLUMN BARS.T_KWT_2924.FDAT IS '';
COMMENT ON COLUMN BARS.T_KWT_2924.REF IS '';
COMMENT ON COLUMN BARS.T_KWT_2924.S IS '';
COMMENT ON COLUMN BARS.T_KWT_2924.TT2 IS '';
COMMENT ON COLUMN BARS.T_KWT_2924.RKW IS '';




PROMPT *** Create  index I1_TKWT2924 ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_TKWT2924 ON BARS.T_KWT_2924 (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T_KWT_2924.sql =========*** End *** ==
PROMPT ===================================================================================== 
