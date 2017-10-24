

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T31_KWT_2924.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T31_KWT_2924 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T31_KWT_2924'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T31_KWT_2924'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T31_KWT_2924 ***
begin 
  execute immediate '
  CREATE TABLE BARS.T31_KWT_2924 
   (	ACC NUMBER, 
	FDAT DATE, 
	REF NUMBER, 
	S NUMBER, 
	TT2 CHAR(3), 
	RKW NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T31_KWT_2924 ***
 exec bpa.alter_policies('T31_KWT_2924');


COMMENT ON TABLE BARS.T31_KWT_2924 IS '';
COMMENT ON COLUMN BARS.T31_KWT_2924.ACC IS '';
COMMENT ON COLUMN BARS.T31_KWT_2924.FDAT IS '';
COMMENT ON COLUMN BARS.T31_KWT_2924.REF IS '';
COMMENT ON COLUMN BARS.T31_KWT_2924.S IS '';
COMMENT ON COLUMN BARS.T31_KWT_2924.TT2 IS '';
COMMENT ON COLUMN BARS.T31_KWT_2924.RKW IS '';



PROMPT *** Create  grants  T31_KWT_2924 ***
grant SELECT                                                                 on T31_KWT_2924    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T31_KWT_2924.sql =========*** End *** 
PROMPT ===================================================================================== 
