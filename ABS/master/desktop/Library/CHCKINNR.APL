.head 0 +  Application Description: +----------------------------------------+
| CHECKINNR.APL - Приложение внутреннего |
|                 контролера банка       |
|----------------------------------------|
| Разработчик: Сыропоршнев Д.Л.          |
| Unity-Bars, Ltd. (c) 1999-2004         |
+----------------------------------------+
.head 1 -  Outline Version - 4.0.26
.head 1 +  Design-time Settings
.data VIEWINFO
0000: 6F00000001000000 FFFF01000D004347 5458566965775374 6174650400010000
0020: 0000000000A40000 002C000000020000 0003000000000000 00CF010000F8FFFF
0040: FFE2FFFFFFFFFFFF FF000000007C0200 004D010000010000 0000000000010000
0060: 000F4170706C6963 6174696F6E497465 6D01000000075769 6E646F7773
.enddata
.data DT_MAKERUNDLG
0000: 02000000001E513A 5C4241525339385C 4C4942524152595C 4348434B494E4E52
0020: 2E6578651E513A5C 4241525339385C4C 4942524152595C43 48434B494E4E522E
0040: 646C6C1E513A5C42 41525339385C4C49 42524152595C4348 434B494E4E522E61
0060: 706300000101011E 513A5C4241525339 385C4C4942524152 595C4348434B494E
0080: 4E522E72756E1E51 3A5C424152533938 5C4C494252415259 5C4348434B494E4E
00A0: 522E646C6C1E513A 5C4241525339385C 4C4942524152595C 4348434B494E4E52
00C0: 2E61706300000101 01185C4241525339 385C42494E5C4348 434B494E4E522E41
00E0: 5044185C42415253 39385C42494E5C43 48434B494E4E522E 646C6C185C424152
0100: 5339385C42494E5C 4348434B494E4E52 2E61706300000101 011E513A5C424152
0120: 5339385C4C494252 4152595C4348434B 494E4E522E61706C 1E513A5C42415253
0140: 39385C4C49425241 52595C4348434B49 4E4E522E646C6C1E 513A5C4241525339
0160: 385C4C4942524152 595C4348434B494E 4E522E6170630000 010101
.enddata
.head 2 -  Outline Window State: Normal
.head 2 +  Outline Window Location and Size
.data VIEWINFO
0000: 6600040003002D00 0000000000000000 0000B71E5D0E0500 1D00FFFF4D61696E
0020: 0000000000000000 0000000000000000 0000003B00010000 00000000000000E9
0040: 1E800A00008600FF FF496E7465726E61 6C2046756E637469 6F6E730000000000
0060: 0000000000000000 0000000000003200 0100000000000000 0000E91E800A0000
0080: DF00FFFF56617269 61626C6573000000 0000000000000000 0000000000000000
00A0: 3000010000000000 00000000F51E100D 0000F400FFFF436C 6173736573000000
00C0: 0000000000000000 0000000000000000
.enddata
.data VIEWSIZE
0000: D000
.enddata
.head 3 -  Left:   -0.013"
.head 3 -  Top:    0.0"
.head 3 -  Width:  8.013"
.head 3 -  Height: 4.969"
.head 2 +  Options Box Location
.data VIEWINFO
0000: 0818B80BB80B2500
.enddata
.data VIEWSIZE
0000: 0800
.enddata
.head 3 -  Visible? Yes
.head 3 -  Left:   4.15"
.head 3 -  Top:    1.885"
.head 3 -  Width:  3.8"
.head 3 -  Height: 2.073"
.head 2 +  Class Editor Location
.head 3 -  Visible? No
.head 3 -  Left:   0.575"
.head 3 -  Top:    0.094"
.head 3 -  Width:  5.063"
.head 3 -  Height: 2.719"
.head 2 +  Tool Palette Location
.head 3 -  Visible? No
.head 3 -  Left:   6.388"
.head 3 -  Top:    0.729"
.head 2 -  Fully Qualified External References? Yes
.head 2 -  Reject Multiple Window Instances? No
.head 2 -  Enable Runtime Checks Of External References? Yes
.head 2 -  Use Release 4.0 Scope Rules? No
.head 1 +  Libraries
.head 2 -  File Include: Gencheck.apl
.head 2 -  File Include: Genfcls.apl
.head 2 -  File Include: Docfun6.apl
.head 2 -  File Include: Genlist.apl
.head 2 -  File Include: Gentimer.apl
.head 2 -  File Include: Gentbl.apl
.head 2 -  File Include: Xsalspl.apl
.head 2 -  File Include: Xsalimg.apl
.head 2 -  File Include: Xsalcpt.apl
.head 2 -  Dynalib: Message.apd
.head 2 -  Dynalib: Nsiapi.apd
.head 2 -  Dynalib: Service.apd
.head 1 +  Global Declarations
.head 2 +  Window Defaults
.head 3 +  Tool Bar
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Form Window
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Dialog Box
.head 4 -  Display Style? Etched
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: System Default
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Default
.head 3 +  Top Level Table Window
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: System Default
.head 4 -  Background Color: System Window Color
.head 3 +  Data Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Multiline Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Spin Field
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Background Text
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Pushbutton
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 3 +  Radio Button
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Check Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Option Button
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 3 +  Group Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Child Table Window
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: System Window Color
.head 3 +  List Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Combo Box
.head 4 -  Font Name: Use Parent
.head 4 -  Font Size: Use Parent
.head 4 -  Font Enhancement: Use Parent
.head 4 -  Text Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 3 +  Line
.head 4 -  Line Color: Use Parent
.head 3 +  Frame
.head 4 -  Border Color: Use Parent
.head 4 -  Background Color: 3D Face Color
.head 3 +  Picture
.head 4 -  Border Color: Use Parent
.head 4 -  Background Color: Use Parent
.head 2 +  Formats
.head 3 -  Number: 0'%'
.head 3 -  Number: #0
.head 3 -  Number: ###000
.head 3 -  Number: ###000;'($'###000')'
.head 3 -  Date/Time: hh:mm:ss AMPM
.head 3 -  Date/Time: M/d/yy
.head 3 -  Date/Time: MM-dd-yy
.head 3 -  Date/Time: dd-MMM-yyyy
.head 3 -  Date/Time: MMM d, yyyy
.head 3 -  Date/Time: MMM d, yyyy hh:mm AMPM
.head 3 -  Date/Time: MMMM d, yyyy hh:mm AMPM
.head 3 -  Number: ###000
.head 3 -  Date/Time: dd-MM-yyyy
.head 3 -  Input: 99/99/9999
.head 3 -  Input: 99.99.9999
.head 3 -  Date/Time: dd.MM.yyyy
.head 2 +  External Functions
.head 2 +  Constants
.data CCDATA
0000: 3000000000000000 0000000000000000 00000000
.enddata
.data CCSIZE
0000: 1400
.enddata
.head 3 +  System
.head 3 +  User
.head 2 +  Resources
.head 2 +  Variables
.head 3 -  Boolean: fInitLib        ! Флаг инициализации библиотеки
.head 3 -  Number: nBackKvit        ! Флаг формирования квитанции D при сторнировании документа
.head 3 -  String: strPathD
.head 3 -  : cDocChk		 ! Текущий экземпляр документа
.head 4 -  Class: cDoc
.head 3 -  Number: n2Pay     ! Флаги    1 - можно платить на визе
.head 3 -  Number: n2Sig     !          2 или 3 - надо подписывать подписью СЕП
.head 3 -  Window Handle: hWndDocCheck
.head 3 -  Window Handle: hWndDocVr
.head 3 -  Boolean: bFUNCHK1
.head 2 +  Internal Functions
.head 3 +  Function: Chckinnr_Init
.head 4 -  Description: Инициализация лингвистической таблицы и прочего
для библиотеки
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strPathToLangResources
.head 5 -  String: strLangId
.head 5 -  !
.head 5 -  String: strFileName
.head 4 +  Actions
.head 5 +  If NOT fInitLib
.head 6 -  ! Открывать только одно окно визирования документов
.head 6 -  Set bFUNCHK1 = GetGlobalOptionEx('FUNCHK1')=1
.head 6 -  ! Формировать квитанцию D?
.head 6 -  Call SalUseRegistry(FALSE, '')
.head 6 -  Set nBackKvit = SalGetProfileInt(INI_ElektroKlients, 'NOKK_BackKvit', 0, GetIniFileName())
.head 6 -  Call SalGetProfileString(INI_ElektroKlients, 'NOKK_DPath', GetPrnDir(), strPathD, GetIniFileName())
.head 6 -  !
.head 6 -  ! Инициализация LNG-файла
.head 6 -  Set bStaticsAsWindows=TRUE
.head 6 -  Set strPathToLangResources = GetLangPath()
.head 6 -  Set strLangId = GetLang()
.head 6 -  Set strFileName = strPathToLangResources || "\\" || strLangId || "\\chckinnr.lng"
.head 6 -  !
.head 6 +  If (NOT strLangId) OR (NOT CurrentLangTable.InitFromFile( strFileName, strLangId ))
.head 7 -  Call CurrentLangTable.Init()
.head 7 -  ! ====================================================
.head 7 -  Call CurrentLangTable.AddAtom('cTTitleAt','Внимание!')
.head 7 -  Call CurrentLangTable.AddAtom('cTTitleError','Ошибка!')
.head 7 -  Call CurrentLangTable.AddAtom('cTTitleControl','Контроль')
.head 7 -  Call CurrentLangTable.AddAtom('cTTitleTechnErr','Нарушение технологии')
.head 7 -  ! ====================================================
.head 7 -  Call CurrentLangTable.AddAtom('cTMessNotFoundSelfVisa','Не задано в параметрах АБС значение кода группы самовизирования!')
.head 7 -  Call CurrentLangTable.AddAtom('cTMessNotUserMentor','Пользователь не обладает правами Контролера платежей')
.head 7 -  Call CurrentLangTable.AddAtom('cTMessToLogBackPrevVisaGrp','Возврат документа на предыдущую группу визирования.')
.head 7 -  ! ====================================================
.head 7 -  ! DocumentCheck
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogPrevVisaSignErr','Неверная подпись предыдущей группы визирования')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessPrevVisaSignErr','Подпись предыдущей группы визирования неверна!')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessErrInitECP','Ошибка инициализации')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessQuestionBackPrevVisa','Возвратить документ на повторное визирование?')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogBackPrevVisa','Возврат документа на повторное визирование.')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogSignErr','Неверная подпись на документе')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessErrReturnCode','Нерасчетный код возврата!')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessSetVisa1','На документ')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessSetVisa2','накладывается виза наивысшего приоритета. Визировать?')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogPFac','Фактическая оплата документа')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessQuestionRepeatPay','Повторить процедуру оплаты?')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogNotPay','Пользователь отказался от оплаты документа')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessDocState1','Состояние документа')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessDocState2','не соответсвует начальным условиям визирования.')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessDocState3','Возможно документ уже завизирован другим пользователем.')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogOldInfo1','Обнаружена устаревшая информция о документе')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogOldInfo2','Документ не обрабатывается.')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogRepeatPayDoc','Повторная попытка оплаты документа')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessQuestionVisaCancel','Отменить операцию визирования?')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessVisaCancel','Пользователь прервал цикл визирования документов...')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessErrSetVisa','Не удалось подписать визу')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogSetVisaOk1','Документ')
.head 7 -  Call CurrentLangTable.AddAtom('DocumentCheck.cTMessToLogSetVisaOk2','ЗАВИЗИРОВАН')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_ChkGroupSelect
.head 7 -  Call CurrentLangTable.AddAtom('dlg_ChkGroupSelect.cTWndTitle','Группы контроля платежей')
.head 7 -  ! button 
.head 7 -  Call CurrentLangTable.AddAtom('dlg_ChkGroupSelect.pbSelect','Выбрать')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_ChkGroupSelect.pbAbort', 'Отменить')
.head 7 -  ! ====================================================
.head 7 -  ! frmCheckInner
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTWndTitle','Неоплаченые документы на контроле')
.head 7 -  ! error text
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTErr','Ошибка')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTErrFormD','Ошибка формирования квитанции D для док.')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTErrSignStorno','Не удалось подписать сторно операцию!')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTErrReason','Причина отказа не была выбрана или пуста! Повторите операцию.')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTErrStorno','Сторно документов, ошибка')
.head 7 -  ! message text
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessQuestionVisa','Будут визированы все отмеченные документы. Продолжать?')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessExecDoc',     'Обрабатывается документ')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessInfo',        'Информация в таблице устарела! Рекомнедуем регулярно обновлять ее.')
.head 7 -  ! Call CurrentLangTable.AddAtom('frmCheckInner.cTMessTechn',       'Нарушение технологии')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessOldInfo',     'Обнаружена устаревшая информция в форме визирования. Выход из цикла обработки.')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessDoc',         'Документ')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessDoc1',        'не может быть завизирован данным пользователем')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessDoc2',        'не найден!')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessNoVisa',      'Отказ в визировании документа')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessSelfVisa',    'Попытка визировать свой документ!')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessQuestionBack','Вы уверены, что хотите возвратить отмеченные документы плательщику?')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessStorno',      'Сторно документов')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessBack',        'Возврат документа отправителю')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessVisa',        'Виза группы')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessQuestion1StepBack','Вы уверены, что хотите возвратить отмеченные документы на предыдущую группу визирования?')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMess1',           'Перераспределение')
.head 7 -  Call CurrentLangTable.AddAtom('frmCheckInner.cTMessErrSaveVisa', 'неможливо зберегти дані візування')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_LinkedDocs
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.cTWndTitle','Підпорядковані документи для документа з реф.')
.head 7 -  ! column
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.tblSubDoc.colRef', 'Референс')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.tblSubDoc.colTT',  'Код~оп.')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.tblSubDoc.colND',  'Номер~док-та')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.tblSubDoc.colNLS', 'Рахунок А')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.tblSubDoc.colSS',  'Сума')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.tblSubDoc.colDK',  'Д/К')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.tblSubDoc.colSK',  'СКП')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.tblSubDoc.colNazn','Призначення платежу')
.head 7 -  !
.head 7 -  Call CurrentLangTable.AddAtom('dlg_LinkedDocs.cTItogo', 'ВСЬОГО')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_SelectedInfo
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SelectedInfo.cTWndTitle','Отмечено')
.head 7 -  ! field
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SelectedInfo.bgDoc','Документов')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_SelectedInfo.bgSum','На сумму')
.head 7 -  ! ====================================================
.head 7 -  ! dlg_Spec
.head 7 -  Call CurrentLangTable.AddAtom('dlg_Spec.cTWndTitle','Специальная обработка документа Финансового учета')
.head 7 -  ! field
.head 7 -  Call CurrentLangTable.AddAtom('dlg_Spec.bgSumD','Сумма документа')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_Spec.bgSumP','Сумма показателя')
.head 7 -  ! button 
.head 7 -  Call CurrentLangTable.AddAtom('dlg_Spec.pbOK',  'Оплатить')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_Spec.pbExit','Завершить')
.head 7 -  ! error text
.head 7 -  Call CurrentLangTable.AddAtom('dlg_Spec.cTErr1','Не указана СУММА уменьшения')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_Spec.cTErr2','Cумма уменьшения больше суммы документа')
.head 7 -  Call CurrentLangTable.AddAtom('dlg_Spec.cTErr3','Не указан СЧЕТ для уменьшения')
.head 7 -  ! ====================================================
.head 7 -  ! VR
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTWndTitle','Верификация Ввода')
.head 7 -  ! column
.head 7 -  Call CurrentLangTable.AddAtom('VR.REF',   'Реф')
.head 7 -  Call CurrentLangTable.AddAtom('VR.ND',    '№ док')
.head 7 -  Call CurrentLangTable.AddAtom('VR.ISP',   'Исп.')
.head 7 -  Call CurrentLangTable.AddAtom('VR.NLSA',  'Счет-А~вериф')
.head 7 -  Call CurrentLangTable.AddAtom('VR.MFOB',  'МФО-Б~вериф')
.head 7 -  Call CurrentLangTable.AddAtom('VR.NLSB',  'Счет-Б~вериф')
.head 7 -  Call CurrentLangTable.AddAtom('VR.OKPOB', 'ОКПО-Б~вериф')
.head 7 -  Call CurrentLangTable.AddAtom('VR.S',     'Сумма~вериф')
.head 7 -  Call CurrentLangTable.AddAtom('VR.NAZN',  'Назначение')
.head 7 -  Call CurrentLangTable.AddAtom('VR.S1',    'Сумма~ввод')
.head 7 -  Call CurrentLangTable.AddAtom('VR.NLSA1', 'Счет-А~ввод')
.head 7 -  Call CurrentLangTable.AddAtom('VR.MFOB1', 'МФО-Б~ввод')
.head 7 -  Call CurrentLangTable.AddAtom('VR.NLSB1', 'Счет-Б~ввод')
.head 7 -  Call CurrentLangTable.AddAtom('VR.OKPOB1','ОКПО-Б~ввод')
.head 7 -  ! button strTip
.head 7 -  Call CurrentLangTable.AddAtom('VR.cBTipDel','Вернуть документ')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cBTipDetails','Посмотреть введенный документ')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cBTipKol','Сколько в очереди?')
.head 7 -  ! field
.head 7 -  Call CurrentLangTable.AddAtom('VR.cb_NLSA', 'Счет-А')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cb_MFOB', 'МФО-Б')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cb_NLSB', 'Счет-Б')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cb_OKPOB','ОКПО-Б')
.head 7 -  ! nazn
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTNazn','Ош.вериф.')
.head 7 -  ! error text
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTErrNLSA', 'Счет-А !')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTErrMFOB', 'Мфо-Б !')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTErrNLSB', 'Счет-Б !')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTErrOKPOB','ОКПО-Б !')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTErrS',    'Сумма !')
.head 7 -  ! message text
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTMessBack','Вы уверены, что хотите возвратить реф.')
.head 7 -  Call CurrentLangTable.AddAtom('VR.cTMessStorno','Сторно документов')
.head 7 -  ! ====================================================
.head 6 -  !
.head 6 -  Set fInitLib = TRUE
.head 5 -  Return fInitLib
.head 3 +  Function: FunCheckDocumentsSel   !__exported
.head 4 -  Description: Глобальный селектор функций визирования
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nMode        ! Режим работы
.head 5 -  String: strParam1    ! Дополнительное условие для фильтра
.head 5 -  String: strParam2    ! Резерв.
.head 5 -  Number: nParam1      ! Флаг "Самовизирование"
.head 5 -  ! Спецобработка: 0-закрыть спецвизу, 
                 1-показать спецвизу, 
                 2-закрыть спецвозврат, 
                 3-закрыть спецвизу и спецвозврат
.head 5 -  Number: nParam2      ! Флаг "Спецобработка"
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCheckId
.head 5 -  String: strAddCondition
.head 5 -  Boolean: bCreateWindow
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 -  ! Проверка ЭЦП на визах
.head 5 +  If nMode = 99
.head 6 -  Return FunCheckVisaSign()
.head 5 -  ! 0/1 - Визирование
  2   - СБЕРБАНК-спецвизирование
