prompt ... 

delete from BARS.META_CALL_SETTINGS where CODE ='UPLOAD_EXCEL_NBUR_OVDP_6EX';

begin
    execute immediate 'Insert into BARS.META_CALL_SETTINGS
   (ID, CODE, CALL_FROM, WEB_FORM_NAME, INSERT_AFTER, 
    EDIT_MODE, SUMM_VISIBLE, ADD_WITH_WINDOW, SWITCH_OF_DEPS, SHOW_COUNT,custom_options  )
 Values
   (12, ''UPLOAD_EXCEL_NBUR_OVDP_6EX'', ''FREE'', ''[CUSTOM_OPTIONS_TO_CLASS=>CallFunctionMetaInfo]'', 0, 
    ''ROW_EDIT'', 0, 0, 0, 0,

''{"isFuncOnly":true,"PROC_NAME":"BARS.p_nbur_ovdp_6ex_ins(:p_clob,:p_message)","DESCR":"","PROC_EXEC":"BEFORE","OutParams":":p_message(SEM=Помилка,TYPE=MESSAGE)","OutParamsInfo":[{"ColumnInfo":null,"ColName":"p_message","GetFrom":null,"ColType":"MESSAGE","IsInput":false,"Semantic":"Помилка","FileForBackend":false}],"ConvertParamsInfo":null,"ConvertParams":null,"MultiParams":":p_clob(KIND=FROM_UPLOAD_EXCEL,TYPE=CLOB,GET_FROM=EXCEL_FILE,COL_NAMES_FROM=CUSTOM_OPTIONS)","MultiRowsParams":[{"ColName":"p_clob","GetFrom":"EXCEL_FILE","IsInput":false,"SemanticRowNumber":1,"Kind":"FROM_UPLOAD_EXCEL"}],"CUSTOM_OPTIONS":" [{  \"Value\":\"DATE_FV\" , \"Name\":\"Дата, на яку розрахована справедлива вартість\" },{  \"Value\":\"ISIN\" , \"Name\":\"ISIN\" },{  \"Value\":\"KV\" , \"Name\":\"Валюта номіналу цінного папера\" }, {  \"Value\":\"FV_CP\" , \"Name\":\"Справедлива вартість одного цінного папера з урахуванням накопиченого купонного доходу, у валюті номіналу\" },{  \"Value\":\"YIELD\" , \"Name\":\"Дохідність до погашення, %\" },{  \"Value\":\"KURS\" , \"Name\":\"Курс цінного папера без урахування накопиченого купонного доходу, %\" },{  \"Value\":\"KOEF\" , \"Name\":\"Коригуючий коефіцієнт\" },{\"Value\":\"DATE_MATURITY\" , \"Name\":\"Дата погашення\" }]"}''


)';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
