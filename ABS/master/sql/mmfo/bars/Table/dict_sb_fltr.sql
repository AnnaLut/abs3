

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DICT_SB_FLTR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DICT_SB_FLTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DICT_SB_FLTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DICT_SB_FLTR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DICT_SB_FLTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DICT_SB_FLTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.DICT_SB_FLTR 
   (	GROUPID NUMBER(*,0), 
	LEVELID NUMBER(*,0), 
	LEVELNAME VARCHAR2(200), 
	FILTER VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DICT_SB_FLTR ***
 exec bpa.alter_policies('DICT_SB_FLTR');


COMMENT ON TABLE BARS.DICT_SB_FLTR IS '';
COMMENT ON COLUMN BARS.DICT_SB_FLTR.GROUPID IS '';
COMMENT ON COLUMN BARS.DICT_SB_FLTR.LEVELID IS '';
COMMENT ON COLUMN BARS.DICT_SB_FLTR.LEVELNAME IS '';
COMMENT ON COLUMN BARS.DICT_SB_FLTR.FILTER IS '';



PROMPT *** Create  grants  DICT_SB_FLTR ***
grant SELECT                                                                 on DICT_SB_FLTR    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DICT_SB_FLTR    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DICT_SB_FLTR    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DICT_SB_FLTR    to START1;
grant SELECT                                                                 on DICT_SB_FLTR    to UPLD;
grant FLASHBACK,SELECT                                                       on DICT_SB_FLTR    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DICT_SB_FLTR.sql =========*** End *** 
PROMPT ===================================================================================== 