.head 5 +  Else
.head 6 -  Set bCreateWindow = TRUE
.head 6 +  If bFUNCHK1
.head 7 +  If IsWindow(hWndDocCheck)
.head 8 -  Set bCreateWindow = FALSE
.head 8 -  Call SalBringWindowToTop(hWndDocCheck)
.head 6 +  If bCreateWindow
.head 7 +  If nParam1
.head 8 -  Set nCheckId = GetGlobalOptionEx('SELFVISA')
.head 8 +  If NOT nCheckId
.head 9 -  ! Call MessageError('Не задано в параметрах АБС значение кода группы самовизирования!')
.head 9 -  Call MessageError(CurrentLangTable.GetAtomTitle('cTMessNotFoundSelfVisa'))
.head 9 -  Return FALSE
.head 8 -  Set strAddCondition = '( a.nextvisagrp = \'' || NumberToHexSX(nCheckId) || '\' )'
.head 7 +  Else
.head 8 +  If not FunPreCheck(nCheckId, strAddCondition)
.head 9 -  Return FALSE
.head 7 -  !
.head 7 +  If strParam1
.head 8 +  If strAddCondition
.head 9 -  Set strAddCondition = '(' || strParam1 || ') and (' || strAddCondition || ')'
.head 8 +  Else
.head 9 -  Set strAddCondition =  strParam1 
.head 7 -  !
.head 7 -  Set hWndDocCheck = SalCreateWindow(frmCheckInner, hWndMDI, nMode, nCheckId, strAddCondition, nParam1, nParam2)
.head 5 -  Return TRUE
.head 3 +  Function: FunCheckDocuments      !__exported
.head 4 -  Description: Функция подписания/оплаты документов разрешенных
транзакций
Без спецобработки и самовизирования
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCheckId
.head 5 -  String: strAddCondition
.head 5 -  Boolean: bCreateWindow
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 -  Set bCreateWindow = TRUE
.head 5 +  If bFUNCHK1
.head 6 +  If IsWindow(hWndDocCheck)
.head 7 -  Set bCreateWindow = FALSE
.head 7 -  Call SalBringWindowToTop(hWndDocCheck)
.head 5 +  If bCreateWindow
.head 6 +  If not FunPreCheck(nCheckId, strAddCondition)
.head 7 -  Return FALSE
.head 6 -  ! Закриэйтим окошко, через которое будут взирать очи
.head 6 -  Set hWndDocCheck = SalCreateWindow(frmCheckInner, hWndMDI, 0, nCheckId, strAddCondition, 0, 0)
.head 5 -  Return TRUE
.head 3 +  Function: FunCheckDocumentsA     !__exported
.head 4 -  Description: Спец - Визирование, 
с самовизой и спец обработкой.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWin ! Окно-родитель
.head 5 -  String: strUserCond ! Пользовательское дополнительное
                      условие
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCheckId
.head 5 -  String: strAddCondition
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 -  Set nCheckId = GetGlobalOptionEx( 'SELFVISA' )
.head 5 +  If NOT nCheckId
.head 6 -  ! Call MessageError( 'Не задано в параметрах АБС значение кода группы самовизирования!' )
.head 6 -  Call MessageError(CurrentLangTable.GetAtomTitle('cTMessNotFoundSelfVisa'))
.head 6 -  Return FALSE
.head 5 -  Set strAddCondition = '( a.nextvisagrp = \'' || NumberToHexSX(nCheckId) || '\' )'
.head 5 +  If strUserCond
.head 6 +  If strAddCondition
.head 7 -  Set strAddCondition = '(' || strUserCond || ') and (' || strAddCondition || ')'
.head 6 +  Else
.head 7 -  Set strAddCondition =  strUserCond 
.head 5 -  Call SalCreateWindow(frmCheckInner, hWin, 0, nCheckId,  strAddCondition, 1, 1)
.head 5 -  Return TRUE
.head 3 +  Function: FunCheckDocumentsEx    !__exported
.head 4 -  Description: Функция подписания/оплаты документов
разрешенных транзакций
Без спецобработки и самовизирования,
С внешним дополнительным условием.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWin ! Окно-родитель
.head 5 -  String: strUserCond ! Пользовательское дополнительное
                      условие
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strAddCondition
.head 5 -  Number: nCheckId
.head 5 -  Boolean: bCreateWindow
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 -  Set bCreateWindow = TRUE
.head 5 +  If bFUNCHK1
.head 6 +  If IsWindow(hWndDocCheck)
.head 7 -  Set bCreateWindow = FALSE
.head 7 -  Call SalBringWindowToTop(hWndDocCheck)
.head 5 +  If bCreateWindow
.head 6 +  If not FunPreCheck(nCheckId, strAddCondition)
.head 7 -  Return FALSE
.head 6 -  ! ! Закриэйтим окошко, через которое будут взирать очи
.head 6 +  If strUserCond
.head 7 +  If strAddCondition
.head 8 -  Set strAddCondition = '(' || strUserCond || ') and (' || strAddCondition || ')'
.head 7 +  Else
.head 8 -  Set strAddCondition =  strUserCond 
.head 6 -  Set hWndDocCheck = SalCreateWindow(frmCheckInner, hWin, 0, nCheckId,  strAddCondition, 0, 0)
.head 5 -  Return TRUE
.head 3 +  Function: FunVerifi              !__exported
.head 4 -  Description: Верификация ввода
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Window Handle: hWin ! Окно-родитель
.head 5 -  Number: nSam
.head 5 -  String: strUserCond ! Пользовательское дополнительное условие
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nCheckId
.head 5 -  String: strAddCondition
.head 5 -  Boolean: bCreateWindow
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 -  Set bCreateWindow = TRUE
.head 5 +  If bFUNCHK1
.head 6 +  If IsWindow(hWndDocVr)
.head 7 -  Set bCreateWindow = FALSE
.head 7 -  Call SalBringWindowToTop(hWndDocVr)
.head 5 +  If bCreateWindow
.head 6 +  If not FunPreCheck(nCheckId, strAddCondition)
.head 7 -  Return FALSE
.head 6 +  If strUserCond
.head 7 +  If strAddCondition
.head 8 -  Set strAddCondition = '(' || strUserCond || ') and (' || strAddCondition || ')'
.head 7 +  Else
.head 8 -  Set strAddCondition =  strUserCond 
.head 6 -  Set hWndDocVr = SalCreateWindow(VR, hWin, nCheckId,  strAddCondition, nSam)
.head 5 -  Return TRUE
.head 3 +  Function: FunPayAndBck           !__exported
.head 4 -  Description: Функция оплаты или возврата документов (имени Кострова С.В.)
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Boolean: nMode ! Разрешено ли платить или только смотреть
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalMessageBox('Функция устарела и выведена из употребления. Обратитесь к Администратору АБС',
'Внимание!', MB_Ok)
.head 5 -  Return FALSE
.head 3 -  !
.head 3 +  Function: FunGetPrevCheckGroup   !__exported
.head 4 -  Description: Возвращает значение группы контроля для транзакции
!Необходимая последняя виза!
.head 4 +  Returns
.head 5 -  String:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  String: strTT
.head 5 -  Number: nCheckId
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strCheck
.head 5 -  String: strHCheck
.head 5 -  String: strPrev
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 -  Set strCheck = '  '
.head 5 -  Set strPrev  = '  '
.head 5 -  Set strHCheck = NumberToHexSX(nCheckId)
.head 5 +  Loop
.head 6 +  If NOT SqlPrepareAndExecute(hSqlAux(), 
'SELECT SUBSTR(chk.GetNextVisaGroup(' || SalNumberToStrX(nRef,0) || ', \'' ||
   strPrev || '\'), 1, 2) INTO :strCheck FROM dual')
.head 7 -  Set strPrev = ''
.head 7 -  Break
.head 6 +  If NOT SqlFetchNext(hSqlAux(), nFetchRes)
.head 7 -  Set strPrev = ''
.head 7 -  Break
.head 6 -  ! Call Debug( 'Curr Visa: ' || strPrev || ', NextVisa: ' || strCheck ||', Target: ' || strHCheck )
.head 6 +  If strCheck =  strHCheck OR strCheck = '!!'
.head 7 -  Break
.head 6 -  Set strPrev = strCheck
.head 5 -  Return SalStrTrimX(strPrev)
.head 3 +  Function: FunGetChkGroup         !__exported
.head 4 -  Description: Функция выбора группы контроля для пользователя
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  Number: nUserId
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 -  Return SalModalDialog(dlg_ChkGroupSelect, hWndForm, nUserId)
.head 3 +  Function: FunIsDocReady2Pay
.head 4 -  Description: Проверка готовности платежа к оплате
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  Number: nCId
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strTT
.head 5 -  String: strCurr
.head 5 -  String: strNext
.head 5 -  String: strNNext
.head 4 +  Actions
.head 5 +  If not SqlPrepareAndExecute(hSql(), '
     SELECT tt,currvisagrp,nextvisagrp,substr(CHK.GetNextVisaGroup(ref,nextvisagrp),1,2) 
       INTO :strTT, :strCurr, :strNext, :strNNext
       FROM oper
      WHERE ref=:nRef')
.head 6 -  Return FALSE
.head 5 +  If NOT SqlFetchNext(hSql(), nFetchRes)
.head 6 -  Return FALSE
.head 5 -  Return (strCurr = FunGetPrevCheckGroup(nRef, strTT, nCId) and 
        strNext = NumberToHexSX(nCId) and strNNext = '!!')
.head 3 +  Function: FunIsDocCanBProcessed
.head 4 -  Description: Проверка на актуальность состояния документа для работы с ним.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  Number: nCId
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nDocNum
.head 4 +  Actions
.head 5 -  ! Лочит документ и получает флаги оплаты и подписания СЕП
.head 5 +  If GetGlobalOption('INTSIGN')='2'
.head 6 +  If SqlPLSQLCommand(hSql(),"chk.lock_doc(nRef,nCId,n2Pay,n2Sig)")
.head 7 -  Return TRUE
.head 5 +  Else
.head 6 +  If SqlPrepareAndExecute( hSql(), "SELECT 1 INTO :nDocNum FROM oper 
      WHERE ref=:nRef AND ref IN (SELECT ref FROM ref_que) 
    AND sos BETWEEN 0 AND 3 AND nextvisagrp = '" ||NumberToHexSX(nCId)||"' FOR UPDATE OF chk NOWAIT" ) and
   SqlFetchNext( hSql(), nFetchRes )
.head 7 -  Return TRUE
.head 5 -  Call SqlRollback( hSql() )
.head 5 -  Return FALSE
.head 3 +  Function: FunPreCheck
.head 4 -  Description: Функция предварительной подготовки данных для
вызова окна контролера. Возвращает сроку
дополнительного условия фильтра
----------------------------------------------------
ОРИЕНТИРОВАНА НА ДОПОЛНИТЕЛЬНОЕ ПОЛЕ В OPER, ГДЕ
ХРАНИТСЯ ЗНАЧЕНИЕ ПОСЛЕДНЕЙ ВИЗЫ (ГРУППА ВИЗИРОВАНИЯ)
И СЛЕДУЮЩЕЙ ГРУППЫ.
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Receive Number: CheckId
.head 5 -  Receive String: strCondition
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  : TChk
.head 6 -  Class: cABSConnect
.head 5 -  Number: UserId
.head 5 -  Number: fUserIsMentor
.head 5 -  Number: nSelfCheck
.head 5 -  String: strSQLCnt
.head 4 +  Actions
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Call XConnectGetParams(TChk)
.head 5 +  If NOT TChk.Connect()
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return FALSE
.head 5 -  !
.head 5 -  Set UserId = GetUserId()
.head 5 -  Set nSelfCheck = GetGlobalOptionEx( 'SELFVISA' )
.head 5 -  ! Проверим принадлежит ли юзер к лику досточтимых
! контролеров
.head 5 -  Set strSQLCnt = 'SELECT count(*) INTO :fUserIsMentor FROM staff_chk WHERE '
.head 5 +  If nSelfCheck
.head 6 -  Set strSQLCnt = strSQLCnt || 'chkid <> ' || SalNumberToStrX(nSelfCheck, 0) || ' and '
.head 5 +  If EnhancedSecurity()
.head 6 -  Set strSQLCnt = strSQLCnt || ' NVL(approve,0)=1 and ' || 'date_is_valid(adate1,adate2,rdate1,rdate2)=1 and '
.head 5 -  Set strSQLCnt = strSQLCnt || 'id in (' || GetSubstListId(UserId, TRUE) || ')'
.head 5 +  If SqlPrepareAndExecute( TChk.hSql(), strSQLCnt )
.head 6 -  Call SqlFetchNext(TChk.hSql(), nFetchRes)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 +  If fUserIsMentor = NUMBER_Null OR fUserIsMentor = 0
.head 6 -  ! Call MessageError('Пользователь не обладает правами Контролера платежей')
.head 6 -  Call MessageError(CurrentLangTable.GetAtomTitle('cTMessNotUserMentor'))
.head 6 -  Return FALSE
.head 5 -  ! Выберем группу контроля, достойную принять венценосного и мудроликого
.head 5 -  Set CheckId = FunGetChkGroup(UserId)
.head 5 +  If CheckId = -1
.head 6 -  Return FALSE
.head 5 -  Call SalWaitCursor(TRUE)
.head 5 -  Set strCondition = '( a.nextvisagrp = \'' || NumberToHexSX(CheckId) || '\' )'
.head 5 +  If TChk.IsConnected()
.head 6 -  Call TChk.Disconnect()
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 3 +  Function: DocumentCheck          !__exported
.head 4 -  Description: Обработка документа при визировании
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  Number: nCId
.head 5 -  String: strChk
.head 5 -  Boolean: isMultiLineVisaMode
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strHexMark
.head 5 -  Number: nRetVal
.head 5 -  ! cDoc: cDoc
.winattr class :
.head 6 -  Class: cDoc
.end
.head 5 -  Number: nUserId
.head 5 -  Number: nStatus
.head 5 -  Number: nRet
.head 5 -  Boolean: fPaySkip
.head 5 -  Boolean: fIErr
.head 5 -  String: strKeyId
.head 5 -  Boolean: mustCommitTrans
.head 5 -  !
.head 4 +  Actions
.head 5 -  Return DocumentCheckSpec(nRef, nCId, strChk, isMultiLineVisaMode, 0)
.head 3 +  Function: DocumentCheckSpec
.head 4 -  Description: Обработка документа при визировании
.head 4 +  Returns
.head 5 -  Number:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  Number: nCId
.head 5 -  String: strChk
.head 5 -  Boolean: isMultiLineVisaMode
.head 5 -  ! Спецобработка: 2-запретить возврат на предыдущ. визу
.head 5 -  Number: nSpec
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strHexMark
.head 5 -  Number: nRetVal
.head 5 -  ! cDoc: cDoc
.winattr class :
.head 6 -  Class: cDoc
.end
.head 5 -  Number: nUserId
.head 5 -  Number: nStatus
.head 5 -  Number: nRet
.head 5 -  Boolean: fPaySkip
.head 5 -  Boolean: fIErr
.head 5 -  String: strKeyId
.head 5 -  Boolean: mustCommitTrans
.head 5 -  !
.head 5 -  String: sTt
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 -  Set mustCommitTrans = FALSE
.head 5 -  !
.head 5 -  ! Лочим документ для визирования
.head 5 -  !
.head 5 +  If NOT FunIsDocCanBProcessed(nRef, nCId)
.head 6 -  Call SalMessageBeep(MB_IconStop) 
.head 6 -  ! Информация в таблице устарела! Рекомнедуем регулярно обновлять ее. Нарушение технологии
.head 6 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessInfo'), 
     CurrentLangTable.GetAtomTitle('cTTitleTechnErr'), MB_IconStop | MB_Ok)
.head 6 -  ! Обнаружена устаревшая информция в форме визирования. Выход из цикла обработки.
.head 6 -  Call SaveInfoToLog('VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessOldInfo'))
.head 6 -  Return FALSE 
.head 5 -  !
.head 5 -  Call cDocChk.SetDocR(nRef, FALSE)
.head 5 -  Set cDocChk.m_nSiG=0   ! Обнулити флаг підписання при вставці в arc_rrp
.head 5 -  !
.head 5 -  Set strHexMark = SalStrTrimX(strChk) || SalStrRightX('00' || NumberToHexSX(nCId), 2) || 
                                      SalStrRightX('0000' || NumberToHexSX(GetUserId()), 4)
.head 5 -  Set nStatus = 1
.head 5 -  !
.head 5 -  ! Проверка подписи на визе (если надо)
.head 5 -  !
.head 5 +  If GetGlobalOptionEx('VISASIGN') AND GetSignOn() != 0    ! Проверка подписи n-1
.head 6 -  ! Проверим подпись
.head 6 -  ! если не верна, то выдать сообщение и по разрешению вернуть документ на предыдущий уровень??
.head 6 -  ! -------------------------------------- MIK
.head 6 +  If GetGlobalOption('INTSIGN') = '2'               ! новая внутрення подпись
.head 7 +  If NOT cDocChk.cDocInt(99,nCId)
.head 8 -  ! 'Ошибка инициализации!'
.head 8 -  Call SaveErrorToLog('VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessErrInitECP') || ' [Ref=' || SalNumberToStrX(nRef, 0))
.head 8 +  If nSpec < 2
.head 9 -  Call SalMessageBeep(MB_IconStop)
.head 9 -  ! Ошибка инициализации! Возвратить документ на повторное визирование?
.head 9 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessErrInitECP') || '!' || PutCrLf() || 
   CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessQuestionBackPrevVisa'), 
   CurrentLangTable.GetAtomTitle('cTTitleError'), MB_IconStop | MB_YesNo | MB_DefButton1) = IDYES
.head 10 -  ! -- не удаляем запись кто ввел документ (status=0)
.head 10 +  If SqlPrepareAndExecute(hSql(), 'UPDATE oper SET chk=substr(chk, 1, length(rtrim(chk))-6) WHERE ref=:nRef') AND 
   SqlPrepareAndExecute(hSql(), 'DELETE FROM oper_visa WHERE sqnc = (SELECT max(sqnc) FROM oper_visa WHERE ref=:nRef) and status <> 0')
.head 11 -  ! Возврат документа на повторное визирование. Ref = nRef
.head 11 -  Call SqlCommitEx(hSql(), 'VISA. ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogBackPrevVisa') || ' Ref = ' || SalNumberToStrX(nRef, 0))
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Return FALSE
.head 6 -  ! -------------------------------------- MIK
.head 6 +  Else ! старая внутрення подпись
.head 7 +  If NOT cDocChk.CheckDocSign('CUR', 0) 
.head 8 +  Select Case cDocChk.m_nSignErrType
.head 9 +  Case 1
.head 10 -  ! Виза группы nCId: Неверная подпись на документе [Ref=nRef]!
.head 10 -  Call SaveErrorToLog('VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessVisa') || ' ' || SalNumberToStrX(nCId,0) || ': ' || 
     CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogSignErr') || ' [Ref=' || SalNumberToStrX(nRef, 0) || ']!')
.head 10 -  Break
.head 9 +  Case 2
.head 10 -  ! Виза группы nCId: Неверная подпись предыдущей группы визирования [Ref=nRef]!
.head 10 -  Call SaveErrorToLog('VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessVisa') || ' ' || SalNumberToStrX(nCId,0) || ': ' || 
     CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogPrevVisaSignErr') || ' [Ref=' || SalNumberToStrX(nRef, 0) || ']!')
.head 10 -  Call SalMessageBeep(MB_IconStop)
.head 10 -  ! Подпись предыдущей группы визирования неверна! Возвратить документ на повторное визирование?
.head 10 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessPrevVisaSignErr') || PutCrLf() || 
   CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessQuestionBackPrevVisa'), 
   CurrentLangTable.GetAtomTitle('cTTitleError'), MB_IconStop | MB_YesNo | MB_DefButton1) = IDYES
