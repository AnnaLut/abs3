

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FM_TURN_TMP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FM_TURN_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FM_TURN_TMP'', ''CENTER'' , ''C'', ''C'', ''C'', null);
               bpa.alter_policy_info(''FM_TURN_TMP'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''FM_TURN_TMP'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FM_TURN_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.FM_TURN_TMP 
   (	ACC NUMBER(38,0), 
	DK CHAR(1), 
	S NUMBER(24,0), 
	SQ NUMBER(24,0)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FM_TURN_TMP ***
 exec bpa.alter_policies('FM_TURN_TMP');


COMMENT ON TABLE BARS.FM_TURN_TMP IS '';
COMMENT ON COLUMN BARS.FM_TURN_TMP.ACC IS '';
COMMENT ON COLUMN BARS.FM_TURN_TMP.DK IS '';
COMMENT ON COLUMN BARS.FM_TURN_TMP.S IS '';
COMMENT ON COLUMN BARS.FM_TURN_TMP.SQ IS '';



PROMPT *** Create  grants  FM_TURN_TMP ***
grant SELECT                                                                 on FM_TURN_TMP     to BARSREADER_ROLE;
grant SELECT                                                                 on FM_TURN_TMP     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FM_TURN_TMP     to BARS_DM;
grant SELECT                                                                 on FM_TURN_TMP     to START1;
grant SELECT                                                                 on FM_TURN_TMP     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FM_TURN_TMP.sql =========*** End *** =
PROMPT ===================================================================================== 