.head 11 +  If SqlPrepareAndExecute(hSql(), 'UPDATE oper SET chk=substr(chk, 1, length(rtrim(chk))-6) WHERE ref=:nRef') AND 
   SqlPrepareAndExecute(hSql(), 'DELETE FROM oper_visa WHERE sqnc = (SELECT max(sqnc) FROM oper_visa WHERE ref=:nRef)')
.head 12 -  ! Возврат документа на повторное визирование. Ref = nRef
.head 12 -  Call SqlCommitEx(hSql(), 'VISA. ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogBackPrevVisa') || ' Ref = ' || SalNumberToStrX(nRef, 0))
.head 10 -  Break
.head 9 +  Default
.head 10 -  ! cDocChk.m_nSignErrType - Нерасчетный код возврата!
.head 10 -  Call Debug(SalNumberToStrX(cDocChk.m_nSignErrType, 0) || ' - ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessErrReturnCode'))
.head 10 -  Break
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Return FALSE
.head 5 -  !
.head 5 -  If GetGlobalOption('INTSIGN') = '2'
.head 5 +  Else
.head 6 -  Set n2Pay = FunIsDocReady2Pay(nRef, nCId)
.head 5 -  !
.head 5 +  If n2Pay
.head 6 -  Set nStatus = 2
.head 5 -  !
.head 5 -  Set nUserId = GetUserId()
.head 5 -  Set strKeyId = GetIdOper()
.head 5 -  !
.head 5 +  If GetGlobalOption('INTSIGN') = '2'
.head 6 +  If n2Pay and (n2Sig & DEF_EXT_SIGN)
.head 7 -  Set cDocChk.m_nSiG=1   ! Встановити флаг підписання при вставці в arc_rrp при оплаті
.head 5 -  ! оплата документа
.head 5 -  !
.head 5 +  If n2Pay
.head 6 -  ! Set nStatus = 2
.head 6 -  Call SalMessageBeep(MB_IconQuestion)
.head 6 -  ! На документ N nRef накладывается виза наивысшего приоритета. Визировать? Контроль
.head 6 -  Set nRetVal = MessageActionConfirm(CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessSetVisa1') || ' N ' || SalNumberToStrX(nRef, 0) || ' ' ||
    CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessSetVisa2'), 
    CurrentLangTable.GetAtomTitle('cTTitleControl'))
.head 6 +  If nRetVal != MBEx_Yes
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return nRetVal
.head 6 -  Set fPaySkip = FALSE
.head 6 -  ! Фактическая оплата документа REF=nRef
.head 6 -  Call SaveInfoToLog('VISA. ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogPFac') || ' REF=' || SalNumberToStrX(nRef, 0))
.head 6 +  While (NOT fPaySkip) AND (NOT cDocChk.P_Fac(nRef, GetBankDateEx()))
.head 7 -  Call SalMessageBeep(MB_IconQuestion)
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  ! Повторить процедуру оплаты?
.head 7 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessQuestionRepeatPay'), 
   CurrentLangTable.GetAtomTitle('cTTitleAt'), MB_IconQuestion | MB_RetryCancel | MB_DefButton1) = IDCANCEL
.head 8 -  Set fPaySkip = TRUE
.head 8 -  ! Пользователь отказался от оплаты документа REF=nRef
.head 8 -  Call SaveInfoToLog('VISA. ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogNotPay') || ' REF=' || SalNumberToStrX(nRef, 0))
.head 7 +  Else
.head 8 +  If NOT FunIsDocCanBProcessed(nRef, nCId)
.head 9 -  Call SalMessageBeep(MB_IconStop) 
.head 9 -  ! Состояние документа № nRef не соответсвует начальным условиям визирования. Возможно документ уже завизирован другим пользователем.
  Нарушение технологии
.head 9 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessDocState1') || ' № ' || SalNumberToStrX(nRef, 0) || ' ' || 
     CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessDocState2') || 
     CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessDocState3'), 
     CurrentLangTable.GetAtomTitle('cTTitleTechnErr'), MB_IconStop | MB_Ok)
.head 9 -  ! Обнаружена устаревшая информция о документе REF=nRef. Документ не обрабатывается.
.head 9 -  Call SaveInfoToLog('VISA. ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogOldInfo1') || ' REF=' || SalNumberToStrX(nRef, 0) || '. ' || 
     CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogOldInfo2'))
.head 9 -  Set fPaySkip = TRUE
.head 9 -  Break
.head 8 -  ! Повторная попытка оплаты документа REF=nRef
.head 8 -  Call SaveInfoToLog('VISA. ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogRepeatPayDoc') || ' REF=' || SalNumberToStrX(nRef, 0))
.head 8 -  Call SalWaitCursor(TRUE)
.head 6 +  If fPaySkip
.head 7 -  Call SalWaitCursor(FALSE)
.head 7 -  Call SqlRollback(hSql())
.head 7 +  If isMultiLineVisaMode
.head 8 -  Call SalMessageBeep(MB_IconQuestion)
.head 8 -  ! Отменить операцию визирования?
.head 8 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessQuestionVisaCancel'), 
   CurrentLangTable.GetAtomTitle('cTTitleAt'), MB_IconQuestion | MB_YesNo | MB_DefButton2) = IDYES
.head 9 -  Call SalWaitCursor(TRUE)
.head 9 -  ! Пользователь прервал цикл визирования документов...
.head 9 -  Call SaveInfoToLog('VISA. ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessVisaCancel'))
.head 9 -  Return MBEx_Cancel
.head 7 -  Return FALSE
.head 5 -  !
.head 5 -  ! Наложение Визы + ЭЦП-1 + ЭЦП-2 
.head 5 +  If GetGlobalOption('INTSIGN') = '2'
.head 6 +  If GetGlobalOptionEx('VISASIGN') AND GetSignOn() != 0    ! подпись n
.head 7 +  If not cDocChk.sDocInt(99,nCId)
.head 8 -  ! Виза группы nCId: Не удалось подписать визу (INT)!
.head 8 -  Call SaveErrorToLog('VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessVisa') || ' ' || SalNumberToStrX(nCId,0) || ': ' || 
     CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessErrSetVisa') || ' (INT)!')
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Return FALSE
.head 6 +  If (n2Sig & DEF_EXT_SIGN) !! n2Pay=0 and
.head 7 -  ! Подпись СЕП для этой группы 
.head 7 -  Set cDocChk.m_sOperId=GetIdOper()
.head 7 +  If not cDocChk.sDoc()  ! наложить ЭЦП СЭП
.head 8 -  ! Не удалось подписать документ СЭП.
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Return FALSE
.head 6 +  If cDocChk.PutVis (nCId,nStatus)
.head 7 -  Set mustCommitTrans = TRUE
.head 6 +  Else
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return FALSE
.head 5 +  Else
.head 6 +  If GetGlobalOptionEx('VISASIGN') AND GetSignOn() != 0    ! подпись n
.head 7 +  If NOT cDocChk.sDocVisa()
.head 8 -  ! Виза группы nCId: Не удалось подписать визу!
.head 8 -  Call SaveErrorToLog('VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessVisa') || ' ' || SalNumberToStrX(nCId,0) || ': ' || 
     CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessErrSetVisa'))
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Return FALSE
.head 6 +  ! If SqlPrepareAndExecute(hSql(), 'UPDATE oper SET chk=:strHexMark WHERE ref=:nRef')
.head 7 +  If GetGlobalOptionEx('VISASIGN') AND GetSignOn() != 0
.head 8 -  Call SqlSetLongBindDatatype(6, BLOB_BYTE)
.head 8 +  If SqlPrepareAndExecute(hSql(), '
 INSERT INTO oper_visa (ref, dat, userid, groupid, status, keyid, sign) 
 VALUES (:nRef,sysdate,:nUserId,:nCId,:nStatus,:strKeyId,:cDocChk.m_lsSign)')
.head 9 -  Set mustCommitTrans = TRUE
.head 8 +  Else 
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Return FALSE
.head 7 +  Else 
.head 8 +  If SqlPrepareAndExecute(hSql(), '
 INSERT INTO oper_visa (ref, dat, userid, groupid, status) 
 VALUES (:nRef,sysdate,:nUserId,:nCId,:nStatus)')
.head 9 -  Set mustCommitTrans = TRUE
.head 8 +  Else 
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Return FALSE
.head 6 -  Call SqlPrepareAndExecute(hSql(), "select tt into :sTt from oper where ref = :nRef")
.head 6 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 6 +  If SqlPLSQLCommand(hSql(), 'chk.put_visa (nRef, sTt, nCId, nStatus, strKeyId, STRING_Null, STRING_Null)')
.head 7 -  Set mustCommitTrans = TRUE
.head 6 +  Else
.head 7 -  Call SqlRollback(hSql())
.head 7 -  Return FALSE
.head 5 +  If mustCommitTrans
.head 6 -  ! Документ REF=nRef ЗАВИЗИРОВАН.
.head 6 -  Call SqlCommitEx(hSql(), 'VISA. ' || CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogSetVisaOk1') || ' REF=' || SalNumberToStrX(nRef, 0) || ' ' || 
     CurrentLangTable.GetAtomTitle('DocumentCheck.cTMessToLogSetVisaOk2'))
.head 6 -  Return TRUE
.head 3 +  Function: BackKlBob		 !__exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  Number: nStornoReasonId
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: sNls
.head 5 -  String: sMfo
.head 5 -  String: sNlsp
.head 5 -  Number: nS
.head 5 -  String: sNd
.head 5 -  String: sText1
.head 5 -  String: sPond
.head 5 -  String: sNaex
.head 5 -  String: sNaimp
.head 5 -  Number: nEom
.head 5 -  String: sSab0
.head 5 -  String: sOper
.head 5 -  String: AMFO
.head 5 -  String: sStornoReason
.head 4 +  Actions
.head 5 +  If GetGlobalOption('KL_BOB') = '0'
.head 6 +  If SqlPrepareAndExecute(hSql(), 
"SELECT k.nls, k.mfo, k.nlsp, k.naimp, k.s, k.nd, k.text1, k.pond, k.naex, k.eom
 INTO :sNls, :sMfo, :sNlsp, :sNaimp, :nS, :sNd, :sText1, :sPond, :sNaex, :nEom
 FROM klp k
 WHERE k.ref=:nRef") and SqlFetchNext(hSql(), nFetchRes)
.head 7 -  Set sSab0 = Subs(sNaex, 3, 4)
.head 7 -  Set sOper = Right(Str(10000+nEom), 4)
.head 7 -  Set AMFO  = GetBankMfo()
.head 7 +  If not SqlPrepareAndExecute(hSql(), 
"SELECT reason INTO :sStornoReason FROM bp_reason WHERE id=:nStornoReasonId")
or not SqlFetchNext(hSql(), nFetchRes)
.head 8 -  Set sStornoReason = 'Сторно'
.head 7 +  If not SqlPrepareAndExecute(hSql(), 
"INSERT INTO klpoow(sab,oper,mfoa,nlsa,mfob,nlsb,namb,s,nd,nazn,pond,prwo,nfia,tip)
 VALUES(:sSab0,:sOper,:AMFO,:sNls,:sMfo,:sNlsp,:sNaimp,:nS,:sNd,:sText1,:sPond,:sStornoReason,:sNaex,'W')") 
or not SqlPrepareAndExecute(hSql(), 
"UPDATE klp SET fl=9 WHERE ref=:nRef")
.head 8 -  Call Debug('Ошибка формирования возврата по КЛИЕНТ-БАНК')
.head 8 -  Call SqlRollback(hSql())
.head 8 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: BackKvitD		 !__exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 +  If nBackKvit
.head 6 +  If not KvitD(nRef,strPathD)
.head 7 -  ! 'Ошибка формирования квитанции D для док.'
.head 7 -  Call MessageError(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessErrFormD') || Str(nRef))
.head 7 -  Return FALSE
.head 5 -  Return TRUE
.head 3 +  Function: DocumentBack		 !__exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  Number: nLevel
.head 5 -  Number: nStornoReasonId
.head 5 -  Number: nCheckId
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strChk
.head 5 -  Number: nErr
.head 5 -  String: sErr
.head 5 -  Number: nStatus
.head 5 -  Number: nUserId
.head 5 -  String: strHexMark2Ret
.head 5 -  String: strKeyId
.head 5 -  Boolean: isSqlOk
.head 5 -  Boolean: isSignOk
.head 4 +  Actions
.head 5 -  Return DocumentStorno(nRef, nLevel, nStornoReasonId, nCheckId, 1)
.head 3 +  Function: DocumentStorno	 !__exported
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  Number: nLevel
.head 5 -  Number: nStornoReasonId
.head 5 -  Number: nCheckId
.head 5 -  Number: nFullBack	! 0-возврат документа с визирования,
                          1-полный убой документа
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  String: strChk
.head 5 -  Number: nErr
.head 5 -  String: sErr
.head 5 -  Number: nStatus
.head 5 -  Number: nUserId
.head 5 -  String: strHexMark2Ret
.head 5 -  String: strKeyId
.head 5 -  Boolean: isSqlOk
.head 5 -  Boolean: isSignOk
.head 4 +  Actions
.head 5 -  Call Chckinnr_Init()
.head 5 +  If NOT SqlPrepareAndExecute(hSql(),"SELECT chk INTO :strChk FROM oper WHERE ref=:nRef") 
OR NOT SqlFetchNext(hSql(), nFetchRes)
.head 6 -  ! Call Debug('Документ REF' || Str(nRef) || 'не найден!')
.head 6 -  Call Debug(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessDoc') || ' REF' || Str(nRef) || ' ' ||
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessDoc2'))
.head 6 -  Return FALSE
.head 5 +  If SqlPLSQLCommand(hSql(), "p_back_dok(nRef,nLevel,nStornoReasonId,nErr,sErr,nFullBack)")
.head 6 -  Set nStatus = 3
.head 6 -  Set nUserId = GetUserId()
.head 6 -  Set strHexMark2Ret = SalStrTrimX(strChk) ||
    SalStrRightX('00' || NumberToHexSX(nCheckId), 2) ||
    SalStrRightX('0000' || NumberToHexSX(nUserId), 4)
.head 6 -  Set isSqlOk = TRUE
.head 6 -  ! Подписать документ на сторнировании
.head 6 +  If GetGlobalOptionEx('VISASIGN') and GetSignOn() != 0   ! подпись сторнирующего лица
.head 7 +  If cDocChk.SetDocR(nRef, TRUE)
.head 8 -  ! Подписываем...
.head 8 -  Set strKeyId = GetIdOper()
.head 8 +  If GetGlobalOption('INTSIGN')='2'               ! новая внутрення подпись
.head 9 -  Set isSignOk = cDocChk.sDocInt(99,nCheckId)
.head 9 +  If isSignOk
.head 10 -  Set isSqlOk = cDocChk.PutVis(nCheckId,nStatus)
.head 8 +  Else
.head 9 -  Set isSignOk = cDocChk.sDocVisa()
.head 9 +  If isSignOk
.head 10 -  Set isSqlOk = SqlPrepareAndExecute(hSql(), "UPDATE oper SET chk=:strHexMark2Ret WHERE ref=:nRef")
.head 10 +  If isSqlOk
.head 11 -  Call SqlSetLongBindDatatype(6, BLOB_BYTE)
.head 11 -  Set isSqlOk = SqlPrepareAndExecute(hSql(), 
"INSERT INTO oper_visa (ref,dat,userid,groupid,status,keyid,sign)
 VALUES(:nRef,sysdate,:nUserId,:nCheckId,:nStatus,:strKeyId,:cDocChk.m_lsSign)")
.head 8 +  If isSignOk
.head 9 +  If isSqlOk
.head 10 +  If NOT BackKlBob(nRef, nStornoReasonId)
.head 11 -  Call SqlRollback(hSql())
.head 11 -  Return FALSE
.head 10 +  If NOT BackKvitD(nRef)
.head 11 -  Call SqlRollback(hSql())
.head 11 -  Return FALSE
.head 10 -  ! 'Возврат документа отправителю. Ref = ' || Str(nRef))
.head 10 -  Call SqlCommitEx(hSql(), 'VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessBack') || '. Ref = ' || Str(nRef))
.head 10 -  Return TRUE
.head 9 +  Else
.head 10 -  ! 'Ошибка: неможливо зберегти дані візування'
.head 10 -  Call Debug(CurrentLangTable.GetAtomTitle('frmCheckInner.cTErr') || ': ' || 
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessErrSaveVisa'))
.head 10 -  Call SqlRollback(hSql())
.head 8 +  Else
.head 9 -  ! Call Debug('Виза группы ' || Str(nCheckId) || ': Не удалось подписать сторно операцию!')
.head 9 -  Call Debug(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessVisa') || ' ' || Str(nCheckId) || ': ' || 
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTErrSignStorno'))
.head 9 -  ! Call SaveErrorToLog('Виза группы ' || Str(nCheckId) || ': Не удалось подписать сторно операцию!')
.head 9 -  Call SaveErrorToLog('VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessVisa') || ' ' || Str(nCheckId) || ': ' || 
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTErrSignStorno'))
.head 9 -  Call SqlRollback(hSql())
.head 7 +  Else
.head 8 -  ! Call Debug('Виза группы ' || Str(nCheckId) || ': Не удалось подписать сторно операцию!')
.head 8 -  Call Debug(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessVisa') || ' ' || Str(nCheckId) || ': ' || 
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTErrSignStorno'))
.head 8 -  ! Call SaveErrorToLog('Виза группы ' || Str(nCheckId) || ': Не удалось подписать сторно операцию!')
.head 8 -  Call SaveErrorToLog('VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessVisa') || ' ' || Str(nCheckId) || ': ' || 
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTErrSignStorno'))
.head 8 -  Call SqlRollback(hSql())
.head 6 +  Else ! виза без ЭЦП
.head 7 +  If SqlPrepareAndExecute(hSql(),"UPDATE oper SET chk=:strHexMark2Ret WHERE ref=:nRef")
.head 8 +  If SqlPrepareAndExecute(hSql(),"INSERT INTO oper_visa (ref,dat,userid,groupid,status) VALUES(:nRef,sysdate,:nUserId,:nCheckId,:nStatus)")
.head 9 +  If NOT BackKlBob(nRef, nStornoReasonId)
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Return FALSE
.head 9 +  If NOT BackKvitD(nRef)
.head 10 -  Call SqlRollback(hSql())
.head 10 -  Return FALSE
.head 9 -  ! 'Возврат документа отправителю. Ref = ' || Str(nRef))
.head 9 -  Call SqlCommitEx(hSql(), 'VISA. ' || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessBack') || '. Ref = ' || Str(nRef))
.head 9 -  Return TRUE
.head 8 +  Else
.head 9 -  ! 'Ошибка: ' || 'INSERT INTO oper_visas'
.head 9 -  Call Debug(CurrentLangTable.GetAtomTitle('frmCheckInner.cTErr') || ': INSERT INTO oper_visas')
.head 9 -  Call SqlRollback(hSql())
.head 7 +  Else
.head 8 -  ! 'Ошибка: ' || 'UPDATE oper SET chk'
.head 8 -  Call Debug(CurrentLangTable.GetAtomTitle('frmCheckInner.cTErr') || ': UPDATE oper SET chk')
.head 8 -  Call SqlRollback(hSql())
.head 5 +  Else
.head 6 -  Call SqlRollback(hSql())
.head 5 -  Return FALSE
.head 3 +  Function: Document1StepBack
.head 4 -  Description: Вернуть доумент на предыдущую группу визирования
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 5 -  Number: nCId
.head 5 -  String: strChk
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nUId
.head 4 +  Actions
.head 5 +  If NOT strChk
.head 6 -  Return FALSE
.head 5 -  !
.head 5 +  ! If NOT FunDocLock( nRef )
.head 6 -                                                           Return FALSE
.head 5 +  If NOT FunIsDocCanBProcessed(nRef, nCId)
.head 6 -  Return FALSE
.head 5 -  !
.head 5 -  Set nUId = GetUserId()
.head 5 +  ! If SqlPrepareAndExecute(hSql(), 'UPDATE oper SET chk=substr(chk, 1, length(rtrim(chk))-6) WHERE ref=:nRef') AND 
   SqlPrepareAndExecute(hSql(), 'DELETE FROM oper_visa WHERE sqnc = (SELECT max(sqnc) FROM oper_visa WHERE ref=:nRef)') AND
   SqlPrepareAndExecute(hSql(), 'INSERT INTO oper_visa (ref, dat, userid, groupid, status, passive) VALUES (:nRef, SYSDATE, :nUId, :nCId, 0, 1)')
.head 6 -  ! Call SqlCommitEx( hSql(), 'Возврат документа на предыдущую группу визирования. Ref = ' || SalNumberToStrX(nRef, 0))
.head 6 -   Call SqlCommitEx(hSql(), 'VISA. ' || CurrentLangTable.GetAtomTitle('cTMessToLogBackPrevVisaGrp') || ' Ref = ' || SalNumberToStrX(nRef, 0))
.head 5 +  If SqlPLSQLCommand(hSql(),'chk.back_last_visa(nRef,NUMNULL)')
.head 6 -  Call SqlCommitEx(hSql(), 'VISA. ' || CurrentLangTable.GetAtomTitle('cTMessToLogBackPrevVisaGrp') || ' Ref = ' || SalNumberToStrX(nRef, 0))
.head 5 +  Else
.head 6 -  Call SqlRollback( hSql() )
.head 5 -  Return TRUE
.head 3 +  Function: FunCheckVisaSign
.head 4 -  Description: Проверка ЭЦП на визах с занесением информации в OPER_VISA
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Call SalCreateWindow(frmCheckVisaSign, hWndMDI)
.head 5 -  Return TRUE
.head 2 +  Named Menus
.head 2 +  Class Definitions
.data RESOURCE 0 0 1 25218691
0000: 37010000A2000000 0000000000000000 0200000200FFFF01 00160000436C6173
0020: 73566172004F7574 6C696E6552006567 496E666F22003C00 000A630047656E46
0040: 696C746500727400 00000400001E0002 0400C10001000000 3F8001F800000037
0060: 040001F00D000000 FF1F110000DC0002 00FF7F1570000000 0100FFFF21018022
0080: 000001C200000B63 47F8444669B30004 00770200F601004F 800100FE008D0400
00A0: 010DFD00FF371100 02F700FFDF15DC00 0100FF7F
.enddata
.head 2 +  Default Classes
.head 3 -  MDI Window: cBaseMDI
.head 3 -  Form Window:
.head 3 -  Dialog Box:
.head 3 -  Table Window:
.head 3 -  Quest Window:
.head 3 -  Data Field:
.head 3 -  Spin Field:
.head 3 -  Multiline Field:
.head 3 -  Pushbutton: cpbBrowse
.head 3 -  Radio Button:
.head 3 -  Option Button:
.head 3 -  Check Box:
.head 3 -  Child Table:
.head 3 -  Quest Child Window: cQuickDatabase
.head 3 -  List Box:
.head 3 -  Combo Box:
.head 3 -  Picture:
.head 3 -  Vertical Scroll Bar:
.head 3 -  Horizontal Scroll Bar:
.head 3 -  Column:
.head 3 -  Background Text:
.head 3 -  Group Box:
.head 3 -  Line:
.head 3 -  Frame:
.head 3 -  Custom Control:
.head 2 -  Application Actions
.head 1 +  Form Window: frmCheckInner
.head 2 -  Class: Form_Window_Checker
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Неоплаченые документы на контроле
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Display Style? Class Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   0.54"
.head 4 -  Top:    0.45"
.head 4 -  Width:  Class Default
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
.head 4 -  Height Editable? Class Default
.head 3 -  Form Size
.head 4 -  Width:  Class Default
.head 4 -  Height: Class Default
.head 4 -  Number of Pages: Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 2 -  Description: Форма работы с документами
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: Class Default
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Child Table: tblDocList
.head 4 -  Class Child Ref Key: 1
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Class Default
.head 6 -  Top:    Class Default
.head 6 -  Width:  13.0"
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  View: Class Default
.head 5 -  Allow Row Sizing? Class Default
.head 5 -  Lines Per Row: Class Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: 1000
.head 5 -  Discardable? Class Default
.head 4 +  Contents
.head 5 +  Column: colUId
.head 6 -  Class Child Ref Key: 8
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Исп
.head 6 -  Visible? Yes
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  0.686"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colRef
.head 6 -  Class Child Ref Key: 2
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  0.857"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colTT
.head 6 -  Class Child Ref Key: 3
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNd
.head 6 -  Class Child Ref Key: 34
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colAccA
.head 6 -  Class Child Ref Key: 39
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colAccB
.head 6 -  Class Child Ref Key: 40
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colMfoB
.head 6 -  Class Child Ref Key: 33
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDK
.head 6 -  Class Child Ref Key: 7
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colSum
.head 6 -  Class Child Ref Key: 6
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  2.071"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDig
.head 6 -  Class Child Ref Key: 28
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNSum
.head 6 -  Class Child Ref Key: 30
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNSumDig
.head 6 -  Class Child Ref Key: 44
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colCur
.head 6 -  Class Child Ref Key: 20
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  0.6"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colSK
.head 6 -  Class Child Ref Key: 25
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  0.686"
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNazn
.head 6 -  Class Child Ref Key: 24
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDig2
.head 6 -  Class Child Ref Key: 29
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNSum2
.head 6 -  Class Child Ref Key: 31
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNSum2Dig
.head 6 -  Class Child Ref Key: 45
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colSum2
.head 6 -  Class Child Ref Key: 27
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colChk
.head 6 -  Class Child Ref Key: 18
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colCur2
.head 6 -  Class Child Ref Key: 26
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colVdat
.head 6 -  Class Child Ref Key: 32
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNVisa
.head 6 -  Class Child Ref Key: 41
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colPrty
.head 6 -  Class Child Ref Key: 42
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colOtm
.head 6 -  Class Child Ref Key: 43
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 +  Window Variables
.head 5 -  Number: nTmp
.head 5 -  Boolean: bSortOrd
.head 5 -  Number: nColHan
.head 5 -  Number: nDig
.head 4 +  Message Actions
.head 5 +  On WM_RbuttonUp
.head 6 -  Call SalSendClassMessage(WM_RbuttonUp, wParam, lParam)
.head 6 -  Call SalModalDialog(dlg_SelectedInfo, hWndForm, frmCheckInner.tblDocList.nSelQuant,frmCheckInner.tblDocList.nSelSumm/100)
.head 3 +  Child Table: tblCheckMarks
.head 4 -  Class Child Ref Key: 9
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   7.0"
.head 6 -  Top:    Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  View: Class Default
.head 5 -  Allow Row Sizing? Class Default
.head 5 -  Lines Per Row: Class Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Class Default
.head 5 -  Discardable? Class Default
.head 4 +  Contents
.head 5 +  Column: colActionId
.head 6 -  Class Child Ref Key: 47
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colMentorGroup
.head 6 -  Class Child Ref Key: 10
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colMentorName
.head 6 -  Class Child Ref Key: 11
.head 6 -  Class ChildKey: 0
.head 6 -  Class: Form_Window_Checker
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? Class Default
.head 6 -  Editable? Class Default
.head 6 -  Maximum Data Length: Class Default
.head 6 -  Data Type: Class Default
.head 6 -  Justify: Class Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Format: Class Default
.head 6 -  Country: Class Default
.head 6 -  Input Mask: Class Default
.head 6 -  Cell Options
.head 7 -  Cell Type? Class Default
.head 7 -  Multiline Cell? Class Default
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Class Default
.head 8 -  Vertical Scroll? Class Default
.head 8 -  Auto Drop Down? Class Default
.head 8 -  Allow Text Editing? Class Default
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Class Default
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbFilter
.head 4 -  Class Child Ref Key: 12
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Class Default
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbPrint
.head 4 -  Class Child Ref Key: 14
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.383"
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\print.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbCheck
.head 4 -  Class Child Ref Key: 16
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.8"
.head 5 -  Top:    4.714"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tblDocList, ROW_Selected, 0)
.head 7 +  Select Case wParam
.head 8 +  Case 0   ! Визирование
.head 9 -  ! Будут визированы все отмеченные документы. Продолжать?
.head 9 +  If MessageQuestion(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessQuestionVisa')) = IDYES
.head 10 -  Call SalWaitCursor(TRUE)
.head 10 -  Set nNextRow = TBL_MinRow
.head 10 -  Set nMarkedRows = 0
.head 10 +  While SalTblFindNextRow(tblDocList, nNextRow, ROW_Selected, 0)
.head 11 -  Set nMarkedRows = nMarkedRows + 1
.head 10 -  !
.head 10 -  Set nNextRow = TBL_MinRow
.head 10 +  While SalTblFindNextRow(tblDocList, nNextRow, ROW_Selected, 0)
.head 11 -  Call SalTblSetContext(tblDocList, nNextRow)
.head 11 -  ! Обрабатывается документ REF=tblDocList.colRef
.head 11 -  Call SaveInfoToLog("VISA. " || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessExecDoc')||' REF=' || SalNumberToStrX( tblDocList.colRef, 0 ) )
.head 11 -  !
.head 11 +  If tblDocList.colUId != GetUserId() or fSam
.head 12 +  If SalTblQueryRowFlags(tblDocList, nNextRow, ROW_Edited)
.head 13 +  If not SqlPLSQLCommand(hSql(), "chk.put_prty(tblDocList.colRef, tblDocList.colPrty)")
.head 14 -  Call SqlRollbackEx(hSql(), "VISA. Ошибка установки признака СТП=" || Str(tblDocList.colPrty) || " для REF " || Str(tblDocList.colRef))
.head 14 -  Break
.head 13 -  Call SqlCommitEx(hSql(), "VISA. Установлен признак СТП=" || Str(tblDocList.colPrty) || " для REF " || Str(tblDocList.colRef))
.head 12 +  If DocumentCheckSpec(tblDocList.colRef, nCheckId, tblDocList.colChk,(nMarkedRows > 1), fSpec) = MBEx_Cancel
.head 13 -  Break
.head 11 +  Else
.head 12 -  Call SalMessageBeep(MB_IconStop) 
.head 12 -  ! Документ № tblDocList.colRef не может быть завизирован данным пользователем
  Нарушение технологии
.head 12 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessDoc')||' № ' ||
     SalNumberToStrX(tblDocList.colRef, 0) || ' '||CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessDoc1'), 
     CurrentLangTable.GetAtomTitle('cTTitleTechnErr'), MB_IconStop | MB_Ok)
.head 12 -  ! Отказ в визировании документа REF=tblDocList.colRef. Попытка визировать свой документ!
.head 12 -  Call SaveErrorToLog("VISA. " || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessNoVisa') || ' REF=' || SalNumberToStrX( tblDocList.colRef, 0 ) || '. ' ||
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessSelfVisa') )
.head 10 -  ! Clear Yes2all flags in function !
.head 10 -  Call MessageActionConfirm(MBEx_Clear, '')
.head 10 -  !
.head 10 -  Call SalSendMsg(tblDocList, WM_Populate, 0, 0)
.head 10 -  Call SalWaitCursor(FALSE)
.head 9 -  Break
.head 8 +  Case 1   ! Спеобработка
.head 9 +  If tblDocList.colTT = 'RCK'
.head 10 -  ! Расч Центр Клиентов (Петрокомерц) 
.head 10 -  Call SalModalDialog(dlg_RCK, hWndForm, tblDocList.colRef,
     tblDocList.colAccA, tblDocList.colAccB,
     tblDocList.colDK, tblDocList.colNSum,
     tblDocList.colNazn)
.head 9 +  Else
.head 10 -  ! АСПО
.head 10 -  Call SalModalDialog(dlg_Spec, hWndForm, tblDocList.colRef,
     tblDocList.colAccA, tblDocList.colAccB,
     tblDocList.colDK, tblDocList.colNSum,
     tblDocList.colNazn)
.head 9 -  Call SalSendMsg(tblDocList, WM_Populate, 0, 0)
.head 9 -  Break
.head 8 +  Default
.head 9 -  Break
.head 3 +  Pushbutton: pbReRead
.head 4 -  Class Child Ref Key: 21
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Class Default
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 -  !
.head 3 +  Pushbutton: pbSearch
.head 4 -  Class Child Ref Key: 13
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Class Default
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbDoc
.head 4 -  Class Child Ref Key: 15
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.383"
.head 5 -  Top:    5.274"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\open.bmp
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbDrop
.head 4 -  Class Child Ref Key: 17
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   2.8"
.head 5 -  Top:    5.274"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If SalTblAnyRows(tblDocList, ROW_Selected, 0)
.head 7 -  ! Проверим доставерность информции...
.head 7 +  If not FunIsDocCanBProcessed(tblDocList.colRef, nCheckId)
.head 8 -  Call SalMessageBeep(MB_IconStop) 
.head 8 -  ! Информация в таблице устарела! Рекомнедуем регулярно обновлять ее. 
  Нарушение технологии
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessInfo'), 
     CurrentLangTable.GetAtomTitle('cTTitleTechnErr'), MB_IconStop | MB_Ok)
.head 8 -  ! Обнаружена устаревшая информция в форме визирования. Выход из цикла обработки.
.head 8 -  Call SaveInfoToLog("VISA. " || CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessOldInfo'))
.head 8 -  Return FALSE 
.head 7 +  Select Case wParam
.head 8 +  Case 0   ! Сторнировтаь
.head 9 +  If SalTblAnyRows(tblDocList, ROW_Selected, 0)
.head 10 -  Call SalMessageBeep(MB_IconQuestion)
.head 10 -  ! Вы уверены, что хотите возвратить отмеченные документы плательщику?
  Сторно документов
.head 10 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessQuestionBack'),
   CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessStorno'), MB_IconQuestion | MB_YesNo | MB_DefButton1) = IDYES
.head 11 -  Set sStornoReasonId = ''
.head 11 -  Set sStornoReason = ''
.head 11 +  If FunNSIGet('BP_REASON', '', sStornoReasonId,  sStornoReason)
.head 12 +  If sStornoReasonId and sStornoReason
.head 13 -  Call SalWaitCursor(TRUE)
.head 13 -  Set nNextRow = TBL_MinRow
.head 13 +  While SalTblFindNextRow(tblDocList, nNextRow, ROW_Selected, 0)
.head 14 -  Call SalTblFetchRow(tblDocList, nNextRow)
.head 14 -  Call DocumentStorno(tblDocList.colRef, 5, Val(sStornoReasonId), nCheckId, 0)
.head 13 -  Call SalWaitCursor(FALSE)
.head 13 -  Call SalSendMsg(tblDocList, WM_Populate, 0, 0)
.head 12 +  Else
.head 13 -  Call SalMessageBeep(MB_IconStop)
.head 13 -  ! Причина отказа не была выбрана или пуста! Повторите операцию.
  Сторно документов, ошибка
.head 13 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('frmCheckInner.cTErrReason'), 
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTErrStorno'), MB_IconStop)
.head 11 +  Else
.head 12 -  Call SalMessageBeep(MB_IconStop)
.head 12 -  ! Причина отказа не была выбрана или пуста! Повторите операцию.
  Сторно документов, ошибка
.head 12 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('frmCheckInner.cTErrReason'), 
     CurrentLangTable.GetAtomTitle('frmCheckInner.cTErrStorno'), MB_IconStop)
.head 9 -  Break
.head 8 +  Case 1   ! На визу назад
.head 9 +  If SalTblAnyRows(tblDocList, ROW_Selected, 0)
.head 10 -  Call SalMessageBeep(MB_IconQuestion)
.head 10 -  ! Вы уверены, что хотите возвратить отмеченные документы на предыдущую группу визирования?
  Перераспределение
.head 10 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessQuestion1StepBack'),
   CurrentLangTable.GetAtomTitle('frmCheckInner.cTMess1'), MB_IconQuestion | MB_YesNo | MB_DefButton1) = IDYES
.head 11 -  Call SalWaitCursor(TRUE)
.head 11 -  Set nNextRow = TBL_MinRow
.head 11 +  While SalTblFindNextRow(tblDocList, nNextRow, ROW_Selected, 0)
.head 12 -  Call SalTblFetchRow(tblDocList, nNextRow)
.head 12 -  Call Document1StepBack(tblDocList.colRef, nCheckId, tblDocList.colChk)
.head 11 -  Call SalWaitCursor(FALSE)
.head 11 -  Call SalSendMsg(tblDocList, WM_Populate, 0, 0)
.head 9 -  Break
.head 8 +  Default
.head 9 -  Break
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 23
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Class Default
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: cpbTime
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTimer
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Timer
.head 4 -  Window Location and Size
.head 5 -  Left:   4.014"
.head 5 -  Top:    4.219"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.292"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On UM_TimerFired
.head 6 -  Call SalSendMsg(pbReRead,SAM_Click , 0, 0)
.head 5 +  On UM_ParentSize
.head 6 -  Call SalSetWindowLoc(hWndItem, 4.029,
     SalPixelsToFormUnits(hWndItem, lParam, TRUE) - 2.12)
.head 3 +  Pushbutton: pbPrintOption
.head 4 -  Class Child Ref Key: 36
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Class Default
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbCheckOption
.head 4 -  Class Child Ref Key: 37
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Class Default
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \Bars98\RESOURCE\BMP\Pop.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbDocOption
.head 4 -  Class Child Ref Key: 38
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Class Default
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbDropOption
.head 4 -  Class Child Ref Key: 35
.head 4 -  Class ChildKey: 0
.head 4 -  Class: Form_Window_Checker
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   Class Default
.head 5 -  Top:    Class Default
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbSbbSpec
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbBrowse
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Спецвиза
.head 4 -  Window Location and Size
.head 5 -  Left:   5.467"
.head 5 -  Top:    4.726"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  ! Будут визированы все отмеченные документы. Продолжать?
.head 6 +  If MessageQuestion(CurrentLangTable.GetAtomTitle('frmCheckInner.cTMessQuestionVisa')) = IDYES
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  !
.head 7 -  Set bSbbSpec = TRUE
.head 7 -  Set nNextRow = TBL_MinRow
.head 7 +  While SalTblFindNextRow(tblDocList, nNextRow, ROW_Selected, 0)
.head 8 -  Call SalTblSetContext(tblDocList, nNextRow)
.head 8 -  !
.head 8 +  If not SbbSpec(tblDocList.colRef)
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Call SalMessageBox("Ошибка сохранения отмеченных документов во временной таблице!", "Внимание!", MB_IconStop | MB_OK)
.head 9 -  Set bSbbSpec = FALSE
.head 9 -  Break
.head 7 +  If bSbbSpec and nNextRow >= 0
.head 8 -  !
.head 8 +  If SqlPLSQLCommand(hSql(), "sbb_spec(nCheckId)")
.head 9 -  Call SqlCommit(hSql())
.head 8 +  Else
.head 9 -  Call SqlRollback(hSql())
.head 9 -  Call SalMessageBox("Ошибка выполнения процедуры спецвизирования!", "Внимание!", MB_IconStop | MB_OK)
.head 7 -  !
.head 7 -  Call SalSendMsg(tblDocList, WM_Populate, 0, 0)
.head 7 -  Call SalWaitCursor(FALSE)
.head 5 +  On UM_ParentSize
.head 6 -  Call XSalSetWindowPos( hWndItem, 356, SalNumberRound( 0.6 * lParam + 40 ))
.head 2 +  Functions
.head 3 +  Function: DocViewLinked
.head 4 -  Description: Показать список связанных документов
Должна быть реализована в экземпляре класса
.head 4 -  Returns
.head 4 +  Parameters
.head 5 -  Window Handle: hWndParent
.head 5 -  Number: nRefParent
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nSubRefCnt
.head 4 +  Actions
.head 5 +  If SqlPrepareAndExecute( hSql(), 'SELECT refl INTO :nSubRefCnt FROM oper WHERE ref=:nRefParent' )
.head 6 +  If SqlFetchNext( hSql(), nFetchRes )
.head 7 +  If nSubRefCnt
.head 8 -  Call SalModalDialog( dlg_LinkedDocs, hWndParent, nRefParent )
.head 7 +  Else
.head 8 -  Call SalMessageBeep(MB_IconAsterisk)
.head 3 +  Function: SbbSpec
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 +  Parameters
.head 5 -  Number: nRef
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Return SqlPrepareAndExecute(hSql(), "insert into tmp_sbbspec(ref) values(:nRef)")
.head 2 +  Window Parameters
.head 3 -  Number: nMode	! 2 - СБЕРБАНК-спецвизирование
.head 3 -  Number: nCheckId
.head 3 -  String: strAdditional
.head 3 -  Boolean: fSam
.head 3 -  Number: fSpec
.head 2 +  Window Variables
.head 3 -  Number: nNextRow
.head 3 -  Number: nMarkedRows
.head 3 -  String: strCheckerName
.head 3 -  String: strHexMark2Ret
.head 3 -  String: sStornoReasonId
.head 3 -  String: sStornoReason
.head 3 -  ! cDoc: cDoc
.winattr class :
.head 4 -  Class: cDoc
.end
.head 3 -  Number: nInterval
.head 3 -  String: sAutoRefr
.head 3 -  String: sInterval
.head 3 -  !
.head 3 -  Number: nStatus
.head 3 -  Number: nUserId
.head 3 -  ! cDoc: cDoc
.winattr class :
.head 4 -  Class: cDoc
.end
.head 3 -  String: strKeyId
.head 3 -  Number: nFile
.head 3 -  Number: nCheck
.head 3 -  !
.head 3 -  String: sNls
.head 3 -  String: sMfo
.head 3 -  String: sNlsp
.head 3 -  Number: nS
.head 3 -  String: sNd
.head 3 -  String: sText1
.head 3 -  String: sPond
.head 3 -  String: sNaex
.head 3 -  String: sNaimp
.head 3 -  Number: nEom
.head 3 -  String: sSab0
.head 3 -  String: sOper
.head 3 -  String: AMFO
.head 3 -  !
.head 3 -  Number: nErr
.head 3 -  String: sErrTxt
.head 3 -  Boolean: isSignOk
.head 3 -  Boolean: isSqlOk
.head 3 -  !
.head 3 -  Boolean: bSbbSpec
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Присваиваем значения многоязыковым объектам
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SqlPrepareAndExecute(hSql(), "SELECT name INTO :strCheckerName FROM chklist WHERE idchk=:nCheckId")
.head 4 -  Call SqlFetchNext(hSql(), nFetchRes)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('frmCheckInner.cTWndTitle')|| ': [ ' || strCheckerName || ' ]')
.head 4 -  Call PrepareWindowEx(hWndForm)
.head 4 -  !
.head 4 -  Set frmCheckInner.strAddSql = strAdditional
.head 4 -  !
.head 4 -  Call SalUseRegistry(TRUE,GetCompanyName())
.head 4 -  Call SalGetProfileString('DocCheck','Autorefresh','0', sAutoRefr,GetProductName())
.head 4 -  Call SalGetProfileString('DocCheck','Interval','300', sInterval,GetProductName())
.head 4 -  Call SalUseRegistry(FALSE,GetCompanyName())
.head 4 -  Set nInterval = SalStrToNumber(sInterval)
.head 4 +  If sAutoRefr = '1'
.head 5 +  If sInterval != ''
.head 6 -  Call cpbTime.Init(nInterval, 0, TRUE)
.head 4 -  !
.head 4 +  If nMode != 2
.head 5 -  Call SalHideWindow(pbSbbSpec)
.head 4 -  !
.head 4 +  If NOT fSpec or fSpec > 3
.head 5 -  Call SalDisableWindow(pbCheckOption)
.head 4 +  Else If fSpec = 2
.head 5 -  Call SalDisableWindow(pbDropOption)
.head 4 +  Else If fSpec = 3
.head 5 -  Call SalDisableWindow(pbCheckOption)
.head 5 -  Call SalDisableWindow(pbDropOption)
.head 4 -  !
.head 4 -  ! Проверяем Участь банку в СТП
.head 4 +  If Val(GetValueStr("select nvl(ssp,0) from banks where mfo='" || GetBankMfo() || "'")) = 0
.head 5 -  Call SalHideWindow(tblDocList.colPrty)
.head 4 -  !
.head 4 -  Set frmCheckInner.nTabInstance = nCheckId
.head 4 -  !
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 3 +  On SAM_Destroy
.head 4 -  ! Disactivation of function's role, which activated for calling window
.head 4 +  If SalStrTrimX(SalStrUpperX(GetDBMS())) = 'ORACLE'
.head 5 -  Call XRoleUnset(hSql(), ' FunCheckDocuments() ')
.head 1 +  Dialog Box: dlg_ChkGroupSelect
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Группы контроля платежей
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  5.357"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.656"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Выбор группы контроля
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  List Box: lbGroupsCheck
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.086"
.head 5 -  Top:    0.083"
.head 5 -  Width:  5.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.396"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Multiple selection? No
.head 4 -  Sorted? No
.head 4 -  Vertical Scroll? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: System Window Color
.head 4 -  Horizontal Scroll? No
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set nIterator = 0
.head 6 +  Loop
.head 7 +  If nIterator >= nGrpNum
.head 8 -  Break
.head 7 -  Call SalListAdd(hWndItem, strGrpArray[nIterator,0])
.head 7 -  Set nIterator = nIterator + 1
.head 6 -  Call SalListSetSelect(hWndItem, 0)
.head 5 +  On SAM_DoubleClick
.head 6 -  Call SalSendMsg(pbSelect, SAM_Click, 0, 0)
.head 3 +  Pushbutton: pbSelect
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Выбрать
.head 4 -  Window Location and Size
.head 5 -  Left:   0.586"
.head 5 -  Top:    1.688"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Enter
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\APPLY.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm,
     SalStrToNumber(strGrpArray[
     SalListQuerySelection(lbGroupsCheck), 1]))
.head 3 +  Pushbutton: pbAbort
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cPushButtonLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Отменить
.head 4 -  Window Location and Size
.head 5 -  Left:   3.214"
.head 5 -  Top:    1.688"
.head 5 -  Width:  1.5"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.452"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\DISCARD.BMP
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, -1)
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nUserId
.head 2 +  Window Variables
.head 3 -  String: strGrpArray[*,2]
.head 3 -  Number: nGrpNum
.head 3 -  Number: nIterator
.head 3 -  !
.head 3 -  String: strGrpName
.head 3 -  Number: nGrpId
.head 3 -  !
.head 3 -  Number: nSelfCheck
.head 3 -  String: strSecure
.head 3 -  String: strSelf
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalCenterWindow(hWndForm)
.head 4 -  Call SetWindowFont(hWndForm)
.head 4 -  ! Присваиваем значения многоязыковым объектам
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('dlg_ChkGroupSelect.cTWndTitle')  )
.head 4 -  !
.head 4 -  Set strSecure = ''
.head 4 -  Set strSelf   = ''
.head 4 -  Set nSelfCheck = GetGlobalOptionEx( 'SELFVISA' )
.head 4 +  If EnhancedSecurity()
.head 5 -  Set strSecure = ' and NVL(b.approve,0)=1 and ' ||
    'date_is_valid(b.adate1,b.adate2,b.rdate1,b.rdate2)=1 '
.head 4 +  If nSelfCheck
.head 5 -  Set strSelf = strSelf || ' and a.idchk <> ' || SalNumberToStrX(nSelfCheck, 0) 
.head 4 -  Set nGrpNum = 0
.head 4 -  Call SqlPrepareAndExecute(hSql(), '
     SELECT distinct a.idchk,a.name
     INTO :nGrpId,:strGrpName
     FROM chklist a, staff_chk b
     WHERE a.idchk=b.chkid and b.id in (' ||
           GetSubstListId(nUserId, TRUE) || ') ' || strSecure || strSelf || ' ORDER BY 2')
.head 4 +  While SqlFetchNext(hSql(), nFetchRes)
.head 5 -  Set strGrpArray[nGrpNum,0] = strGrpName
.head 5 -  Set strGrpArray[nGrpNum,1] = SalNumberToStrX(nGrpId, 0)
.head 5 -  Set nGrpNum = nGrpNum + 1
.head 4 +  If nGrpNum = 1
.head 5 -  Call SalEndDialog(hWndForm,
     SalStrToNumber(strGrpArray[0, 1]))
.head 1 +  Dialog Box: dlg_RCK
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Обработка документа с отключением контроля на "КРАСНОЕ САЛЬДО" в  РЦК
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.3"
.head 4 -  Top:    0.333"
.head 4 -  Width:  12.067"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 5.548"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Data Field: sRef
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.133"
.head 6 -  Top:    0.115"
.head 6 -  Width:  1.233"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Референс в РЦК' )
.head 3 +  Data Field: MFOA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.733"
.head 6 -  Top:    0.119"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'МФО-А' )
.head 3 +  Data Field: NLSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.733"
.head 6 -  Top:    0.119"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Счет-А' )
.head 3 +  Data Field: NMSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.433"
.head 6 -  Top:    0.119"
.head 6 -  Width:  6.117"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Наименование-А' )
.head 3 +  Data Field: MFOB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.733"
.head 6 -  Top:    0.369"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'МФО-Б' )
.head 3 +  Data Field: NLSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.733"
.head 6 -  Top:    0.369"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Счет-Б' )
.head 3 +  Data Field: NMSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.433"
.head 6 -  Top:    0.369"
.head 6 -  Width:  6.117"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Наименование-Б' )
.head 3 +  Data Field: DK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.35"
.head 6 -  Top:    0.119"
.head 6 -  Width:  0.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'ДК' )
.head 3 +  Data Field: NAZN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.733"
.head 6 -  Top:    0.631"
.head 6 -  Width:  8.817"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Назначение платежа' )
.head 3 +  Data Field: REF_ABS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.133"
.head 6 -  Top:    0.369"
.head 6 -  Width:  1.233"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Референс в АБС' )
.head 3 +  Data Field: MFO_ABS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.133"
.head 6 -  Top:    0.631"
.head 6 -  Width:  1.233"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'МФО-АБС' )
.head 3 +  Data Field: DATD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.65"
.head 6 -  Top:    0.119"
.head 6 -  Width:  1.067"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Дата документа' )
.head 3 +  Data Field: ND
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.35"
.head 6 -  Top:    0.369"
.head 6 -  Width:  1.367"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, '№ документа' )
.head 3 +  Data Field: S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.35"
.head 6 -  Top:    0.631"
.head 6 -  Width:  1.367"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Сумма документа' )
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.383"
.head 5 -  Top:    4.19"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Light Green
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set strTip = ' РАЗРЕШИТЬ оплату с превышением лимита'
.head 5 +  On SAM_Click
.head 6 +  If SalMessageBox( 
" РАЗРЕШИТЬ оплату документа с превышением лимита РЦК ?", 
"В Н И М А Н И Е  !",
 MB_IconQuestion | MB_YesNo) = IDYES
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 -  Set sSql = "
Begin 
 update tts set flags= substr(flags,1,38)||'1'||substr(flags,40,25) where tt='RCK';
 gl.pay(2,"|| sRef ||", gl.BDATE);
 update tts set flags= substr(flags,1,38)||'0'||substr(flags,40,25) where tt='RCK';
 insert into oper_visa(ref,dat,userid,STATUS) values ("||sRef||",sysdate,USER_ID,2);
 insert into operw (ref, tag, value) values ("||sRef||",'OSNOV','"||OSNOV||"'); 
 commit;
End;" 
.head 7 -  ! Set sSql = "
Begin 
 update tts set flags= substr(flags,1,38)||'1'||substr(flags,40,25) where tt='RCK';
 gl.pay(2,"|| sRef ||", gl.BDATE);
 update tts set flags= substr(flags,1,38)||'0'||substr(flags,40,25) where tt='RCK';
 insert into oper_visa(ref,dat,userid,STATUS) values ("||sRef||",sysdate,USER_ID,2);
 insert into operw (ref, tag, value) values ("||sRef||",'OSNOV','"||OSNOV||"'); 
 RCK.in_rckque( "||sRef||");
 commit;
End;" 
.head 7 +  If SqlPrepareAndExecute(hSql(), sSql ) 
.head 8 -  Set sLog = "Реф.РЦК = "|| sRef || " оплачен с превышением лимитов ! "
.head 8 -  Call SaveFInfoToLog (sLog)
.head 8 -  ! Call SalDisableWindow( pbOK )
.head 8 -  Call SalEndDialog(hWndForm, 0)
.head 7 -  Call SalWaitCursor(FALSE)
.head 3 +  Pushbutton: pbDel
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.383"
.head 5 -  Top:    4.524"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name: \bars98\RESOURCE\BMP\DELETE.BMP
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Sky
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set strTip = ' ЗАПРЕТИТЬ оплату документа с превышением лимита РЦК  '
.head 5 +  On SAM_Click
.head 6 +  ! If SalMessageBox( 
" ЗАПРЕТИТЬ оплату документа с превышением лимита РЦК ?", 
"В Н И М А Н И Е  !",
 MB_IconQuestion | MB_YesNo) = IDYES
.head 7 -  ! Call SalWaitCursor(TRUE)
.head 7 -  ! Set sSql = "
Begin 
 update tts set flags= substr(flags,1,38)||'1'||substr(flags,40,25) where tt='RCK';
 gl.pay(2,"|| sRef ||", gl.BDATE);
 update tts set flags= substr(flags,1,38)||'0'||substr(flags,40,25) where tt='RCK';
 insert into oper_visa(ref,dat,userid,STATUS) values ("||sRef||",sysdate,USER_ID,2);
 insert into operw (ref, tag, value) values ("||sRef||",'OSNOV','"||OSNOV||"');
End;" 
.head 7 +  ! If SqlPrepareAndExecute(hSql(), sSql ) and SqlPrepareAndExecute(hSql(),'commit')
.head 8 -                                                                               Set sLog = "Реф.РЦК = "|| sRef || " оплачен с превышением лимитов ! "
.head 8 -                                                                               Call SaveFInfoToLog (sLog)
.head 8 -  ! Call SalDisableWindow( pbOK )
.head 8 -                                                                               Call SalEndDialog(hWndForm, 0)
.head 7 -  ! Call SalWaitCursor(FALSE)
.head 6 -  Call SalSendMsg(frmCheckInner.pbDrop, SAM_Click, 0, 0)
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 3 +  ! cpbOk: pbOK
.winattr class Pushbutton:
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Оплатить
.head 4 -  Window Location and Size
.head 5 -  Left:   7.483"
.head 5 -  Top:    1.702"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Apply.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +                                                                                  Message Actions 
.head 5 +                                                                                  On SAM_Click
.head 6 +                                                                                  If SalMessageBox( 
"Разрешить оплату документа с превышением лимита РЦК ?", 
"В Н И М А Н И Е  !",
 MB_IconQuestion | MB_YesNo) = IDYES
.head 7 -                                                                                  Call SalWaitCursor(TRUE)
.head 7 -                                                                                  Set sSql = "
Begin 
 update tts set flags= substr(flags,1,38)||'1'||substr(flags,40,25) where tt='RCK';
 gl.pay(2,"|| sRef ||", gl.BDATE);
 update tts set flags= substr(flags,1,38)||'0'||substr(flags,40,25) where tt='RCK';
 insert into oper_visa(ref,dat,userid,STATUS) values ("||sRef||",sysdate,USER_ID,2);
 insert into operw (ref, tag, value) values ("||sRef||",'OSNOV','"||OSNOV||"');
End;" 
.head 7 +                                                                                  If SqlPrepareAndExecute(hSql(), sSql ) and SqlPrepareAndExecute(hSql(),'commit')
.head 8 -                                                                                  Set sLog = "Реф.РЦК = "|| sRef || " оплачен с превышением лимитов ! "
.head 8 -                                                                                  Call SaveFInfoToLog (sLog)
.head 8 -  ! Call SalDisableWindow( pbOK )
.head 8 -                                                                                  Call SalEndDialog(hWndForm, 0)
.head 7 -                                                                                  Call SalWaitCursor(FALSE)
.head 3 +  ! cpbCancel: pbExit
.winattr class Pushbutton:
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Завершить
.head 4 -  Window Location and Size
.head 5 -  Left:   8.783"
.head 5 -  Top:    2.643"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.45"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: MS Sans Serif
.head 4 -  Font Size: 8
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 4 -  Picture Transparent Color: Gray
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.end
.head 4 +                                                                                  Message Actions 
.head 5 +                                                                                  On SAM_Click
.head 6 -                                                                                  Call SalEndDialog(hWndForm, 0)
.head 3 +  Multiline Field: OSNOV
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  String Type: String
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Border? Yes
.head 5 -  Word Wrap? Yes
.head 5 -  Vertical Scroll? Yes
.head 5 -  Window Location and Size
.head 6 -  Left:   0.133"
.head 6 -  Top:    4.214"
.head 6 -  Width:  11.15"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.964"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  ! On SAM_Validate
.head 6 +                                                                                 If OSNOV !=STRING_Null
.head 7 -                                                                                 Call SalEnableWindow( pbOK )
.head 6 +                                                                                 Else 
.head 7 -                                                                                 Call SalDisableWindow( pbOK )
.head 5 +  On SAM_AnyEdit
.head 6 +  If OSNOV !=STRING_Null
.head 7 -  Call SalEnableWindow( pbOK )
.head 6 +  Else
.head 7 -  Call SalDisableWindow( pbOK )
.head 5 +  On SAM_TooltipSetText
.head 6 -  Return XSalTooltipSetText( lParam, 'Документ-Основание, разрешающий превышение лимита' )
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: ctb_pbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Window Location and Size
.head 5 -  Left:   11.383"
.head 5 -  Top:    4.857"
.head 5 -  Width:  Class Default
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Maize
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set strTip = 'Завершить'
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 3 +  Child Table: tb
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.133"
.head 6 -  Top:    0.893"
.head 6 -  Width:  11.733"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.286"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Default
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: PL
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: №
 плана
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.667"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: KV
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Вал
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.483"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: SYM
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Символ
лимита
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.233"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: NAME
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Назначение
лимита
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  2.267"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: LIM
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Установлено
лимита
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.367"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Decimal
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: OST
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Использовано
лимита
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.383"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Decimal
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: NLIM
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Свободный
лимит
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.283"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Decimal
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 -  !
.head 5 +  Column: SYMD
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Символ
из док.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.267"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: S
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сумма
 документа
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.133"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Decimal
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: PAP
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class:
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: №
 плана
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.667"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_FetchRowDone
.head 6 +  If PAP =2 
.head 7 -  Set NLIM = LIM + OST
.head 7 +  If NLIM + S < 0 
.head 8 -  Call XSalTblSetRowBackColor( tb, lParam, SalColorFromRGB( 255,210,250 ))
.head 6 +  Else
.head 7 -  Set LIM = NUMBER_Null
.head 7 -  Set NLIM = NUMBER_Null
.head 6 +  If SYM != SYMD
.head 7 -  Set SYMD = STRING_Null
.head 7 -  Set S = NUMBER_Null
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: colRef 
.head 3 -  String: colAccA
.head 3 -  String: colAccB
.head 3 -  Number: colDK
.head 3 -  Number: colSum 
.head 3 -  String: colNazn
.head 2 +  Window Variables
.head 3 -  Number: nTmp
.head 3 -  String: sSql
.head 3 -  String: sLog
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Set sRef = Str(colRef)
.head 4 -  Set NLSA = colAccA
.head 4 -  Set NLSB = colAccB
.head 4 -  Set DK = colDK
.head 4 -  Set S = colSum/100
.head 4 -  Set NAZN = colNazn
.head 4 -  Set OSNOV = STRING_Null
.head 4 -  Call SalDisableWindow( pbOK )
.head 4 -  !
.head 4 +  If SqlPrepareAndExecute(hSql(),
"SELECT w.value, o.datd, o.mfoa, o.mfob, o.nam_a, o.nam_b, o.nd, o.dk,o.USERID
 INTO :REF_ABS,:DATD,:MFOA,:MFOB,:NMSA,:NMSB, :ND, :DK, :MFO_ABS
 FROM oper o, operw w WHERE o.ref=:colRef and o.ref=w.ref and w.tag='REF_A' ")
 and not SqlFetchNext(hSql(), nTmp)
.head 5 -  Call SalEndDialog(hWndForm, 0)
.head 4 -  If SalTblPopulate(dlg_RCK.tb, hSql(),
  "SELECT substr(b.nls,1,4)+0, a.kv, substr(b.nls,5,10), b.nms, 
          -o.S/100,  b.lim/100, b.ostc/100, substr(a.nls,5,10), b.pap 
   INTO :tb.PL, :tb.KV, :tb.SYM, :tb.NAME, :tb.S, :tb.LIM,:tb.OST, :tb.SYMD, :tb.PAP
   from accounts a, opldok o, accounts b  
   where a.kv=b.kv and o.acc=a.acc and o.ref=:colRef and o.dk=0 and 
         (b.pap=2 and a.nls like b.nls||'%' and b.lim+b.ostc-o.s <0 or b.nls=a.nls)
   order by b.nls ", TBL_FillAll)
.head 4 -  Call SalTblSetLockedColumns( tb, 7 )
.head 1 +  Dialog Box: dlg_Spec
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Специальная обработка документа Финансового учета 
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   0.29"
.head 4 -  Top:    0.542"
.head 4 -  Width:  11.843"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.969"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Data Field: REF_NU
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.157"
.head 6 -  Top:    0.115"
.head 6 -  Width:  0.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: NLSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.057"
.head 6 -  Top:    0.115"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: NLSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   5.057"
.head 6 -  Top:    0.417"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: DK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: 1
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.857"
.head 6 -  Top:    0.115"
.head 6 -  Width:  0.3"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: NAZN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.157"
.head 6 -  Top:    1.021"
.head 6 -  Width:  11.457"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.552"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: REF_FU
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.057"
.head 6 -  Top:    0.115"
.head 6 -  Width:  0.8"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: DATD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.157"
.head 6 -  Top:    0.115"
.head 6 -  Width:  1.1"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Date
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: MFOA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.057"
.head 6 -  Top:    0.115"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: MFOB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   4.057"
.head 6 -  Top:    0.417"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: NMSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.757"
.head 6 -  Top:    0.115"
.head 6 -  Width:  4.871"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: NMSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.757"
.head 6 -  Top:    0.417"
.head 6 -  Width:  4.871"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: ND
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   3.257"
.head 6 -  Top:    0.115"
.head 6 -  Width:  0.814"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Frame
.head 4 -  Resource Id: 14052
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.057"
.head 5 -  Top:    0.031"
.head 5 -  Width:  11.657"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 1.625"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Corners: Square
.head 4 -  Border Style: Etched
.head 4 -  Border Thickness: 1
.head 4 -  Border Color: 3D Shadow Color
.head 4 -  Background Color: Default
.head 3 -  Background Text: Сумма документа
.head 4 -  Resource Id: 14053
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   8.086"
.head 5 -  Top:    2.094"
.head 5 -  Width:  1.9"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgSumD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.186"
.head 6 -  Top:    2.333"
.head 6 -  Width:  1.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: SD
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   6.771"
.head 6 -  Top:    0.719"
.head 6 -  Width:  1.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 -  Background Text: Сумма показателя
.head 4 -  Resource Id: 14054
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.071"
.head 5 -  Top:    2.094"
.head 5 -  Width:  1.914"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgSumP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: NMS
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: String
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.986"
.head 6 -  Top:    2.333"
.head 6 -  Width:  6.2"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Left
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: OST
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    2.333"
.head 6 -  Width:  1.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Data Field: S1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   8.186"
.head 6 -  Top:    2.708"
.head 6 -  Width:  1.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Combo Box: cmb1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cGenComboBox_NumId
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Window Location and Size
.head 5 -  Left:   1.986"
.head 5 -  Top:    2.708"
.head 5 -  Width:  6.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 1.76"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  String Type: Class Default
.head 4 -  Maximum Data Length: 35
.head 4 -  Sorted? Class Default
.head 4 -  Always Show List? Class Default
.head 4 -  Vertical Scroll? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  List Initialization
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call cmb1.Init(hWndItem)
.head 6 -  Call cmb1.Populate(hSql(), "NLS", "NLS || ' ' || NMS",
     "SALDOD", " WHERE nls <>:NLS and isp=" || Str(nId) ||
     " ORDER BY nms ")
.head 5 +  On SAM_Click
.head 6 -  Set NLS1 = cmb1.GetKey(SalListQuerySelection(hWndItem))
.head 6 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT ostc/100
     INTO :OST1
     FROM accounts
     WHERE nls=:NLS1 and kv=:n980")
.head 6 -  Call SqlFetchNext(hSql(),nTmp)
.head 6 -  ! Call DebugN(NLS1)
.head 3 +  Data Field: OST1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.086"
.head 6 -  Top:    2.708"
.head 6 -  Width:  1.9"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: Unformatted
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbOK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbOk
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Оплатить
.head 4 -  Window Location and Size
.head 5 -  Left:   10.3"
.head 5 -  Top:    2.51"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 +  If S1 <= 0
.head 7 -  Call Debug('Не указана СУММА уменьшения')
.head 6 +  Else If S1 > S
.head 7 -  Call Debug('Cумма уменьшения больше суммы документа')
.head 6 +  Else If NLS1 = 0 
.head 7 -  Call Debug('Не указан СЧЕТ для уменьшения')
.head 6 +  Else
.head 7 -  Call SalWaitCursor(TRUE)
.head 7 +  If ccDoc.PayTT(1, REF_NU, bDate, 'POR', nDk, n980,
   Str(NLS), S1*100, n980, Str(NLS1), S1*100)
.head 8 -  Call SqlCommit(hSql())
.head 8 -  Call F_Clear()
.head 7 +  ! If not SqlPLSQLCommand(hSql(),
   "PAYTT(Pay,Ref,DatV,TT,Dk,KvA,NlsA,SA,KvB,NlsB,SB)")
.head 8 -                                                                                                            Call SqlCommit(hSql())
.head 8 -                                                                                                            Call F_Clear()
.head 7 +  Else
.head 8 -  Call SqlRollback(hSql())
.head 7 -  Call SalWaitCursor(FALSE)
.head 3 +  Pushbutton: pbExit
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cpbCancel
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Завершить
.head 4 -  Window Location and Size
.head 5 -  Left:   5.243"
.head 5 -  Top:    3.125"
.head 5 -  Width:  1.3"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: Class Default
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Call SalEndDialog(hWndForm, 0)
.head 2 +  Functions
.head 3 +  Function: F_Clear
.head 4 -  Description:
.head 4 -  Returns
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 -  Local variables
.head 4 +  Actions
.head 5 -  Set OST = OST - S1
.head 5 -  Set S = S - S1
.head 5 -  Set OST1 = OST1 + S1
.head 5 -  Set NLS1 = 0
.head 5 -  Set S1 = 0
.head 2 +  Window Parameters
.head 3 -  Number: colRef 
.head 3 -  String: colAccA
.head 3 -  String: colAccB
.head 3 -  Number: colDK
.head 3 -  Number: colSum 
.head 3 -  String: colNazn
.head 2 +  Window Variables
.head 3 -  Number: nTmp
.head 3 -  Number: NLS1
.head 3 -  : ccDoc
.head 4 -  Class: cDoc
.head 3 -  Number: nDk
.head 3 -  Number: nId
.head 3 -  Number: n980
.head 3 -  String: sTT
.head 3 -  Number: NLS
.head 3 -  Date/Time: bDate
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SetWindowFont(hWndForm)
.head 4 -  ! Присваиваем значения многоязыковым объектам
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('dlg_Spec.cTWndTitle'))
.head 4 -  !
.head 4 -  Set REF_NU = colRef
.head 4 -  Set NLSA = colAccA
.head 4 -  Set NLSB = colAccB
.head 4 -  Set nId = GetUserId()
.head 4 -  Set bDate = GetBankDate()
.head 4 -  Set n980 = GetBaseVal()
.head 4 -  Set DK = colDK
.head 4 -  Set S = colSum/100
.head 4 -  Set SD = colSum/100
.head 4 -  Set NAZN = colNazn
.head 4 -  Call SqlPrepareAndExecute(hSql(), "
     SELECT p.REFL,p.datd,p.mfoa,p.mfob,p.nam_a,p.nam_b,p.nd,
            a.nls,a.nls || ' ' || a.nms,o.dk,abs(a.ostc)/100
     INTO :REF_FU,:DATD,:MFOA,:MFOB,:NMSA,:NMSB,:ND,:NLS,:NMS,
          :nDk,:OST
     FROM oper p, opldok o, accounts a
     WHERE p.sos=1 and o.ref=p.ref and o.acc=a.acc and
           o.tt=p.tt and o.tt=p.tt and o.s=p.s and
           substr(a.nls,1,4)<>'8999' and p.ref=:REF_NU")
.head 4 +  If not SqlFetchNext(hSql(), nTmp)
.head 5 -  Call SalEndDialog(hWndForm, 0)
.head 4 -  Set NLS1 = 0
.head 4 -  Call F_Clear()
.head 1 +  Dialog Box: dlg_SelectedInfo
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Отмечено...
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  4.55"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 1.0"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Показать результаты выборки (кол-во и сумма)
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 -  Background Text: Документов:
.head 4 -  Resource Id: 21374
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.25"
.head 5 -  Top:    0.06"
.head 5 -  Width:  1.367"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 9
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgDoc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfQuant
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.733"
.head 6 -  Top:    0.024"
.head 6 -  Width:  2.283"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Unformatted
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set MyValue = nQuant
.head 3 -  Background Text: На сумму:
.head 4 -  Resource Id: 21375
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.25"
.head 5 -  Top:    0.31"
.head 5 -  Width:  1.367"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Right
.head 4 -  Font Name: Arial Cyr
.head 4 -  Font Size: 9
.head 4 -  Font Enhancement: Bold
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: bgSum
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cLabelControl
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Class Default
.head 5 -  Data Type: Class Default
.head 5 -  Editable? Class Default
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   Default
.head 6 -  Top:    Default
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Border? Class Default
.head 5 -  Justify: Class Default
.head 5 -  Format: Class Default
.head 5 -  Country: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Input Mask: Class Default
.head 4 -  Message Actions
.head 3 +  Data Field: dfSumm
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Number
.head 5 -  Editable? No
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   1.733"
.head 6 -  Top:    0.286"
.head 6 -  Width:  2.283"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Right
.head 5 -  Format: Decimal
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Bold
.head 5 -  Text Color: Default
.head 5 -  Background Color: 3D Face Color
.head 5 -  Input Mask: Unformatted
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Set MyValue = nSumm
.head 3 +  Pushbutton: pbOk
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cTimer
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: It's Time
.head 4 -  Window Location and Size
.head 5 -  Left:   1.517"
.head 5 -  Top:    0.595"
.head 5 -  Width:  1.2"
.head 5 -  Width Editable? Class Default
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Keyboard Accelerator: Esc
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: Class Default
.head 4 -  Image Style: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 4 +  Message Actions
.head 5 +  On SAM_Create
.head 6 -  Call pbOk.Init( 3, 1, FALSE )
.head 5 +  On UM_TimerFired
.head 6 -  Call SalEndDialog( hWndForm, 1 )
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nQuant
.head 3 -  Number: nSumm
.head 2 -  Window Variables
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call PrepareWindow( hWndForm )
.head 4 -  Call SalCenterWindow( hWndForm )
.head 4 -  ! Присваиваем значения многоязыковым объектам
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('dlg_SelectedInfo.cTWndTitle') )
.head 4 -  !
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor( FALSE )
.head 3 +  On SAM_Destroy
.head 4 -  Call pbOk.Kill(  )
.head 1 +  Dialog Box: dlg_LinkedDocs
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Підпорядковані документи
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Type of Dialog: Modal
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  8.75"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 3.881"
.head 4 -  Height Editable? Yes
.head 3 -  Absolute Screen Location? Yes
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description: Показать связанные документы (чеки, пр.) по RefL
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? Yes
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 +  Child Table: tblSubDoc
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   0.0"
.head 6 -  Top:    0.0"
.head 6 -  Width:  8.633"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 3.548"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Arial Cyr
.head 5 -  Font Size: 9
.head 5 -  Font Enhancement: None
.head 5 -  Text Color: Default
.head 5 -  Background Color: Maize
.head 5 -  View: Table
.head 5 -  Allow Row Sizing? No
.head 5 -  Lines Per Row: Default
.head 4 -  Memory Settings
.head 5 -  Maximum Rows in Memory: Default
.head 5 -  Discardable? Yes
.head 4 +  Contents
.head 5 +  Column: colRef
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Референс
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  1.2"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colTT
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Код
оп.
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 3
.head 6 -  Data Type: String
.head 6 -  Justify: Center
.head 6 -  Width:  0.55"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colND
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Номер
док-та
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNLS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Рахунок А
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  1.6"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сума
.head 6 -  Visible? No
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  2.3"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Decimal
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDig
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title:
.head 6 -  Visible? No
.head 6 -  Editable? Yes
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Justify: Left
.head 6 -  Width:  Default
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colSS
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Сума
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Right
.head 6 -  Width:  2.0"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colDK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Д/К
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 1
.head 6 -  Data Type: Number
.head 6 -  Justify: Right
.head 6 -  Width:  0.45"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colSK
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: СКП
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: 2
.head 6 -  Data Type: Number
.head 6 -  Justify: Center
.head 6 -  Width:  0.5"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 5 +  Column: colNazn
.head 6 -  Class Child Ref Key: 0
.head 6 -  Class ChildKey: 0
.head 6 -  Class: cColumnLabeled
.head 6 -  Property Template:
.head 6 -  Class DLL Name:
.head 6 -  Title: Призначення платежу
.head 6 -  Visible? Yes
.head 6 -  Editable? No
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: String
.head 6 -  Justify: Left
.head 6 -  Width:  4.517"
.head 6 -  Width Editable? Yes
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Input Mask: Unformatted
.head 6 -  Cell Options
.head 7 -  Cell Type? Standard
.head 7 -  Multiline Cell? No
.head 7 -  Cell DropDownList
.head 8 -  Sorted? Yes
.head 8 -  Vertical Scroll? Yes
.head 8 -  Auto Drop Down? No
.head 8 -  Allow Text Editing? Yes
.head 7 -  Cell CheckBox
.head 8 -  Check Value:
.head 8 -  Uncheck Value:
.head 8 -  Ignore Case? Yes
.head 6 -  List Values
.head 6 -  Message Actions
.head 4 -  Functions
.head 4 -  Window Variables
.head 4 +  Message Actions
.head 5 +  On SAM_FetchRowDone
.head 6 -  Set colSS = Dig4( colS/100, colDig, 4 )
.head 6 +  If nDig = 0
.head 7 -  Set nDig = colDig
.head 6 +  If colDK = 0 OR colDK = 2
.head 7 -  Set nSummD = nSummD + colS
.head 6 +  Else
.head 7 -  Set nSummK = nSummK + colS
.head 5 +  On SAM_DoubleClick
.head 6 +  If tblSubDoc.colRef
.head 7 -  Call DocViewContentsEx(hWndForm, tblSubDoc.colRef )
.head 5 +  On SAM_Create
.head 6 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 2 -  Functions
.head 2 +  Window Parameters
.head 3 -  Number: nRefL
.head 2 +  Window Variables
.head 3 -  : TSD
.head 4 -  Class: cABSConnect
.head 3 -  Number: nSummD
.head 3 -  Number: nSummK
.head 3 -  Number: nDig
.head 3 -  Number: nTotalRow
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  Call SalWaitCursor( TRUE )
.head 4 -  Call SetWindowFont(hWndForm)
.head 4 -  Call XConnectGetParams( TSD )
.head 4 +  If NOT TSD.Connect()
.head 5 -  Return FALSE
.head 4 -  Call SalSetWindowText( hWndForm, 'Підпорядковані документи для документа з реф. ' || SalNumberToStrX( nRefL, 0 ) )
.head 4 -  ! Присваиваем значения многоязыковым объектам
.head 4 -  Call SalSendMsgToChildren( hWndForm, UM_QueryLabelText, 0, 0 )
.head 4 -  Call SalSetWindowText( hWndForm, CurrentLangTable.GetAtomTitle('dlg_LinkedDocs.cTWndTitle') || SalNumberToStrX( nRefL, 0 ) )
.head 4 -  !
.head 4 -  Set nSummD = 0
.head 4 -  Set nSummK = 0
.head 4 -  Set nDig  = 0
.head 4 -  Call SalTblPopulate( tblSubDoc, TSD.hSql(), 
'SELECT ref, tt, nd, nlsa, s, dig, dk, sk, nazn  
 INTO :hWndForm.dlg_LinkedDocs.tblSubDoc.colRef, :hWndForm.dlg_LinkedDocs.tblSubDoc.colTT,
      :hWndForm.dlg_LinkedDocs.tblSubDoc.colND, 
      :hWndForm.dlg_LinkedDocs.tblSubDoc.colNLS, :hWndForm.dlg_LinkedDocs.tblSubDoc.colS,
      :hWndForm.dlg_LinkedDocs.tblSubDoc.colDig,
      :hWndForm.dlg_LinkedDocs.tblSubDoc.colDK, :hWndForm.dlg_LinkedDocs.tblSubDoc.colSK,
      :hWndForm.dlg_LinkedDocs.tblSubDoc.colNazn  
 FROM tabval, (SELECT ref, tt, nd, nlsa, s, dk, sk, nazn, kv   
               FROM oper
               WHERE ref <> :nRefL
               START WITH ref=:nRefL CONNECT BY PRIOR refl=ref) o 
 WHERE tabval.kv=o.kv', TBL_FillAll )
.head 4 +  If nSummD
.head 5 -  Set nTotalRow = SalTblInsertRow( tblSubDoc, TBL_MaxRow )
.head 5 +  If nTotalRow != TBL_Error
.head 6 -  Call SalTblSetContext( tblSubDoc, nTotalRow ) 
.head 6 -  ! Set hWndForm.dlg_LinkedDocs.tblSubDoc.colND = 'ВСЬОГО'
.head 6 -  Set hWndForm.dlg_LinkedDocs.tblSubDoc.colND = CurrentLangTable.GetAtomTitle('dlg_LinkedDocs.cTItogo')
.head 6 -  Set hWndForm.dlg_LinkedDocs.tblSubDoc.colSS = Dig4( nSummD/100, nDig, 4 )
.head 6 -  Set hWndForm.dlg_LinkedDocs.tblSubDoc.colDK = 0
.head 6 -  Call SalTblSetRowFlags( tblSubDoc, nTotalRow, ROW_New, FALSE )
.head 4 +  If nSummK
.head 5 -  Set nTotalRow = SalTblInsertRow( tblSubDoc, TBL_MaxRow )
.head 5 +  If nTotalRow != TBL_Error
.head 6 -  Call SalTblSetContext( tblSubDoc, nTotalRow ) 
.head 6 -  ! Set hWndForm.dlg_LinkedDocs.tblSubDoc.colND = 'ВСЬОГО'
.head 6 -  Set hWndForm.dlg_LinkedDocs.tblSubDoc.colND = CurrentLangTable.GetAtomTitle('dlg_LinkedDocs.cTItogo')
.head 6 -  Set hWndForm.dlg_LinkedDocs.tblSubDoc.colSS = Dig4( nSummK/100, nDig, 4 )
.head 6 -  Set hWndForm.dlg_LinkedDocs.tblSubDoc.colDK = 1
.head 6 -  Call SalTblSetRowFlags( tblSubDoc, nTotalRow, ROW_New, FALSE )
.head 4 -  Call SalCenterWindow( hWndForm )
.head 3 +  On SAM_CreateComplete
.head 4 -  Call SalWaitCursor( FALSE )
.head 3 +  On SAM_Destroy
.head 4 +  If TSD.IsConnected(  )
.head 5 -  Call TSD.Disconnect(  )
.head 1 +  Table Window: VR
.head 2 -  Class: cGenericTable
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Верификация Ввода
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? Class Default
.head 2 -  Visible? Class Default
.head 2 -  Display Settings
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Class Default
.head 3 -  Initial State: Class Default
.head 3 -  Maximizable? Class Default
.head 3 -  Minimizable? Class Default
.head 3 -  System Menu? Class Default
.head 3 -  Resizable? Class Default
.head 3 -  Window Location and Size
.head 4 -  Left:   0.275"
.head 4 -  Top:    0.229"
.head 4 -  Width:  14.8"
.head 4 -  Width Editable? Class Default
.head 4 -  Height: Class Default
.head 4 -  Height Editable? Class Default
.head 3 -  Font Name: Class Default
.head 3 -  Font Size: Class Default
.head 3 -  Font Enhancement: Class Default
.head 3 -  Text Color: Class Default
.head 3 -  Background Color: Class Default
.head 3 -  View: Class Default
.head 3 -  Allow Row Sizing? Class Default
.head 3 -  Lines Per Row: Class Default
.head 2 -  Memory Settings
.head 3 -  Maximum Rows in Memory: 65535
.head 3 -  Discardable? Class Default
.head 2 -  Description: Верификация
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Class Default
.head 4 -  Location? Class Default
.head 4 -  Visible? Class Default
.head 4 -  Size: 0.464"
.head 4 -  Size Editable? Class Default
.head 4 -  Font Name: Class Default
.head 4 -  Font Size: Class Default
.head 4 -  Font Enhancement: Class Default
.head 4 -  Text Color: Class Default
.head 4 -  Background Color: Class Default
.head 3 +  Contents
.head 4 +  Pushbutton: pbIns
.head 5 -  Class Child Ref Key: 33
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.033"
.head 6 -  Top:    0.06"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbDel
.head 5 -  Class Child Ref Key: 34
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.514"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Yes
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If SalTblAnyRows(hWndForm, ROW_Selected, 0)
.head 8 -  ! If SalMessageBox('Вы уверены, что хотите возвратить реф.' || Str(REF) || ' ?', 
   'Сторно документов', MB_IconQuestion | MB_YesNo | MB_DefButton1) = IDYES
.head 8 +  If SalMessageBox(CurrentLangTable.GetAtomTitle('VR.cTMessBack') || Str(REF) || ' ?', 
   CurrentLangTable.GetAtomTitle('VR.cTMessStorno'),  MB_IconQuestion | MB_YesNo | MB_DefButton1) = IDYES
.head 9 -  Set sNaznErr = CurrentLangTable.GetAtomTitle('VR.cTNazn')
.head 9 +  If DocumentStorno(VR.REF, 5, 0, nCheckId, 0)
.head 10 +  If SqlPrepareAndExecute(hSql(),
"UPDATE operw SET value=:sNaznErr WHERE ref=:REF AND tag='BACKR'")
.head 11 -  Call SqlCommitEx(hSql(), "VR. Возврат документа REF " || Str(VR.REF) || " на верификации [Пользователь " || Str(nId) || "]")
.head 11 -  Set nTmp = SalTblQueryContext(hWndForm)
.head 11 -  Set dKol = dKol-1
.head 11 -  Set dSum = dSum-S1
.head 11 -  Call SetTblRowColor(VR, COLOR_Red)
.head 11 -  Call SalTblSetRowFlags(VR, nTmp, ROW_Edited, FALSE)
.head 11 -  Call SalTblSetRowFlags(VR, nTmp, ROW_New, TRUE)
.head 7 -  Call SalWaitCursor(FALSE)
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Вернуть документ'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('VR.cBTipDel')
.head 4 +  Pushbutton: pbRefresh
.head 5 -  Class Child Ref Key: 35
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.333"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbUpdate
.head 5 -  Class Child Ref Key: 36
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.583"
.head 6 -  Top:    0.083"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 36974
.head 5 -  Class Child Ref Key: 37
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbSearch
.head 5 -  Class Child Ref Key: 38
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   0.767"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 +  Pushbutton: pbFilter
.head 5 -  Class Child Ref Key: 44
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.2"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If SetQueryFilter(VR.cF)
.head 8 -  Call SalMapEnterToTab(TRUE)
.head 8 -  Call SalPostMsg(hWndForm, UM_Populate, 0, 0)
.head 4 +  Pushbutton: pbDetails
.head 5 -  Class Child Ref Key: 39
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.057"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Call DocViewContentsEx(hWndMDI, VR.REF)
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Посмотреть введенный документ'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('VR.cBTipDetails')
.head 4 +  Pushbutton: pbPrint
.head 5 -  Class Child Ref Key: 40
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   1.633"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 36975
.head 5 -  Class Child Ref Key: 41
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Pushbutton: pbExit
.head 5 -  Class Child Ref Key: 42
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   10.986"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Discard.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 -  Message Actions
.head 4 -  Line
.head 5 -  Resource Id: 36976
.head 5 -  Class Child Ref Key: 43
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cGenericTable
.head 5 -  Coordinates
.head 6 -  Begin X:  Class Default
.head 6 -  Begin Y:  Class Default
.head 6 -  End X:  Class Default
.head 6 -  End Y:  Class Default
.head 5 -  Visible? No
.head 5 -  Line Style: Class Default
.head 5 -  Line Thickness: Class Default
.head 5 -  Line Color: Class Default
.head 4 +  Data Field: dKol
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   8.457"
.head 7 -  Top:    0.052"
.head 7 -  Width:  0.529"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.313"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Right
.head 6 -  Format: Unformatted
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Data Field: dSum
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class:
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Data
.head 6 -  Maximum Data Length: Default
.head 6 -  Data Type: Number
.head 6 -  Editable? No
.head 5 -  Display Settings
.head 6 -  Window Location and Size
.head 7 -  Left:   8.986"
.head 7 -  Top:    0.052"
.head 7 -  Width:  1.6"
.head 7 -  Width Editable? Yes
.head 7 -  Height: 0.313"
.head 7 -  Height Editable? Yes
.head 6 -  Visible? Yes
.head 6 -  Border? Yes
.head 6 -  Justify: Right
.head 6 -  Format: Decimal
.head 6 -  Country: Default
.head 6 -  Font Name: Default
.head 6 -  Font Size: Default
.head 6 -  Font Enhancement: Default
.head 6 -  Text Color: Default
.head 6 -  Background Color: Default
.head 6 -  Input Mask: Unformatted
.head 5 -  Message Actions
.head 4 +  Pushbutton: pb_Kol
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbOk
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   7.957"
.head 6 -  Top:    0.048"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? Class Default
.head 5 -  Keyboard Accelerator: Class Default
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name: \BARS98\RESOURCE\BMP\Help.bmp
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  ! Call fKol(dKol, dSum)
.head 6 +  On SAM_Create
.head 7 -  ! Set strTip = 'Сколько в очереди?'
.head 7 -  Set strTip = CurrentLangTable.GetAtomTitle('VR.cBTipKol')
.head 4 +  Check Box: cb_NLSA
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cCheckBoxLabeled
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Счет-А
.head 5 -  Window Location and Size
.head 6 -  Left:   2.383"
.head 6 -  Top:    0.071"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.26"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If not cb_NLSA
.head 8 -  Call SalHideWindow(NLSA)
.head 7 +  Else
.head 8 -  Call SalShowWindow(NLSA)
.head 4 +  Check Box: cb_MFOB
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cCheckBoxLabeled
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: МФО-Б
.head 5 -  Window Location and Size
.head 6 -  Left:   3.5"
.head 6 -  Top:    0.071"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.26"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If not cb_MFOB
.head 8 -  Call SalHideWindow(MFOB)
.head 7 +  Else
.head 8 -  Call SalShowWindow(MFOB)
.head 4 +  Check Box: cb_NLSB
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cCheckBoxLabeled
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: Счет-Б
.head 5 -  Window Location and Size
.head 6 -  Left:   4.617"
.head 6 -  Top:    0.071"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.26"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If not cb_NLSB
.head 8 -  Call SalHideWindow(NLSB)
.head 7 +  Else
.head 8 -  Call SalShowWindow(NLSB)
.head 4 +  Check Box: cb_OKPOB
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: cCheckBoxLabeled
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title: ОКПО-Б
.head 5 -  Window Location and Size
.head 6 -  Left:   5.743"
.head 6 -  Top:    0.073"
.head 6 -  Width:  1.0"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.26"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 +  If not cb_OKPOB
.head 8 -  Call SalHideWindow(OKPOB)
.head 7 +  Else
.head 8 -  Call SalShowWindow(OKPOB)
.head 4 +  Pushbutton: pbF6
.head 5 -  Class Child Ref Key: 0
.head 5 -  Class ChildKey: 0
.head 5 -  Class: ctb_pbChilds
.head 5 -  Property Template:
.head 5 -  Class DLL Name:
.head 5 -  Title:
.head 5 -  Window Location and Size
.head 6 -  Left:   10.886"
.head 6 -  Top:    0.052"
.head 6 -  Width:  Class Default
.head 6 -  Width Editable? Class Default
.head 6 -  Height: Class Default
.head 6 -  Height Editable? Class Default
.head 5 -  Visible? No
.head 5 -  Keyboard Accelerator: F6
.head 5 -  Font Name: Class Default
.head 5 -  Font Size: Class Default
.head 5 -  Font Enhancement: Class Default
.head 5 -  Picture File Name:
.head 5 -  Picture Transparent Color: Class Default
.head 5 -  Image Style: Class Default
.head 5 -  Text Color: Class Default
.head 5 -  Background Color: Class Default
.head 5 +  Message Actions
.head 6 +  On SAM_Click
.head 7 -  Set bShowC = not bShowC
.head 7 +  If bShowC
.head 8 +  If ShowInputPassword(  )
.head 9 -  Call SalShowWindow( S1 )
.head 9 -  Call SalShowWindow( NLSA1 )
.head 9 -  Call SalShowWindow( MFOB1 )
.head 9 -  Call SalShowWindow( NLSB1 )
.head 9 -  Call SalShowWindow( OKPOB1 )
.head 7 +  Else
.head 8 -  Call SalHideWindow( S1 )
.head 8 -  Call SalHideWindow( NLSA1 )
.head 8 -  Call SalHideWindow( MFOB1 )
.head 8 -  Call SalHideWindow( NLSB1 )
.head 8 -  Call SalHideWindow( OKPOB1 )
.head 6 +  On SAM_Create
.head 7 -  Set bShowC = FALSE
.head 7 -  Call SalHideWindow( S1 )
.head 7 -  Call SalHideWindow( NLSA1 )
.head 7 -  Call SalHideWindow( MFOB1 )
.head 7 -  Call SalHideWindow( NLSB1 )
.head 7 -  Call SalHideWindow( OKPOB1 )
.head 2 +  Contents
.head 3 +  Column: REF
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Реф
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Left
.head 4 -  Width:  1.0"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: ND
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: № док
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.033"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: ISP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Исп.
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Center
.head 4 -  Width:  0.5"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: NLSA
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-А
вериф
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If NOT SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set nContextRow = SalTblQueryContext(hWndForm)
.head 7 +  If NLSA != NLSA1 
.head 8 -  Call SalTblSetCellTextColor(NLSA, COLOR_Red, FALSE)
.head 8 -  ! Call SalMessageBox('Счет-А !', 'Ошибка!', MB_IconStop)
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('VR.cTErrNLSA'), 
     CurrentLangTable.GetAtomTitle('cTTitleError'), MB_IconStop)
.head 7 +  Else
.head 8 -  Call SalTblSetCellTextColor(NLSA, COLOR_DarkGreen, FALSE)
.head 8 +  If S = S1 and
   (cb_NLSB and NLSB = NLSB1 or not cb_NLSB) and 
   (cb_MFOB and MFOB = MFOB1 or not cb_MFOB) and 
   (cb_OKPOB and OKPOB = OKPOB1 or not cb_OKPOB)
.head 9 -  ! Хорошая виза
.head 9 -  Call VISA_PLUS()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_SetFocus
.head 6 -  Set sValTmp = NLSA
.head 5 +  On SAM_AnyEdit
.head 6 +  If SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set NLSA = sValTmp
.head 3 +  Column: MFOB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: МФО-Б
вериф
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 6
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.2"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If NOT SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set nContextRow = SalTblQueryContext(hWndForm)
.head 7 +  If MFOB != MFOB1
.head 8 -  Call SalTblSetCellTextColor(MFOB, COLOR_Red, FALSE)
.head 8 -  ! Call SalMessageBox('Мфо-Б !', 'Ошибка!', MB_IconStop)
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('VR.cTErrMFOB'), 
     CurrentLangTable.GetAtomTitle('cTTitleError'), MB_IconStop)
.head 7 +  Else
.head 8 -  Call SalTblSetCellTextColor(MFOB, COLOR_DarkGreen, FALSE)
.head 8 +  If S = S1 and
   (cb_NLSB and NLSB = NLSB1 or not cb_NLSB) and 
   (cb_NLSA and NLSA = NLSA1 or not cb_NLSA) and 
   (cb_OKPOB and OKPOB = OKPOB1 or not cb_OKPOB)
.head 9 -  ! Хорошая виза
.head 9 -  Call VISA_PLUS()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_SetFocus
.head 6 -  Set sValTmp = MFOB
.head 5 +  On SAM_AnyEdit
.head 6 +  If SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set MFOB = sValTmp
.head 3 +  Column: NLSB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-Б
вериф
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If NOT SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set nContextRow = SalTblQueryContext(hWndForm)
.head 7 +  If NLSB != NLSB1 
.head 8 -  Call SalTblSetCellTextColor(NLSB, COLOR_Red, FALSE)
.head 8 -  ! Call SalMessageBox('Счет-Б !', 'Ошибка!', MB_IconStop)
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('VR.cTErrNLSB'), 
     CurrentLangTable.GetAtomTitle('cTTitleError'), MB_IconStop)
.head 7 +  Else
.head 8 -  Call SalTblSetCellTextColor(NLSB, COLOR_DarkGreen, FALSE)
.head 8 +  If S = S1 and
   (cb_NLSA and NLSA = NLSA1 or not cb_NLSA) and 
   (cb_MFOB and MFOB = MFOB1 or not cb_MFOB) and 
   (cb_OKPOB and OKPOB = OKPOB1 or not cb_OKPOB)
.head 9 -  ! Хорошая виза
.head 9 -  Call VISA_PLUS()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_SetFocus
.head 6 -  Set sValTmp = NLSB
.head 5 +  On SAM_AnyEdit
.head 6 +  If SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set NLSB = sValTmp
.head 3 +  Column: OKPOB
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ОКПО-Б
вериф
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.2"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If NOT SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set nContextRow = SalTblQueryContext(hWndForm)
.head 7 +  If OKPOB != OKPOB1 
.head 8 -  Call SalTblSetCellTextColor(OKPOB, COLOR_Red, FALSE)
.head 8 -  ! Call SalMessageBox('ОКПО-Б !', 'Ошибка!', MB_IconStop)
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('VR.cTErrOKPOB'), 
     CurrentLangTable.GetAtomTitle('cTTitleError'), MB_IconStop)
.head 7 +  Else
.head 8 -  Call SalTblSetCellTextColor(OKPOB, COLOR_DarkGreen, FALSE)
.head 8 +  If S = S1 and
   (cb_NLSA and NLSA = NLSA1 or not cb_NLSA) and 
   (cb_NLSB and NLSB = NLSB1 or not cb_NLSB) and
   (cb_MFOB and MFOB = MFOB1 or not cb_MFOB)
.head 9 -  ! Хорошая виза
.head 9 -  Call VISA_PLUS()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_SetFocus
.head 6 -  Set sValTmp = OKPOB
.head 5 +  On SAM_AnyEdit
.head 6 +  If SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set OKPOB = sValTmp
.head 3 +  Column: S
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
вериф
.head 4 -  Visible? Yes
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 +  Message Actions
.head 5 +  On SAM_Validate
.head 6 +  If NOT SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set nContextRow = SalTblQueryContext(hWndForm)
.head 7 +  If S != S1 
.head 8 -  Call SalTblSetCellTextColor(S, COLOR_Red, FALSE)
.head 8 -  ! Call SalMessageBox('Сумма !', 'Ошибка!', MB_IconStop)
.head 8 -  Call SalMessageBox(CurrentLangTable.GetAtomTitle('VR.cTErrS'), 
     CurrentLangTable.GetAtomTitle('cTTitleError'), MB_IconStop)
.head 7 +  Else
.head 8 -  Call SalTblSetCellTextColor(S, COLOR_DarkGreen, FALSE)
.head 8 +  If (cb_NLSA and NLSA = NLSA1 or not cb_NLSA) and
   (cb_NLSB and NLSB = NLSB1 or not cb_NLSB) and 
   (cb_MFOB and MFOB = MFOB1 or not cb_MFOB) and 
   (cb_OKPOB and OKPOB = OKPOB1 or not cb_OKPOB)
.head 9 -  ! Хорошая виза
.head 9 -  Call VISA_PLUS()
.head 6 -  Return VALIDATE_Ok
.head 5 +  On SAM_SetFocus
.head 6 -  Set nValTmp = S
.head 5 +  On SAM_AnyEdit
.head 6 +  If SalTblQueryRowFlags(VR, SalTblQueryContext(VR), ROW_New)
.head 7 -  Set S = nValTmp
.head 3 +  Column: NAZN
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Назначение
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 160
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  3.517"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: sCHK
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title:
.head 4 -  Visible? No
.head 4 -  Editable? Yes
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.514"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: S1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Сумма
ввод
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Right
.head 4 -  Width:  1.617"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Decimal
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: NLSA1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-А
ввод
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: MFOB1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: МФО-Б
ввод
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 6
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.2"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: NLSB1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Счет-Б
ввод
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.6"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: OKPOB1
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: ОКПО-Б
ввод
.head 4 -  Visible? Yes
.head 4 -  Editable? No
.head 4 -  Maximum Data Length: 14
.head 4 -  Data Type: String
.head 4 -  Justify: Left
.head 4 -  Width:  1.2"
.head 4 -  Width Editable? Yes
.head 4 -  Format: Unformatted
.head 4 -  Country: Default
.head 4 -  Input Mask: Unformatted
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? No
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Yes
.head 6 -  Vertical Scroll? Yes
.head 6 -  Auto Drop Down? No
.head 6 -  Allow Text Editing? Yes
.head 5 -  Cell CheckBox
.head 6 -  Check Value:
.head 6 -  Uncheck Value:
.head 6 -  Ignore Case? Yes
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: STP
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: СТП
.head 4 -  Visible? Class Default
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  0.8"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Check Box
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value: 1
.head 6 -  Uncheck Value: 0
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 3 +  Column: STP_Old
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class: cColumnLabeled
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: СТП
.head 4 -  Visible? No
.head 4 -  Editable? Class Default
.head 4 -  Maximum Data Length: Class Default
.head 4 -  Data Type: Number
.head 4 -  Justify: Class Default
.head 4 -  Width:  0.8"
.head 4 -  Width Editable? Class Default
.head 4 -  Format: Class Default
.head 4 -  Country: Class Default
.head 4 -  Input Mask: Class Default
.head 4 -  Cell Options
.head 5 -  Cell Type? Standard
.head 5 -  Multiline Cell? Class Default
.head 5 -  Cell DropDownList
.head 6 -  Sorted? Class Default
.head 6 -  Vertical Scroll? Class Default
.head 6 -  Auto Drop Down? Class Default
.head 6 -  Allow Text Editing? Class Default
.head 5 -  Cell CheckBox
.head 6 -  Check Value: 1
.head 6 -  Uncheck Value: 0
.head 6 -  Ignore Case? Class Default
.head 4 -  List Values
.head 4 -  Message Actions
.head 2 +  Functions
.head 3 +  Function: VISA_PLUS
.head 4 -  Description:
.head 4 +  Returns
.head 5 -  Boolean:
.head 4 -  Parameters
.head 4 -  Static Variables
.head 4 +  Local variables
.head 5 -  Number: nRetVal
.head 4 +  Actions
.head 5 -  ! Хорошая виза
.head 5 -  Call SalMapEnterToTab(FALSE)
.head 5 +  If STP != STP_Old
.head 6 +  If not SqlPLSQLCommand(hSql(), "chk.put_prty(VR.REF, VR.STP)")
.head 7 -  Call SqlRollbackEx(hSql(), "VR. Ошибка установки признака СТП=" || Str(VR.REF) || " для REF " || Str(VR.REF))
.head 7 -  Return FALSE
.head 6 -  Call SqlCommitEx(hSql(), "VR. Установлен признак СТП=" || Str(VR.REF) || " для REF " || Str(VR.REF))
.head 5 -  Set nRetVal = DocumentCheck(VR.REF, nCheckId, VR.sCHK, FALSE)
.head 5 +  If nRetVal = MBEx_No OR nRetVal = MBEx_Cancel OR nRetVal = FALSE
.head 6 -  Call SalMapEnterToTab(TRUE)
.head 6 -  Call SalWaitCursor(FALSE)
.head 6 -  Return FALSE
.head 5 -  Call SaveInfoToLog("VR. Визирование документа REF " || Str(VR.REF) || " на верификации [Пользователь " || Str(nId) || "]")
.head 5 -  Set dKol = dKol - 1
.head 5 -  Set dSum = dSum - S1
.head 5 -  Call SetTblRowColor(VR, COLOR_Black)
.head 5 -  Call SalTblSetRowFlags(VR, nContextRow, ROW_Edited, FALSE)
.head 5 -  Call SalTblSetRowFlags(VR, nContextRow, ROW_New, TRUE)
.head 5 +  If NOT SalTblAnyRows( hWndForm, 0, 0 )
.head 6 -  Call SalSendMsg( pbRefresh, SAM_Click, 0, 0 )
.head 5 -  Call SalMapEnterToTab(TRUE)
.head 5 -  Call SalWaitCursor(FALSE)
.head 5 -  Return TRUE
.head 2 +  Window Parameters
.head 3 -  Number: nCheckId
.head 3 -  String: strAdditional
.head 3 -  Number: nSam
.head 2 +  Window Variables
.head 3 -  String: strHexMark2Ret
.head 3 -  Number: nId
.head 3 -  Number: nTmp
.head 3 -  Boolean: bShowC
.head 3 -  !
.head 3 -  String: strOpts
.head 3 -  String: strOpt[10]
.head 3 -  Number: nOpt
.head 3 -  Number: i
.head 3 -  String: sNaznErr
.head 3 -  Number: nKol
.head 3 -  Number: nSum
.head 3 -  Number: nContextRow
.head 3 -  Number: nValTmp
.head 3 -  String: sValTmp
.head 3 -  Number: nErr
.head 3 -  String: sErrTxt
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 -  ! Присваиваем значения многоязыковым объектам
.head 4 -  Call SalSendMsgToChildren(hWndForm, UM_QueryLabelText, 0, 0)
.head 4 -  Call SalSetWindowText(hWndForm, CurrentLangTable.GetAtomTitle('VR.cTWndTitle'))
.head 4 -  Call PrepareWindow(hWndForm)
.head 4 -  Call SetWindowFullSize(hWndForm)
.head 4 -  !
.head 4 -  Set nId = GetUserId()
.head 4 -  Call SalDisableWindow(pb_Kol)
.head 4 -  Set cb_NLSA  = TRUE
.head 4 -  Set cb_NLSB  = TRUE
.head 4 -  Set cb_MFOB  = TRUE
.head 4 -  Set cb_OKPOB = TRUE
.head 4 -  ! Выключаем возможность убирания обязательных реквизитов
.head 4 -  Set strOpts = SalStrUpperX(GetGlobalOption('VRFOPT'))
.head 4 +  If strOpts
.head 5 -  Set nOpt = SalStrTokenize(strOpts, '', ';', strOpt)
.head 5 +  If nOpt > 0
.head 6 -  Set i = 0
.head 6 +  While i < nOpt
.head 7 +  If strOpt[i] = 'NLSA'
.head 8 -  Call SalDisableWindow(cb_NLSA)
.head 7 +  If strOpt[i] = 'NLSB'
.head 8 -  Call SalDisableWindow(cb_NLSB)
.head 7 +  If strOpt[i] = 'MFOB'
.head 8 -  Call SalDisableWindow(cb_MFOB)
.head 7 +  If strOpt[i] = 'OKPOB'
.head 8 -  Call SalDisableWindow(cb_OKPOB)
.head 7 -  Set i = i + 1
.head 4 -  ! Проверяем Участь банку в СТП
.head 4 +  If Val(GetValueStr("select nvl(ssp,0) from banks where mfo='" || GetBankMfo() || "'")) = 0
.head 5 -  Call SalHideWindow(VR.STP)
.head 4 -  !
.head 4 -  Call SalTblSetLockedColumns(hWndForm,2)
.head 4 -  Set hWndForm.VR.nFlags = GT_NoIns | GT_NoUpd | GT_NoRet
.head 4 -  Set hWndForm.VR.strFilterTblName = 'OPER'
.head 4 -  Set hWndForm.VR.strPrintFileName = 'VR.txt'
.head 4 -  Set hWndForm.VR.strSqlPopulate =
"SELECT a.chk, a.ref, a.nd, a.userid, 
        a.nlsa, a.mfob, a.nlsb, a.s/100, a.nazn, a.id_b, decode(nvl(a.prty,0),1,1,0) 
   INTO :hWndForm.VR.sCHK, :hWndForm.VR.REF, :hWndForm.VR.ND, :hWndForm.VR.ISP, 
        :hWndForm.VR.NLSA1, :hWndForm.VR.MFOB1, :hWndForm.VR.NLSB1, :hWndForm.VR.S1,
        :hWndForm.VR.NAZN, :hWndForm.VR.OKPOB1, :hWndForm.VR.STP 
   FROM oper a 
  WHERE a.ref IN (SELECT ref FROM ref_que) 
    AND a.sos >= 0 
    AND a.userid <> :hWndForm.VR.nId
    AND (" || strAdditional || ") 
  ORDER BY a.VDAT, a.ref " 
.head 4 -  Call SalSendClassMessage(SAM_Create, 0, 0)
.head 4 -  Call cF.Init('OPER', 'a')
.head 4 -  Call SalMapEnterToTab(TRUE)
.head 4 -  Call SalWaitCursor(FALSE)
.head 3 +  On UM_Populate
.head 4 -  Set nKol = 0
.head 4 -  Set nSum = 0
.head 4 -  Call SalSendClassMessage(UM_Populate, 0, 0)
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, hWndForm.VR.REF)
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, hWndForm.VR.ND)
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, hWndForm.VR.ISP)
.head 4 -  Call VisTblAutoSizeColumn(hWndForm, hWndForm.VR.NAZN)
.head 4 -  Set dKol = nKol
.head 4 -  Set dSum = nSum
.head 3 +  On SAM_FetchRowDone
.head 4 -  Set STP_Old = STP
.head 4 -  Set nKol = nKol + 1
.head 4 -  Set nSum = nSum + S1
.head 4 -  Call SetTblRowColor(VR, COLOR_DarkGreen)
.head 3 +  On UM_Close
.head 4 -  Call SalDestroyWindow(hWndForm)
.head 1 +  Form Window: frmCheckVisaSign
.head 2 -  Class:
.head 2 -  Property Template:
.head 2 -  Class DLL Name:
.head 2 -  Title: Проверка ЭЦП на визах
.head 2 -  Icon File:
.head 2 -  Accesories Enabled? No
.head 2 -  Visible? Yes
.head 2 -  Display Settings
.head 3 -  Display Style? Default
.head 3 -  Visible at Design time? Yes
.head 3 -  Automatically Created at Runtime? Yes
.head 3 -  Initial State: Normal
.head 3 -  Maximizable? No
.head 3 -  Minimizable? No
.head 3 -  System Menu? Yes
.head 3 -  Resizable? No
.head 3 -  Window Location and Size
.head 4 -  Left:   Default
.head 4 -  Top:    Default
.head 4 -  Width:  5.283"
.head 4 -  Width Editable? Yes
.head 4 -  Height: 2.381"
.head 4 -  Height Editable? Yes
.head 3 -  Form Size
.head 4 -  Width:  Default
.head 4 -  Height: Default
.head 4 -  Number of Pages: Dynamic
.head 3 -  Font Name: Default
.head 3 -  Font Size: Default
.head 3 -  Font Enhancement: Default
.head 3 -  Text Color: Default
.head 3 -  Background Color: Default
.head 2 -  Description:
.head 2 -  Named Menus
.head 2 -  Menu
.head 2 +  Tool Bar
.head 3 -  Display Settings
.head 4 -  Display Style? Default
.head 4 -  Location? Top
.head 4 -  Visible? No
.head 4 -  Size: Default
.head 4 -  Size Editable? Yes
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Contents
.head 2 +  Contents
.head 3 -  Background Text: Дата начала периода
.head 4 -  Resource Id: 28098
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.283"
.head 5 -  Top:    0.345"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 -  Background Text: Дата окончания периода
.head 4 -  Resource Id: 28099
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Window Location and Size
.head 5 -  Left:   0.283"
.head 5 -  Top:    0.679"
.head 5 -  Width:  2.3"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.167"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Justify: Left
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 3 +  Data Field: dfDateStart
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.783"
.head 6 -  Top:    0.321"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: dd.MM.yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: 99.99.9999
.head 4 -  Message Actions
.head 3 +  Data Field: dfDateFinish
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Data
.head 5 -  Maximum Data Length: Default
.head 5 -  Data Type: Date/Time
.head 5 -  Editable? Yes
.head 4 -  Display Settings
.head 5 -  Window Location and Size
.head 6 -  Left:   2.783"
.head 6 -  Top:    0.655"
.head 6 -  Width:  1.7"
.head 6 -  Width Editable? Yes
.head 6 -  Height: 0.25"
.head 6 -  Height Editable? Yes
.head 5 -  Visible? Yes
.head 5 -  Border? Yes
.head 5 -  Justify: Center
.head 5 -  Format: dd.MM.yyyy
.head 5 -  Country: Default
.head 5 -  Font Name: Default
.head 5 -  Font Size: Default
.head 5 -  Font Enhancement: Default
.head 5 -  Text Color: Default
.head 5 -  Background Color: Default
.head 5 -  Input Mask: 99.99.9999
.head 4 -  Message Actions
.head 3 +  Pushbutton: pbCheck
.head 4 -  Class Child Ref Key: 0
.head 4 -  Class ChildKey: 0
.head 4 -  Class:
.head 4 -  Property Template:
.head 4 -  Class DLL Name:
.head 4 -  Title: Начать проверку
.head 4 -  Window Location and Size
.head 5 -  Left:   1.483"
.head 5 -  Top:    1.238"
.head 5 -  Width:  2.1"
.head 5 -  Width Editable? Yes
.head 5 -  Height: 0.298"
.head 5 -  Height Editable? Yes
.head 4 -  Visible? Yes
.head 4 -  Keyboard Accelerator: (none)
.head 4 -  Font Name: Default
.head 4 -  Font Size: Default
.head 4 -  Font Enhancement: Default
.head 4 -  Picture File Name:
.head 4 -  Picture Transparent Color: None
.head 4 -  Image Style: Single
.head 4 -  Text Color: Default
.head 4 -  Background Color: Default
.head 4 +  Message Actions
.head 5 +  On SAM_Click
.head 6 -  Set date_start  = dfDateStart
.head 6 -  Set date_finish = dfDateFinish + 1
.head 6 -  Set isOk = TRUE
.head 6 -  Set old_hideErrorMsg = g_hideErrorMsg
.head 6 -  Set g_hideErrorMsg = TRUE
.head 6 -  ! Call SalDateToStr( date_start, strBuf )
.head 6 -  ! Call Debug( strBuf )
.head 6 -  ! Call SalDateToStr( date_finish, strBuf )
.head 6 -  ! Call Debug( strBuf )
.head 6 +  If cDocChk.sIni()
.head 7 +  If SqlPrepareAndExecute( hSqlAux(),
  "select ref, vrank, sqnc
   into :v_ref,:v_level,:v_sqnc
   from (
select decode((select min(status) from oper_visa where ref=v.ref),
              0,(rank() over (partition by v.ref order by v.sqnc))-1,
		(rank() over (partition by v.ref order by v.sqnc))
              ) vrank,
	v.*  
from oper_visa v, oper o 
where v.ref=o.ref 
and o.pdat>=:date_start and o.pdat<:date_finish
and nvl(v.passive,0)=0 
) where keyid is not null and sign is not null " )
.head 8 -  Call WaitCursorOn(  )
.head 8 +  While SqlFetchNext( hSqlAux(), nFetchRes )
.head 9 +  If not cDocChk.SetDocR( v_ref, FALSE )
.head 10 -  Call MessageErrorEx( 'Ошибка установки экземпляра документа. REF='||Str(v_ref) )
.head 10 -  Set isOk = FALSE
.head 10 -  Break
.head 9 -  ! Call SalStatusSetText( hWndForm, 'Обработка Ref = '||Str(v_ref) )
.head 9 -  Call SalSetWindowText( hWndForm, 'Проверка ЭЦП на визах: Ref='||Str(v_ref) )
.head 9 -  Set bRes = cDocChk.cDocInt( v_level, NUMBER_Null )
.head 9 +  If NOT SqlPLSQLCommand( hSqlAux2(), "chk.update_check_sign(v_sqnc,g_nErrorSign,g_strErrorSign)" )
.head 10 -  Call MessageErrorEx( 'Ошибка выполнения процедуры chk.update_check_sign()' )
.head 10 -  Set isOk = FALSE
.head 10 -  Break
.head 8 -  Call WaitCursorOff(  )
.head 8 +  If isOk
.head 9 -  Call SqlCommit( hSqlAux2() )
.head 9 -  Set strDateStart  = SalFmtFormatDateTime ( dfDateStart, 'dd.MM.yyyy' )
.head 9 -  Set strDateFinish = SalFmtFormatDateTime ( dfDateFinish, 'dd.MM.yyyy' )
.head 9 -  Call MessageInfo( 'Проверка ЭЦП на визах за период с '
||strDateStart||' по '||strDateFinish||' завершена.' )
.head 8 +  Else
.head 9 -  Call SqlRollback( hSqlAux2() )
.head 6 -  Set g_hideErrorMsg = old_hideErrorMsg
.head 6 -  Call SalSetWindowText( hWndForm, 'Проверка ЭЦП на визах завершена' )
.head 6 -  ! Call SalStatusSetText( hWndForm, 'Обработка завершена' )
.head 2 -  Functions
.head 2 -  Window Parameters
.head 2 +  Window Variables
.head 3 -  Number: v_ref
.head 3 -  Number: v_level
.head 3 -  Number: v_sqnc
.head 3 -  Date/Time: date_start
.head 3 -  Date/Time: date_finish
.head 3 -  String: strDateStart
.head 3 -  String: strDateFinish
.head 3 -  String: strBuf
.head 3 -  Boolean: isOk
.head 3 -  Boolean: bRes
.head 3 -  Boolean: old_hideErrorMsg
.head 3 -  Number: i
.head 3 -  String: str
.head 2 +  Message Actions
.head 3 +  On SAM_Create
.head 4 +  If not (GetGlobalOptionEx('VISASIGN')=1 and GetGlobalOptionEx('INTSIGN')=2)
.head 5 -  Call MessageErrorEx( 'Данная функция работает только с параметрами VISASIGN=1 & INTSIGN=2.' )
.head 5 -  Call SalDestroyWindow( hWndForm )
.head 5 -  Return FALSE
.head 4 -  Call SalCenterWindow( hWndForm )
.head 4 -  Set dfDateStart  = SalDateCurrent(  ) -1
.head 4 -  Set dfDateFinish = SalDateCurrent(  )
.head 4 -  Call SalSetFocus( pbCheck )
.head 4 -  ! Call SalMapEnterToTab( TRUE )
.head 4 -  ! Set i = 0
.head 4 -  ! Set str = SalStrRepeatX( 'Тест ', 300 )
.head 4 +  ! While i < 300
.head 5 -                           Call SaveFInfoToLog( str )
.head 5 -                           Set i = i + 1
.head 3 +  On SAM_Destroy
.head 4 -  ! Call SalMapEnterToTab( FALSE )
